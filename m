Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95641C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D1192068E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com header.b="NKcnOcbz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730113AbgEFP0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:26:02 -0400
Received: from smtp2.axis.com ([195.60.68.18]:64270 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729606AbgEFPZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=1984; q=dns/txt; s=axis-central1;
  t=1588778747; x=1620314747;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g4pSnXC9ETSX82mL7jdj/f/E60NtYuVks+hnYgNlpAE=;
  b=NKcnOcbz+JCP5wFQb4GS5aTEgqywBPIw0bFCxq2t7iFBe9Z4DFl4XLXj
   x3botCuS7l/7OqQA5uyCyI+aTi/JSY3l40fqdHsIxPwuX05k5ZIKpdASo
   3OQOdj3yOGfD1aqKtExEJDenRbs2Zmjjz0GjD62DYbtBmnIEQ3olxpNJe
   zhbOWQE1O+vKlEXWpKaGsfnk9YGX2yEoO8xueqaMrhDjHo/JDJ60aofy3
   jpA9HibLsDqoc0VV+soyTsr/56I82L8fHLXQ6f9ukLeo2h9K3bpilXg4L
   bf3XKH6uW+PnH8z1UlG1/eIFcswrhFXjGMipeTN3p6/DmRhZYF4whZOyC
   g==;
IronPort-SDR: AKBGHpcM8BafnapRQsr1FxP3dvICNjoNiKOvJze/+/IugtOp7sq8s6+xM8k6OISvdahdvSesLQ
 y+KB0pKhJ8uYqtklAe7SGgadnPokY0B7z8aizYJ5Srqi1xo7o5MaS/tYmg4H6Jrr+epHco5pwW
 ka31te4LKvOcNeWtTojZxFx6vZv41ZSHUhwyX2ATO4AtgKTRAH8aRAsvqlG65IU2O0z7tkpNPg
 HRYj9S7mulBTjiQxGRUJDvSgLvxhMrgEIHVfye8OLeqzM5NSWaZ3W+8jrQ+5HPyoVDXxRg5Abz
 utA=
X-IronPort-AV: E=Sophos;i="5.73,359,1583190000"; 
   d="scan'208";a="8222270"
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <linux@armlinux.org.uk>, <jeyu@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH 2/2] ARM: module: fix handling of unwind init sections
Date:   Wed, 6 May 2020 17:25:33 +0200
Message-ID: <20200506152533.31286-2-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200506152533.31286-1-vincent.whitchurch@axis.com>
References: <20200506152533.31286-1-vincent.whitchurch@axis.com>
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

