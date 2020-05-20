Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7652C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 14:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79DF2205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 14:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgETO1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 10:27:48 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:32930 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726958AbgETOW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 10:22:27 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1jbPbw-00036A-5p; Wed, 20 May 2020 15:22:20 +0100
Received: from ben by deadeye with local (Exim 4.93)
        (envelope-from <ben@decadent.org.uk>)
        id 1jbPbv-007DQl-2c; Wed, 20 May 2020 15:22:19 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Takashi Iwai" <tiwai@suse.de>
Date:   Wed, 20 May 2020 15:14:04 +0100
Message-ID: <lsq.1589984008.75685006@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 36/99] ALSA: sh: Fix compile warning wrt const
In-Reply-To: <lsq.1589984008.673931885@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.84-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit f1dd4795b1523fbca7ab4344dd5a8bb439cc770d upstream.

A long-standing compile warning was seen during build test:
  sound/sh/aica.c: In function 'load_aica_firmware':
  sound/sh/aica.c:521:25: warning: passing argument 2 of 'spu_memload' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]

Fixes: 198de43d758c ("[ALSA] Add ALSA support for the SEGA Dreamcast PCM device")
Link: https://lore.kernel.org/r/20200105144823.29547-69-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/sh/aica.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/sound/sh/aica.c
+++ b/sound/sh/aica.c
@@ -120,10 +120,10 @@ static void spu_memset(u32 toi, u32 what
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

