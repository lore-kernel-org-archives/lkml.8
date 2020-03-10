Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB5FC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 202B22253D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844851;
	bh=BOycNQ3hu9z5TKmz+nFLfEl5WjjEGkeMuxukdNWX07A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OKrSJGmN9I3InPlSNzD66vQ7AC+ThLlczjSoZt2P7OFO7g3EIB7Ap9XQb9hayF245
	 +Hw9RyBsA/g4ENn8/YNUwNInJv6M0Cfj3EI/IiXrBXI+S9o1Zy4c1GrU97u/tL/Faw
	 30p+P4vbWD3Fhx4k+CzQDJ+5s/s6aVx1f3BEpuyQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbgCJMyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:54:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:60542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728894AbgCJMyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:54:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F8522253D;
        Tue, 10 Mar 2020 12:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844847;
        bh=BOycNQ3hu9z5TKmz+nFLfEl5WjjEGkeMuxukdNWX07A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xTAiownthVje3YrDFgnNdbh30iu01ZPqcUGydmCNy2RWkbDC4x8K4oRa+cd7mwNHC
         c3fxjlEWRTVwgKEYjsEB2ZHOowZQjjI30bFtUK5cu0Jc3VqvNxUZ+XYqoSod2mA0ki
         R0Aj5HkQTi/2BB5dHGmZaJNp9L7QXOYXRj54kGA4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marco Felsch <m.felsch@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 5.4 139/168] ARM: dts: imx6: phycore-som: fix emmc supply
Date:   Tue, 10 Mar 2020 13:39:45 +0100
Message-Id: <20200310123649.563525286@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123635.322799692@linuxfoundation.org>
References: <20200310123635.322799692@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Felsch <m.felsch@pengutronix.de>

commit eb0bbba7636b9fc81939d6087a5fe575e150c95a upstream.

Currently the vmmc is supplied by the 1.8V pmic rail but this is wrong.
The default module behaviour is to power VCCQ and VCC by the 3.3V power
rail. Optional the user can connect the VCCQ to the pmic 1.8V emmc
power rail using a solder jumper.

Fixes: ddec5d1c0047 ("ARM: dts: imx6: Add initial support for phyCORE-i.MX 6 SOM")
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi
@@ -183,7 +183,6 @@
 	pinctrl-0 = <&pinctrl_usdhc4>;
 	bus-width = <8>;
 	non-removable;
-	vmmc-supply = <&vdd_emmc_1p8>;
 	status = "disabled";
 };
 


