Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7852C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC2F82054F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6ufszp7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbgEMVql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 17:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729627AbgEMVqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 17:46:40 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1E3C061A0C;
        Wed, 13 May 2020 14:46:39 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id h17so1306051wrc.8;
        Wed, 13 May 2020 14:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jW05YIYcf1GNolkjiyr0mICfCVmFkBpfqxOEcp+jfSE=;
        b=B6ufszp741BrL+8jST20P2NOnKbKE/LNB0r5wtKJFYTRDlckV/y9gXmjPYv7DSytm5
         N3AMbtHVrYFTCSwCiaDlyXrW9z+p7l1w7/eCeTbBxTMtWGRX/SMolhOP8VQuYczT9DkW
         CHxeTsCHlwc5lCyzBPRZ+M31ujfjBfGSgHqx/27EQC1XXYkWNnbps5HfIjw+hKDNFXxN
         vWzEDj7eVxbdYYTapTC0qlRtAKivLG64U/FR6pXzZpuchoBxHQ3c4SiBUSL+C8ypStQB
         5zCBc5kn2VvrXWVcZpwx3hfjvSfAo0EhObsX7ynqyraCai9yJALEmKdL3D464SExMah7
         6OvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jW05YIYcf1GNolkjiyr0mICfCVmFkBpfqxOEcp+jfSE=;
        b=VXudyQwTO717oUQA2hMHTnnlXhYQUlVbF6ELZkoq7wXIZWurbppl5KzzAolA9NuaSm
         ZAzVnDAAIG/I36xDcW2L2/b46JS/MDdeMgmNSk4fbxOHiu5503ikT7q3vl/9ENiTuTxe
         Fa0TTIoHM2HVgd8CgWe/aYfTpHpmt9BmqMeSVL+iwT5DmnfYRN6eZduc1i15GYR1Atqf
         TnMmFVNakAPMGLe5/J78J8YSvMVU5B3LqDfq4/KPgC8Yp4knnxAeVWDs6k+sUeqF2AEH
         jxbLJOpO7hTpqH3ClpLw2ewA4Dwc4W5xQIuhHVfhV45/jQH/guXGPaixCqU8xvFELBLo
         HMIw==
X-Gm-Message-State: AOAM531ptTe78VNcGTl+vGMbq/3kxTOAe2oRbH86lY407vdKHQ4zeKtK
        RM1WRNqDexvhdzb7UxfCu1c=
X-Google-Smtp-Source: ABdhPJw3w2J0RzaICCUDrZ+Ja4zE6bbo3lH35G0biusV3jmscCSLw1DMkpvIdJ8Bwau8RbnHiAwd8A==
X-Received: by 2002:adf:f605:: with SMTP id t5mr1519029wrp.354.1589406398407;
        Wed, 13 May 2020 14:46:38 -0700 (PDT)
Received: from localhost.localdomain (cpc91192-cmbg18-2-0-cust374.5-4.cable.virginm.net. [80.6.113.119])
        by smtp.gmail.com with ESMTPSA id m23sm1699734wmg.45.2020.05.13.14.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 14:46:37 -0700 (PDT)
From:   Emil Velikov <emil.l.velikov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     emil.l.velikov@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Subject: [PATCH 01/11] tty/sysrq: alpha: export and use __sysrq_get_key_op()
Date:   Wed, 13 May 2020 22:43:41 +0100
Message-Id: <20200513214351.2138580-1-emil.l.velikov@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export a pointer to the sysrq_get_key_op(). This way we can cleanly
unregister it, instead of the current solutions of modifuing it inplace.

Since __sysrq_get_key_op() is no longer used externally, let's make it
a static function.

This patch will allow us to limit access to each and every sysrq op and
constify the sysrq handling.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-kernel@vger.kernel.org
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
Please keep me in the CC list, as I'm not subscribed to the list.

IMHO it would be better if this gets merged this via the tty tree.
---
 arch/alpha/kernel/setup.c | 13 +++++++++++--
 drivers/tty/sysrq.c       |  4 +++-
 include/linux/sysrq.h     |  2 +-
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/alpha/kernel/setup.c b/arch/alpha/kernel/setup.c
index f19aa577354b..dd7f770f23cf 100644
--- a/arch/alpha/kernel/setup.c
+++ b/arch/alpha/kernel/setup.c
@@ -430,6 +430,15 @@ register_cpus(void)
 
 arch_initcall(register_cpus);
 
+#ifdef CONFIG_MAGIC_SYSRQ
+static struct sysrq_key_op srm_sysrq_reboot_op = {
+	.handler	= machine_halt,
+	.help_msg       = "reboot(b)",
+	.action_msg     = "Resetting",
+	.enable_mask    = SYSRQ_ENABLE_BOOT,
+};
+#endif
+
 void __init
 setup_arch(char **cmdline_p)
 {
@@ -550,8 +559,8 @@ setup_arch(char **cmdline_p)
 	/* If we're using SRM, make sysrq-b halt back to the prom,
 	   not auto-reboot.  */
 	if (alpha_using_srm) {
-		struct sysrq_key_op *op = __sysrq_get_key_op('b');
-		op->handler = (void *) machine_halt;
+		unregister_sysrq_key('b', __sysrq_reboot_op);
+		register_sysrq_key('b', &srm_sysrq_reboot_op);
 	}
 #endif
 
diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 0dc3878794fd..1741134cabca 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -172,6 +172,8 @@ static struct sysrq_key_op sysrq_reboot_op = {
 	.enable_mask	= SYSRQ_ENABLE_BOOT,
 };
 
+struct sysrq_key_op *__sysrq_reboot_op = &sysrq_reboot_op;
+
 static void sysrq_handle_sync(int key)
 {
 	emergency_sync();
@@ -516,7 +518,7 @@ static int sysrq_key_table_key2index(int key)
 /*
  * get and put functions for the table, exposed to modules.
  */
-struct sysrq_key_op *__sysrq_get_key_op(int key)
+static struct sysrq_key_op *__sysrq_get_key_op(int key)
 {
         struct sysrq_key_op *op_p = NULL;
         int i;
diff --git a/include/linux/sysrq.h b/include/linux/sysrq.h
index 8e159e16850f..9b51f98e5f60 100644
--- a/include/linux/sysrq.h
+++ b/include/linux/sysrq.h
@@ -47,7 +47,7 @@ void handle_sysrq(int key);
 void __handle_sysrq(int key, bool check_mask);
 int register_sysrq_key(int key, struct sysrq_key_op *op);
 int unregister_sysrq_key(int key, struct sysrq_key_op *op);
-struct sysrq_key_op *__sysrq_get_key_op(int key);
+extern struct sysrq_key_op *__sysrq_reboot_op;
 
 int sysrq_toggle_support(int enable_mask);
 int sysrq_mask(void);
-- 
2.25.1

