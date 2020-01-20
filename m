Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1C5C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 04:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FBB72070C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 04:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=brennan.io header.i=stephen@brennan.io header.b="ABZX5Wmd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbgATEdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 23:33:36 -0500
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21115 "EHLO
        sender4-of-o51.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729043AbgATEdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 23:33:36 -0500
X-Greylist: delayed 904 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Jan 2020 23:33:35 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1579493901;
        s=selector01; d=brennan.io; i=stephen@brennan.io;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=stViw/vZBTTKFHulxgqF7UGf9elupV/iKpDOvA31W08=;
        b=ABZX5WmdD1rtnsD7ma5/aoYcPqlJTkoaH6ppekhzsVYQNDnr9Opn+O+SL61R1iRr
        eZh/7q+1MNG9vDcIIPycmU+XcPTY5DsoN0CIEb4uoctxYw3FyM5z2YzBF1sW3NHQ+c7
        iv0LOkzXPNRYqx5Yx1pr2xTY8KdEpy1JyxkR7zN0=
Received: from localhost (195.173.24.136.in-addr.arpa [136.24.173.195]) by mx.zohomail.com
        with SMTPS id 1579493895817813.4788828872422; Sun, 19 Jan 2020 20:18:15 -0800 (PST)
From:   Stephen Brennan <stephen@brennan.io>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Stephen Brennan <stephen@brennan.io>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <20200120041740.193485-1-stephen@brennan.io>
Subject: [PATCH] ARM: dts: bcm2711: Use bcm2711 compatible for sdhci
Date:   Sun, 19 Jan 2020 20:17:40 -0800
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When booting Raspberry Pi 4B using a micro SDHC UHS class 1 card, the SD
card partitions never appear in /dev.  According to the device tree
bindings for Broadcom IPROC SDHCI controller, we should use
"brcm,bcm2711-emmc2" compatible string on BCM2711. Set this compatible
string, which allows these cards to be mounted.

Signed-off-by: Stephen Brennan <stephen@brennan.io>
---
 arch/arm/boot/dts/bcm2711.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dts=
i
index b64865ad5a41..48e3b0162bda 100644
--- a/arch/arm/boot/dts/bcm2711.dtsi
+++ b/arch/arm/boot/dts/bcm2711.dtsi
@@ -853,6 +853,7 @@ &mailbox {
 };
=20
 &sdhci {
+=09compatible =3D "brcm,bcm2711-emmc2";
 =09interrupts =3D <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
 };
=20
--=20
2.24.0



