Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9767CC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 05:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F01720784
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 05:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emWiWxRZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbgDBFg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 01:36:27 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33148 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbgDBFg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 01:36:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id c138so1252095pfc.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 22:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IAh7UMloMAsOoi/+PgYpkgLYca+CmRu3t0XReUuJ4tk=;
        b=emWiWxRZn9S+bqaR9D56ZUCgLabBF8zrQYPHzSlVMuFNfqroqPigGnFZbaSqLcXyia
         c75i0fPsGyIvSYmYGik6oKogT8lCvzw6MF6vNvuArNMgLwXSCPXd6vJ1+6lrFbqDrdNm
         26kdg/wkDTiigvjYGuC7badIIixE3CDwpHWxsG499qyXBYr3ZrTff8aivmSgcN4zbfGA
         /2tiOIY5x2A/T66ptBcrGN0p43qo8hJr9nf6iyluWyitOIm6DLDQHEz4VAtibqQWLKol
         s6QY2c8aH8nyUGHf/WO8b5ZquAvsNSoBfVHGTDCqkNfVb9ti10q2P++hOTtw6nFVpueJ
         oaGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IAh7UMloMAsOoi/+PgYpkgLYca+CmRu3t0XReUuJ4tk=;
        b=QKHN/gooOE0fNMNiDSl4+UTSyCB2w4tRVECck1H6MKUhISLVxu9x6glekEb2z1P5v3
         +8XbYeovxo20If8ZBtylY/ACw5tu889nB827BiWF+gWNEsH9dkKa8x//3nfIIL4MdaRu
         e2UJHNNMadL5maJF7RZpOJcZAUPQmbolWPQLUm5nPJOfw3WeSFYulKEyQfop0a7g/xqX
         ih4pUWd9TCzkp5PLTj02YmnPvfOvM1IU3lvFDzVeVPhKfbtMm4aAorUjgBypi7/imLtY
         fcD/EGomOQblRbMV4//tckdWlJORaiEEblQzfisCJr4eh9u5GU9GbQRy5V43rNUFkT74
         rr3w==
X-Gm-Message-State: AGi0PuYwvR7hph7s7Zw2xPZMvb+geFW58WNKr/L8vU/PU3jB28pssM9B
        cHab9PdfeBfQDsB2Yvoelxo=
X-Google-Smtp-Source: APiQypLBx8wymvTZN5pVSUzPbgkNr6Uo8Oq28moaA64ap2WlXHGMyFFgshdRpwK7NEWGTEFIlhH3/g==
X-Received: by 2002:a65:5249:: with SMTP id q9mr1774384pgp.150.1585805785687;
        Wed, 01 Apr 2020 22:36:25 -0700 (PDT)
Received: from OptiPlexFedora.fios-router.home ([47.144.161.84])
        by smtp.gmail.com with ESMTPSA id y28sm2863136pfp.128.2020.04.01.22.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 22:36:25 -0700 (PDT)
From:   "John B. Wyatt IV" <jbwyatt4@gmail.com>
To:     outreachy-kernel@googlegroups.com,
        Rob Springer <rspringer@google.com>,
        Todd Poynor <toddpoynor@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     "John B. Wyatt IV" <jbwyatt4@gmail.com>
Subject: [PATCH 1/2] staging: gasket: Fix 4 over 80 char warnings
Date:   Wed,  1 Apr 2020 22:36:16 -0700
Message-Id: <20200402053617.826678-2-jbwyatt4@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200402053617.826678-1-jbwyatt4@gmail.com>
References: <20200402053617.826678-1-jbwyatt4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix 4 over 80 char warnings by caching long enum values into local
variables.

All enums are only used once inside each function (and once inside
the entire file).

Reported by checkpatch.

Signed-off-by: John B. Wyatt IV <jbwyatt4@gmail.com>
---
 drivers/staging/gasket/apex_driver.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
index 46199c8ca441..f48209ec7d24 100644
--- a/drivers/staging/gasket/apex_driver.c
+++ b/drivers/staging/gasket/apex_driver.c
@@ -253,6 +253,8 @@ static int apex_get_status(struct gasket_dev *gasket_dev)
 /* Enter GCB reset state. */
 static int apex_enter_reset(struct gasket_dev *gasket_dev)
 {
+	int idle_gen_reg = APEX_BAR2_REG_IDLEGENERATOR_IDLEGEN_IDLEREGISTER;
+
 	if (bypass_top_level)
 		return 0;
 
@@ -263,7 +265,7 @@ static int apex_enter_reset(struct gasket_dev *gasket_dev)
 	 *    - Enable GCB idle
 	 */
 	gasket_read_modify_write_64(gasket_dev, APEX_BAR_INDEX,
-				    APEX_BAR2_REG_IDLEGENERATOR_IDLEGEN_IDLEREGISTER,
+				    idle_gen_reg,
 				    0x0, 1, 32);
 
 	/*    - Initiate DMA pause */
@@ -395,11 +397,12 @@ static int apex_device_cleanup(struct gasket_dev *gasket_dev)
 	u64 scalar_error;
 	u64 hib_error;
 	int ret = 0;
+	int status = APEX_BAR2_REG_SCALAR_CORE_ERROR_STATUS;
 
 	hib_error = gasket_dev_read_64(gasket_dev, APEX_BAR_INDEX,
 				       APEX_BAR2_REG_USER_HIB_ERROR_STATUS);
 	scalar_error = gasket_dev_read_64(gasket_dev, APEX_BAR_INDEX,
-					  APEX_BAR2_REG_SCALAR_CORE_ERROR_STATUS);
+					  status);
 
 	dev_dbg(gasket_dev->dev,
 		"%s 0x%p hib_error 0x%llx scalar_error 0x%llx\n",
@@ -584,6 +587,8 @@ static int apex_pci_probe(struct pci_dev *pci_dev,
 	ulong page_table_ready, msix_table_ready;
 	int retries = 0;
 	struct gasket_dev *gasket_dev;
+	int page_table_init = APEX_BAR2_REG_KERNEL_HIB_PAGE_TABLE_INIT;
+	int msix_table_init = APEX_BAR2_REG_KERNEL_HIB_MSIX_TABLE_INIT;
 
 	ret = pci_enable_device(pci_dev);
 	if (ret) {
@@ -606,10 +611,10 @@ static int apex_pci_probe(struct pci_dev *pci_dev,
 	while (retries < APEX_RESET_RETRY) {
 		page_table_ready =
 			gasket_dev_read_64(gasket_dev, APEX_BAR_INDEX,
-					   APEX_BAR2_REG_KERNEL_HIB_PAGE_TABLE_INIT);
+					   page_table_init);
 		msix_table_ready =
 			gasket_dev_read_64(gasket_dev, APEX_BAR_INDEX,
-					   APEX_BAR2_REG_KERNEL_HIB_MSIX_TABLE_INIT);
+					   msix_table_init);
 		if (page_table_ready && msix_table_ready)
 			break;
 		schedule_timeout(msecs_to_jiffies(APEX_RESET_DELAY));
-- 
2.25.1

