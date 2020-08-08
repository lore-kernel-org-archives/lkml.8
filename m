Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7610C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 12:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B812220759
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 12:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="YBvh7NZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgHHMdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 08:33:10 -0400
Received: from vultr.net.flygoat.com ([149.28.68.211]:43042 "EHLO
        vultr.net.flygoat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgHHMdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 08:33:09 -0400
Received: from localhost.localdomain (unknown [IPv6:2001:da8:20f:4430:250:56ff:fe9a:7470])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id A723D1FF0F;
        Sat,  8 Aug 2020 12:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1596889988; bh=FZwMouVt5pVi2xA2RzMRC4pCbrZinPpiAS2LJWILeXY=;
        h=From:To:Cc:Subject:Date:From;
        b=YBvh7NZBtiWUhmtYedBHrkQScH7pivdDxzStKrTYG/Le1AK2PCMT3SwdOw0DSQOAO
         ykCRgr8PayIVP9SWn6RpzwI09aCkS5ywZtt0oRb/W7QebcMWZ4gNAzfE876ywHuOk/
         oDUsQTTzUT+9I+pERKWsssT1LyFVc7pzVnbdooZwcGK6ft+wCeMIJTob31bEQ1Bxd8
         36myTh0l9NdgzAxk4BRh5XiFHjUK+oS39H6KvfbvlgN2AmOWRxCpUmDxOgVNbLayuw
         +VFRtqMfwA1nQjIqGlOZIOJ7KXBSpAeC6aO6VqFHd76xEbFJGfQnMzcAnnpU69Vfxh
         MPSwNEoK2pj1A==
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH for-fixes] MIPS: Loongson64: Do not override watch and ejtag feature
Date:   Sat,  8 Aug 2020 20:32:27 +0800
Message-Id: <20200808123227.2873961-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.28.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not override ejtag feature to 0 as Loongson 3A1000+ do have ejtag.
For watch, as KVM emulated CPU doesn't have watch feature, we should
not enable it unconditionally.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
This patch should go into mips-fixes tree as watch feature is blocking
KVM guest boot in some cases.
---
 arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h b/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
index b6e9c99b85a5..eb181224eb4c 100644
--- a/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
@@ -26,7 +26,6 @@
 #define cpu_has_counter		1
 #define cpu_has_dc_aliases	(PAGE_SIZE < 0x4000)
 #define cpu_has_divec		0
-#define cpu_has_ejtag		0
 #define cpu_has_inclusive_pcaches	1
 #define cpu_has_llsc		1
 #define cpu_has_mcheck		0
@@ -42,7 +41,6 @@
 #define cpu_has_veic		0
 #define cpu_has_vint		0
 #define cpu_has_vtag_icache	0
-#define cpu_has_watch		1
 #define cpu_has_wsbh		1
 #define cpu_has_ic_fills_f_dc	1
 #define cpu_hwrena_impl_bits	0xc0000000
-- 
2.28.0.rc1

