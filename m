Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19036C18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC1E2467D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844950;
	bh=XEXZZ3AeeRBg3Un5BwVmquNRa4spPwv3uB1xz132X1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PInJuHSTi7O0rqae8RLSv25yMnoz/Fy6H0lSMf5axzuV416RpMOQ4a7hVeeJXwB90
	 YUGBbCpdPkZXi7+u3IAIYNhb/Gp8ydDUmYzHVDWkoV6xnKgh+fVAhu9ia/ZZ/3RCg1
	 1hMfHczOgHM2iuFH4yqiT8V0fyygMpigKtRuK2ow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbgCJMzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:55:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728220AbgCJMzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:55:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BCA22253D;
        Tue, 10 Mar 2020 12:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844942;
        bh=XEXZZ3AeeRBg3Un5BwVmquNRa4spPwv3uB1xz132X1Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u0Jjc5XqDaPhUbCZYHDvu1A5KpZ7/5MPaedSluOAP30xHgvXqLQTRnGz0Q79ubVe4
         q2ZofHJzWDmr8cDjT06zTlQ/6LOYznBHurIX8lUs2dn9mo6VFINC1VAozLKf8xEe/b
         PsW6hWm4BBStZaAQ870GNFnl3iiGdNjqzp62TaS0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sanchayan Maity <maitysanchayan@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Subject: [PATCH 5.4 157/168] ARM: dts: imx6dl-colibri-eval-v3: fix sram compatible properties
Date:   Tue, 10 Mar 2020 13:40:03 +0100
Message-Id: <20200310123651.426820011@linuxfoundation.org>
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

From: Johan Hovold <johan@kernel.org>

commit bcbf53a0dab50980867476994f6079c1ec5bb3a3 upstream.

The sram-node compatible properties have mistakingly combined the
model-specific string with the generic "mtd-ram" string.

Note that neither "cy7c1019dv33-10zsxi, mtd-ram" or
"cy7c1019dv33-10zsxi" are used by any in-kernel driver and they are
not present in any binding.

The physmap driver will however bind to platform devices that specify
"mtd-ram".

Fixes: fc48e76489fd ("ARM: dts: imx6: Add support for Toradex Colibri iMX6 module")
Cc: Sanchayan Maity <maitysanchayan@gmail.com>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
@@ -236,7 +236,7 @@
 
 	/* SRAM on Colibri nEXT_CS0 */
 	sram@0,0 {
-		compatible = "cypress,cy7c1019dv33-10zsxi, mtd-ram";
+		compatible = "cypress,cy7c1019dv33-10zsxi", "mtd-ram";
 		reg = <0 0 0x00010000>;
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -247,7 +247,7 @@
 
 	/* SRAM on Colibri nEXT_CS1 */
 	sram@1,0 {
-		compatible = "cypress,cy7c1019dv33-10zsxi, mtd-ram";
+		compatible = "cypress,cy7c1019dv33-10zsxi", "mtd-ram";
 		reg = <1 0 0x00010000>;
 		#address-cells = <1>;
 		#size-cells = <1>;


