Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3424FC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 21:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 062CE207CD
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 21:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T1mixKM4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbgHVVSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 17:18:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34858 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728729AbgHVVSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 17:18:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598131129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=xZbAofBMByOnbSpYAqNdbUjqwUWCsauk/KwtU8NifwA=;
        b=T1mixKM4Ng1luVw/b9wqS3X1esdUb4aYS5gx53XKr54hCwbF1cKReCBORybFJJLSzuSsFb
        iibQy/OHy4ayuk6+Y/KvNDsCcBPy1IrV8/D7RQeFUwpTLTKw/5VbxgBT4msBG13/9dup6s
        /upxTatFsquVVV/yPle66ocYQ3XT+Ak=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-1YhT63wgM-mI2ZtLK8UJDw-1; Sat, 22 Aug 2020 17:18:47 -0400
X-MC-Unique: 1YhT63wgM-mI2ZtLK8UJDw-1
Received: by mail-qt1-f197.google.com with SMTP id w30so3934243qte.14
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 14:18:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xZbAofBMByOnbSpYAqNdbUjqwUWCsauk/KwtU8NifwA=;
        b=I15WiWw9iWayTjILjy0rf2puoCUm0SfdDsB4JlJt3tGsMkQDyVnxRwI2meixyzwPqL
         GHqd852uCV9ZD/TX//dfZGS9EWJrmDfcdmJHBfmGHxNcM1EGltnoBQUOH3AX3qx/L84p
         YmjmO08iq8wPqPYeTcDeyNHeHEm8efB+ivcsjalo2IlLwhSpyEUHq1pTjJ0SImNWT7NA
         vxQ2UGxQkGwd4o42TXzkgpkVZpOESCJQhQc9SMr5llKOLp3cKWNrUtILp84KLsvdlY1h
         H9x9h2Qo1O4IQvklEjnj6fNgkjwa5QaCsyX3ZIEO/qXmcUzxylejpnbX4y3i+vYqJqBq
         96uA==
X-Gm-Message-State: AOAM533zeAMpXBTk5EkoyzyLgMVZbntG0y1vVOcTjfEoY4iKhaAHV2R4
        SjsvFGKTI9Siv8Dr6ART2/9PIts4AVKsLA4cmm4yHwqk0NSRAF18xxaR+ki4tVVQbXYI2rvS43C
        LrJLNQnKouIapvShHa4FgwbON
X-Received: by 2002:ae9:ef8d:: with SMTP id d135mr7890573qkg.477.1598131126775;
        Sat, 22 Aug 2020 14:18:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwOwTBkOcs9B9ZoClJFFqyUHPmzql1g+XIUrsy9bwJ//6dtk1AXOnzS6+XQU+OJaT51bVUSA==
X-Received: by 2002:ae9:ef8d:: with SMTP id d135mr7890563qkg.477.1598131126468;
        Sat, 22 Aug 2020 14:18:46 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x23sm5173752qkj.4.2020.08.22.14.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2020 14:18:45 -0700 (PDT)
From:   trix@redhat.com
To:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] usb: storage: initialize variable
Date:   Sat, 22 Aug 2020 14:18:39 -0700
Message-Id: <20200822211839.5117-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis reports this representative problem

transport.c:495:15: warning: Assigned value is garbage or
  undefined
        length_left -= partial;
                   ^  ~~~~~~~
partial is set only when usb_stor_bulk_transfer_sglist()
is successful.

So initialize to partial to 0.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/usb/storage/transport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/storage/transport.c b/drivers/usb/storage/transport.c
index 238a8088e17f..ce920851b1f2 100644
--- a/drivers/usb/storage/transport.c
+++ b/drivers/usb/storage/transport.c
@@ -461,7 +461,7 @@ static int usb_stor_bulk_transfer_sglist(struct us_data *us, unsigned int pipe,
 int usb_stor_bulk_srb(struct us_data* us, unsigned int pipe,
 		      struct scsi_cmnd* srb)
 {
-	unsigned int partial;
+	unsigned int partial = 0;
 	int result = usb_stor_bulk_transfer_sglist(us, pipe, scsi_sglist(srb),
 				      scsi_sg_count(srb), scsi_bufflen(srb),
 				      &partial);
@@ -484,7 +484,7 @@ int usb_stor_bulk_transfer_sg(struct us_data* us, unsigned int pipe,
 		void *buf, unsigned int length_left, int use_sg, int *residual)
 {
 	int result;
-	unsigned int partial;
+	unsigned int partial = 0;
 
 	/* are we scatter-gathering? */
 	if (use_sg) {
-- 
2.18.1

