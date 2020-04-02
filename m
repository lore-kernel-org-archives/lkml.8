Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3628C2D0F3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A9982074D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=flowbird.group header.i=@flowbird.group header.b="D8XUasNH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732843AbgDBNvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:51:36 -0400
Received: from mail-wr1-f97.google.com ([209.85.221.97]:39375 "EHLO
        mail-wr1-f97.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732591AbgDBNve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 09:51:34 -0400
Received: by mail-wr1-f97.google.com with SMTP id p10so4294304wrt.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 06:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flowbird.group; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yPUD4F4jhx7/mi0KaztxcsCPAij+5GRCYLwubP4M4n0=;
        b=D8XUasNHDKei7vJxYiYh9CfYGlKQFR5U6+L/aCvM/bY5esrvXd6wHqponjNp/KcOzU
         /0xRh4TUOA9YkKeTs+ZOKjq3fFN1HYOu4yI5qo4LlOQFYOWtsldlguXeVI4dXAtGPaXO
         sdSUwO9qKjYD47nUp/21ad52W627XEk/e53y0zIII32VOQwxNw4SVBmNPNOYrnOr9Nk2
         1rPqyFZO3K+bzoPEEiQOfo+vg0ylABbDX3EsebC+Ma4sHUGgeXuY0luNAjdDJygH9jAB
         79BzSWAb9wYe+i4a+dB02k2FEYQtZUsuz6rMt4lxGA6a0on6lEQfWsqhmer+nxIMXjvb
         mGTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yPUD4F4jhx7/mi0KaztxcsCPAij+5GRCYLwubP4M4n0=;
        b=ewZUm4DArdwl+oV9ZZAgBgVE1Un9Lp2rjXyjQw5au/IzF7YXTMinm+duLSHkm3CoBE
         nRr6qXVZx7++NvQ/DBTa59xPDVnlxf9Bm5XNV+a4pqe46VUgyDVdE1VvEDKnUPfnHsqa
         Q7poV033rNu801vChcTW+TSZ6pBoymIIzdqiW7jZJOB4OkKIc4TOVH+AHCwKfEquAxnN
         qKycKzMAg5d7YVDV7TTeK3ddWLGi4sPKGinHqggzTGyie6+lwPDeJswAk7UJ5NzhyjvS
         DZ+HzliPyJu1g+5K5O0uHLOop7+dlT/uuwX9fVODOSeSFXksjmsBJNith+UNJYkekM6M
         6HhQ==
X-Gm-Message-State: AGi0Puahgk/mM5sKvgW0eR29M8a0ldfBCTQvMQ6TfQyW9jzpT3ZVBWZl
        8e2rmkZxc0xONmhK8NPyigTX46DrJZngcwKTr/GV12l1f7oi
X-Google-Smtp-Source: APiQypIslmTrvWxc6+PCXCJKisz7gnh6rZeh4pgL0sio8rcxwJXnJbctMlP9ZJsZlMHbYPzTAtusNkZ39+4s
X-Received: by 2002:a5d:474b:: with SMTP id o11mr3505217wrs.4.1585835492767;
        Thu, 02 Apr 2020 06:51:32 -0700 (PDT)
Received: from mail.besancon.parkeon.com ([185.149.63.251])
        by smtp-relay.gmail.com with ESMTPS id c9sm95411wrd.85.2020.04.02.06.51.32
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 02 Apr 2020 06:51:32 -0700 (PDT)
X-Relaying-Domain: flowbird.group
Received: from [172.16.12.10] (port=55896 helo=PC12445-BES.dynamic.besancon.parkeon.com)
        by mail.besancon.parkeon.com with esmtp (Exim 4.71)
        (envelope-from <martin.fuzzey@flowbird.group>)
        id 1jK0Fo-0001KP-Dh; Thu, 02 Apr 2020 15:51:32 +0200
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
Subject: [PATCH v3 2/4] ARM: dts: imx6: Use gpc for FEC interrupt controller to fix wake on LAN.
Date:   Thu,  2 Apr 2020 15:51:28 +0200
Message-Id: <1585835490-3813-3-git-send-email-martin.fuzzey@flowbird.group>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1585835490-3813-1-git-send-email-martin.fuzzey@flowbird.group>
References: <1585835490-3813-1-git-send-email-martin.fuzzey@flowbird.group>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to wake from suspend by ethernet magic packets the GPC
must be used as intc does not have wakeup functionality.

But the FEC DT node currently uses interrupt-extended,
specificying intc, thus breaking WoL.

This problem is probably fallout from the stacked domain conversion
as intc used to chain to GPC.

So replace "interrupts-extended" by "interrupts" to use the default
parent which is GPC.

Fixes: b923ff6af0d5 ("ARM: imx6: convert GPC to stacked domains")

Signed-off-by: Martin Fuzzey <martin.fuzzey@flowbird.group>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 5 ++---
 arch/arm/boot/dts/imx6qp.dtsi  | 1 -
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index e6b4b85..bc488df 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -1039,9 +1039,8 @@
 				compatible = "fsl,imx6q-fec";
 				reg = <0x02188000 0x4000>;
 				interrupt-names = "int0", "pps";
-				interrupts-extended =
-					<&intc 0 118 IRQ_TYPE_LEVEL_HIGH>,
-					<&intc 0 119 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <0 118 IRQ_TYPE_LEVEL_HIGH>,
+					     <0 119 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6QDL_CLK_ENET>,
 					 <&clks IMX6QDL_CLK_ENET>,
 					 <&clks IMX6QDL_CLK_ENET_REF>;
diff --git a/arch/arm/boot/dts/imx6qp.dtsi b/arch/arm/boot/dts/imx6qp.dtsi
index 5f51f8e..d91f92f 100644
--- a/arch/arm/boot/dts/imx6qp.dtsi
+++ b/arch/arm/boot/dts/imx6qp.dtsi
@@ -77,7 +77,6 @@
 };
 
 &fec {
-	/delete-property/interrupts-extended;
 	interrupts = <0 118 IRQ_TYPE_LEVEL_HIGH>,
 		     <0 119 IRQ_TYPE_LEVEL_HIGH>;
 };
-- 
1.9.1

