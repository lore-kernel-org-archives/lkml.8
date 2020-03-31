Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360ADC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D0C208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585645582;
	bh=WdrpLdSsYq3kQgncJPzNCgTZYn/K/kVhYZKhp/uifWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0SdxR+61OyB2UmOIciHe4x8/m9sUBbxx8dDE3MyLg9vrjlxxmIEV+dKOC5foKhcxB
	 j0YZt1AUFqXPLr+KlAvfL+kUZe0ale3ooTWKFAeiOd9e7DPfPYqhrWvzupffSwWDtV
	 MuO6gbzSEk4+53eVBKoaF9Zk3BHJofYjd7dZiHkg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbgCaJGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:06:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:47602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731116AbgCaJGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:06:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FC2C20787;
        Tue, 31 Mar 2020 09:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585645574;
        bh=WdrpLdSsYq3kQgncJPzNCgTZYn/K/kVhYZKhp/uifWk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LSfou71gnQyjgYZD3l8+3f3yK0SQ0ADD8M82qIH4qs94wyPYm9u9xFIY1Y/yjgG56
         74uMRFOVU2c7BVjLzaDoPSU+d0gO1oa84zf26TaqVDSqY9OOjS0V4NKgH/sOsJIN9/
         RnRzoeGZ2y+/cw2OqwyGqWRziBam5MKyYcIsJ1sM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roger Quadros <rogerq@ti.com>,
        stable@kernel.org, Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5.5 095/170] ARM: dts: dra7: Add bus_dma_limit for L3 bus
Date:   Tue, 31 Mar 2020 10:58:29 +0200
Message-Id: <20200331085434.336896278@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085423.990189598@linuxfoundation.org>
References: <20200331085423.990189598@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roger Quadros <rogerq@ti.com>

commit cfb5d65f25959f724081bae8445a0241db606af6 upstream.

The L3 interconnect's memory map is from 0x0 to
0xffffffff. Out of this, System memory (SDRAM) can be
accessed from 0x80000000 to 0xffffffff (2GB)

DRA7 does support 4GB of SDRAM but upper 2GB can only be
accessed by the MPU subsystem.

Add the dma-ranges property to reflect the physical address limit
of the L3 bus.

Issues ere observed only with SATA on DRA7-EVM with 4GB RAM
and CONFIG_ARM_LPAE enabled. This is because the controller
supports 64-bit DMA and its driver sets the dma_mask to 64-bit
thus resulting in DMA accesses beyond L3 limit of 2G.

Setting the correct bus_dma_limit fixes the issue.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Cc: stable@kernel.org
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/dra7.dtsi |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -148,6 +148,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x0 0xc0000000>;
+		dma-ranges = <0x80000000 0x0 0x80000000 0x80000000>;
 		ti,hwmods = "l3_main_1", "l3_main_2";
 		reg = <0x0 0x44000000 0x0 0x1000000>,
 		      <0x0 0x45000000 0x0 0x1000>;


