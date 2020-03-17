Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D268AC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7BE520738
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=flowbird.group header.i=@flowbird.group header.b="LKMnOP59"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgCQQuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 12:50:20 -0400
Received: from mail-lj1-f225.google.com ([209.85.208.225]:37390 "EHLO
        mail-lj1-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgCQQuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 12:50:13 -0400
Received: by mail-lj1-f225.google.com with SMTP id r24so23759700ljd.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 09:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flowbird.group; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=evj4d0V6zpXsfSXOnl0C5Tn/QOdwXKQU5BTSPlnFegk=;
        b=LKMnOP59KoyxHHgA43wSg0vYtKMMlf+6CHG7yVovbtWy7miYzxYL1Uhgm7eYcIn7nm
         D95mX62KcwLQg10mi9DsMSXdhLDICSZ8kXioMF49aS1UnGT9pheUV4KBEgZHt0cAXwY6
         WC1vmMn4K+J7INIslhfFR+uxZMJKz1GGsaUY78K8FQgPj7jYoq0sLXKd6jro1oaIxuYe
         6w20mlkNGYKDFjktFijUHswhMSgs8cpUQQRf4je9oP6+3R7jKNIEGyAN9mC/Ad++ecWj
         NACNurJhQa3CCrCFwxVYKPvIDQZPaZkJcWLdoHRIiJLUap7itpslyz2ehw/wxUzrwpXh
         Zkpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=evj4d0V6zpXsfSXOnl0C5Tn/QOdwXKQU5BTSPlnFegk=;
        b=RVCnX8m+Y7Sdrp4ps4MENCw8jRysv8fLrq/a/XlQIVasldKvuEy0lDOMOZ6r38JC4J
         W+PjF9gK6opUSji7DX9gOyp7ohOH+gWBpbIFuaMIGokVFKYeYyu6H4BhBVwHzB/mxtzV
         /4wNeQYigew9dVvnQFY6lLaaEHOGg6nmpGfPAGe4i+EUZiUqo5FZHt1S+ZryiCiapUkB
         mmmIxNoyWyKEvwfs0a4FNJXmWCScxajPkshGmXLDXiL6ZQkemIbTG6fmGaah9PnKj0L/
         ejrcAeZKZ+BBMzLuRlZUyzuYi3+0nMjS1mKEiw3w7XFCxyOb8XJvDB6ejCjTVgJmel5w
         v3zg==
X-Gm-Message-State: ANhLgQ1x5wa5KCDyp8dF4Om2obl9Tr4aPruPoz44sA259YqxdKi0p5BL
        HqkC8253UqzAvOx64cgt4Mz/xQ2+PNffPtbPSNSqw5FVBCS9
X-Google-Smtp-Source: ADFU+vst4+YLm4+TecIAr8Y9a4YBFV0tjg8Q0cTN8eC53ZXZGkwdowxtmQVzVsRMuQLu+vq3/hq480X3rORk
X-Received: by 2002:a2e:89c9:: with SMTP id c9mr3483335ljk.181.1584463811099;
        Tue, 17 Mar 2020 09:50:11 -0700 (PDT)
Received: from mail.besancon.parkeon.com ([185.149.63.251])
        by smtp-relay.gmail.com with ESMTPS id e20sm13727lfn.29.2020.03.17.09.50.10
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 17 Mar 2020 09:50:11 -0700 (PDT)
X-Relaying-Domain: flowbird.group
Received: from [172.16.13.134] (port=56876 helo=PC12445-BES.dynamic.besancon.parkeon.com)
        by mail.besancon.parkeon.com with esmtp (Exim 4.71)
        (envelope-from <martin.fuzzey@flowbird.group>)
        id 1jEFPu-0000dJ-BW; Tue, 17 Mar 2020 17:50:10 +0100
From:   Martin Fuzzey <martin.fuzzey@flowbird.group>
To:     Fugang Duan <fugang.duan@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org
Subject: [PATCH 4/4] ARM: dts: imx6: add fsl,stop-mode property.
Date:   Tue, 17 Mar 2020 17:50:06 +0100
Message-Id: <1584463806-15788-5-git-send-email-martin.fuzzey@flowbird.group>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1584463806-15788-1-git-send-email-martin.fuzzey@flowbird.group>
References: <1584463806-15788-1-git-send-email-martin.fuzzey@flowbird.group>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is required for wake on lan on i.MX6

Signed-off-by: Martin Fuzzey <martin.fuzzey@flowbird.group>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index bc488df..49c0527 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -1045,6 +1045,7 @@
 					 <&clks IMX6QDL_CLK_ENET>,
 					 <&clks IMX6QDL_CLK_ENET_REF>;
 				clock-names = "ipg", "ahb", "ptp";
+				fsl,stop-mode = <&gpr 0x34 27>;
 				status = "disabled";
 			};
 
-- 
1.9.1

