Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE874C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 17:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABE6320658
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 17:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tutanota.com header.i=@tutanota.com header.b="dJK0hecX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbgHPRRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 13:17:00 -0400
Received: from w1.tutanota.de ([81.3.6.162]:39246 "EHLO w1.tutanota.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726699AbgHPRQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 13:16:53 -0400
Received: from w3.tutanota.de (unknown [192.168.1.164])
        by w1.tutanota.de (Postfix) with ESMTP id ADF43FA03C7;
        Sun, 16 Aug 2020 17:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1597598210;
        s=s1; d=tutanota.com;
        h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
        bh=fFg+yOI86gXXhmSNLal3y6xWuCA7tvRJk3uvQWOzwvc=;
        b=dJK0hecXw7dRZq4TTfMeFTX4bwq7NRvLeLxmF7gwf09Aj/u1cRxnh72rJMt+M3Gj
        mgFaBZvdiYDhkUUnwovAWRupa1TqReN/9n1kXekRiYaTxtM8IAqED7btDhq9jdpZRu9
        6mImnu0Oo1+8AXu1e0ciKCNwRm7VoOtyxBbtnDjnR0rA1MCysXSlch8jUKocap4Qk+U
        y5fcwU0Z2wKBXmGt8BIZzTtZEON+t2BYkrjy/wdJZMoGOtzVS3wPDjkicDG5xgBofDh
        vYgKopqg5gOBK+c7RjgFXLWxZUnpxhyiFdAxaHyaNJJ0Mm1+aCZtLaZEbPgZrt9i312
        g6wYPDrVeA==
Date:   Sun, 16 Aug 2020 19:16:50 +0200 (CEST)
From:   Cameron Nemo <cnemo@tutanota.com>
To:     Devicetree <devicetree@vger.kernel.org>,
        Linux Arm Kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Rockchip <linux-rockchip@lists.infradead.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     robh+dt@kernel.org, Heiko <heiko@sntech.de>, balbi@kernel.org,
        gregkh@linuxfoundation.org
Message-ID: <MEsGWB_--3-2@tutanota.com>
Subject: [PATCH 1/3] usb: dwc3: of-simple: Add compatible for rk3328
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible to be hooked into by the Rockchip rk3328 device tree.

The rk3399 compatible cannot be reused because the rk3328 SoCs may
require a specialized driver in the future, and old device trees must
remain commpatible with newer kernels.

Signed-off-by: Cameron Nemo <cnemo@tutanota.com>
---
drivers/usb/dwc3/dwc3-of-simple.c | 4 +++-
1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-s=
imple.c
index 7df115012935..54f38e434028 100644
--- a/drivers/usb/dwc3/dwc3-of-simple.c
+++ b/drivers/usb/dwc3/dwc3-of-simple.c
@@ -49,7 +49,8 @@ static int dwc3_of_simple_probe(struct platform_device *p=
dev)
* Some controllers need to toggle the usb3-otg reset before trying to
* initialize the PHY, otherwise the PHY times out.
*/
-=09if (of_device_is_compatible(np, "rockchip,rk3399-dwc3"))
+=09if (of_device_is_compatible(np, "rockchip,rk3399-dwc3") ||
+=09=C2=A0=C2=A0=C2=A0 of_device_is_compatible(np, "rockchip,rk3328-dwc3"))
simple->need_reset =3D true;

simple->resets =3D of_reset_control_array_get(np, false, true,
@@ -171,6 +172,7 @@ static const struct dev_pm_ops dwc3_of_simple_dev_pm_op=
s =3D {
};

static const struct of_device_id of_dwc3_simple_match[] =3D {
+=09{ .compatible =3D "rockchip,rk3328-dwc3" },
{ .compatible =3D "rockchip,rk3399-dwc3" },
{ .compatible =3D "xlnx,zynqmp-dwc3" },
{ .compatible =3D "cavium,octeon-7130-usb-uctl" },
--
2.28.0


