Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8EEC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2920207C3
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQTXqB70"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgIGHEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 03:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgIGHEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 03:04:34 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3D6C061574;
        Mon,  7 Sep 2020 00:04:33 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id w186so7588280pgb.8;
        Mon, 07 Sep 2020 00:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FqAG9igPFBIm5I71RECWWlWkVlr9xLx/8DgDVT5uKZw=;
        b=YQTXqB70FOxoYbplD1RyiH/vGAqYc+eq5To12NwEwkCENc6+zHRu7a+LrGAIrDvBw0
         1RzYjqvjIXebbVeyrXzS1RkVhAv4EeTZo/jUY3/2mDvpGAE7hTSoXSb+7a3pF/2qGCJ9
         FQ0l53OKgDEJL+paMUH3zuNfh4jlZ9s/daOMF3LRGLPiUNBTPPhjP/m11bQ6DNPvM2aT
         33w7AsCd5YCOU00n5BbvyhrPK26KVvlbAiTs/3KuT9B4R/mZFViVvZaRXPw5DbNAlc8d
         pGjEZz08S5EuTr7+X/ZO8pRJFcA977W2yhK+TnWQxEwhPWEFBjhZR7Nv6iv1Ya5jEOZA
         /vzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FqAG9igPFBIm5I71RECWWlWkVlr9xLx/8DgDVT5uKZw=;
        b=WNnTiMxqv4KZq4XuQmB5Rzm+shZTt3SiuR3fuYP+Nb/Iadu52A+QDxz3qmIl6rD5kT
         BaAtCdFWA8JY7tVurE3llerZwBhf+NHxWmURRromQ70SYDm/R6rNvLmUBHkXHTWnzs1s
         xhkMRo2Ms8/QL7n6MfC/XvHSs+sEH7B0M0t8aeFsr2/7+jotITWEhxechKCntH1xyhlp
         xYmkKG4C3KsZgVyzMjoQ8ehqvh0gtc+yBCNWdGNLIdD/Er0ITebAI3ywLF8HYUV5xbaE
         wsOtT7Vnt/k3ScQgtq0DmjFTuz/ZbqB76fTUaxGDxBIZOyKZhSbxbWytL9jFW06pmoey
         bsOw==
X-Gm-Message-State: AOAM532is82Sr/oeN3jRxEJH06Fm0sOYnADdWcbbWG3wuzMJ+4uj8n34
        j6dipegb/reKSY1O63/GTPE=
X-Google-Smtp-Source: ABdhPJyD3ea1SKxV0y/fkOts7IPF7fAry7BYAtFdP95oJdb+n9w9Ob7nfkX1K7RX16sJHgCqyTyFTQ==
X-Received: by 2002:a63:8ac8:: with SMTP id y191mr15696084pgd.159.1599462273169;
        Mon, 07 Sep 2020 00:04:33 -0700 (PDT)
Received: from varodek.localdomain ([106.201.26.241])
        by smtp.gmail.com with ESMTPSA id 204sm6804733pfc.200.2020.09.07.00.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 00:04:32 -0700 (PDT)
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
Date:   Mon,  7 Sep 2020 12:32:20 +0530
Message-Id: <20200907070221.29938-2-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200907070221.29938-1-vaibhavgupta40@gmail.com>
References: <20200907070221.29938-1-vaibhavgupta40@gmail.com>
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

