Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A497DC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 761012074D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+QkETad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504801AbgDNTae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 15:30:34 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35296 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504783AbgDNTaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 15:30:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586892597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=4nt9rcH2RnKfJzDA58agnsCRn6rTIqNaptR/6NgozyU=;
        b=O+QkETadPHScdgH5/HUWWvDreF5nfvNDSiY7QfBIlpSThBp0tzinjqODomR7C9ZgtyxZV0
        FahXcGampD7e2WQxp1ckp+03XMeVbaSMq3AWjLMoi6ahb1ZtbsVv3td8000txW61GIixI7
        Oby0TjMPWGRaWj9nMkLLjO5D6450fYs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-Xc2oPvfjP7mbYjWGtjiEGA-1; Tue, 14 Apr 2020 15:29:55 -0400
X-MC-Unique: Xc2oPvfjP7mbYjWGtjiEGA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6723C107ACC9;
        Tue, 14 Apr 2020 19:29:52 +0000 (UTC)
Received: from llong.com (ovpn-118-173.rdu2.redhat.com [10.10.118.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F1F4419C70;
        Tue, 14 Apr 2020 19:29:46 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-mm@kvack.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 3/3] btrfs: Use kfree() in btrfs_ioctl_get_subvol_info()
Date:   Tue, 14 Apr 2020 15:29:33 -0400
Message-Id: <20200414192933.26846-1-longman@redhat.com>
In-Reply-To: <20200413211550.8307-1-longman@redhat.com>
References: <20200413211550.8307-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In btrfs_ioctl_get_subvol_info(), there is a classic case where kzalloc()
was incorrectly paired with kzfree(). According to David Sterba, there
isn't any sensitive information in the subvol_info that needs to be
cleared before freeing. So kfree_sensitive() isn't really needed,
use kfree() instead.

Reported-by: David Sterba <dsterba@suse.cz>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 fs/btrfs/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index eab3f8510426..5070bd2436b7 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2691,7 +2691,7 @@ static int btrfs_ioctl_get_subvol_info(struct file *file, void __user *argp)
 	btrfs_put_root(root);
 out_free:
 	btrfs_free_path(path);
-	kfree_sensitive(subvol_info);
+	kfree(subvol_info);
 	return ret;
 }
 
-- 
2.18.1

