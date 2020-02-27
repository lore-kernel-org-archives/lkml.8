Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C707C35DF1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD5A20578
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582810935;
	bh=gG8HGprrQBBywmF5eY3kLdDk0um/SI/w5sXTZx28iH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mmUm7nC4N8gPEW3Kw0BQn/4oIhBBkPI7vnAis+UPPS+J+SPtagFF+02Cj28otMtlR
	 c6C7D7p/aSJrp40CnnfkqSnCTMPfEuLk0dzonDfVsGacQorAxlYK/Hb1nefYYrAezz
	 SrPrk0SouPRASijhogaVu32PVfgjukX8/FWK9A6g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbgB0NmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:42:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:37010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729335AbgB0NmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:42:08 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C576F222C2;
        Thu, 27 Feb 2020 13:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582810928;
        bh=gG8HGprrQBBywmF5eY3kLdDk0um/SI/w5sXTZx28iH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k9rR1lfj9K2GmErS+f4oMHVjqQVPHDGKC6tOaHSx5u+E4wVtBrYyBVfRf6KuRYMOy
         EsPR3Art/j54zcPrCDreUdPNYiiu7xGe/J/vyRtjhoPqpucm2G3tGxjN2qN7oB423m
         TICcTEpPqbHWcXh6PSdZkIrGQuGecLj0HWy8FKrw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 050/113] ALSA: sh: Fix compile warning wrt const
Date:   Thu, 27 Feb 2020 14:36:06 +0100
Message-Id: <20200227132219.757796699@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132211.791484803@linuxfoundation.org>
References: <20200227132211.791484803@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



