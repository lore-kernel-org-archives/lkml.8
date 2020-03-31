Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E8AC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712932137B
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585645693;
	bh=mJQ0BF9iUHKFsG4Vqthf273UpMIufUGa1gqjsyWZtUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NjF6m917FWMWKe1MjOvggcwfAZEHIlKi0RY068orfc043CNu6ZqUvG5I4tYyJclLm
	 /JScFK6BC3HSdHzQQihkDVcCp/YlVddm4MaRVUnu9j7wo480tkX9eus6cgIbhi4G4K
	 pNtyItOJ1to+gozdHIz25FBrB7pYtNMPe2kxBdu4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731318AbgCaJIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:08:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:50306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730922AbgCaJIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:08:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAC85212CC;
        Tue, 31 Mar 2020 09:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585645686;
        bh=mJQ0BF9iUHKFsG4Vqthf273UpMIufUGa1gqjsyWZtUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mui0GmKB9mEqQD4R0v6ACVAhrtBDLmtK1D4REtWw6TQ0ZFPr8bZwVC2vLNw1P19WV
         mY9XeKO9MuD/ZI60v/CifQyUoMzdJxeAwpkM8Zq0YCNYoLK5YlbBNlIUxiC7Vjjuky
         PznrrghSkRe9EKSwcXaWS6ko4mVjC5DTOnxNqABE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.5 132/170] afs: Fix unpinned address list during probing
Date:   Tue, 31 Mar 2020 10:59:06 +0200
Message-Id: <20200331085437.674920880@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085423.990189598@linuxfoundation.org>
References: <20200331085423.990189598@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

commit 9efcc4a129363187c9bf15338692f107c5c9b6f0 upstream.

When it's probing all of a fileserver's interfaces to find which one is
best to use, afs_do_probe_fileserver() takes a lock on the server record
and notes the pointer to the address list.

It doesn't, however, pin the address list, so as soon as it drops the
lock, there's nothing to stop the address list from being freed under
us.

Fix this by taking a ref on the address list inside the locked section
and dropping it at the end of the function.

Fixes: 3bf0fb6f33dd ("afs: Probe multiple fileservers simultaneously")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/afs/fs_probe.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/afs/fs_probe.c
+++ b/fs/afs/fs_probe.c
@@ -145,6 +145,7 @@ static int afs_do_probe_fileserver(struc
 	read_lock(&server->fs_lock);
 	ac.alist = rcu_dereference_protected(server->addresses,
 					     lockdep_is_held(&server->fs_lock));
+	afs_get_addrlist(ac.alist);
 	read_unlock(&server->fs_lock);
 
 	atomic_set(&server->probe_outstanding, ac.alist->nr_addrs);
@@ -163,6 +164,7 @@ static int afs_do_probe_fileserver(struc
 
 	if (!in_progress)
 		afs_fs_probe_done(server);
+	afs_put_addrlist(ac.alist);
 	return in_progress;
 }
 


