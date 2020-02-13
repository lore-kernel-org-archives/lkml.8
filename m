Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC318C352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 04:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E6E4206ED
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 04:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="GJZQGNDo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cLlgoPPa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbgBMEZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 23:25:01 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:50013 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729358AbgBMEZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 23:25:00 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 4D68F21ED6;
        Wed, 12 Feb 2020 23:24:59 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 12 Feb 2020 23:24:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=iZubnMrBjXEk8g508J0BHfR8oe
        p9plnUPmPYucbo4Ws=; b=GJZQGNDodRtGD0R9q1c0WPj71h5Fo9pKqeQDjU3jkt
        dCB6oUFV4uW+CAV09y5toD/+Qxd3FLNXrujTsyyLSiXESMCkCqPPmESktoR6MXNC
        0uEwiLf/6uM1h3RjUDLMk6LqpTfFag18ZWQ+Gv6l+U/m9K2xi7zB2bdfxRmx/sk7
        7FTSRInu+hM6hMdrefJ2cCSkyucYjWzFebm/WbzV1t/cXYe88SQp8qDZ05WorLqb
        a3skqJ9cZSbbwoB6CpYRm4sOOoP7C0vRaf+0E24CPf/2AdDW0dI15S4JBl+qaja5
        Ob257cozmP0b21CtZaPO5jfA/7Wh6FVZhCN5N4OBLBNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=iZubnMrBjXEk8g508
        J0BHfR8oep9plnUPmPYucbo4Ws=; b=cLlgoPPa8ER6SDyy0/9fTB/89XLbO4fQJ
        cseOwzv5A1C1/uqGs42nwyYNG7n60KV/pmeu/N5FAfWH1iHsWlhdwQ0hSbbIo5oC
        BPUgG0CazWxv9b9sgMmWdCqcJVbYShID6D+MhgwIGJZHMXQovTIsGCMkVoV+Wy+k
        o/rgm7hb4EFCWLrzJjUfC6GPIl1fX6padzv8O6sCVQazYlLUAVk85PlnIYDzYMDj
        a+kHnygs9sFwqUYToomMXywcPvtQTwSivF1N1B0TE2vWhzp360OW7d66yqSKfMLK
        kgrY74R08b2iMNnQR7ift7we0GOYF9pIfo+ZAPn3Tbwv+NCYDPKBg==
X-ME-Sender: <xms:m89EXijq7Nxiibf0W93WlOyLaOEb7rZ80Ih5vHjiuRSj72AISQHVcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrieejgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghlucfj
    ohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppeejtd
    drudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:m89EXnSYRBmHkrAJ04UPFZ5QlLLC6VnsMAb-R9JoBE91RHGv-ZRJyw>
    <xmx:m89EXlEOyEe68ycGUL3uGzV2QoEKNRw21Hg9vy6Pu1U6msjDp4XZFQ>
    <xmx:m89EXvnntcwwE0iaTWfCtcRu7WL2FFvYJLYQYy7yxYh0i7BO5OOV-Q>
    <xmx:m89EXtwFakvAb95eHuEP8MaRhe0XK8VvEizd7mEnb4_cPhpDke9CTg>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id B147230607B0;
        Wed, 12 Feb 2020 23:24:58 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH] arm64: kaslr: Fix build failure with CONFIG_ARCH_RANDOM=n
Date:   Wed, 12 Feb 2020 22:24:57 -0600
Message-Id: <20200213042457.17842-1-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2e8e1ea88cbc ("arm64: Use v8.5-RNG entropy for KASLR seed")
introduced unconditional use of arm64-specific functions exported by
asm/archrandom.h. With CONFIG_ARCH_RANDOM=y, this header is transitively
included through linux/random.h. However, with CONFIG_ARCH_RANDOM=n,
this header is not included, and the kernel fails to build.

Explicitly include asm/archrandom.h so __early_cpu_has_rndr() and
__arm64_rndr() are always available, even when they are just stubs.

Fixes: 2e8e1ea88cbc ("arm64: Use v8.5-RNG entropy for KASLR seed")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/kernel/kaslr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
index 53b8a4ee64ff..91a83104c6e8 100644
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -11,6 +11,7 @@
 #include <linux/sched.h>
 #include <linux/types.h>
 
+#include <asm/archrandom.h>
 #include <asm/cacheflush.h>
 #include <asm/fixmap.h>
 #include <asm/kernel-pgtable.h>
-- 
2.24.1

