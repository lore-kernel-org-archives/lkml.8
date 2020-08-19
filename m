Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C201C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 599C120738
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lx1RsfMz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgHSS1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgHSS0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 14:26:53 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE03C061757;
        Wed, 19 Aug 2020 11:26:52 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y10so9666551plr.11;
        Wed, 19 Aug 2020 11:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qCN/5vzgqEfQvumo24ihZle46Xb4ELiwR/jqerThKtc=;
        b=lx1RsfMzld1unBv/pUBP6EzOHaTwjmaAqgzjBqtN7uIA0VbDMwgIMmcYoy6qcEQeib
         7taJ0WpxRbj2FiERacyZ4bkAiygahYjAB3apwpU9LU1e6IHRyrN3mPCj4+vOKZhI8jVy
         Gbi2aT5I2fVuVCgPavPv8vm9ikYG2UW2b8i8DU7ZmUuxmi0flH6boGIp1Fg/OkS+3NHa
         3htkwI7sS3wR/poEvhCM0EQzbIti/IcFlwCsOJqWRUIhDAbFcHCfduJ+uYRQktWyvWKx
         C9zI9M2CyG3PV4xdHxDl33A3N3aIfj71Y3hlCPcaDasj00hfxPt80rBSX/3FBN+jtCmi
         oRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qCN/5vzgqEfQvumo24ihZle46Xb4ELiwR/jqerThKtc=;
        b=tic5FSEt2UcO8f6VNBDvF3Hsjh+q34ra/P0vtDwuaNGbHu7kxhdHub3Sc9SLrij9IF
         JZh/AoUxW2CZqYDhRTNbr9UOcwLxQkt2CJddo7CDAZpDj+WKvObsgCEb8Uq9BpeF73Co
         5mmRpuFiskrUsS+wrtNcq5a9dywEG3JHq6c+Wan0b1yoC+ehAdLTHeoFvS4cf9oDTGNg
         nl7U/PJLgrNPF86OxdxSL+ovsAyoqyGuiaGGn7Dh8t8PJ7zJjdsu1BGLcPeGvvnAR/HT
         fZ3/+WN8N9hxGYV/KNTWuEL+ugz6viAJ/VPS107/ZG98CwMMW4tpJvJVf2xsWs38McwE
         agqA==
X-Gm-Message-State: AOAM532rQy/o7cDTQs6ijoVCu/SRDe2d/65CDSfQdvozURQvxWHVTKk7
        w31u1hbEHfRjyYt6ilBDErE=
X-Google-Smtp-Source: ABdhPJyXQSfZn+JzTr6Vxknv11vB+BelNOwEfnt+fry0El7QWN8nI69X6we4kBNtn0a5wqIkvXs3tw==
X-Received: by 2002:a17:902:7291:: with SMTP id d17mr19628026pll.141.1597861612266;
        Wed, 19 Aug 2020 11:26:52 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id l78sm29448483pfd.130.2020.08.19.11.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 11:26:51 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Paul Burton <paulburton@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Liangliang Huang <huanglllzu@gmail.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        bcm-kernel-feedback-list@broadcom.com (open list:BROADCOM BMIPS MIPS
        ARCHITECTURE),
        linux-mips@vger.kernel.org (open list:BROADCOM BMIPS MIPS ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH mips-fixes 1/2] MIPS: mm: BMIPS5000 has inclusive physical caches
Date:   Wed, 19 Aug 2020 11:26:44 -0700
Message-Id: <20200819182645.30132-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200819182645.30132-1-f.fainelli@gmail.com>
References: <20200819182645.30132-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the BMIPS generic cpu-feature-overrides.h file was introduced,
cpu_has_inclusive_caches/MIPS_CPU_INCLUSIVE_CACHES was not set for
BMIPS5000 CPUs. Correct this when we have initialized the MIPS secondary
cache successfully.

Fixes: f337967d6d87 ("MIPS: BMIPS: Add cpu-feature-overrides.h")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/mm/c-r4k.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index fc5a6d25f74f..0ef717093262 100644
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
2.17.1

