Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1549C352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 17:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C746F20656
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 17:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uNKTtXHP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391453AbgDPRDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 13:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729869AbgDPRD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 13:03:29 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F38C061A0C;
        Thu, 16 Apr 2020 10:03:29 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k11so5725971wrp.5;
        Thu, 16 Apr 2020 10:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nLvlmP+OaOH6XW/i7K94s12/ONzxLukR4SF+ucpoCHw=;
        b=uNKTtXHP8cvUQQbNFw1c9nnkLSq7dHHgQI0iH/8O9iGDfpfukB9BaMqONTL4ICZlFp
         CDsLCWWKI+nGlFRMktoyd4JjrbUbBkAvY2WLSV4Hb8q8NQ1or2X9ZLaPBOMz0z2JCgBD
         6iaa8u2mYbUr5jD5zPfKDmpVohCiuYqvxvd/Zf2LQal6zKnZQqjVI/ar6i5wrqBUC5Tq
         OOyaUGdFlbkKTB19y0b89KYUKHn46XnfHoqB6RxBbeAV6Q7A3af2LoWD+56J2StptJxR
         EZChN5V76QQ79KAibeYHEds7O0AtFN1q/Q6AjHYJSTK6PxGdiL3va23xkBGiQcjjHDul
         GfbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nLvlmP+OaOH6XW/i7K94s12/ONzxLukR4SF+ucpoCHw=;
        b=ARo03qtF/H1BvvqSMEGgZx+ZjXjQEzGDLzgxkuUEoTqi64f3PypNE96ncKwgZcQUdl
         O+gvb42RB4WwzXjnYYQfL2GTstsknglaD5vOWx0L71iuNcqBhCH3Uf3ne5W9FLT6MPkN
         aZAFOSv46EUiN00NETIxu06DcHjw5x4ic9Mrup9xgoRIC+4NUhIQA5/EcRNFCYoh8UUN
         GN5dm+rmMcgKZhAgD8ChQArwkozbt6BWotHqt3M9WepgldDIXFAc5zXj/7nWtuamGEeh
         7GavE4hWpYeSxjLHlqUrheNPgWR0JNvN+g0y5x0NRuvhvqhvCB9Od+2hQp/MFbJ+/kxH
         KjjQ==
X-Gm-Message-State: AGi0PuY1klueMdY3UglmvpSATju0vyfWUAXEYP8t7oA8WP2XjQlqIhEf
        do87WuQZB3+gvWi+E3yIGU4=
X-Google-Smtp-Source: APiQypK95rbXcmypBPzPHCxDjxmMrTBCh+O7czfG2FI28j7jzckXtzx3G4SBDQAJt4D/gvqxhBXPlw==
X-Received: by 2002:adf:eccc:: with SMTP id s12mr28943588wro.15.1587056608237;
        Thu, 16 Apr 2020 10:03:28 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id g186sm4339600wme.7.2020.04.16.10.03.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Apr 2020 10:03:27 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: rockchip: fix phy nodename for rk3228-evb
Date:   Thu, 16 Apr 2020 19:03:20 +0200
Message-Id: <20200416170321.4216-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives for example this error:

arch/arm/boot/dts/rk3228-evb.dt.yaml: phy@0:
'#phy-cells' is a required property

The phy nodename is normally used by a phy-handle.
This node is however compatible with
"ethernet-phy-id1234.d400", "ethernet-phy-ieee802.3-c22"
which is just been added to 'ethernet-phy.yaml'.
So change nodename to 'ethernet-phy' for which '#phy-cells'
is not a required property

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=~/.local/lib/python3.5/site-packages/dtschema/schemas/
phy/phy-provider.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3228-evb.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3228-evb.dts b/arch/arm/boot/dts/rk3228-evb.dts
index 5670b33fd..aed879db6 100644
--- a/arch/arm/boot/dts/rk3228-evb.dts
+++ b/arch/arm/boot/dts/rk3228-evb.dts
@@ -46,7 +46,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		phy: phy@0 {
+		phy: ethernet-phy@0 {
 			compatible = "ethernet-phy-id1234.d400", "ethernet-phy-ieee802.3-c22";
 			reg = <0>;
 			clocks = <&cru SCLK_MAC_PHY>;
-- 
2.11.0

