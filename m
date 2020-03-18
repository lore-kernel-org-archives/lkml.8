Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A37C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 03:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 934E5206F1
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 03:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KNcCj7O6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgCRDbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 23:31:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46448 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgCRDbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 23:31:11 -0400
Received: by mail-wr1-f68.google.com with SMTP id w16so12034022wrv.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 20:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=aIT1zTK9Ocso7RE9WeFEQk5SlR5xoNixSCclsbBUu/g=;
        b=KNcCj7O6ttPqHHD/f7f7kRJ38s/SgzALF5DtpnS4WUODbYaxIrhIBM0SjK0Z5AUbKP
         ScckZfkZgdubMBTtD5LbY5NXhEjFj/+3IWV5ERArTHilG/ew6N7rfmOoKJIWCBnQxfCq
         01XZzw+9njVxiksAXjjEY9I9S+x0aSqE9iDRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aIT1zTK9Ocso7RE9WeFEQk5SlR5xoNixSCclsbBUu/g=;
        b=oOjTlU5fM/knPCo28ztx9mw426IvAeo5vEO3DtLaOwPuqQnBUx/ZVEPDdkkjGDIO3G
         ZX3OJoUTab2MtNs+FRm5TzR5sIrNkO5SXEZD8QzcbLtSir9gDGC0BpJSbWsHqTlTwvWB
         PD98WTWqQstJcdhIAzbSQ5b71QwdduP995t9/BNR+k0tnM2ogzKPT17n2KjizsvM6C66
         zktmT1reNDB/588r3N+jhqKjsuC1oNBmGusQOp4Y9xW901XrIdGgR7gmi7N9xEtaFm7Q
         m/4jy6BoUB+NfXPoSgk7NaPRKYHGze9nyilCGgQ6BBLM1buggrKk9eSveGiugAlZQ8ba
         VY/g==
X-Gm-Message-State: ANhLgQ3P79hv8ctaWhpt5VRNACC0x01yUhGSCV9CR9At7A+L0fqi6vSQ
        Zf1L26ePakmdoBLqg/rf+x0itEwaaIw=
X-Google-Smtp-Source: ADFU+vtjwQwj07nqkkP9fnyM9t9FFpQz/6TzwQOv7Zkq7ebdg6DdlCtiR27htOncCjU47DmsYY+M+w==
X-Received: by 2002:a5d:488c:: with SMTP id g12mr2669622wrq.67.1584502267780;
        Tue, 17 Mar 2020 20:31:07 -0700 (PDT)
Received: from rayagonda.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id f17sm7664084wrj.28.2020.03.17.20.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 20:31:06 -0700 (PDT)
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Cc:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH v2 1/1] maillbox: bcm-flexrm-mailbox: handle cmpl_pool dma allocation failure
Date:   Wed, 18 Mar 2020 09:00:55 +0530
Message-Id: <20200318033055.5335-1-rayagonda.kokatanur@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle 'cmpl_pool' dma memory allocation failure.

Fixes: a9a9da47f8e6 ("mailbox: no need to check return value of debugfs_create functions")
Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
---
Changes from v1:
- Address code review comments from Tyler Hicks,
  Add missing Fixes tag.

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

