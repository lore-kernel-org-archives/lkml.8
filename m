Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECA2C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 05:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83122207ED
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 05:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="ZfnV8TRN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgE0F14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 01:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgE0F1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 01:27:55 -0400
Received: from vultr.net.flygoat.com (vultr.net.flygoat.com [IPv6:2001:19f0:6001:3633:5400:2ff:fe8c:553])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F96C061A0F;
        Tue, 26 May 2020 22:27:55 -0700 (PDT)
Received: from localhost.localdomain (unknown [142.147.94.151])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id CBA6A20CF1;
        Wed, 27 May 2020 05:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1590557274; bh=tyvvfagfsu9f7HfjLvutuI+UZCSBQKRjuuJghsFVXtc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZfnV8TRNkmp3XM1lOxG+iIXlflLk/EUEotoEqqQRKWuVccegGXkRlpgUGvP3LDpJ7
         deGZoEhj3Y1D2GYSd0jgdXDlx3Iv9bmoRQo8O61n/q3ecjyx7bLDXv2ws3UhmAjYGj
         e8lxgUvDhi57Sph2w5/+rO7sVf/QQAkvnKEnjuchpU3r6C9La6e3NiAzm45y92RkfN
         gcHYYyOMYLqiMztIHP6UHzWgM2k4+JMQzsyVVbOwfWTMO1kLfCjWf2azr/nDzgqZaG
         NOWuWAl9Hh7+zAjr3mL6XWnogG+5llnDfr2OJpEFG55+kat/w+TAB9MBBSAqwGDnSw
         NqKrLqE+Q1Mkw==
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] MIPS: Loongso64: select NO_EXCEPT_FILL
Date:   Wed, 27 May 2020 13:27:19 +0800
Message-Id: <20200527052721.366704-3-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <20200527052721.366704-1-jiaxun.yang@flygoat.com>
References: <20200527052721.366704-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Loongson64 load kernel at 0x82000000 and allocate exception vectors
by ebase. So we don't need to reserve space for exception vectors
at head of kernel.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 3ca59b610a67..0e385f7b7691 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -462,6 +462,7 @@ config MACH_LOONGSON64
 	select IRQ_MIPS_CPU
 	select NR_CPUS_DEFAULT_64
 	select USE_GENERIC_EARLY_PRINTK_8250
+	select NO_EXCEPT_FILL
 	select SYS_HAS_CPU_LOONGSON64
 	select SYS_HAS_EARLY_PRINTK
 	select SYS_SUPPORTS_SMP
-- 
2.27.0.rc0

