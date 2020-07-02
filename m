Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11376C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E37A420780
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbYNjobK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730064AbgGBOxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729724AbgGBOxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:53:36 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A014BC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 07:53:36 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bj10so6180755plb.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 07:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tkP14FZHz0Xjk/ZquQal3zEzP8POeB5iXLL2u4k/QTk=;
        b=RbYNjobKhAR609AkY67Hd3+9gfhFW/BWnJ/QkXKGc0cIMbPd4tKVY/Bt91CGHURUre
         xkmJ91y7RWOnWuzPu9fL6027+baPclD/mb7pvgEugphdBMsaUQGZHysf+l7w7paYvcb1
         F9P8x9fUZTwJHiwjZsCUmPwlrR2P2dcMV4wnWYQn4lFfZ6BwSypgA7m7XuTe62KrbJJ3
         h9xdNZ3tMuS+HnAGAnd6+ksJrPLm5LE37dTwZIXzPa2LV0MiPi+g76g3e4UTbcOZ2avq
         uc9Y+B3L5XYoYtk5pRtbz3PtIuMu0sGz7Or+pw6E/3qfpvKRVo294d0la8+ihnAT2R7W
         HSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tkP14FZHz0Xjk/ZquQal3zEzP8POeB5iXLL2u4k/QTk=;
        b=UPiW2xhLYDaB8+UuH4G5uEsAIvCJv05if+vYuytwtAVtHOkzQ1uLphIxOW1yWPpeNW
         umgI5aEAypJqDldi1AvFN8ijQiADIEUhGFODExaXWYOF1x1tKotq1KHLzRE60X2X61tb
         l8YcrVu5IhEy3T7Dqe/XYJrDe3VFuwqMDtgyvx2n+GEVxlsw5VwcgM/5yDn1H8z6XJLK
         +QrOndh01RWTlAfrv42EfPO1ICjObY4Ol9qlj8lke4AhdLr16+0PaUZ3mPDwN0LKbY5O
         HbNuzeSDc+O9fFeXbCYouLvW4D3YoHQ9Ha866k0FfPc3XECIDP3656wdRblhpyWGrW2q
         T6Sg==
X-Gm-Message-State: AOAM5335qLUXKMLKViqwzHUzx9ekVisfhWBfCozN7b6plI4r/wRxLFbS
        79Mk9Id1Wdw6tpTt1Uk0BBc=
X-Google-Smtp-Source: ABdhPJxBDEmg5tu1NGcS3Gn0Gj7/rgVHkT6WZNzzoE12eCo2usc6DO9xxRsI7+teLiaJtNrhUEMJdQ==
X-Received: by 2002:a17:902:a982:: with SMTP id bh2mr27128636plb.2.1593701616153;
        Thu, 02 Jul 2020 07:53:36 -0700 (PDT)
Received: from localhost.localdomain ([223.190.0.253])
        by smtp.gmail.com with ESMTPSA id 204sm9487891pfc.18.2020.07.02.07.53.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jul 2020 07:53:35 -0700 (PDT)
From:   Amit Singh Tomar <amittomer25@gmail.com>
To:     andre.przywara@arm.com, afaerber@suse.de,
        manivannan.sadhasivam@linaro.org, sboyd@kernel.org
Cc:     cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
Subject: [PATCH v5 04/10] clk: actions: Add MMC clock-register reset bits
Date:   Thu,  2 Jul 2020 20:22:50 +0530
Message-Id: <1593701576-28580-5-git-send-email-amittomer25@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593701576-28580-1-git-send-email-amittomer25@gmail.com>
References: <1593701576-28580-1-git-send-email-amittomer25@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds reset bits needed for MMC clock registers present
on Actions S700 SoC.

Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
---
Changes from v4:
	* Reordered it from 03/10 to 04/10.
Changes from v3:
        * NO change.
Changes from v2:
        * No change.
Changes from v1:
        * No change.
Changes from RFC:
        * No change.
---
 drivers/clk/actions/owl-s700.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/actions/owl-s700.c b/drivers/clk/actions/owl-s700.c
index a2f34d13fb54..cd60eca7727d 100644
--- a/drivers/clk/actions/owl-s700.c
+++ b/drivers/clk/actions/owl-s700.c
@@ -577,6 +577,9 @@ static const struct owl_reset_map s700_resets[] = {
 	[RESET_DSI]	= { CMU_DEVRST0, BIT(2) },
 	[RESET_CSI]	= { CMU_DEVRST0, BIT(13) },
 	[RESET_SI]	= { CMU_DEVRST0, BIT(14) },
+	[RESET_SD0]     = { CMU_DEVRST0, BIT(22) },
+	[RESET_SD1]     = { CMU_DEVRST0, BIT(23) },
+	[RESET_SD2]     = { CMU_DEVRST0, BIT(24) },
 	[RESET_I2C0]	= { CMU_DEVRST1, BIT(0) },
 	[RESET_I2C1]	= { CMU_DEVRST1, BIT(1) },
 	[RESET_I2C2]	= { CMU_DEVRST1, BIT(2) },
-- 
2.7.4

