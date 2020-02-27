Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E59BC11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 20:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 500882469C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 20:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=castello.eng.br header.i=@castello.eng.br header.b="tcjbM6ns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbgB0UkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 15:40:05 -0500
Received: from gateway36.websitewelcome.com ([192.185.193.119]:25353 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726758AbgB0UkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 15:40:04 -0500
X-Greylist: delayed 1417 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Feb 2020 15:40:04 EST
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 11F6B400C2F5F
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 13:31:19 -0600 (CST)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id 7Pa5jzwbiRP4z7Pa5jOUPN; Thu, 27 Feb 2020 14:16:25 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qoO2qsaKDDkITqEnriWbR9MEmzTrNQCsMHlNkFBYJ7c=; b=tcjbM6nsjXMnB1U50YJqJ0Xpq+
        qnb6sizE41zDg6WWUl6+PgNcBLucBF18ilJ0ekjStyF0ZK+qs9laPZeAs4HULnEnQJAPcUYmJhJh3
        iNANGLYl0YuK6SGCRzH2kwFqTtzFPqn065TDn2wj+R8SSpz9sqOrctyNxJ7dlKjIGHuo/lxgZJ7gW
        4QE368So677rBzP33fUqD1UHd+Z5E1rOKM1ck0LnzvKzZWMkTYPLf2n/ieBR1K0zTtFiUfv6wle1v
        dp+OsSgF9hYl1BG91kGTsc5PPX0iJg/vbfN2VOy0Txc/DcxMMZxqGE8gjOwKZQLcNBPMf5yjUSZCA
        mj2+zzYA==;
Received: from [191.31.195.84] (port=40030 helo=castello.castello)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <matheus@castello.eng.br>)
        id 1j7Pa4-002xJo-Nh; Thu, 27 Feb 2020 17:16:25 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     afaerber@suse.de, manivannan.sadhasivam@linaro.org,
        mark.rutland@arm.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH v1 1/2] dt-bindings: arm: actions: Document Caninos Loucos Labrador
Date:   Thu, 27 Feb 2020 17:15:56 -0300
Message-Id: <20200227201557.368533-2-matheus@castello.eng.br>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200227201557.368533-1-matheus@castello.eng.br>
References: <20200227201557.368533-1-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.31.195.84
X-Source-L: No
X-Exim-ID: 1j7Pa4-002xJo-Nh
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (castello.castello) [191.31.195.84]:40030
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 10
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the documentation to add the Caninos Loucos Labrador
vendor-prefix and items that were included in the device tree files.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
---
 Documentation/devicetree/bindings/arm/actions.yaml     | 5 +++++
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 2 files changed, 7 insertions(+)

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

