Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6345FC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42BD721556
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="opvfaQb0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730830AbgDONL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 09:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2506078AbgDONLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 09:11:07 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3513FC061A0C;
        Wed, 15 Apr 2020 06:11:06 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id z6so19016931wml.2;
        Wed, 15 Apr 2020 06:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1YK31f6d9R7ZKz1959zNs117rXGUB2qZVpteQ8Nm8rE=;
        b=opvfaQb0ZITpiBld1k4u5Ru6l4CFHpZ7v8Dsm3tWBEB7BZxs190+jPFTPIwCl50rrx
         NPPMdBa7gnGMXIrhYoOpvsYB8NX67Xjf92Y6es4h/dRkErBjLDBbjqxCGRmV/GjT9ahb
         4il8jDWH3Wn9uiNiMzxAq8Po0YDsM5JA8B9WcZtp/qDYTMGaTLOYqN0SgUkn/Z7PVcSw
         hsdfygbK/xTy52wU0y6n7Cqi0wAyu61S/3Nq5uFCyTH1DprmeApdnBrS4oXhcfva95OX
         RpmoHTicjgAFZXs141O7f9i2gCRF2ctZwxqoP5d51mzkRirXjLJR34W41a7FfOC68577
         PSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1YK31f6d9R7ZKz1959zNs117rXGUB2qZVpteQ8Nm8rE=;
        b=pNWyBTJDoC/NpRuaCrVicAp+NdfEXevTySiPoSmHtvOUym1V8u0XF05+d0ujMjxZ0Q
         W5y8DgAF7kOpp4LxpdzaqcphCyMwaGE+2tjIfyzN94blgZyz9CEiedgI4A8k0l6qKxht
         32WBlGRzZwBk60tGM00CUDx6IwDY4YEkZOWuBMtr/AnpAVhB12V/h5XZaWQ0I7dsKBrK
         y9r2nfW5dibk38ToJqgWk3C1Tpbf1whuBKIN41mNJNIIhUgKYK0/nqb5ez9J1LMXv8VS
         6eGJzoUkeZhqMKof2ntMJsZt8oP13bgiLmiXYcQiVN715STTxp51bYrIXUt1JZXHA296
         mwnw==
X-Gm-Message-State: AGi0PubSVHhSXySvUScZ5VoVD/KqyIaUm3+M+Y7QU57W5IXxjugYopW8
        5lrWGeHMrGQtB311d34djgU=
X-Google-Smtp-Source: APiQypKb/YVsijkXt1W8jtMK4h3qXbl3iX+wO+27T2T3+keWoO4EtLb2fRtUtD+xSMEElkqoUaNBbQ==
X-Received: by 2002:a1c:b70a:: with SMTP id h10mr5272755wmf.172.1586956264930;
        Wed, 15 Apr 2020 06:11:04 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id c20sm24022450wmd.36.2020.04.15.06.11.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Apr 2020 06:11:04 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: remove bus-width from mmc nodes in rk3308-roc-cc.dts
Date:   Wed, 15 Apr 2020 15:10:57 +0200
Message-Id: <20200415131057.2366-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'bus-width' property for mmc nodes is defined both in
'rk3308.dtsi' and 'rk3308-roc-cc.dts'.
'bus-width' and pinctrl containing the bus-pins
should be in the same file, so remove all entries
from mmc nodes in 'rk3308-roc-cc.dts'.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts b/arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts
index aa256350b..8011e9b12 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts
@@ -123,7 +123,6 @@
 };
 
 &emmc {
-	bus-width = <8>;
 	cap-mmc-highspeed;
 	disable-wp;
 	mmc-hs200-1_8v;
@@ -171,7 +170,6 @@
 };
 
 &sdmmc {
-	bus-width = <4>;
 	cap-mmc-highspeed;
 	cap-sd-highspeed;
 	card-detect-delay = <300>;
-- 
2.11.0

