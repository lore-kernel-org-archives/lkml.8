Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA5AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 03:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FDDE20C56
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 03:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="Tf6h3bMW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388217AbgE2Doy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 23:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388037AbgE2Dou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 23:44:50 -0400
Received: from vultr.net.flygoat.com (vultr.net.flygoat.com [IPv6:2001:19f0:6001:3633:5400:2ff:fe8c:553])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DC0C08C5C6;
        Thu, 28 May 2020 20:44:50 -0700 (PDT)
Received: from localhost.localdomain (unknown [142.147.94.151])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id 17AAE20C7A;
        Fri, 29 May 2020 03:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1590723888; bh=PwotI4TiGasuhIiQDbOHTos1E5+4xZNTYufK4hQ7lmM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tf6h3bMWMWFygeU0DFMWWsPUgzvMbkWkda5kT5oWqPwIYWcyGyBWswVZibnikL1G1
         AKWGqrE2J2zlwW/96sD66GzEtxpOcABK6brRKBmFG3qMPnalhOcRfVlnx/7/dRAJ6T
         TrBEd+DcJZKvlscRMVoRkU5J9tGlGjMsrPnrC5k/r0qFRMPH0T0zMKb1XC1rsx5B7V
         oAoc+nVwqsmhBDpoMkify/mMQKm1hBg4aTlI53xDF0pSFYOFzYQX7f2rRC8H/djmjG
         KcDQDz9RIxoXDi4tRIGqMcv38ArVP9gW7DQrQovpzVx97W7H7QiDHKlA8q/Ck06nhF
         5wGFoAwM+8UHQ==
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     maz@kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Huacai Chen <chenhc@lemote.com>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: mips: Document two Loongson generic boards
Date:   Fri, 29 May 2020 11:43:18 +0800
Message-Id: <20200529034338.1137776-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <20200529034338.1137776-1-jiaxun.yang@flygoat.com>
References: <20200529034338.1137776-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document loongson3-8core-ls7a and loongson3-r4-ls7a, with
two boards LS7A PCH.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 .../devicetree/bindings/mips/loongson/devices.yaml        | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mips/loongson/devices.yaml b/Documentation/devicetree/bindings/mips/loongson/devices.yaml
index 74ed4e397a78..6164b0fcb493 100644
--- a/Documentation/devicetree/bindings/mips/loongson/devices.yaml
+++ b/Documentation/devicetree/bindings/mips/loongson/devices.yaml
@@ -24,4 +24,12 @@ properties:
       - description: Generic Loongson3 Octa Core + RS780E
         items:
           - const: loongson,loongson3-8core-rs780e
+
+      - description: Generic Loongson3 Quad Core + LS7A
+        items:
+          - const: loongson,loongson3-8core-ls7a
+
+      - description: Generic Loongson3 Release 4 + LS7A
+        items:
+          - const: loongson,loongson3-r4-ls7a
 ...
-- 
2.27.0.rc0

