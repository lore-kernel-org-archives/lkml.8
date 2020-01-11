Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B452C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0166920848
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578737530;
	bh=LhXCJwhZ7SIthiaSz6eacka57FWG4LDTW51FS5XhUMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rZsB6fucnMMiXd/sVav00im4Qcqa2kIeUvUHaWOlzL/NDIBlKmGWi+mPCrCQQD7qQ
	 8p+iS7uRlvGrsdwINgsBCfYBDBugHmIfJrEXSYsQMDRQKtcUdDWslrZYs7RH79sTLs
	 /+9sW8afKAi05j4YEM/ifutW3LDb5nS4O1PAhab8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbgAKKMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:12:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:46480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729836AbgAKKKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:10:07 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54C94206DA;
        Sat, 11 Jan 2020 10:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578737407;
        bh=LhXCJwhZ7SIthiaSz6eacka57FWG4LDTW51FS5XhUMc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1B8Spb8Alh7/Q2byitjY99ChwuHg26pKOKwBXcyBnTmquC1gj0iiFMFDFs5S9sSxP
         pUu9DNCaK2hegiub3GDOFAqem87OnG3QvLAMDjYDUmTpBZ2jfOei70r2TI7gldebvr
         I7ziWd2oWy+Tokrxm23kP5tLQ48YxmGkjCsQucNc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Simon Horman <simon.horman@netronome.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 14/62] ARM: dts: Cygnus: Fix MDIO node address/size cells
Date:   Sat, 11 Jan 2020 10:49:56 +0100
Message-Id: <20200111094842.966053502@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094837.425430968@linuxfoundation.org>
References: <20200111094837.425430968@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit fac2c2da3596d77c343988bb0d41a8c533b2e73c ]

The MDIO node on Cygnus had an reversed #address-cells and
 #size-cells properties, correct those.

Fixes: 40c26d3af60a ("ARM: dts: Cygnus: Add the ethernet switch and ethernet PHY")
Reported-by: Simon Horman <simon.horman@netronome.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Simon Horman <simon.horman@netronome.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 8b2c65cd61a2..b822952c29f8 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -165,8 +165,8 @@
 		mdio: mdio@18002000 {
 			compatible = "brcm,iproc-mdio";
 			reg = <0x18002000 0x8>;
-			#size-cells = <1>;
-			#address-cells = <0>;
+			#size-cells = <0>;
+			#address-cells = <1>;
 			status = "disabled";
 
 			gphy0: ethernet-phy@0 {
-- 
2.20.1



