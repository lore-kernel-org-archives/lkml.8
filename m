Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEAFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A62C320771
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MJPPVath"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbgHKPB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 11:01:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45873 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728837AbgHKPBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597158114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zDRlGLWIwDOghzmBBGdpXjJ9z1N+J+XyA1bX28/IXrA=;
        b=MJPPVathhsN1ENen/orRKP9rxiekMPvJbtu2m3nrYvDE+6PBcKgrUeOiJY4TxQIAM6q1Xd
        mv3LAKd3Ba7x9+5i0KZnrkPsFjNzJNsJKHyu4SCHuRBV8YJ59XAGgvPk++MZmQIxw1EIVY
        1IYobFfG+7hXke4lfJDbPaYDshaApzo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-xYn28TrCNG2K7t6ePMNq0w-1; Tue, 11 Aug 2020 11:01:52 -0400
X-MC-Unique: xYn28TrCNG2K7t6ePMNq0w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFD77107ACCA;
        Tue, 11 Aug 2020 15:01:50 +0000 (UTC)
Received: from rules.brq.redhat.com (unknown [10.40.208.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 89C461001B07;
        Tue, 11 Aug 2020 15:01:48 +0000 (UTC)
From:   Vladis Dronov <vdronov@redhat.com>
To:     Taehee Yoo <ap420073@gmail.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Vladis Dronov <vdronov@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] debugfs: Fix module state check condition
Date:   Tue, 11 Aug 2020 17:01:29 +0200
Message-Id: <20200811150129.53343-1-vdronov@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The '#ifdef MODULE' check in the original commit does not work as intended.
The code under the check is not built at all if CONFIG_DEBUG_FS=y. Fix this
by using a correct check.

Fixes: 275678e7a9be ("debugfs: Check module state before warning in {full/open}_proxy_open()")
Signed-off-by: Vladis Dronov <vdronov@redhat.com>
---
 fs/debugfs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index b167d2d02148..a768a09430c3 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -177,7 +177,7 @@ static int open_proxy_open(struct inode *inode, struct file *filp)
 		goto out;
 
 	if (!fops_get(real_fops)) {
-#ifdef MODULE
+#ifdef CONFIG_MODULES
 		if (real_fops->owner &&
 		    real_fops->owner->state == MODULE_STATE_GOING)
 			goto out;
@@ -312,7 +312,7 @@ static int full_proxy_open(struct inode *inode, struct file *filp)
 		goto out;
 
 	if (!fops_get(real_fops)) {
-#ifdef MODULE
+#ifdef CONFIG_MODULES
 		if (real_fops->owner &&
 		    real_fops->owner->state == MODULE_STATE_GOING)
 			goto out;
-- 
2.26.2

