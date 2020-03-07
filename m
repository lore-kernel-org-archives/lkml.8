Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C526C10DCE
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 00:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3063420637
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 00:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=castello.eng.br header.i=@castello.eng.br header.b="mSWQ807T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgCGAuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 19:50:32 -0500
Received: from gateway31.websitewelcome.com ([192.185.144.96]:27519 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726245AbgCGAub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 19:50:31 -0500
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 399B01ED92
        for <linux-kernel@vger.kernel.org>; Fri,  6 Mar 2020 18:25:42 -0600 (CST)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id ANHijQxhd8vkBANHijKMP9; Fri, 06 Mar 2020 18:25:42 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Vz7QCVTScPIXCPlremyyPp9LM84BR1/7adELzoK6PKY=; b=mSWQ807TvynUdlv1VaaaDOERWC
        9sBBiZ/MqafHffssNPhy6kUkukGykrbaVD0FZhKE8EhF1IUw303Qmbp+q4JTKKBUEV3ubL4zID8jP
        JHDwK55H916MYhc15fXvRTXKOLDHZsXgrPlm5SjXwnVv0c14UOI3aJP8ZODvrFs/AJD4F1f0NuY1C
        dqN0ThYi2y8624zwEsORDTVJrzn5NXE/481Vq9Nz1DgZd5zLU7vg2HIWSLzdWrBntdUULDN20vJeh
        rSzVsvJgryph9kGo8litMXit5wOnqj2PyfDpVfoJDHS6EVdYBPZL1AKIMSGjHKkpFo3X/D2pt/7+Y
        aV+0t9rg==;
Received: from [191.31.207.132] (port=48872 helo=castello.castello)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <matheus@castello.eng.br>)
        id 1jANHh-001YDM-Lp; Fri, 06 Mar 2020 21:25:42 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     afaerber@suse.de, manivannan.sadhasivam@linaro.org,
        mark.rutland@arm.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v2 1/3] dt-bindings: Add vendor prefix for Caninos Loucos
Date:   Fri,  6 Mar 2020 21:24:51 -0300
Message-Id: <20200307002453.350430-2-matheus@castello.eng.br>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200307002453.350430-1-matheus@castello.eng.br>
References: <20200229104358.GB19610@mani>
 <20200307002453.350430-1-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.31.207.132
X-Source-L: No
X-Exim-ID: 1jANHh-001YDM-Lp
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (castello.castello) [191.31.207.132]:48872
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 9
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Caninos Loucos Program develops Single Board Computers with an open
structure. The Program wants to form a community of developers to use
the IoT technology and disseminate the learning of embedded systems in
Brazil.

The boards are designed and manufactured by LSI-TEC NPO.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 9e67944bec9c..3e974dd563cf 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -167,6 +167,8 @@ patternProperties:
     description: Calxeda
   "^capella,.*":
     description: Capella Microsystems, Inc
+  "^caninos,.*":
+    description: Caninos Loucos LSI-TEC NPO
   "^cascoda,.*":
     description: Cascoda, Ltd.
   "^catalyst,.*":
--
2.25.0

