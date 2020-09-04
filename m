Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2D5C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 20:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B15C620E65
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 20:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qIGEZ8IU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbgIDUvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 16:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbgIDUvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 16:51:04 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3620C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 13:51:02 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y6so1691264plk.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 13:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CiIeU7VL4tMoVGzTU+NA9ADQCjCTiXtDHd4RfiX4JPU=;
        b=qIGEZ8IU/KonixvIH+81t7lD5THpreiflld91bmt22uKrzTnbgRJeS0Poot9aBXOGb
         Q7zEEfBEhexKvNtM+omzhJC3B+L28OioVM3x3BpwByaR0ENclxeoLDlPdTdh6ZThhD5F
         3SUFweLGFdfH2KLyFx8seFVjqjKOZMXX2sqnuWcAB264OajedZlpMCTnkBmkGsCKrGuN
         MWBNQkaCYah6BHjRvOWWkDwZWY/mZ1sO1gLOoDkWbn2Tn5bv6B0EB8UQAb/PlEUa67M7
         jaxoGww25pGOVIBYDwnR5cTB5Fj2uOmDs3WXCfKNhW8FrjWUAVNk2/+6Paczb5z8Qf2X
         PFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CiIeU7VL4tMoVGzTU+NA9ADQCjCTiXtDHd4RfiX4JPU=;
        b=nLJRwIuFdpuIXy436tUJQwqVI1Jzi38IHlgxI29DHgLyRiF1jiTNGX9iJzFV2YPIFk
         ACUOkq3TYW1XoIKyHQWyE///xyy/UG+QqRQMZUEqV3MGsY/4B45JOEZ9eFJFlgas5KDF
         t4kWpjr3n26lHWoXWcM7SSgJHfhcwtTbKr1sbDsdor6o6wAJ0Y8fAOgmugGfEPDOsVCa
         UlUrafuLazLhUoMHJ18X6URVjLCHEjxMWKR+3A0mY1ixPM4cTO2sGxMkb8P+SykLN/Yk
         /4TrLt5xZFmHiy1RWenaZqLy95rR9VHSE2hKdhmvHsnvRI77tBMP8xat2bk3xQmtb0I9
         ey8g==
X-Gm-Message-State: AOAM532i969IXMdEPHDLEYTrRTurvMi0LfI9fX4ETB7+9n4q3r+aZ0/t
        WU+hUK+Uq7YHqjpEJghcmAA=
X-Google-Smtp-Source: ABdhPJyjr9MyChSY4+lePwokvZkYAaeFkzJKMyNDxCbsugPjT78loijjo/Ue4CL6eCT7IpC5fnZ/2g==
X-Received: by 2002:a17:902:b60d:: with SMTP id b13mr10584752pls.48.1599252662512;
        Fri, 04 Sep 2020 13:51:02 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id gb17sm6193305pjb.15.2020.09.04.13.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 13:51:01 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/4] soc: bcm: brcmstb: biuctrl: Tune MCP settings for 72165
Date:   Fri,  4 Sep 2020 13:50:52 -0700
Message-Id: <20200904205055.3309379-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200904205055.3309379-1-f.fainelli@gmail.com>
References: <20200904205055.3309379-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

72165 uses a Brahma-B53 CPU and its Bus Interface Unit, tune it
according to the existing values we have.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/soc/bcm/brcmstb/biuctrl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/bcm/brcmstb/biuctrl.c b/drivers/soc/bcm/brcmstb/biuctrl.c
index a4b01894a9ad..d448a89ceb27 100644
--- a/drivers/soc/bcm/brcmstb/biuctrl.c
+++ b/drivers/soc/bcm/brcmstb/biuctrl.c
@@ -131,6 +131,7 @@ static const u32 a72_b53_mach_compat[] = {
 	0x7211,
 	0x7216,
 	0x72164,
+	0x72165,
 	0x7255,
 	0x7260,
 	0x7268,
-- 
2.25.1

