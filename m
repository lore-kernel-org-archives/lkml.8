Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBC5C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 04:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A369E20719
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 04:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZSU+aYcZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgCQEZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 00:25:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46974 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgCQEZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 00:25:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id w16so7469271wrv.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 21:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=E17silW7K4zE4aUnYxC29i6t6YyS9hQDZKzsoHaks7E=;
        b=ZSU+aYcZKv7IYzrKBs+ASvuHnrUYTdfHPm8BNUUEHLI6/7Lh89YNbDIQJL64cDrFLd
         QISmRdyZZQg9B4UzREcKPO/O5gJ3B+kADfb0wIrnF4j6XIiECnJQ1SwSGjfR+zlQhZkN
         WnaF9QqKVCynUrgCl7xMSL9qY+zzGnT0rk0R4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=E17silW7K4zE4aUnYxC29i6t6YyS9hQDZKzsoHaks7E=;
        b=UNB/02s/IgGZluyehyg/aYwQaCUeikVOrZHGTmlsDZ/JOH6HMPsSXWVEEEuPFU/36S
         rJ5EXcGjiIdy/q3vaTMuIvNGek7CSfss6kUSQHTi06WPUE6HR20o8BBIlZNtupvYqzh5
         8wToAyeJBnJt0eSPsIuciHw232FpjI0rNBf9lh6kVQYaxAH9G9bxpcKrR3LXwkMYtpUo
         Us/DrYxU7RSmLl12puHzKOY4vSZ9uLN88rzN/MN/vjST+5xGcNAkOG8Mt07f9WeYim6H
         H65+Dr5e2c2N/0Szvf1bQRpABC+PBbfr/uLCzYooJwaTbSPyPuyCHG6PRWbdQlZ3spqj
         kaQQ==
X-Gm-Message-State: ANhLgQ21uI13jj4n4YaG0I1d9Yr4jIw3afgPXSGd+hIlLMwQfaDSB08h
        nxRiMlmKhaOJxxkyhxY/6ZanBQ==
X-Google-Smtp-Source: ADFU+vsk8VRY9NBdsUlZQQBCTy3qkF/okNsH3uEnITtS3yEWbGFAfOiuPk//jxBHBJUY7dZAl1w5jw==
X-Received: by 2002:adf:e98c:: with SMTP id h12mr3370624wrm.345.1584419108218;
        Mon, 16 Mar 2020 21:25:08 -0700 (PDT)
Received: from rayagonda.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id q4sm2841396wro.56.2020.03.16.21.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 21:25:07 -0700 (PDT)
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Cc:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH v1 1/1] maillbox: bcm-flexrm-mailbox: handle cmpl_pool dma allocation failure
Date:   Tue, 17 Mar 2020 09:52:16 +0530
Message-Id: <20200317042216.20623-1-rayagonda.kokatanur@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle 'cmpl_pool' dma memory allocation failure.

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
---
 drivers/mailbox/bcm-flexrm-mailbox.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
index 8ee9db274802..bee33abb5308 100644
--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -1599,6 +1599,7 @@ static int flexrm_mbox_probe(struct platform_device *pdev)
 					  1 << RING_CMPL_ALIGN_ORDER, 0);
 	if (!mbox->cmpl_pool) {
 		ret = -ENOMEM;
+		goto fail_destroy_bd_pool;
 	}
 
 	/* Allocate platform MSIs for each ring */
@@ -1661,6 +1662,7 @@ static int flexrm_mbox_probe(struct platform_device *pdev)
 	platform_msi_domain_free_irqs(dev);
 fail_destroy_cmpl_pool:
 	dma_pool_destroy(mbox->cmpl_pool);
+fail_destroy_bd_pool:
 	dma_pool_destroy(mbox->bd_pool);
 fail:
 	return ret;
-- 
2.17.1

