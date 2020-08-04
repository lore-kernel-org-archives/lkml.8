Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACF7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8DE122CF7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbgHDQKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 12:10:42 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:50742 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728777AbgHDQHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 12:07:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 92B20EB27;
        Tue,  4 Aug 2020 18:07:00 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id y6vmc6G22xcS; Tue,  4 Aug 2020 18:06:59 +0200 (CEST)
Received: from function (lfbn-bor-1-797-11.w86-234.abo.wanadoo.fr [86.234.239.11])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id B597F83E4;
        Tue,  4 Aug 2020 18:06:59 +0200 (CEST)
Received: from samy by function with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1k2zSt-0027me-1x; Tue, 04 Aug 2020 18:06:59 +0200
Date:   Tue, 4 Aug 2020 18:06:59 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: [PATCHv2 2/2] speakup: only build serialio when ISA is enabled
Message-ID: <20200804160659.7y76sdseow43lfms@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        speakup@linux-speakup.org
References: <20200804160637.x3iycau5izywbgzl@function>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804160637.x3iycau5izywbgzl@function>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers using serialio were already made available in Kconfig only under
the ISA condition.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Index: linux-2.6/drivers/accessibility/speakup/Makefile
===================================================================
--- linux-2.6.orig/drivers/accessibility/speakup/Makefile
+++ linux-2.6/drivers/accessibility/speakup/Makefile
@@ -25,8 +25,8 @@ speakup-y := \
 	keyhelp.o \
 	kobjects.o \
 	selection.o \
-	serialio.o \
 	spk_ttyio.o \
 	synth.o \
 	thread.o \
 	varhandlers.o
+speakup-$(CONFIG_SPEAKUP_SERIALIO) += serialio.o
Index: linux-2.6/drivers/accessibility/speakup/Kconfig
===================================================================
--- linux-2.6.orig/drivers/accessibility/speakup/Kconfig
+++ linux-2.6/drivers/accessibility/speakup/Kconfig
@@ -42,6 +42,11 @@ config SPEAKUP
 		one of the listed synthesizers, you should say n.
 
 if SPEAKUP
+
+config SPEAKUP_SERIALIO
+	def_bool y
+	depends on ISA || COMPILE_TEST
+
 config SPEAKUP_SYNTH_ACNTSA
 	tristate "Accent SA synthesizer support"
 	help
@@ -52,7 +57,7 @@ config SPEAKUP_SYNTH_ACNTSA
 
 config SPEAKUP_SYNTH_ACNTPC
 	tristate "Accent PC synthesizer support"
-	depends on ISA || COMPILE_TEST
+	depends on SPEAKUP_SERIALIO
 	help
 		This is the Speakup driver for the accent pc
 		synthesizer.  You can say y to build it into the kernel,
@@ -104,7 +109,7 @@ config SPEAKUP_SYNTH_DECEXT
 
 config SPEAKUP_SYNTH_DECPC
 	depends on m
-	depends on ISA || COMPILE_TEST
+	depends on SPEAKUP_SERIALIO
 	tristate "DECtalk PC (big ISA card) synthesizer support"
 	help
 
@@ -127,7 +132,7 @@ config SPEAKUP_SYNTH_DECPC
 
 config SPEAKUP_SYNTH_DTLK
 	tristate "DoubleTalk PC synthesizer support"
-	depends on ISA || COMPILE_TEST
+	depends on SPEAKUP_SERIALIO
 	help
 
 		This is the Speakup driver for the internal DoubleTalk
@@ -138,7 +143,7 @@ config SPEAKUP_SYNTH_DTLK
 
 config SPEAKUP_SYNTH_KEYPC
 	tristate "Keynote Gold PC synthesizer support"
-	depends on ISA || COMPILE_TEST
+	depends on SPEAKUP_SERIALIO
 	help
 
 		This is the Speakup driver for the Keynote Gold
