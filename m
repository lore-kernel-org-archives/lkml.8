Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C1BC4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 22:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D3CC2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 22:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BK9j0God"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgCWW1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 18:27:47 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44286 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgCWW1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 18:27:47 -0400
Received: by mail-oi1-f195.google.com with SMTP id v134so7540664oie.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 15:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tmt/AtSQf/b1AfMKrhHYlgdsJf3jzbEQVXwlMTLV4uU=;
        b=BK9j0Godyj24t7Fh24qKYPTNIBwldF+AKe5Yhrr1AfBOcN8aG8EwvFxZbx3vpsFFVh
         B87k0TbZhIioXj2VyUHHcm/5XznanhVQ+ny95smNcJE4z28rUfToByS+f7/8MbWIENyQ
         eAyq1UDs8Rw6JgYLk/ie0RPDfZ/StIL63C+uQ6UX1/8wqr18nwx16fjUmAI5Fx3rmcoT
         JIXcrJ14x3c7gLEKDHf1e8HrDCZBbsPq4A/OU7NoAF8MLJiRRc1Huh6uixI3uIThDKO2
         y5NnLa0qxRQjO9bG0uqZreariGc++7WXpSM9JU2WP+lOUouk/RMP1iZRiKJ7dEWQhoHY
         k+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tmt/AtSQf/b1AfMKrhHYlgdsJf3jzbEQVXwlMTLV4uU=;
        b=nuODTjutPNSRqweX8UG8mQSoS5h5YwEzdTGCbSq6aDYT6obfWgEqk1/4oAmUQiSIvA
         hpzwbAsaPMeqLdMSJrKDuFU83MFJAhki4smPEvcaKCctxAfGVG4qBm3+vPNv0CkaQxhw
         J2+OD3s4I6XxZg3jsGxl6l/NSuuWW/lttPqsnoMR9zatvZTcBvdJnf3cmyhgc8344g4C
         mC2tgDh/oDZ6UjMlxuy7B+1sSh9g+cU0ZBEwROHzD8KXCJH2WoDBcROBlgDWWuVuvCzi
         SP5k7hFeRnnBbK3nccwU6sJ/ErsxfFrRQMNGA+LGVtmIIoWZwQATpCN4OafjLV/q1EHT
         rLBA==
X-Gm-Message-State: ANhLgQ0Z1Mm25XiyOc0q4t2AbasSmEZ5hs0Ke8QaTEPwjtQGuzE9O5yF
        s7M1UvryGrE5Naa8fuAsUFk=
X-Google-Smtp-Source: ADFU+vsUUH/xlVPi4/C8Ryv+a8s7tKna64jEsgzR7P/5p5OxS/SoTVln/yBUQR6ydtxBXbp2e0RQhQ==
X-Received: by 2002:aca:3302:: with SMTP id z2mr1282962oiz.3.1585002466086;
        Mon, 23 Mar 2020 15:27:46 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id y9sm5708282oie.0.2020.03.23.15.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 15:27:45 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ilie Halip <ilie.halip@gmail.com>
Subject: [PATCH] powerpc/maple: Fix declaration made after definition
Date:   Mon, 23 Mar 2020 15:27:29 -0700
Message-Id: <20200323222729.15365-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building ppc64 defconfig, Clang errors (trimmed for brevity):

arch/powerpc/platforms/maple/setup.c:365:1: error: attribute declaration
must precede definition [-Werror,-Wignored-attributes]
machine_device_initcall(maple, maple_cpc925_edac_setup);
^

machine_device_initcall expands to __define_machine_initcall, which in
turn has the macro machine_is used in it, which declares mach_##name
with an __attribute__((weak)). define_machine actually defines
mach_##name, which in this file happens before the declaration, hence
the warning.

To fix this, move define_machine after machine_device_initcall so that
the declaration occurs before the definition, which matches how
machine_device_initcall and define_machine work throughout arch/powerpc.

While we're here, remove some spaces before tabs.

Fixes: 8f101a051ef0 ("edac: cpc925 MC platform device setup")
Link: https://godbolt.org/z/kDoYSA
Link: https://github.com/ClangBuiltLinux/linux/issues/662
Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Suggested-by: Ilie Halip <ilie.halip@gmail.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 arch/powerpc/platforms/maple/setup.c | 34 ++++++++++++++--------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/platforms/maple/setup.c b/arch/powerpc/platforms/maple/setup.c
index 6f019df37916..15b2c6eb506d 100644
--- a/arch/powerpc/platforms/maple/setup.c
+++ b/arch/powerpc/platforms/maple/setup.c
@@ -291,23 +291,6 @@ static int __init maple_probe(void)
 	return 1;
 }
 
-define_machine(maple) {
-	.name			= "Maple",
-	.probe			= maple_probe,
-	.setup_arch		= maple_setup_arch,
-	.init_IRQ		= maple_init_IRQ,
-	.pci_irq_fixup		= maple_pci_irq_fixup,
-	.pci_get_legacy_ide_irq	= maple_pci_get_legacy_ide_irq,
-	.restart		= maple_restart,
-	.halt			= maple_halt,
-       	.get_boot_time		= maple_get_boot_time,
-       	.set_rtc_time		= maple_set_rtc_time,
-       	.get_rtc_time		= maple_get_rtc_time,
-      	.calibrate_decr		= generic_calibrate_decr,
-	.progress		= maple_progress,
-	.power_save		= power4_idle,
-};
-
 #ifdef CONFIG_EDAC
 /*
  * Register a platform device for CPC925 memory controller on
@@ -364,3 +347,20 @@ static int __init maple_cpc925_edac_setup(void)
 }
 machine_device_initcall(maple, maple_cpc925_edac_setup);
 #endif
+
+define_machine(maple) {
+	.name			= "Maple",
+	.probe			= maple_probe,
+	.setup_arch		= maple_setup_arch,
+	.init_IRQ		= maple_init_IRQ,
+	.pci_irq_fixup		= maple_pci_irq_fixup,
+	.pci_get_legacy_ide_irq	= maple_pci_get_legacy_ide_irq,
+	.restart		= maple_restart,
+	.halt			= maple_halt,
+	.get_boot_time		= maple_get_boot_time,
+	.set_rtc_time		= maple_set_rtc_time,
+	.get_rtc_time		= maple_get_rtc_time,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= maple_progress,
+	.power_save		= power4_idle,
+};
-- 
2.26.0

