Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57663C54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 17:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 302AF206DD
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 17:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=castello.eng.br header.i=@castello.eng.br header.b="pdUqdKvE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgDZRtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 13:49:51 -0400
Received: from gateway34.websitewelcome.com ([192.185.149.72]:15577 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726154AbgDZRtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 13:49:51 -0400
X-Greylist: delayed 1649 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 Apr 2020 13:49:50 EDT
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 1553630A1DF5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 11:59:28 -0500 (CDT)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id Skcqj8pAS8vkBSkcqjsxCP; Sun, 26 Apr 2020 11:59:28 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=e+jJxdcYJ/hbFBY+xD9PXWL+/xiGmlod4Jp6X2xhM4Q=; b=pdUqdKvEoQiXcCIa/mtQVbSCLh
        z5hYqIvXV0mJ5uKgPq6owU8zXlWBFNIJhLGhrRUD8XD/VtHDnsthk81EFzxKrdiPrcw4QsaXiavHK
        /3PtccT7GK7bTa5BKbSGRJOpaXF860Uo6uiz2M2FazsimupI38iwdockxjdPKR+8Cs2y7KlnH8JVN
        Bg2gu7/IE7FRopdHr+WuLjxlluAOgMolo7RHgTrL1eGtN8BiVD7oVhDbQFHHCC1Bpe/XTw8zPrqG4
        YxenjeuY2344IJ0bBg8PgclRIDZuYbDOfwbWPrUOJLksFNL46/rfMceV9WCON9N/lvuPuokmMe/vz
        iK6Lw7Jg==;
Received: from [191.31.197.205] (port=35482 helo=castello.castello)
        by br164.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <matheus@castello.eng.br>)
        id 1jSkcp-001TTf-G5; Sun, 26 Apr 2020 13:59:27 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     afaerber@suse.de, manivannan.sadhasivam@linaro.org,
        mark.rutland@arm.com, robh+dt@kernel.org
Cc:     edgar.righi@lsitec.org.br, igor.lima@lsitec.org.br,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org,
        Matheus Castello <matheus@castello.eng.br>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/3] dt-bindings: Add vendor prefix for Caninos Loucos
Date:   Sun, 26 Apr 2020 13:58:33 -0300
Message-Id: <20200426165835.105970-2-matheus@castello.eng.br>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200426165835.105970-1-matheus@castello.eng.br>
References: <f9e48fba-0da8-7ba9-d44a-7909067a1df1@castello.eng.br>
 <20200426165835.105970-1-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.31.197.205
X-Source-L: No
X-Exim-ID: 1jSkcp-001TTf-G5
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (castello.castello) [191.31.197.205]:35482
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 28
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
2.25.0

