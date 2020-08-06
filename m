Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88027C38153
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C9D122CAE
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvDXjycJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgHFH3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 03:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728600AbgHFH2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 03:28:49 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE2FC061574;
        Thu,  6 Aug 2020 00:28:48 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p8so10121268pgn.13;
        Thu, 06 Aug 2020 00:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FqAG9igPFBIm5I71RECWWlWkVlr9xLx/8DgDVT5uKZw=;
        b=IvDXjycJnrN8Jo7WOBOS09G5BUYYTTV0IUIJ9wpcXxQy05TLWKQNzNu8lHaucHzSTl
         y68SIu+ULcnB5LCS2k/2pAog5eVaeK59DOrn7Z4pvWw2CZNrj+VSyTR48547nrbJmXLf
         hNYZIS5cKTNqbnINKSo3O+eKgE+R6PSujzrkqM1SFkprvg6OgiQGp1gZ/TVp04zhgHZU
         BFxDkEwDpOwo2cyhyyzPRFE/ToughqUKSMHPNmIpdlRZm3hwFF8IMHtBGdhpe6Soulnk
         B6+2OMFoiJ5pjrGNm2/n7kLLcolyCh+w87JV4SKPjqbid+Hqb9RcSRjygSIOXlNv8dcV
         UIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FqAG9igPFBIm5I71RECWWlWkVlr9xLx/8DgDVT5uKZw=;
        b=CnL9hRNRkTVXuNBLm0WaENysJqS32g3kiRQZIOb92jM4Fli7d1WgqjbD4CEjsXhjUB
         R8p3fFR2LLLGrbi0zPAKiwd3sLThhr0AiUQncn1/GmCzR0xjgbm/9ZH2uJ408FjZ8vlU
         BjAToOy8hDp+pcYnEZ209HtsdHmxISjoAsspJrLhtpG+B9M5xJ7vtIwRLg+rNBAN3dLr
         CQu0sz9d9BKIAcr1ySGJEHvC5oBg+JofsGKyrHB9h+N2XxJ5uJqk80gIj/vs6MM+iRbX
         8sdg64ZB+1RgFAVDJiHxAQZNvhEIs/9vgaJDFjL3mcnD/DdPbVAYy63I3vipRv/57Ei+
         GQYg==
X-Gm-Message-State: AOAM5324XQzBcv2Z4ttbHTwH9sZNgMekHuFe3a4GF8MmrxDYBfrOHYMR
        dcsvVsrQyuQGCw9vOIWlPto=
X-Google-Smtp-Source: ABdhPJxVKJqpZfSMdLJ6I807JIkHlELXYBb82Be8Y42ptKkZOHmfshPFYt72e4K8u4JCl6vyNn+7gw==
X-Received: by 2002:a65:484c:: with SMTP id i12mr6512604pgs.145.1596698928075;
        Thu, 06 Aug 2020 00:28:48 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.152.86])
        by smtp.gmail.com with ESMTPSA id e125sm6654646pfh.69.2020.08.06.00.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 00:28:47 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thierry Reding <treding@nvidia.com>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v1 1/2] video: fbdev: aty: radeon_pm: remove redundant CONFIG_PM container
Date:   Thu,  6 Aug 2020 12:56:57 +0530
Message-Id: <20200806072658.592444-2-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200806072658.592444-1-vaibhavgupta40@gmail.com>
References: <20200806072256.585705-1-vaibhavgupta40@gmail.com>
 <20200806072658.592444-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes commit 42ddb453a0cd ("radeon: Conditionally compile PM code")

Before the above mentioned patch, codes between the line number 547 and
2803 were already inside "#ifdef CONFIG_PM" container. Thus, addition of
"#if defined(CONFIG_PM)" was not required in the patch. It also affected
the "#ifdef CONFIG_PPC_OF" container (line 1943-2510).

From the current snapshot of radeon_pm.c, remove:
    1434 | #if defined(CONFIG_PM)
and,
    2213 | #endif

This removes the redundant CONFIG_PM directive as well as fixes the
CONFIG_PPC (earlier CONFIG_PPC_OF) container.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/video/fbdev/aty/radeon_pm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/fbdev/aty/radeon_pm.c b/drivers/video/fbdev/aty/radeon_pm.c
index 7c4483c7f313..b9af70bd656a 100644
--- a/drivers/video/fbdev/aty/radeon_pm.c
+++ b/drivers/video/fbdev/aty/radeon_pm.c
@@ -1431,7 +1431,6 @@ static void radeon_pm_full_reset_sdram(struct radeonfb_info *rinfo)
 	mdelay( 15);
 }
 
-#if defined(CONFIG_PM)
 #if defined(CONFIG_X86) || defined(CONFIG_PPC_PMAC)
 static void radeon_pm_reset_pad_ctlr_strength(struct radeonfb_info *rinfo)
 {
@@ -2210,7 +2209,6 @@ static void radeon_reinitialize_M9P(struct radeonfb_info *rinfo)
 	radeon_pm_m10_enable_lvds_spread_spectrum(rinfo);
 }
 #endif
-#endif
 
 #if 0 /* Not ready yet */
 static void radeon_reinitialize_QW(struct radeonfb_info *rinfo)
-- 
2.27.0

