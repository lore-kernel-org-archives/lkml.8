Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3FFC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5173206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593466724;
	bh=ewj35rSkElcFIZJ1hg66kwd3Hqh8xk0tOa2edu8ul6s=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=2jbi4ZjXY2eLiWffpoyvIyGz3751X6bpBht3sM3/HaHmtOMrmkd4FnWSIloEJ/S3r
	 c574QykGLGcxcVci2lr2qv+yBkQW0iRSU0De4mIeMw2MxTR/TL0sfmAuuydF7fTUd+
	 f0/c0zAfz3Rc0c/VcOpmnMT5Z6ZoJUqvEzQWDquc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733024AbgF2Vim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:38:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:60646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728349AbgF2Skc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:40:32 -0400
Received: from localhost.localdomain (unknown [194.230.155.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B70F2085B;
        Mon, 29 Jun 2020 08:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593418541;
        bh=ewj35rSkElcFIZJ1hg66kwd3Hqh8xk0tOa2edu8ul6s=;
        h=From:To:Cc:Subject:Date:From;
        b=UWvRfKHtNAZnU9vTW3cs08UEr9o1o7kqvg7ahwYE1DOS9WSEf1ELbbw/H3torogjJ
         9DtSz9ASc0TuNNu3dUj5myKETz43cRuCM7MfI/ZmSz+w4kRVE7TcebAxWn/38woaJV
         ft4eqKuF+6CYIOIIEKW5KwSyF47qdpYtYxN9ieGA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/3] ARM: dts: alpine: Align GIC nodename with dtschema
Date:   Mon, 29 Jun 2020 10:15:33 +0200
Message-Id: <20200629081535.13502-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix dtschema validator warnings like:
    gic@fb001000: $nodename:0:
        'gic@fb001000' does not match '^interrupt-controller(@[0-9a-f,]+)*$'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/alpine.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/alpine.dtsi b/arch/arm/boot/dts/alpine.dtsi
index d3036ea823d1..3b0675a1c460 100644
--- a/arch/arm/boot/dts/alpine.dtsi
+++ b/arch/arm/boot/dts/alpine.dtsi
@@ -91,7 +91,7 @@
 		};
 
 		/* Interrupt Controller */
-		gic: gic@fb001000 {
+		gic: interrupt-controller@fb001000 {
 			compatible = "arm,cortex-a15-gic";
 			#interrupt-cells = <3>;
 			#size-cells = <0>;
-- 
2.17.1

