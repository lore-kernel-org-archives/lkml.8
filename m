Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC97C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 373862076E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K67tpfAU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbgCRRmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:42:51 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40643 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbgCRRmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:42:50 -0400
Received: by mail-wm1-f65.google.com with SMTP id z12so4357920wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 10:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HnFDyu+bqN/T6zaniZEXcMr32LKFRq1enTNFpCP4Q04=;
        b=K67tpfAUKbMoV2koVIXIpMjwt5tEFoSbo/DIHeBK/fWp8i7wAqh3N+TkPGsX3gPgsV
         nFoYm8RwK2tLxNyBOFjYxwqhFHNsRUisHxOQK+vWM1+CfJaMugPNXBmoHGtPlba+izJ+
         Ift6mWkBT2qLd8mX0nJhczK4V4RDitPrguFTZ13xw74JxhdTSuCyHaR1i7qBrN35i//8
         AyyiuGfnRCFRrsVFPVk+UcRpe+CuHAokVSPbWic3roN7eCXJ0akqBkTyAnY53/7D5ODu
         OscTN02R87RR9nwGEcqWq7IrzJTledRkQ9DVMyj2MZ/DZAKeqcwMfJ38gAEBnsos71zp
         Lx1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HnFDyu+bqN/T6zaniZEXcMr32LKFRq1enTNFpCP4Q04=;
        b=TS4xYd0vicFmaNya8wKQ6IsF2nkZYqaVSg1t2IuvgZ4b9Q55LQSgpuJ1gf4F297sjn
         fNxmFM0J88c1fMaH/JhnVkWT/MLgFIg0P2RUXkT/Bghba4AmDCbGEXgk7LF/k2siIEAb
         R39jeRyU8Ui7OO8+7rp81Ue71uYAp9InzY6Fgc6PKKrR/ri9JtpXV5HI00TpYKzaeTX3
         1c3bq9JHL4mo7nHF+2guoCfsogtV3Io14Ji4a9X1pP1JAQ0PbYG7F/XRHgHFtKt4OXHf
         q8h2d6pcCvSILdhWO4vlnWz7NqdsuV0J2JtfSozAZBEVb+PTipoNLMcyRts/Ff085Kb2
         bmKg==
X-Gm-Message-State: ANhLgQ1bQqXatYTXUmFufT7gzDw1AoRMhbIbsSl9KtJYA0GDAbBcuhLd
        r+FzuO4QTR/XKW8MAlab6itx74ZDImE=
X-Google-Smtp-Source: ADFU+vsKfHYGfDw6iV2Bg6By9IpmEZ8h/mJpbNTNQgFhdFdq9qSd1CnlxUVe3F96luINcsTqGkMyRg==
X-Received: by 2002:a1c:9904:: with SMTP id b4mr6301036wme.34.1584553368216;
        Wed, 18 Mar 2020 10:42:48 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:5d64:ea6:49bd:69d7])
        by smtp.gmail.com with ESMTPSA id r3sm3787212wrm.35.2020.03.18.10.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 10:42:47 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH 13/21] clocksource/drivers/timer-ti-dm: Convert to SPDX identifier
Date:   Wed, 18 Mar 2020 18:41:23 +0100
Message-Id: <20200318174131.20582-13-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318174131.20582-1-daniel.lezcano@linaro.org>
References: <e6cd8adf-60df-437a-003f-58e3403e4697@linaro.org>
 <20200318174131.20582-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lokesh Vutla <lokeshvutla@ti.com>

Use SPDX-License-Identifier instead of a verbose license text.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200305082715.15861-2-lokeshvutla@ti.com
---
 drivers/clocksource/timer-ti-dm.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 269a994d6a99..c0e9e9978cdd 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * linux/arch/arm/plat-omap/dmtimer.c
  *
@@ -15,24 +16,6 @@
  *
  * Copyright (C) 2009 Texas Instruments
  * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2 of the License, or (at your
- * option) any later version.
- *
- * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
- * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
- * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
- * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- * You should have received a copy of the  GNU General Public License along
- * with this program; if not, write  to the Free Software Foundation, Inc.,
- * 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
 #include <linux/clk.h>
-- 
2.17.1

