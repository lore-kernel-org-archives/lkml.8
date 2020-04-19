Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE19EC38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 17:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9587D206E9
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 17:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgDSRM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 13:12:57 -0400
Received: from v6.sk ([167.172.42.174]:44160 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbgDSRMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 13:12:55 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 687D5610B8;
        Sun, 19 Apr 2020 17:12:23 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 09/15] ARM: dts: mmp3: Fix L2 cache controller node name
Date:   Sun, 19 Apr 2020 19:11:51 +0200
Message-Id: <20200419171157.672999-10-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200419171157.672999-1-lkundrak@v3.sk>
References: <20200419171157.672999-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current one makes validation unhappy:

  mmp3-dell-ariel.dt.yaml: l2-cache-controller@d0020000: $nodename:0:
      'l2-cache-controller@d0020000' does not match
      '^(cache-controller|cpu)(@[0-9a-f,]+)*$'

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/mmp3.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/mmp3.dtsi b/arch/arm/boot/dts/mmp3.dtsi
index 3ac5e4e86e56d..531e1d85d5fa6 100644
--- a/arch/arm/boot/dts/mmp3.dtsi
+++ b/arch/arm/boot/dts/mmp3.dtsi
@@ -523,7 +523,7 @@ ssp4: spi@d4039000 {
 			};
 		};
 
-		l2: l2-cache-controller@d0020000 {
+		l2: cache-controller@d0020000 {
 			compatible = "marvell,tauros3-cache", "arm,pl310-cache";
 			reg = <0xd0020000 0x1000>;
 			cache-unified;
-- 
2.26.0

