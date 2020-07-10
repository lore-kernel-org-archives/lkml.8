Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAE2C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 22:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD54E206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 22:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yz/B5qsH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgGJWUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 18:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbgGJWUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 18:20:12 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60379C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 15:20:12 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z15so7333333wrl.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 15:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i1lY4mOYwbC3YTfhlW/QS2seif89bl0vl1xCMEEs94k=;
        b=Yz/B5qsHqYqUiq04kd5kePUIy9vGWkUnOtKFFJMfNukQ/Pkj65Vz63fW7GZ9o16B4b
         jW+3xseRxjwnKDtaKoG7xQCkUukArPJ+twkfFZLws5DGufPIPNTqLKBVl+QX8g8KM+2R
         f59hTUNb89FfwqLP7+mjT1AfZ+kBsbDTnocvuPCwOCLSzm9CxrVHHRVaFktOF+kIk4Up
         mPe4IHKxjCMFUaYCUDFmM9zjL/ZyWr0l4+OyjFOEW4RLo5iaIu6ANyZCrc6W28mWt2PO
         wOTk9Uzjlx3Ffpzz1v51NeYeMaxDppJuqAq5nzBkC014ZBf7RW+9g/kWWfZw4Z/N1v3f
         iY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i1lY4mOYwbC3YTfhlW/QS2seif89bl0vl1xCMEEs94k=;
        b=boivepI+aPQaLEzxORhQ7LDBVohLu13ouuwjVbymB6Obz6Gs0NLtlssJ6pjA5dnGfS
         DHzQh5c2Ier0OYl8NhD9lwhCwQUTuIAsgjL7Co36VNERlsvAJ1ipLGCsDricYw4S3Ps+
         18Il3Gf4GQzMOxGCC1TrXdEywSC36BPbh67RoFt8oF9kKyvc1netyZh2KldGEr/mu7u0
         XKahsFYX/4ZK7TcC8YGMXUz7onafm/0GnQsTDv6uiONNaHiHaVzL2ozFrK7/SjV6oUo/
         B71rnQPh51HZoY/mT5DRTE6pISuRs2B7kHnpckhC9aswFDvWIELE8v43qt+UkHZVigJr
         wMbA==
X-Gm-Message-State: AOAM531qa4BQ1pSaZl5RxJWtgY/pNrez6GgdO1QdPx9rzCya+vNVq05H
        rEmOcD2FRaLhyJq2hXlv6J8=
X-Google-Smtp-Source: ABdhPJzLgCNHcIqTU4KKqGwF2qxzIEG2z5ZfBr1mckA0gtBgXK1kkZVOMPXHxvHWg1dVplPIcC2w+w==
X-Received: by 2002:adf:eec2:: with SMTP id a2mr68357262wrp.127.1594419611018;
        Fri, 10 Jul 2020 15:20:11 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id l18sm12170281wrm.52.2020.07.10.15.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 15:20:10 -0700 (PDT)
From:   Saheed Olayemi Bolarinwa <refactormyself@gmail.com>
To:     helgaas@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/14 v3] misc: rtsx: Check the return value of pcie_capability_read_*()
Date:   Fri, 10 Jul 2020 23:20:14 +0200
Message-Id: <20200710212026.27136-3-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200710212026.27136-1-refactormyself@gmail.com>
References: <20200710212026.27136-1-refactormyself@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

On failure pcie_capability_read_dword() sets it's last parameter, val
to 0. In which case (val & PCI_EXP_DEVCTL2_LTR_EN) evaluates to 0.
However, with Patch 14/14, it is possible that val is set to ~0 on
failure. This would introduce a bug because (x & x) == (~0 & x).

This bug can be avoided without changing the function's behaviour if the
return value of pcie_capability_read_word is checked to confirm success.

Check the return value of pcie_capability_read_word() to ensure success.

Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

---
 drivers/misc/cardreader/rts5227.c | 5 +++--
 drivers/misc/cardreader/rts5249.c | 5 +++--
 drivers/misc/cardreader/rts5260.c | 5 +++--
 drivers/misc/cardreader/rts5261.c | 5 +++--
 4 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/cardreader/rts5227.c b/drivers/misc/cardreader/rts5227.c
index 3a9467aaa435..7a20a4898d07 100644
--- a/drivers/misc/cardreader/rts5227.c
+++ b/drivers/misc/cardreader/rts5227.c
@@ -92,6 +92,7 @@ static void rts5227_force_power_down(struct rtsx_pcr *pcr, u8 pm_state)
 static int rts5227_extra_init_hw(struct rtsx_pcr *pcr)
 {
 	u16 cap;
+	int ret;
 
 	rtsx_pci_init_cmd(pcr);
 
@@ -105,8 +106,8 @@ static int rts5227_extra_init_hw(struct rtsx_pcr *pcr)
 	/* LED shine disabled, set initial shine cycle period */
 	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, OLT_LED_CTL, 0x0F, 0x02);
 	/* Configure LTR */
-	pcie_capability_read_word(pcr->pci, PCI_EXP_DEVCTL2, &cap);
-	if (cap & PCI_EXP_DEVCTL2_LTR_EN)
+	ret = pcie_capability_read_word(pcr->pci, PCI_EXP_DEVCTL2, &cap);
+	if (!ret && (cap & PCI_EXP_DEVCTL2_LTR_EN))
 		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, LTR_CTL, 0xFF, 0xA3);
 	/* Configure OBFF */
 	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, OBFF_CFG, 0x03, 0x03);
diff --git a/drivers/misc/cardreader/rts5249.c b/drivers/misc/cardreader/rts5249.c
index 6c6c9e95a29f..2b05e8663431 100644
--- a/drivers/misc/cardreader/rts5249.c
+++ b/drivers/misc/cardreader/rts5249.c
@@ -95,6 +95,7 @@ static void rts5249_init_from_cfg(struct rtsx_pcr *pcr)
 {
 	struct rtsx_cr_option *option = &(pcr->option);
 	u32 lval;
+	int ret;
 
 	if (CHK_PCI_PID(pcr, PID_524A))
 		rtsx_pci_read_config_dword(pcr,
@@ -118,8 +119,8 @@ static void rts5249_init_from_cfg(struct rtsx_pcr *pcr)
 	if (option->ltr_en) {
 		u16 val;
 
-		pcie_capability_read_word(pcr->pci, PCI_EXP_DEVCTL2, &val);
-		if (val & PCI_EXP_DEVCTL2_LTR_EN) {
+		ret = pcie_capability_read_word(pcr->pci, PCI_EXP_DEVCTL2, &val);
+		if (!ret && (val & PCI_EXP_DEVCTL2_LTR_EN)) {
 			option->ltr_enabled = true;
 			option->ltr_active = true;
 			rtsx_set_ltr_latency(pcr, option->ltr_active_latency);
diff --git a/drivers/misc/cardreader/rts5260.c b/drivers/misc/cardreader/rts5260.c
index 7a9dbb778e84..934aeaeebfaf 100644
--- a/drivers/misc/cardreader/rts5260.c
+++ b/drivers/misc/cardreader/rts5260.c
@@ -498,6 +498,7 @@ static void rts5260_init_from_cfg(struct rtsx_pcr *pcr)
 {
 	struct rtsx_cr_option *option = &pcr->option;
 	u32 lval;
+	int ret;
 
 	rtsx_pci_read_config_dword(pcr, PCR_ASPM_SETTING_5260, &lval);
 
@@ -518,8 +519,8 @@ static void rts5260_init_from_cfg(struct rtsx_pcr *pcr)
 	if (option->ltr_en) {
 		u16 val;
 
-		pcie_capability_read_word(pcr->pci, PCI_EXP_DEVCTL2, &val);
-		if (val & PCI_EXP_DEVCTL2_LTR_EN) {
+		ret = pcie_capability_read_word(pcr->pci, PCI_EXP_DEVCTL2, &val);
+		if (!ret && (val & PCI_EXP_DEVCTL2_LTR_EN)) {
 			option->ltr_enabled = true;
 			option->ltr_active = true;
 			rtsx_set_ltr_latency(pcr, option->ltr_active_latency);
diff --git a/drivers/misc/cardreader/rts5261.c b/drivers/misc/cardreader/rts5261.c
index 195822ec858e..2b6f61696e19 100644
--- a/drivers/misc/cardreader/rts5261.c
+++ b/drivers/misc/cardreader/rts5261.c
@@ -438,9 +438,10 @@ static void rts5261_init_from_cfg(struct rtsx_pcr *pcr)
 	rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, 0xFF, 0);
 	if (option->ltr_en) {
 		u16 val;
+		int ret;
 
-		pcie_capability_read_word(pcr->pci, PCI_EXP_DEVCTL2, &val);
-		if (val & PCI_EXP_DEVCTL2_LTR_EN) {
+		ret = pcie_capability_read_word(pcr->pci, PCI_EXP_DEVCTL2, &val);
+		if (!ret && (val & PCI_EXP_DEVCTL2_LTR_EN)) {
 			option->ltr_enabled = true;
 			option->ltr_active = true;
 			rtsx_set_ltr_latency(pcr, option->ltr_active_latency);
-- 
2.18.2

