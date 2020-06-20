Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB70C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 03:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0C702311D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 03:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592623674;
	bh=0D6JZ8JJv1a/lkBSX1+FdTETTuYln1rEbfJkzQ3aeIc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=f40VSAJrs3W8CKathLsuBHZOH1QmOpyaE1qAEQ9DEXY+MqtFdmAVKxYJc62KJor4f
	 CR7TeUiXi3KPQ4oG2Ti022HcbHDY0mch6X9Kp9j1mZ1dLEOslai+Oj3wyJjubhqKOM
	 bNaf//NnHIhJ5Wn41rSBWUOarjOdu7Yhe5Fvst/E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732701AbgFTD1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 23:27:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:56722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732633AbgFTD1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 23:27:51 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFD4D2311C;
        Sat, 20 Jun 2020 03:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592623671;
        bh=0D6JZ8JJv1a/lkBSX1+FdTETTuYln1rEbfJkzQ3aeIc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=dRnvzJHI96sK/XqX8w3zM4LBGiCx16DduRQbOw7gST6lLGy+8pwDiXq81ZFdTFwAo
         gwGbbDy2ZZtEwRWQnSCgwnNygk5XL8JmnnvXheu4j8JpO+ikEmYz21tW+GPGF7aUGp
         dG7xlWdsPgc0r13aifchT1eNWBpaJgTYcATK7xm8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <AM6PR04MB4966B94CFAE642E6AF5AEF79809B0@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1591687933-19495-1-git-send-email-Anson.Huang@nxp.com> <1591687933-19495-4-git-send-email-Anson.Huang@nxp.com> <AM6PR04MB49660A10856A3746C7103394809A0@AM6PR04MB4966.eurprd04.prod.outlook.com> <DB3PR0402MB39163BC04E4E5F4F6A22F6D4F59A0@DB3PR0402MB3916.eurprd04.prod.outlook.com> <AM6PR04MB4966B94CFAE642E6AF5AEF79809B0@AM6PR04MB4966.eurprd04.prod.outlook.com>
Subject: RE: [PATCH V2 3/9] clk: imx: Support building SCU clock driver as module
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Stefan Agner <stefan.agner@toradex.com>, allison@lohutok.net,
        arnd@arndb.de, festevam@gmail.com, gregkh@linuxfoundation.org,
        info@metux.net, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        mturquette@baylibre.com, oleksandr.suvorov@toradex.com,
        s.hauer@pengutronix.de, sfr@canb.auug.org.au, shawnguo@kernel.org,
        tglx@linutronix.de, yuehaibing@huawei.com
Date:   Fri, 19 Jun 2020 20:27:50 -0700
Message-ID: <159262367025.62212.11651547971712516448@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Aisheng Dong (2020-06-17 18:58:51)
> > From: Anson Huang <anson.huang@nxp.com>
> > > > +obj-$(CONFIG_MXC_CLK_SCU) +=3D mxc-clk-scu.o
> > >
> > > Like i.MX pinctrl, I'm not sure if it's really necessary to build core
> > > libraries as modules. Probably the simplest way is only building
> > > platform drivers part as module. And leave those core libraries built=
 in kernel.
> > > This may make the code a bit cleaner.
> > >
> >=20
> > Will discuss this with Linaro guys about it, previous requirement I rec=
eived is all
> > SoC specific modules need to be built as module.
> >=20
>=20
> Okay. AFAIK it's not conflict.
> You still make drivers into modules.
> Only difference is for those common libraries part, we don't convert them=
 into module
> Which is less meaningless.
> =20

What is the benefit of making the core part of the SoC driver not a
module? From the module perspective it should be perfectly fine to make
it a module as well, and then depmod will sort out loading modules in
the right order.

This is for android right?
