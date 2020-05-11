Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D5CC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFDF020735
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com header.b="ilMvyZzr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbgEKLsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:48:09 -0400
Received: from smtp1.axis.com ([195.60.68.17]:8795 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbgEKLsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:48:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=2003; q=dns/txt; s=axis-central1;
  t=1589197687; x=1620733687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OE/19k10wHaCTdv4vIwiGTk7dV4vSV5kv7LOywkW2XA=;
  b=ilMvyZzrDAJxT/n6nX9VEfogHqmZys7oJaGHvehUGvfhtdaMg9EaoHM2
   7arjC7HwSKbAKaq0hXkKMUwwlx57XR+OsXnKWoMaMYJVS5D9f2CYVDqnM
   K13+gmC6UPKDHPrq2MJVVO5wyA4IDKBgcLrKz/h+fMfUXYYIgDPQYbIH6
   mc++CW5OBQGGXJTO7J9BJtyYzMvAcDDb/1kTNhNeNi5vRJTYghkL0V2b6
   gyTB5Nxdm+VykFNNkWvOtFadilRHuM7fY/rPZT2zwf3myJ30wDfsHSYbz
   ZdgCW4AfFYtuzPeb8+kToDM0vFYL2sSftjutgtgknVl8cJEU15mikKLqc
   g==;
IronPort-SDR: 02SQVDjpik5zxGFTX9qHDTx6h+TsrBW/mI8e6OKwbZ2V2pIRyW0gJOUtBPc5udRSKYGCDz2TRP
 BtyJ0kPw9EMk65iaw5ORSzp9FR2PlAKLwKZVIOb1ibUu6/FNY1nmP7ANumYzAQZ+TRbCCkFWU9
 fSP209hHNrQC4vtajdNMSwRevwB1q82NqpdGDCvpH0ZfAAt1U83WkYo/oxzlW5BjHJvil8BRcR
 BW850Lq1eZSWfp2aS/aljyQaVnsrwBMscwaPU3GPeH621K570R9Dc5C2oHI540MLBM5ol0uxE5
 VYc=
X-IronPort-AV: E=Sophos;i="5.73,379,1583190000"; 
   d="scan'208";a="8596078"
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <linux@armlinux.org.uk>, <jeyu@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH v2 2/2] ARM: module: fix handling of unwind init sections
Date:   Mon, 11 May 2020 13:48:03 +0200
Message-ID: <20200511114803.4475-2-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200511114803.4475-1-vincent.whitchurch@axis.com>
References: <20200511114803.4475-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unwind information for init sections is placed in .ARM.exidx.init.text
and .ARM.extab.init.text.  The module core doesn't know that these are
init sections so they are allocated along with the core sections, and if
the core and init sections get allocated in different memory regions
(which is possible with CONFIG_ARM_MODULE_PLTS=y) and they can't reach
each other, relocation fails:

  final section addresses:
  	...
  	0x7f800000 .init.text
	..
  	0xcbb54078 .ARM.exidx.init.text
	..

 section 16 reloc 0 sym '': relocation 42 out of range (0xcbb54078 ->
 0x7f800000)

Fix this by informing the module core that these sections are init
sections, and by removing the init unwind tables before the module core
frees the init sections.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
v2: No changes.

 arch/arm/kernel/module.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index deef17f34bd2..af0a8500a24e 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -55,6 +55,13 @@ void *module_alloc(unsigned long size)
 }
 #endif
 
+bool module_init_section(const char *name)
+{
+	return strstarts(name, ".init") ||
+		strstarts(name, ".ARM.extab.init") ||
+		strstarts(name, ".ARM.exidx.init");
+}
+
 bool module_exit_section(const char *name)
 {
 	return strstarts(name, ".exit") ||
@@ -409,8 +416,17 @@ module_arch_cleanup(struct module *mod)
 #ifdef CONFIG_ARM_UNWIND
 	int i;
 
-	for (i = 0; i < ARM_SEC_MAX; i++)
-		if (mod->arch.unwind[i])
-			unwind_table_del(mod->arch.unwind[i]);
+	for (i = 0; i < ARM_SEC_MAX; i++) {
+		unwind_table_del(mod->arch.unwind[i]);
+		mod->arch.unwind[i] = NULL;
+	}
+#endif
+}
+
+void __weak module_arch_freeing_init(struct module *mod)
+{
+#ifdef CONFIG_ARM_UNWIND
+	unwind_table_del(mod->arch.unwind[ARM_SEC_INIT]);
+	mod->arch.unwind[ARM_SEC_INIT] = NULL;
 #endif
 }
-- 
2.25.1

