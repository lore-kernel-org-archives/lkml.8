Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449E9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 226C12065C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591035284;
	bh=rgoYLS+WMEIn3HQPScbZElKfuAs0VrEeOrN4VJIZ2TQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cnFrwNzo7BwmFVKkYfptAwGHcvLtTamCHTJNyDep9PN/CqqhzRNpCE8wNZ4fg3rhW
	 1H9ZZOG3uuc48oyxVLfUOcai9ZLeVIBzrvPjBYLvi7cNBxpbdUjwLbQEmG1g4eWTps
	 2QaAstIozqNHVvO1FPQydNSU3BIJR4BMJm6lKHXI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731496AbgFASOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:14:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:34420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730453AbgFASOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:14:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 679B2206E2;
        Mon,  1 Jun 2020 18:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591035273;
        bh=rgoYLS+WMEIn3HQPScbZElKfuAs0VrEeOrN4VJIZ2TQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xcntPZVZRjqos1xnr7FDwuqwe5yAW46VSCvHKrNavc9WdnZOoanIQ+PWnz93I3Owg
         9xyCX9b/Ebnt/Z17iaIMLRe7+HY3sTpX34QjWtH2oDpP8q512CTesLoyLoxQjcgYGe
         mZU2t4VxCe8V2RjMVmYtXk/Zg1lcDpsELHdLNe1Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Jonker <jbx6244@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 045/177] ARM: dts: rockchip: fix phy nodename for rk3228-evb
Date:   Mon,  1 Jun 2020 19:53:03 +0200
Message-Id: <20200601174052.790962959@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174048.468952319@linuxfoundation.org>
References: <20200601174048.468952319@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Jonker <jbx6244@gmail.com>

[ Upstream commit 287e0d538fcec2f6e8eb1e565bf0749f3b90186d ]

A test with the command below gives for example this error:

arch/arm/boot/dts/rk3228-evb.dt.yaml: phy@0:
'#phy-cells' is a required property

The phy nodename is normally used by a phy-handle.
This node is however compatible with
"ethernet-phy-id1234.d400", "ethernet-phy-ieee802.3-c22"
which is just been added to 'ethernet-phy.yaml'.
So change nodename to 'ethernet-phy' for which '#phy-cells'
is not a required property

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=~/.local/lib/python3.5/site-packages/dtschema/schemas/
phy/phy-provider.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://lore.kernel.org/r/20200416170321.4216-1-jbx6244@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/rk3228-evb.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3228-evb.dts b/arch/arm/boot/dts/rk3228-evb.dts
index 5670b33fd1bd..aed879db6c15 100644
--- a/arch/arm/boot/dts/rk3228-evb.dts
+++ b/arch/arm/boot/dts/rk3228-evb.dts
@@ -46,7 +46,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		phy: phy@0 {
+		phy: ethernet-phy@0 {
 			compatible = "ethernet-phy-id1234.d400", "ethernet-phy-ieee802.3-c22";
 			reg = <0>;
 			clocks = <&cru SCLK_MAC_PHY>;
-- 
2.25.1



