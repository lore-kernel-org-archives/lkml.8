Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECD4C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38BB6246FB
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581697654;
	bh=gG8HGprrQBBywmF5eY3kLdDk0um/SI/w5sXTZx28iH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hThY/G7Z3WqCeYPEzXny5SOy91IRE0CWcNFHTQRpqOjVlaCy7g/abqCT6fjgd7Ipi
	 4RNz9XRb75kdjybPQHeDQi717QAAPdQZxv9GErn72d+4t/7PCe0c1pGGcdInDhtjEh
	 vjkkRj1tavKD7mb/sbLmHJAqOcQ5NF2tR60PG3No=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406671AbgBNQ1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:27:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:35306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405804AbgBNQZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:25:35 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F07FB247C7;
        Fri, 14 Feb 2020 16:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697534;
        bh=gG8HGprrQBBywmF5eY3kLdDk0um/SI/w5sXTZx28iH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pliuNyalW5zKX4wlsHvXqNilErETr8l3A9U/T56w5+8/KiqlkLc2eweq2ngCHtGDr
         iTOMkTW6XURWA5Jw84QstQkjBWGvoPI0FtlMeHkWHLKJwbhstFo1KYeSiO4Pdu2AZf
         FwBqqPXhvfN6LuSesoQsLPdKPGDlod6A6GL8e7Xg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 4.4 056/100] ALSA: sh: Fix compile warning wrt const
Date:   Fri, 14 Feb 2020 11:23:40 -0500
Message-Id: <20200214162425.21071-56-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214162425.21071-1-sashal@kernel.org>
References: <20200214162425.21071-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit f1dd4795b1523fbca7ab4344dd5a8bb439cc770d ]

A long-standing compile warning was seen during build test:
  sound/sh/aica.c: In function 'load_aica_firmware':
  sound/sh/aica.c:521:25: warning: passing argument 2 of 'spu_memload' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]

Fixes: 198de43d758c ("[ALSA] Add ALSA support for the SEGA Dreamcast PCM device")
Link: https://lore.kernel.org/r/20200105144823.29547-69-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/sh/aica.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/sh/aica.c b/sound/sh/aica.c
index ad3d9ae380349..dd601b39f69ef 100644
--- a/sound/sh/aica.c
+++ b/sound/sh/aica.c
@@ -120,10 +120,10 @@ static void spu_memset(u32 toi, u32 what, int length)
 }
 
 /* spu_memload - write to SPU address space */
-static void spu_memload(u32 toi, void *from, int length)
+static void spu_memload(u32 toi, const void *from, int length)
 {
 	unsigned long flags;
-	u32 *froml = from;
+	const u32 *froml = from;
 	u32 __iomem *to = (u32 __iomem *) (SPU_MEMORY_BASE + toi);
 	int i;
 	u32 val;
-- 
2.20.1

