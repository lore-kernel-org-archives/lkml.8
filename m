Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC43C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 23:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3D982065D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 23:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ou7IvQjQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbgGGXDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 19:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbgGGXDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 19:03:46 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8158AC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 16:03:45 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id rk21so48455563ejb.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 16:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eDBfMfO3gH5XivlUuml3iPrkilSX9rGahEiW/VBWUow=;
        b=ou7IvQjQr1Q/ko6wXjR104fN8y9sz8sdtEUgt6XuwBDCe/bqL7yG4MquFqpwpesoNz
         4mQHGHG8rhlYgMovXI+2u1t0kTuTb16vMzkYt8LMQfW8dsJ10uVdWhGj2npLhQjxTFQ5
         bNEPjnVtwAwiDjhRcHBMX+CO15CDxvWI39OwhnkpSme+k+8If4V3geXKh7TC41tiqRIl
         LazOhFBwS0CWwj+s5WvoSbL8jtujUEJ+RcbWYSvwyTf6lWjOomxJWLNceHmM95FPgwtM
         XsFlIm8VWI6zmE4UL1ki6huTv6nhWYtsjREj2tovGbxGtnv8/GoAxXfc3MvlWf8VJDi/
         YPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eDBfMfO3gH5XivlUuml3iPrkilSX9rGahEiW/VBWUow=;
        b=oVQ/JZ0cXCPZudk6FzuqvBYNmZcKsp4aPkLe45grDEgrquyUYaRV4BQWZmYIQjstLU
         WTzMzbpu/DpI8IKrZ3W9yQ3HQ+9kjqkZ7xDCLDQbH4qWhmzzfI1wOYa7no9zduqPp73F
         tBulsRJPgrDMPCMbCxr+wdK+XDvh3iwoFjZdzHYwaoMWspK0ZacV722u8wknupRCwQwn
         9YIzj93dlQ5+wCWJ28yUk3+nXm6ODh60VKGfVUQV/8hHtxTlUvAROWMtF4JEN8Flj1N1
         Xtg/1Inn91f/V1L+fTYFbx8ZrSlM/WHpdHGFFJsIN0FMx4/tPtSbZrWriZXbq4b80aR0
         wzFg==
X-Gm-Message-State: AOAM533zh5VLBJ24qVLDLjO58MZsz+AtARF3eZcJ0xiWKQz24l9Z6mmX
        DEZfW0rl2PAgSmhwfpQwQpM=
X-Google-Smtp-Source: ABdhPJwtxtIuKYVG7KClu+FbOLLOSlitE09bPAeMD6EZGf+XK2CKnqIBEZR0FluZwQZL99Gj8OP1Ag==
X-Received: by 2002:a17:906:f94c:: with SMTP id ld12mr48127036ejb.426.1594163024217;
        Tue, 07 Jul 2020 16:03:44 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id f10sm27096310edx.5.2020.07.07.16.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 16:03:43 -0700 (PDT)
From:   Saheed Olayemi Bolarinwa <refactormyself@gmail.com>
To:     helgaas@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/13] misc: rtsx: Check the return value of pcie_capability_read_*()
Date:   Wed,  8 Jul 2020 00:03:13 +0200
Message-Id: <20200707220324.8425-3-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200707220324.8425-1-refactormyself@gmail.com>
References: <20200707220324.8425-1-refactormyself@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

On failure pcie_capability_read_dword() sets it's last parameter, val
to 0. In which case (val & PCI_EXP_DEVCTL2_LTR_EN) evaluates to 0.
However, with Patch 13/13, it is possible that val is set to ~0 on
failure. This would introduce a bug because (x & x) == (~0 & x).

This bug can be avoided without changing the function's behaviour if the
return value of pcie_capability_read_word is checked to confirm success.

Check the return value of pcie_capability_read_word() to ensure success.

Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
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

