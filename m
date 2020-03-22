Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FDAC54FCF
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 14:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB9820637
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 14:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oi5rzEX0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgCVOA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 10:00:56 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41420 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgCVOAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 10:00:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id h9so13284549wrc.8;
        Sun, 22 Mar 2020 07:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+Pk1Qm0yKFU4UFpPiRDPyywzNL1S0kp3oY+pR0dHLbM=;
        b=oi5rzEX0X8RLP2HKiTVVqVs7HpQ7aPojsZDgCYmMnYOtWabV8UXffBg4gms1wqcqft
         +/58QOvDf6bioXi8SnjrvUM7F6HcQ70/1Kpghz3s2qRBBNtUZxZnrX4Yh6Ho/3kN3BEZ
         2fwN1nJFoFiZLWIdXHivtU9nzJ/K74nWzVxFipAPBoTgjuB/lHjvOcolL4ISXWR2XX/5
         2SZu3Kx1bDbRDkXb8q/hn6hJR7uYBQmORF1lUEz1xfVgDOYNuaJYiHKGGcPQ7yUmPxN8
         +cEeu8HCCo+YMhwe0vXdnx9jtXryqqQwOsPdky5SVb8bgshlml7FsP7PDftZnOxPPhM3
         y/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+Pk1Qm0yKFU4UFpPiRDPyywzNL1S0kp3oY+pR0dHLbM=;
        b=E53DnOZkQUqExn1C8btdvjW4RDmSt9DxsA3n7O8zN2cgMPwTQ5Rb8/xuEgs9KN/pF5
         zH5nAhRDa/S8ztVxOmV/ILgWRdqePfmrv7kF7db5NJ6jUCU/Fvi4CcZFreqrYBZUBUjn
         Amiie6j94+DkzgcbQ+eLdVJCUFKycokHpYctKQwv8O6EVROPU22eib6yHNsjewMDe61W
         yGoMd13sF71ZQa9B3G0X+wMDADMkq1gQP9fTp5i8joqPWEjgleknkCONxO9EDbauWotg
         nKud877yTB3vSNZgAuEP8BXGqIOzFO37ex1rp6NEe0JLokaEAtcPCOaa72blXKkNIhV0
         dbGQ==
X-Gm-Message-State: ANhLgQ35FFALuTKufwVaXvvHOc0+LodbWmCgBfgs1S39LN8eWul4yo2I
        AIFzSEgmwP19eVx0FvvQpBE=
X-Google-Smtp-Source: ADFU+vv9LrpAvriFkI/duBNcEmS2l2/uhLRxDqAJ4ObMkC37RlGZ/y1+sMgI5XKHs3Xia3KUeu4Mjw==
X-Received: by 2002:adf:a4d2:: with SMTP id h18mr24215660wrb.90.1584885653724;
        Sun, 22 Mar 2020 07:00:53 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id 1sm11355129wmz.32.2020.03.22.07.00.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Mar 2020 07:00:53 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: fix defines in pd_vio node for rk3399
Date:   Sun, 22 Mar 2020 15:00:46 +0100
Message-Id: <20200322140046.5824-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives for example this error:

arch/arm64/boot/dts/rockchip/rk3399-evb.dt.yaml: pd_vio@15:
'pd_tcpc0@RK3399_PD_TCPC0', 'pd_tcpc1@RK3399_PD_TCPC1'
do not match any of the regexes:
'.*-names$', '.*-supply$', '^#.*-cells$',
'^#[a-zA-Z0-9,+\\-._]{0,63}$',
'^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}$',
'^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}@[0-9a-fA-F]+(,[0-9a-fA-F]+)*$',
'^__.*__$', 'pinctrl-[0-9]+'

Fix error by replacing the wrong defines by the ones
mentioned in 'rk3399-power.h'.

make -k ARCH=arm64 dtbs_check

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 8aac201f0..3dc8fe620 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1087,12 +1087,12 @@
 					pm_qos = <&qos_isp1_m0>,
 						 <&qos_isp1_m1>;
 				};
-				pd_tcpc0@RK3399_PD_TCPC0 {
+				pd_tcpc0@RK3399_PD_TCPD0 {
 					reg = <RK3399_PD_TCPD0>;
 					clocks = <&cru SCLK_UPHY0_TCPDCORE>,
 						 <&cru SCLK_UPHY0_TCPDPHY_REF>;
 				};
-				pd_tcpc1@RK3399_PD_TCPC1 {
+				pd_tcpc1@RK3399_PD_TCPD1 {
 					reg = <RK3399_PD_TCPD1>;
 					clocks = <&cru SCLK_UPHY1_TCPDCORE>,
 						 <&cru SCLK_UPHY1_TCPDPHY_REF>;
-- 
2.11.0

