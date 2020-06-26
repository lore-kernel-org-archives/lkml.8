Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C96C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24CF02076E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593158796;
	bh=ShdZXhFMHq+oH0B/0iNOVMT1LmutMO+0UPHFutoFfXA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=wR7msO0nIXXbngMoiVWg6Zhk2FM2XnAzNElqZDC/CW5Xdjpxi7H7x+E+NsbECR/qq
	 pEgetK4ODbm1FBW1E1daPWBRJHwzMFdBWbPF7Sq+kMleYEanBeyQ+VAlKka2ZhL+Lc
	 NY2/F1FJoOhSpaT9lFuu7hpCxW1tBiIAkBTfwZPA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbgFZIGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 04:06:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:37716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729306AbgFZIGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 04:06:31 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1742A2076E;
        Fri, 26 Jun 2020 08:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593158791;
        bh=ShdZXhFMHq+oH0B/0iNOVMT1LmutMO+0UPHFutoFfXA=;
        h=From:To:Cc:Subject:Date:From;
        b=XWkYrvco4EvI1xVUDR9MPyhSaOvyF7cF8KvQYIVaZic8SnHEJozzOPcaW73rROW+j
         YewsMYkx+/mvitPgi+Zascw6RwYBVPAB9pPkqgmjSxYDF0zf9EyzKosJfevEwrkuYc
         fn6lfMiKKXutniiEO5vX9g6DCh5eFvxdW6FqJYuU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH] ARM: dts: meson: Align L2 cache-controller nodename with dtschema
Date:   Fri, 26 Jun 2020 10:06:26 +0200
Message-Id: <20200626080626.4080-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix dtschema validator warnings like:
     l2-cache-controller@c4200000: $nodename:0:
         'l2-cache-controller@c4200000' does not match '^(cache-controller|cpu)(@[0-9a-f,]+)*$'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/meson.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
index ae89deaa8c9c..91129dc70d83 100644
--- a/arch/arm/boot/dts/meson.dtsi
+++ b/arch/arm/boot/dts/meson.dtsi
@@ -11,7 +11,7 @@
 	#size-cells = <1>;
 	interrupt-parent = <&gic>;
 
-	L2: l2-cache-controller@c4200000 {
+	L2: cache-controller@c4200000 {
 		compatible = "arm,pl310-cache";
 		reg = <0xc4200000 0x1000>;
 		cache-unified;
-- 
2.17.1

