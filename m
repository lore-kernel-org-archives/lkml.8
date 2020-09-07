Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30F0C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2A7321556
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599498784;
	bh=AVqPuBkTTjcguZkuosZqOamQYFdo3B3gnE6D204M4To=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LOhlZmI6/0AdhqZ+oGT1bIncQj1zNqZV4dT1u0cLPNaJxen68vWBiHN0tuXAkrMnz
	 KKHpReSFanZVn1TmefZfSwmf+UH6pyztCvq7lLK8EUQpzSe0ZICgC1cz2fF6fS6wxt
	 kaLCjSgp0n/ahqAIuQuX5rykNX2ttmGqesuoEfGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731273AbgIGRM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:12:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730589AbgIGQcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:32:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C24EE218AC;
        Mon,  7 Sep 2020 16:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599496344;
        bh=AVqPuBkTTjcguZkuosZqOamQYFdo3B3gnE6D204M4To=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VHtHKTmzAUq4Dg5QWZT6zXALMVNhSbbsWSfd1d8fUE/rF2XjrfdFjQ8auHvEkFZwu
         ok8PY0IKE8tXrXw4TDrC4AMbWe4qtWlDyutkEQzrIB7aDPwvMU0vRbol8gHAVLRXK2
         a3EGAuedTrMNeq87vgEHYTjYFgDra0Gp64VGB7Hk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <sashal@kernel.org>, linux-mips@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 03/53] MIPS: Loongson64: Do not override watch and ejtag feature
Date:   Mon,  7 Sep 2020 12:31:29 -0400
Message-Id: <20200907163220.1280412-3-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907163220.1280412-1-sashal@kernel.org>
References: <20200907163220.1280412-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

[ Upstream commit 433c1ca0d441ee0b88fdd83c84ee6d6d43080dcd ]

Do not override ejtag feature to 0 as Loongson 3A1000+ do have ejtag.
For watch, as KVM emulated CPU doesn't have watch feature, we should
not enable it unconditionally.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Reviewed-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h b/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
index b6e9c99b85a52..eb181224eb4c4 100644
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
2.25.1

