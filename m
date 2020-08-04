Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754DBC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57E012075D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbgHDLTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 07:19:30 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:46426 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730012AbgHDLOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 07:14:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id B4613DB76;
        Tue,  4 Aug 2020 13:13:33 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Pl8Jk5nyrYj5; Tue,  4 Aug 2020 13:13:33 +0200 (CEST)
Received: from function (lfbn-bor-1-797-11.w86-234.abo.wanadoo.fr [86.234.239.11])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 208D51866;
        Tue,  4 Aug 2020 13:13:33 +0200 (CEST)
Received: from samy by function with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1k2usu-001aKA-9s; Tue, 04 Aug 2020 13:13:32 +0200
Date:   Tue, 4 Aug 2020 13:13:32 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     speakup@linux-speakup.org
Subject: [PATCH 2/2] speakup: only build serialio when ISA is enabled
Message-ID: <20200804111332.dex7jobmabifdzw5@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        speakup@linux-speakup.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers using serialio are already made available in Kconfig only under
the ISA condition.

This solves warnings in inb/outb macros on platform that do not have 
support for ISA.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Index: linux-2.6/drivers/accessibility/speakup/Makefile
===================================================================
--- linux-2.6.orig/drivers/accessibility/speakup/Makefile
+++ linux-2.6/drivers/accessibility/speakup/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_SPEAKUP_SYNTH_TXPRT) += spe
 obj-$(CONFIG_SPEAKUP_SYNTH_DUMMY) += speakup_dummy.o
 
 obj-$(CONFIG_SPEAKUP) += speakup.o
+obj-$(CONFIG_ISA) += serialio.o
 speakup-y := \
 	buffers.o \
 	devsynth.o \
@@ -25,7 +26,6 @@ speakup-y := \
 	keyhelp.o \
 	kobjects.o \
 	selection.o \
-	serialio.o \
 	spk_ttyio.o \
 	synth.o \
 	thread.o \
