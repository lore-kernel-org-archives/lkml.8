Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEAEC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 00:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82AF420756
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 00:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="T1UJo69k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgHLAPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 20:15:43 -0400
Received: from crapouillou.net ([89.234.176.41]:52106 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbgHLAPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 20:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1597191321; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7XO3v5AyYseHPAuYJbHPtlC6RLhhlxBPb915QBBXoYI=;
        b=T1UJo69k6Tptfm1mvT//hUF9Rwt3NPqtzd+7pXyrJxIkmGLwOj2q51Rv2jTgeEGyc53v7U
        AWL2uapUkQD76a3COcDfBOluKxuW/E6NSf5RH+BLIoPaxyfnyb15E6IGV5NWW2gu2muKuI
        y30Ws/F74S03eoHn7mYpb+RlwYE+w1w=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Paul Burton <paulburton@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0?= <zhouyanjie@wanyeetech.com>,
        od@zcrc.me, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 03/13] MIPS: cpu-probe: ingenic: Fix broken BUG_ON
Date:   Wed, 12 Aug 2020 02:15:00 +0200
Message-Id: <20200812001510.460382-4-paul@crapouillou.net>
In-Reply-To: <20200812001510.460382-1-paul@crapouillou.net>
References: <20200812001510.460382-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous code was doing:
BUG_ON(!__builtin_constant_p(cpu_has_counter) || cpu_has_counter);

This only worked as the "cpu_has_counter" macro was overridden in
<cpu-feature-overrides.h>. The default "cpu_has_counter" macro is
non-constant, which triggered the BUG_ON() independently of the value
returned by the macro.

What we want to check here, is that *if* the macro was overridden to a
compile-time constant, then must be defined to zero, otherwise it's a
bug.

So the correct check is:
BUG_ON(__builtin_constant_p(cpu_has_counter) && cpu_has_counter);

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: No change

 arch/mips/kernel/cpu-probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index a07e66a6e063..6be23f205e74 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -2123,7 +2123,7 @@ static inline void cpu_probe_ingenic(struct cpuinfo_mips *c, unsigned int cpu)
 
 	/* XBurst does not implement the CP0 counter. */
 	c->options &= ~MIPS_CPU_COUNTER;
-	BUG_ON(!__builtin_constant_p(cpu_has_counter) || cpu_has_counter);
+	BUG_ON(__builtin_constant_p(cpu_has_counter) && cpu_has_counter);
 
 	/* XBurst has virtually tagged icache */
 	c->icache.flags |= MIPS_CACHE_VTAG;
-- 
2.28.0

