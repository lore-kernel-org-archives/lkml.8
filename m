Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748F1C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 016D42063A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759895;
	bh=tlBCLzB8KqqSYZkd4B/QOZWltHSyIudbX/rrs3U1giY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kIyfxPRBMo+jaYGmmCwNf9fJCaqDVHB6k5trTlcQqpnvtSPvAq3l/K7kL9Hu/ob9r
	 F83uOG2LmwPPIikc/PMb81TGz8S8xDQM+qPdnSsbByEVXp4MW782V81wZz99mUqMIY
	 MyPEf32mmMbxvJdfHGWSV8m7UPl53216Zautp4xU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388997AbgDAQhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:37:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:36604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388814AbgDAQh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:37:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B128720772;
        Wed,  1 Apr 2020 16:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585759046;
        bh=tlBCLzB8KqqSYZkd4B/QOZWltHSyIudbX/rrs3U1giY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W/pY+1frTSSsIoPbZd+mM47PJdidAJ1T0jfgxMnZ+dVALHQYO60hBcE+iFLNn/zVe
         d94uFtVfNSGSEk8Ne+QVXuinuVjql20mWA16W1bMEGYHx9zt2MLXm+jgOQamXjdp8w
         zYZUvchho1qfHSzGo+9r2BLdWli5X7TZuxoHJccw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, stable@kernel.org,
        Roger Quadros <rogerq@ti.com>, Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4.9 059/102] ARM: dts: omap5: Add bus_dma_limit for L3 bus
Date:   Wed,  1 Apr 2020 18:18:02 +0200
Message-Id: <20200401161543.236331056@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161530.451355388@linuxfoundation.org>
References: <20200401161530.451355388@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roger Quadros <rogerq@ti.com>

commit dfa7ea303f56a3a8b1ed3b91ef35af2da67ca4ee upstream.

The L3 interconnect's memory map is from 0x0 to
0xffffffff. Out of this, System memory (SDRAM) can be
accessed from 0x80000000 to 0xffffffff (2GB)

OMAP5 does support 4GB of SDRAM but upper 2GB can only be
accessed by the MPU subsystem.

Add the dma-ranges property to reflect the physical address limit
of the L3 bus.

Cc: stable@kernel.org
Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/omap5.dtsi |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -131,6 +131,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0 0 0 0xc0000000>;
+		dma-ranges = <0x80000000 0x0 0x80000000 0x80000000>;
 		ti,hwmods = "l3_main_1", "l3_main_2", "l3_main_3";
 		reg = <0 0x44000000 0 0x2000>,
 		      <0 0x44800000 0 0x3000>,


