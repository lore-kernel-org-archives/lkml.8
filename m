Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E03C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D41520C09
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599593422;
	bh=jpKBANjWFwKlQmZz2iL/OfbL8AE+Hbc6G+JG21oHazI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gb2TdVLK4zuePSWjyMgSrzMEbCCOaSPazwIQef1aalmxEAbQ/Kmhzq+O+m5SNKiPW
	 beg+zXvLYIMI3dF3gii47uoWqUiz2hWYSuBPXs61Ftk5UqA6XCQFqkPcRiM1qOCenQ
	 QXgHQ8xaii0uxdJGFrvh+mvWkRFwXKnthJRs4oj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732247AbgIHTaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:30:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:48728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731004AbgIHP6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:58:05 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB6752256B;
        Tue,  8 Sep 2020 15:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579442;
        bh=jpKBANjWFwKlQmZz2iL/OfbL8AE+Hbc6G+JG21oHazI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XZtY/4d2IcWcy7izkeWhv5QVHASKh03uOijDYWp9gMfSdgpxGktixL7a/1ycodAWc
         DKEQgLv0g+GOHd4XDHjLMUWcaHUGvg0vANrlrImwtcfxRAblWiScURWdptkBnl4DCP
         GusOY2IWmruPBgVPop126mnfr7otG+WdHBQP0N/o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 049/186] MIPS: mm: BMIPS5000 has inclusive physical caches
Date:   Tue,  8 Sep 2020 17:23:11 +0200
Message-Id: <20200908152244.044582236@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152241.646390211@linuxfoundation.org>
References: <20200908152241.646390211@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit dbfc95f98f0158958d1f1e6bf06d74be38dbd821 ]

When the BMIPS generic cpu-feature-overrides.h file was introduced,
cpu_has_inclusive_caches/MIPS_CPU_INCLUSIVE_CACHES was not set for
BMIPS5000 CPUs. Correct this when we have initialized the MIPS secondary
cache successfully.

Fixes: f337967d6d87 ("MIPS: BMIPS: Add cpu-feature-overrides.h")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/mm/c-r4k.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 49569e5666d7a..cb32a00d286e1 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1712,7 +1712,11 @@ static void setup_scache(void)
 				printk("MIPS secondary cache %ldkB, %s, linesize %d bytes.\n",
 				       scache_size >> 10,
 				       way_string[c->scache.ways], c->scache.linesz);
+
+				if (current_cpu_type() == CPU_BMIPS5000)
+					c->options |= MIPS_CPU_INCLUSIVE_CACHES;
 			}
+
 #else
 			if (!(c->scache.flags & MIPS_CACHE_NOT_PRESENT))
 				panic("Dunno how to handle MIPS32 / MIPS64 second level cache");
-- 
2.25.1



