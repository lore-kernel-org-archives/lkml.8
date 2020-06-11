Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B69C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 22:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F4522075F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 22:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20150623.gappssmtp.com header.i=@beagleboard-org.20150623.gappssmtp.com header.b="gnAHqeZA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgFKWKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 18:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgFKWKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 18:10:04 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A1EC08C5C2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 15:10:02 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id c12so7173876qkk.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 15:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=7vi95NSNGo0FVYj7bBTDUtokoPAu8hd+3gRY+DmZdRs=;
        b=gnAHqeZAMs724/5TtjuVPFRp2MixtrDQEfiNIVM8YLfFH4B09RRQPO3+5qffHxj2Yb
         8EJ85CfjzgL6qIkjatNEmxJYgOyuES8RiyssWtUt22FuyfX+33qO+td2YKwlqMzBcMQm
         kRv0M26ybLYxoyw0sHJshp4HQJYb7d9dGcOVnwmpgBxdybRgoq9Fb8vfZZJAMsTk4l8L
         XG0K+pjzJPyvkQmqBnXsMBlsSP3RClxF4FPi+biZy7BDC5+aCPTagt1oOEQjee6LC16r
         1buCfp3sBqpcfxyGtxlcFDexDEfWb3pzIx4zVi6qnXAuB/GFxiRc/QKzjRkCuidn8yqn
         RFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=7vi95NSNGo0FVYj7bBTDUtokoPAu8hd+3gRY+DmZdRs=;
        b=NAYn7TfL0llvAZTRz7GKnFu/G/qNCkpMDJ6oLCdObvLg3ZmOBbh6IA0+3EVHDBh6EX
         cg4EWu4aE6NqdS10eKrQdxKrPkSnEosWPy5A9ep5AKCXZ/308xLYHCCzNi1HWftjCyfl
         0FL2GdYAZc35QNmNzp0PJahgf5iKgZFJShC+Vw7sDMCKLxzD822HwmiPRENT6J3e1CyG
         9I6DnvcG2ShqfqHGD5zoc6cWIX2IqPHkfS4OXG6GgiVwQ7R9Lj45G3y1q+95jULSp0QX
         rCQw7n55syYRtWLBtJx/Qsp6yp5ymVgK5AMMGqRDsPHZ5myY3CnkteQudd4HaO5dSblb
         WtiA==
X-Gm-Message-State: AOAM530wHbNBANiEfsF977quLN0b9KnLJ2p99AV6Dtjg3jTYD2A1NGlv
        A7jXk1eZzhT205hzrqxETufo9g==
X-Google-Smtp-Source: ABdhPJybhAxOsyTZf0LQiKs8JrBNtizqFqRuN3cJeLA7ECRaRH1T6Q08A9mzwpItugpUTANFEU8XKg==
X-Received: by 2002:a37:9f09:: with SMTP id i9mr166786qke.60.1591913401743;
        Thu, 11 Jun 2020 15:10:01 -0700 (PDT)
Received: from x1 ([196.52.2.87])
        by smtp.gmail.com with ESMTPSA id d17sm3168281qke.101.2020.06.11.15.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 15:10:01 -0700 (PDT)
Date:   Fri, 12 Jun 2020 00:09:51 +0200
From:   Drew Fustini <drew@beagleboard.org>
To:     Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] ARM: dts: am5729: beaglebone-ai: fix rgmii phy-mode
Message-ID: <20200611220951.GA3355634@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit cd28d1d6e52e ("net: phy: at803x: Disable phy delay for
RGMII mode") the networking is broken on the BeagleBone AI which has
the AR8035 PHY for Gigabit Ethernet [0].  The fix is to switch from
phy-mode = "rgmii" to phy-mode = "rgmii-rxid".

Note: Grygorii Strashko made a similar phy-mode fix in 820f8a870f65 for
other AM5729 boards.

[0] https://github.com/beagleboard/beaglebone-ai/blob/master/BeagleBone-AI_sch.pdf

Cc: Vinod Koul <vkoul@kernel.org>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Fixes: cd28d1d6e52e ("net: phy: at803x: Disable phy delay for RGMII mode")
Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
Signed-off-by: Drew Fustini <drew@beagleboard.org>
---
 arch/arm/boot/dts/am5729-beagleboneai.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am5729-beagleboneai.dts b/arch/arm/boot/dts/am5729-beagleboneai.dts
index 9877d7709d41..4c51c6b05e64 100644
--- a/arch/arm/boot/dts/am5729-beagleboneai.dts
+++ b/arch/arm/boot/dts/am5729-beagleboneai.dts
@@ -505,7 +505,7 @@ &mac {
 
 &cpsw_emac0 {
 	phy-handle = <&phy0>;
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-rxid";
 };
 
 &ocp {
-- 
2.25.1
