Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964BBC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 05:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75B8E206DA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 05:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="Tbfi4l6E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgHQF7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 01:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgHQF7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 01:59:34 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22F6C061388;
        Sun, 16 Aug 2020 22:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HZyl5q+jnCvX1fyjf0e5q25W96mTDQeUnBuw8XcBjho=; b=Tbfi4l6EOYQY5R4kZrucj5ihlG
        Pa24jwPDsNSiAcgBzp880XtY4ytb+tBXkFJnRNQvQfJxkOr0Nii6011LKqUcs35/fhyQYn+b4XwNL
        CltUqh8GD4Ww7OiU3tQ5DHo8fMtqzAY7U4++7NisYLeFiwnKcSoMObWYX1x25O1Xigkc=;
Received: from p200300ccff0cdf001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0c:df00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1k7YAy-0004Iy-4D; Mon, 17 Aug 2020 07:59:20 +0200
Date:   Mon, 17 Aug 2020 07:59:18 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, marcel.ziswiler@toradex.com,
        sebastien.szymanski@armadeus.com, rjones@gateworks.com,
        leoyang.li@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH RFC 2/2] ARM: dts: imx: add devicetree for Tolino Shine
 2 HD
Message-ID: <20200817075918.4e53e6b8@aktux>
In-Reply-To: <20200816155751.GB103070@latitude>
References: <20200815193336.21598-1-andreas@kemnade.info>
        <20200815193336.21598-3-andreas@kemnade.info>
        <20200816125247.GA103070@latitude>
        <20200816165058.3a17d97a@aktux>
        <20200816155751.GB103070@latitude>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 16 Aug 2020 17:57:51 +0200
Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> wrote:

> On Sun, Aug 16, 2020 at 04:50:58PM +0200, Andreas Kemnade wrote:
> > Hi,
> >=20
> > Seems that we have different hardware, so the first question is
> > first the most interesting thing: how much does the hw actually differ,
> > especially do they require different device trees?
> >=20
> > Can you provide me a photo of your hardware?
> > Or is it a Shine 3? =20
>=20
> It is a Shine 2HD
>=20
> >=20
> > Mine is at https://misc.andi.de1.cc/tolino2.jpg =20
>=20
> Mine:
>=20
> https://raw.githubusercontent.com/wiki/neuschaefer/linux/Tolino-Shine2HD.=
jpg
>=20
>=20
> It appears to be the next PCB revision (+4A3 instead of +4A2), but I
> think the PCB layout looks the same. The Realtek-based Wifi module is
> exactly where the CyberTan WC121 was.
>=20

=46rom other sources I also think these revisions are same besides wifi.

So the only thing warranting separate dtbs might be the OOB IRQ thing.
In the Tolino sources there is the function dhd_customer_oob_irq_map in
the bcmdhd driver, and it gets its number from this:
drivers/net/wireless/bcmdhd/Makefile:	-DCUSTOMER_HW2 -DCUSTOM_OOB_GPIO_NUM=
=3D127 -DOOB_INTR_ONLY -DHW_OOB

The brcmfmac driver is upstream and has devicetree support, but the
rtl8189fs is not. For the Clara I am using this one:
https://github.com/jwrdegoede/rtl8189ES_linux.git (branch 8189fs)
It has no devicetree support, so things cannot be defined anyway.

On one hand the hardware should be described in the devicetree as good
as possible but on the other hand the OOB IRQ is not mandatory.

Regards,
Andreas
