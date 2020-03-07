Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC42C10DCE
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 00:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B5A20637
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 00:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=castello.eng.br header.i=@castello.eng.br header.b="EpxtDvLg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgCGAs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 19:48:56 -0500
Received: from gateway30.websitewelcome.com ([192.185.149.4]:23678 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726633AbgCGAsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 19:48:55 -0500
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id AB6E53C9A6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Mar 2020 18:25:53 -0600 (CST)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id ANHtj3sbxEfyqANHtj7GCj; Fri, 06 Mar 2020 18:25:53 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=a0fH3cAF828a4S/+b1Nbsier8zx9VXfLEXnuCfekO00=; b=EpxtDvLgSuOZQ7sofuiVpGCRFs
        6RdXWHY6RtMMGx1ldUhC+j9iMeVI2Thg2V2qKefOhji1J8Qls+nEs2pciJuVztr3GeIF+4bwbEr/0
        WCC3tDwVv64wzTFiUECIyj7QVpevzHme/2+Q0OG0vnbIPE/7hu3xLfaawTQBXUhFf1OTJ0F1jS0vA
        8ruTO/pYEZ+PXoLzlHZJ+gFPITFDb8+JV4V2fXrKWSzGJ9aGRihO/Q/4Plv3PEDbmEWJ2lkEkiW7X
        zY2Hg9RDsMmEH6/nj5udwibpccWTO9QBBWfEGAMrR4LyQOszG69v29MqRalxmxw3CTTvWPTl6psFL
        JHE9iyWA==;
Received: from [191.31.207.132] (port=48872 helo=castello.castello)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <matheus@castello.eng.br>)
        id 1jANHt-001YDM-4h; Fri, 06 Mar 2020 21:25:53 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     afaerber@suse.de, manivannan.sadhasivam@linaro.org,
        mark.rutland@arm.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v2 2/3] dt-bindings: arm: actions: Document Caninos Loucos Labrador
Date:   Fri,  6 Mar 2020 21:24:52 -0300
Message-Id: <20200307002453.350430-3-matheus@castello.eng.br>
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
X-Exim-ID: 1jANHt-001YDM-4h
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (castello.castello) [191.31.207.132]:48872
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 17
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the documentation to add the Caninos Loucos Labrador. Labrador
project consists of a computer on module based on the Actions Semi S500
processor and the Labrador base board.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
---
 Documentation/devicetree/bindings/arm/actions.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/actions.yaml b/Documentation/devicetree/bindings/arm/actions.yaml
index ace3fdaa8396..1b131ceb884a 100644
--- a/Documentation/devicetree/bindings/arm/actions.yaml
+++ b/Documentation/devicetree/bindings/arm/actions.yaml
@@ -24,6 +24,11 @@ properties:
               - lemaker,guitar-bb-rev-b # LeMaker Guitar Base Board rev. B
           - const: lemaker,guitar
           - const: actions,s500
+      - items:
+          - enum:
+              - caninos,labrador-bb # Caninos Loucos Labrador Base Board
+          - const: caninos,labrador
+          - const: actions,s500

       # The Actions Semi S700 is a quad-core ARM Cortex-A53 SoC.
       - items:
--
2.25.0

