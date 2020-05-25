Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5B0C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 03:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D88D206D5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 03:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VM98ejsh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbgEYDrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 23:47:11 -0400
Received: from mail-m973.mail.163.com ([123.126.97.3]:46642 "EHLO
        mail-m973.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728324AbgEYDrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 23:47:11 -0400
X-Greylist: delayed 911 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 May 2020 23:47:10 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=6IIXyf48wsHgqxd09c
        IS/+VIQjuoiphPvmEZfA1FK2I=; b=VM98ejsh2KJDz3pcVRV6fzBVHFQbSmIFiG
        NxRiHdZH4PeEeRGgqy9+ZXOVxTv89q5goD/dvubwCXFHPBGmLmCnPFysdYAz+Xl1
        5Lr570BxzahWFxtLl7Y9sIilGAM50wJuNJIBbo6NTWkkYyJfJZsXtjHCEcd20rfY
        IfztGiQ4I=
Received: from localhost.localdomain (unknown [124.64.17.235])
        by smtp3 (Coremail) with SMTP id G9xpCgA3pKwbPMte3DLsAg--.227S4;
        Mon, 25 May 2020 11:31:48 +0800 (CST)
From:   YuanJunQing <yuanjunqing66@163.com>
To:     tsbogend@alpha.franken.de
Cc:     paulburton@kernel.org, chenhc@lemote.com,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        liulichao@loongson.cn, YuanJunQing <yuanjunqing66@163.com>
Subject: [PATCH] MIPS: Fix IRQ tracing when call handle_fpe()
Date:   Mon, 25 May 2020 11:31:23 +0800
Message-Id: <20200525033123.13114-1-yuanjunqing66@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: G9xpCgA3pKwbPMte3DLsAg--.227S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7XrWUurykKryUurWrCF17KFg_yoWDXwc_Kr
        4Iq3yj9rn8GwsxWF1xtw4rWr92gw4SgF9akryq9w4Yyr15urn09r4kWFykX3Z3Wr4SkFWI
        y3s8CFn3CF1xtjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUHUqUUUUUU==
X-Originating-IP: [124.64.17.235]
X-CM-SenderInfo: h1xd0ypxqtx0rjwwqiywtou0bp/1tbiNgQvXFWBjPQihAAAsL
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Register "a1" is unsaved in this function,
 when CONFIG_TRACE_IRQFLAGS is enabled,
 the TRACE_IRQS_OFF macro will call trace_hardirqs_off(),
 and this may change register "a1".
 The variment of register "a1" may send SIGFPE signal
 to task when call do_fpe(),and this may kill the task.

Signed-off-by: YuanJunQing <yuanjunqing66@163.com>
---
 arch/mips/kernel/genex.S | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index 8236fb291e3f..956a76429773 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -480,16 +480,18 @@ NESTED(nmi_handler, PT_SIZE, sp)
 	/* gas fails to assemble cfc1 for some archs (octeon).*/ \
 	.set	mips1
 	SET_HARDFLOAT
-	cfc1	a1, fcr31
+	cfc1	s0, fcr31
 	.set	pop
 	CLI
 	TRACE_IRQS_OFF
+	move    a1,s0
 	.endm
 
 	.macro	__build_clear_msa_fpe
-	_cfcmsa	a1, MSA_CSR
+	_cfcmsa	s0, MSA_CSR
 	CLI
 	TRACE_IRQS_OFF
+	move    a1,s0
 	.endm
 
 	.macro	__build_clear_ade
-- 
2.17.1

