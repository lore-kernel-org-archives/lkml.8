Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46287C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A3AD20716
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fsCamMTC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbgC3Kik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 06:38:40 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45738 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728907AbgC3Kij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 06:38:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id r14so5898294pfl.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 03:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=USg8LmP2UmiYxUXQPkCBKoGbEz0f9bclI81RA4aINcA=;
        b=fsCamMTC9R0n2+XtrYD5rnIHKJYR4WNfwv8p2W5blpxPdSuqWxrvdkl9XkGPs3oHoE
         nOuPdwjD1FTDmZjXBIA8t6Jw+ink/2KEcEKkHz+YQal9Q2j5vdm06GSBhPyMWg1E+ArP
         rqOEwXDIWcIEfHUnWDiDb2ITLbuovJNeK0wmeZnUrlabmQaoGRyC7uz85cSf9/h4+rcl
         EF5nuNirxmKiOqB3YL/QUvkWTT1pGPZUiNDR7oe+LgxxYZj3G9+X4Bc3w82NTsFwAz8a
         +qju1wabmSPVKYt0QGLYLB0KzSMex8SEQS5Fdm8+Nd2vyTCpOjLaS6FiJyEN97xM9zJy
         1TEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=USg8LmP2UmiYxUXQPkCBKoGbEz0f9bclI81RA4aINcA=;
        b=sT3UZvbuFDrsNhtmN+tNiKiweLJ0e1JqL95UuY/HFh5TnUBUtRy9xibssmyJPe+e4T
         dQiVkCUsOTXl4R/aEl+eCkVuz2boJk17FoyGNf9QaX0Kzc/X15er8MO7ex7guGNtlclt
         kXYUJI1BU2xDhaBb0PPu7QRXn68JeBybF/6DijSh/LVdoW4Ulweae+DcOUEgLR79oTHJ
         JVR90266pJFYg0eqCD+URODmG1zbean05QEhZOx+6MeXRQxesFLcxBS25us5iT4LnoNk
         tXWE/s7QCgL+AOmCzQAGXlnnv0gdoeySa9P8SkzpxDC0lMG/SlgaNlWui+2bYgXrtk5s
         tnDw==
X-Gm-Message-State: AGi0PuYT3YAbFU2cBAglxOwm255TCUAEJQKOysD572+grSs5D89rJdlg
        vwNITQ2ARObEwtJCZAuwl10=
X-Google-Smtp-Source: APiQypKCg5auukF5okMWierSGKTcgueVd3hJJbC+8cX2Ud6IXjyYSkFh2cQyK75tygRmCIY4xXZI8g==
X-Received: by 2002:a63:31c4:: with SMTP id x187mr5526547pgx.205.1585564718263;
        Mon, 30 Mar 2020 03:38:38 -0700 (PDT)
Received: from payal-desktop ([157.33.199.31])
        by smtp.gmail.com with ESMTPSA id q91sm9785709pjb.11.2020.03.30.03.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 03:38:37 -0700 (PDT)
From:   Payal Kshirsagar <payalskshirsagar1234@gmail.com>
To:     akpm@linux-foundation.org, dave@stgolabs.net,
        viro@zeniv.linux.org.uk, elfring@users.sourceforge.net,
        manfred@colorfullife.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Cc:     Payal Kshirsagar <payalskshirsagar1234@gmail.com>
Subject: [PATCH] ipc: mqueue.c: avoid NULL comparison
Date:   Mon, 30 Mar 2020 16:08:26 +0530
Message-Id: <20200330103826.6531-1-payalskshirsagar1234@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change suggested by coccinelle.
Avoid NULL comparison, compare using boolean negation.

Signed-off-by: Payal Kshirsagar <payalskshirsagar1234@gmail.com>
---
 ipc/mqueue.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 49a05ba3000d..dbc987d71445 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -1361,7 +1361,7 @@ static int do_mq_notify(mqd_t mqdes, const struct sigevent *notification)
 
 	ret = 0;
 	spin_lock(&info->lock);
-	if (notification == NULL) {
+	if (!notification) {
 		if (info->notify_owner == task_tgid(current)) {
 			remove_notification(info);
 			inode->i_atime = inode->i_ctime = current_time(inode);
@@ -1688,7 +1688,7 @@ static int __init init_mqueue_fs(void)
 	mqueue_inode_cachep = kmem_cache_create("mqueue_inode_cache",
 				sizeof(struct mqueue_inode_info), 0,
 				SLAB_HWCACHE_ALIGN|SLAB_ACCOUNT, init_once);
-	if (mqueue_inode_cachep == NULL)
+	if (!mqueue_inode_cachep)
 		return -ENOMEM;
 
 	/* ignore failures - they are not fatal */
-- 
2.17.1

