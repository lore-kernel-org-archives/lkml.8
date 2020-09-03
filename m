Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3156C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 11:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D643208C7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 11:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="rfr/QNV5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbgICL3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 07:29:13 -0400
Received: from crapouillou.net ([89.234.176.41]:50270 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728085AbgICL0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 07:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1599132362; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=SR+iHQciNK1Dv29p/vdSQ9gduW5dmKiBTrl2NLxMY20=;
        b=rfr/QNV5RzywkcrtwTfLhKPhjdrJfEhu9mfs28GozR5K5U8TlPo9A01AW4BtxUR0RBNi1G
        wp1us28vEA+MBOzKHcKM5g0SmOT77V5i42hS1PHUdaVWF/CjlRncgOuu0whBvXUbmSWVwR
        h6uZjr6MxNY4Y4dlFC9WpuGu+k9PXQk=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Felipe Balbi <balbi@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Tony Prisk <linux@prisktech.co.nz>, Bin Liu <b-liu@ti.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 00/20] usb: Use new pm_ptr() macro
Date:   Thu,  3 Sep 2020 13:25:34 +0200
Message-Id: <20200903112554.34263-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pm_ptr() macro was introduced to avoid conditional compilation of
the PM code. Instead of having the .suspend/.resume functions compiled
conditionally if CONFIG_PM_SLEEP, they are now always visible by the
compiler, which can then detect bugs, and will be discarded if unused.

Cheers,
-Paul

Paul Cercueil (20):
  usb/host: ohci-platform: Use pm_ptr() macro
  usb/host: ehci-spear: Use pm_ptr() macro
  usb/host: ehci-npcm7xx: Use pm_ptr() macro
  usb/host: ehci-platform: Use pm_ptr() macro
  usb/cdns3: core: Use pm_ptr() macro
  usb/chipidea: core: Use pm_ptr() macro
  usb/misc: usb3503: Use pm_ptr() macro
  usb/misc: usb4604: Use pm_ptr() macro
  usb/musb: am35x: Use pm_ptr() macro
  usb/musb: da8xx: Use pm_ptr() macro
  usb/musb: musb_dsps: Use pm_ptr() macro
  usb/musb: ux500: Use pm_ptr() macro
  usb/phy: am335x: Use pm_ptr() macro
  usb/phy: mxs-usb: Use pm_ptr() macro
  usb/gadget/udc: atmel: Use pm_ptr() macro
  usb/gadget/udc: bdc: Use pm_ptr() macro
  usb/gadget/udc: mv-u3d: Use pm_ptr() macro
  usb/gadget/udc: pch: Use pm_ptr() macro
  usb/gadget/udc: renesas: Use pm_ptr() macro
  usb/gadget/udc: snps: Use pm_ptr() macro

 drivers/usb/cdns3/core.c                | 13 ++++---------
 drivers/usb/chipidea/core.c             | 26 +++++++++++--------------
 drivers/usb/gadget/udc/atmel_usba_udc.c |  8 +++-----
 drivers/usb/gadget/udc/bdc/bdc_core.c   |  9 +++------
 drivers/usb/gadget/udc/mv_u3d_core.c    |  8 +++-----
 drivers/usb/gadget/udc/pch_udc.c        | 11 +++--------
 drivers/usb/gadget/udc/renesas_usb3.c   |  8 +++-----
 drivers/usb/gadget/udc/snps_udc_plat.c  | 16 +++++----------
 drivers/usb/host/ehci-npcm7xx.c         |  8 +++-----
 drivers/usb/host/ehci-platform.c        |  8 +++-----
 drivers/usb/host/ehci-spear.c           |  8 +++-----
 drivers/usb/host/ohci-platform.c        | 19 ++++++++----------
 drivers/usb/misc/usb3503.c              | 18 ++++++++---------
 drivers/usb/misc/usb4604.c              |  8 +++-----
 drivers/usb/musb/am35x.c                |  8 +++-----
 drivers/usb/musb/da8xx.c                |  8 +++-----
 drivers/usb/musb/musb_dsps.c            | 20 +++++++------------
 drivers/usb/musb/ux500.c                |  8 +++-----
 drivers/usb/phy/phy-am335x.c            |  8 +++-----
 drivers/usb/phy/phy-mxs-usb.c           | 11 +++++------
 20 files changed, 87 insertions(+), 144 deletions(-)

-- 
2.28.0

