Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C44CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 01:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 360912073B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 01:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=castello.eng.br header.i=@castello.eng.br header.b="ims/7aia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388671AbgEYBzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 21:55:22 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.4]:15584 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388090AbgEYBzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 21:55:22 -0400
X-Greylist: delayed 1479 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 May 2020 21:55:21 EDT
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 82CCF60788
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 20:30:40 -0500 (CDT)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id d1wuj3XZGSl8qd1wujK2SO; Sun, 24 May 2020 20:30:40 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GXXdtueQYy1caDAxoJ6IfrNPBdlHFqXjUasF2a2SRgQ=; b=ims/7aiaxYYird2sC8T0bd0Q1g
        FTuv7sO8YvIs+viADzL/Ydt3Yk7910hakPI5XQms8u2qYpYSFpLq9ADZkr2M0FxnysWMEmq0rL11I
        2eEQWwZb7JO4LYrccF149GPzZKqSdYfUmgWh0svuiRc29nw2bdDbXYXb2c0vxa4y9mV808EeW6SuZ
        ASEjkIM3O0EkSeb5wZqn2yarSG8mdVDTqiMXC+2RYYcGVm5f1lP801AH+/easqMlimerMCcg4UeDN
        IpAZdC56tgIrruNak9Wmy0yoBOxcLEj0oq2T1VEIuaAnU8zIYwsIipJHSRWg3sQOTTcAJ5RJrMlw+
        SH90N5kA==;
Received: from [191.31.196.240] (port=34284 helo=castello.castello)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <matheus@castello.eng.br>)
        id 1jd1wt-004Dik-TR; Sun, 24 May 2020 22:30:40 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     afaerber@suse.de, manivannan.sadhasivam@linaro.org,
        mark.rutland@arm.com, robh+dt@kernel.org
Cc:     edgar.righi@lsitec.org.br, igor.lima@lsitec.org.br,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org,
        Matheus Castello <matheus@castello.eng.br>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 1/3] dt-bindings: Add vendor prefix for Caninos Loucos
Date:   Sun, 24 May 2020 22:30:06 -0300
Message-Id: <20200525013008.108750-2-matheus@castello.eng.br>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200525013008.108750-1-matheus@castello.eng.br>
References: <20200525013008.108750-1-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.31.196.240
X-Source-L: No
X-Exim-ID: 1jd1wt-004Dik-TR
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (castello.castello) [191.31.196.240]:34284
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 14
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Caninos Loucos Program develops Single Board Computers with an open
structure. The Program wants to form a community of developers to use
IoT technologies and disseminate the learning of embedded systems in
Brazil.

It is an initiative of the Technological Integrated Systems Laboratory
(LSI-TEC) with the support of Polytechnic School of the University of
São Paulo (Poli-USP) and Jon "Maddog" Hall.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Andreas Färber <afaerber@suse.de>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index d3891386d671..a20a05e3deaa 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -167,6 +167,8 @@ patternProperties:
     description: CALAO Systems SAS
   "^calxeda,.*":
     description: Calxeda
+  "^caninos,.*":
+    description: Caninos Loucos Program
   "^capella,.*":
     description: Capella Microsystems, Inc
   "^cascoda,.*":
--
2.26.2

