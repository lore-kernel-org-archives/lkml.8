Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD84FC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C9E12073B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=flowbird.group header.i=@flowbird.group header.b="CAgKFKEH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732959AbgDBNvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:51:45 -0400
Received: from mail-wm1-f99.google.com ([209.85.128.99]:54903 "EHLO
        mail-wm1-f99.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732723AbgDBNvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 09:51:35 -0400
Received: by mail-wm1-f99.google.com with SMTP id c81so3467194wmd.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 06:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flowbird.group; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q3/W4bkJow86eplxYpKXS4NSE8Ye38WZL3vKGQGBJgI=;
        b=CAgKFKEHAoJsPaHDGmKaVIsRzh82piqq/7ouZPBb26H41t0KcqrPl2CICqjvLn/oLR
         jwaUYBzSX8NjGY2u/5QlvbWQONSYK1E90JjoDrPIPmxu26pNsbuXHNYJYrK3EUDMOLjH
         vwx9lI2VZlRy0yBWHzunEo5f9pk3f1WjKZpduZyXDGmLH93THxl0W7rIrXnE4G7VHPYg
         2rG8RsezEpEBYzUrQj7chgzvhwf2LiFj1Xr6611qCqzQPN9Vg3KT3unOqNNGAQrlP2oC
         H8YVIE8UICAksrlv9Q3WZx0C/mRpup0S5UYxPQKrapnVMynBRE3SQDPvmY12EA+igm3k
         olQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q3/W4bkJow86eplxYpKXS4NSE8Ye38WZL3vKGQGBJgI=;
        b=hFTo5mCaVdOJOezf7xs3T8GeJ71r70ZvI58GHMaps4y87J0pUpT87ZwTONb+WqsgrY
         x2QQ582vcDoVFm8EcWABfses+TOla2Q87YY18qp8ZN+K4Nw71Ln7GKUqdIwe7iw4AkbL
         4mgRfUYVpAuajj6129yu2mSP2wsPQX9RnU1iNXFMUztN+A4g/1K3wtWMJzbdfltuaIJR
         02oqVcBEFwN5jpBGYOrjs5ZaMZZO/zFhJm2wdK3qxhpIc0HTvSdQ9lD9JlJm9AFe/NZV
         1C2UvYhtPhwJZggSw2GoOpBy4M1sKrG97tdQFSLOqJ01BFYMgbA002uZVd2gXWXw9QQw
         649w==
X-Gm-Message-State: AGi0PuYm+QRxqz9gHVA10kBGqEiI8wsHzIVU4GqWeiYgY+AFYiPF4AhY
        qDVGLYReSVxwPggljXHPpyOO32EBZyyOyCTn5NXqtpn3Jipc
X-Google-Smtp-Source: APiQypJVnBj4d11a5FWxkIpNuqoTYc4VqjzLP7kWWP37P/SfWergy0HlMzAspThbw6de+5HNmxfY/MzdZTR1
X-Received: by 2002:a7b:cb8f:: with SMTP id m15mr3616367wmi.162.1585835494158;
        Thu, 02 Apr 2020 06:51:34 -0700 (PDT)
Received: from mail.besancon.parkeon.com ([185.149.63.251])
        by smtp-relay.gmail.com with ESMTPS id m13sm65639wml.4.2020.04.02.06.51.34
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 02 Apr 2020 06:51:34 -0700 (PDT)
X-Relaying-Domain: flowbird.group
Received: from [172.16.12.10] (port=55896 helo=PC12445-BES.dynamic.besancon.parkeon.com)
        by mail.besancon.parkeon.com with esmtp (Exim 4.71)
        (envelope-from <martin.fuzzey@flowbird.group>)
        id 1jK0Fp-0001KP-PX; Thu, 02 Apr 2020 15:51:33 +0200
From:   Martin Fuzzey <martin.fuzzey@flowbird.group>
To:     Fugang Duan <fugang.duan@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v3 4/4] ARM: dts: imx6: add fec gpr property.
Date:   Thu,  2 Apr 2020 15:51:30 +0200
Message-Id: <1585835490-3813-5-git-send-email-martin.fuzzey@flowbird.group>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1585835490-3813-1-git-send-email-martin.fuzzey@flowbird.group>
References: <1585835490-3813-1-git-send-email-martin.fuzzey@flowbird.group>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is required for wake on lan on i.MX6

Signed-off-by: Martin Fuzzey <martin.fuzzey@flowbird.group>
Reviewed-by: Fugang Duan <fugang.duan@nxp.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index bc488df..65b0c8a 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -1045,6 +1045,7 @@
 					 <&clks IMX6QDL_CLK_ENET>,
 					 <&clks IMX6QDL_CLK_ENET_REF>;
 				clock-names = "ipg", "ahb", "ptp";
+				gpr = <&gpr>;
 				status = "disabled";
 			};
 
-- 
1.9.1

