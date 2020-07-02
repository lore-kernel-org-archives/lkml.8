Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB96C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 03:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0943C2083E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 03:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cc5H4/wZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgGBDQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 23:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgGBDQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 23:16:11 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69583C08C5DB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 20:16:11 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e20so28258276ybc.23
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 20:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BZhTm0K+J00uWslBFWcyNoFU+JytjYEWR2LasM10h6k=;
        b=Cc5H4/wZYiLQ+LvrHTw7nKxCtd5ts+FBnf16RiJpFUkfk5R9K7dDg3Vn1pGMz862z1
         Jv1u3na7A69no4UcSPL5oV25e2z8PLxQddKbu4LxbH1lMLa7Fg6MpmyyBqxOnFELAtu0
         0hRrGO4gBSclF9UctwJBRKzNrgi0OcStM8FiK/oOBE93owl4YMm0Ks6eppIKghsRyalA
         ZjQRkxxO/MnG1fsUetu1inruVExK0kQPWM26J/bGVz1VW4krIoU0F5+fZsvuBTwvdKre
         8949wdnB5UecWuWNBG6cWnyVu+CAIw5qDPaUV6NHO17+ZXO1/F2/qnUEWKNLDDDsjnDh
         jxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BZhTm0K+J00uWslBFWcyNoFU+JytjYEWR2LasM10h6k=;
        b=IUUXmJiq+51MA6WeTvvVZ9xC6tItdXIudwkaH0rIaXTEdpMS9TkqZ9grhNdGNLp10z
         hbKdxpnGEh9nmdYhBkFn0gKlq6hlNNSrukWfzaEuP9VZ0IBLiFFr96rNI2jAoLX0j6lD
         Oz/6RakfqLiMtD58hjV06fExSbihwD2vfA1hABlxsVUwoNzQg+gvI2pwUFxyI71Qiq+f
         TsZ4cUc5/feJ2vMe3BWW3d4vnXlNGy/4+my3Ci0ngJHAT0YOY42mLafQxd2EFFO6bbKA
         GRdVoigt2aQW5LH80BXjgn8MLFSr1DESmq+zEKGN5oehxET4vYwb1KttK+XCPXK0CZ4q
         YgVw==
X-Gm-Message-State: AOAM533txLZTfEygJuDyuBX0xv+Xqk3Tfv7AFjF2qjfQTwMWGCxre3CH
        QgDj/1pZll7ELBuuUg8zMNwwYx+BSWSE
X-Google-Smtp-Source: ABdhPJwdeykEH+UR9hjUHH8v8AYWafVNZUnJO6u/K1rQn9wGGIJgZmaje+MYuGRWXORfFZJVdTxTGgAySE78
X-Received: by 2002:a25:4251:: with SMTP id p78mr46020304yba.489.1593659770666;
 Wed, 01 Jul 2020 20:16:10 -0700 (PDT)
Date:   Thu,  2 Jul 2020 13:15:25 +1000
In-Reply-To: <20200702031525.2662441-1-amistry@google.com>
Message-Id: <20200702131350.4.I969f166350d084c150e5ae8052d8a973265ea442@changeid>
Mime-Version: 1.0
References: <20200702031525.2662441-1-amistry@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH 4/4] arm64: dts: mediatek: Update allowed regulator modes for
 elm boards
From:   Anand K Mistry <amistry@google.com>
To:     linux-mediatek@lists.infradead.org
Cc:     hsinyi@chromium.org, drinkcat@chromium.org,
        Anand K Mistry <amistry@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This sets the allowed regulator modes for elm (and derivative) boards.
According to the datasheet, the da9211 does not support SLEEP mode.

Signed-off-by: Anand K Mistry <amistry@google.com>

---

 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
index a5a12b2599a4..d4c84a856e7b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
@@ -6,6 +6,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/regulator/dlg,da9211-regulator.h>
 #include "mt8173.dtsi"
 
 / {
@@ -294,7 +295,8 @@ da9211_vcpu_reg: BUCKA {
 				regulator-max-microamp  = <4400000>;
 				regulator-ramp-delay = <10000>;
 				regulator-always-on;
-				regulator-allowed-modes = <0 1>;
+				regulator-allowed-modes = <DA9211_BUCK_MODE_SYNC
+							   DA9211_BUCK_MODE_AUTO>;
 			};
 
 			da9211_vgpu_reg: BUCKB {
-- 
2.27.0.212.ge8ba1cc988-goog

