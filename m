Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C172EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EA5520704
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864878;
	bh=xx/5NPMChgsJxC9KdTXY9qZMPHMzyd1H6sdrMha8ULg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hR+mieuPgvtuLyYUbqMYdawZX/tR0b5MnnoJbRGD17oFUlUSq7mxpQx2lyFjezy0q
	 dNzphWXS0rWAayQVAspNV6zRY3anneM6BNol9CrVHDNphEYI2+rsUlNFdTX5PL5iLY
	 5YkccYKJs4shSfOpyJkYbP2BAAi5vwn2GZ717i8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391042AbgAXLVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:21:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:59232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733219AbgAXLVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:21:14 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C06B206D4;
        Fri, 24 Jan 2020 11:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864873;
        bh=xx/5NPMChgsJxC9KdTXY9qZMPHMzyd1H6sdrMha8ULg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fbg9qf67A2IFnM4gpit2hpktyM/Hp97sUaVHNZkaj6v54bKZzcLGlE/E7x3GZiB2q
         VMz1xjADGX6s+02t9gSHHkrXt3mGjqxLlKchon98b3NTIiW0HmwsKXowi7wLZAkBVP
         4l1eEOy60W+C+HdlvBixujJcvdtSkLTJ0T8xIv7M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 377/639] afs: Fix lock-wait/callback-break double locking
Date:   Fri, 24 Jan 2020 10:29:07 +0100
Message-Id: <20200124093134.233102242@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

[ Upstream commit c7226e407b6065d3bda8bd9dc627663d2c505ea3 ]

__afs_break_callback() holds vnode->lock around its call of
afs_lock_may_be_available() - which also takes that lock.

Fix this by not taking the lock in __afs_break_callback().

Also, there's no point checking the granted_locks and pending_locks queues;
it's sufficient to check lock_state, so move that check out of
afs_lock_may_be_available() into __afs_break_callback() to replace the
queue checks.

Fixes: e8d6c554126b ("AFS: implement file locking")
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/callback.c | 8 +-------
 fs/afs/flock.c    | 3 ---
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/afs/callback.c b/fs/afs/callback.c
index 4ad7012502998..97283b04fa6fd 100644
--- a/fs/afs/callback.c
+++ b/fs/afs/callback.c
@@ -221,14 +221,8 @@ void afs_break_callback(struct afs_vnode *vnode)
 		vnode->cb_break++;
 		afs_clear_permits(vnode);
 
-		spin_lock(&vnode->lock);
-
-		_debug("break callback");
-
-		if (list_empty(&vnode->granted_locks) &&
-		    !list_empty(&vnode->pending_locks))
+		if (vnode->lock_state == AFS_VNODE_LOCK_WAITING_FOR_CB)
 			afs_lock_may_be_available(vnode);
-		spin_unlock(&vnode->lock);
 	}
 
 	write_sequnlock(&vnode->cb_lock);
diff --git a/fs/afs/flock.c b/fs/afs/flock.c
index aea7224ba1981..fbf4986b12245 100644
--- a/fs/afs/flock.c
+++ b/fs/afs/flock.c
@@ -39,9 +39,6 @@ void afs_lock_may_be_available(struct afs_vnode *vnode)
 {
 	_enter("{%x:%u}", vnode->fid.vid, vnode->fid.vnode);
 
-	if (vnode->lock_state != AFS_VNODE_LOCK_WAITING_FOR_CB)
-		return;
-
 	spin_lock(&vnode->lock);
 	if (vnode->lock_state == AFS_VNODE_LOCK_WAITING_FOR_CB)
 		afs_next_locker(vnode, 0);
-- 
2.20.1



