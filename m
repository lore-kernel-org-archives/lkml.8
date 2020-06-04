Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2711C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 932452087D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591289314;
	bh=1tvXkKNxw2IZ812QyeEYAT+Bv1CjvnZY+yuGta1P37s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=WZxzyStPNM0X2V+BmhIOnqmXoiOUQ2AFAY1G7GLLwbWFw6dn8GaFBvkTuFdMroFdg
	 wffN6/7TNZDCNYHinV81/+zCq6xQK5CRwHZxOWUlhPfKTqy+LqzoSj2J/brLXkW1h3
	 ujItagXGA7yIlAIajlZVyit39x/FlIgURTphpMak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729956AbgFDQsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 12:48:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:58528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729860AbgFDQsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 12:48:32 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C4D820738;
        Thu,  4 Jun 2020 16:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591289312;
        bh=1tvXkKNxw2IZ812QyeEYAT+Bv1CjvnZY+yuGta1P37s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zUHDWalXh8BlYCBZXK69+PCY4h+MaDXE97U23oyjhD9FX6R2AmkK4UD4xXgpuel1i
         zZhC2owU17wv9cpNz545bWkwqd0qLB1md6urDAs/3DzpshMAwO9053xWewynWaAIed
         BbNcM2yenFgubVooLYNB9EILAa+k7ZiY20P/DOck=
Date:   Thu, 4 Jun 2020 09:48:29 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     <andrew@lunn.ch>, <f.fainelli@gmail.com>, <hkallweit1@gmail.com>,
        <davem@davemloft.net>, <robh@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH net-next v6 4/4] net: dp83869: Add RGMII internal delay
 configuration
Message-ID: <20200604094829.0d7d5df7@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <63a53dad-4f0a-31ca-ad1a-361b633c28bf@ti.com>
References: <20200604111410.17918-1-dmurphy@ti.com>
        <20200604111410.17918-5-dmurphy@ti.com>
        <20200604092545.40c85fce@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <63a53dad-4f0a-31ca-ad1a-361b633c28bf@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jun 2020 11:38:14 -0500 Dan Murphy wrote:
> Jakub
>=20
> On 6/4/20 11:25 AM, Jakub Kicinski wrote:
> > On Thu, 4 Jun 2020 06:14:10 -0500 Dan Murphy wrote: =20
> >> Add RGMII internal delay configuration for Rx and Tx.
> >>
> >> Signed-off-by: Dan Murphy <dmurphy@ti.com> =20
> > Hi Dan, please make sure W=3D1 C=3D1 build is clean:
> >
> > drivers/net/phy/dp83869.c:103:18: warning: =C3=A2=E2=82=AC=CB=9Cdp83869=
_internal_delay=C3=A2=E2=82=AC=E2=84=A2 defined but not used [-Wunused-cons=
t-variable=3D]
> >    103 | static const int dp83869_internal_delay[] =3D {250, 500, 750, =
1000, 1250, 1500,
> >        |                  ^~~~~~~~~~~~~~~~~~~~~~ =20
>=20
> I built with W=3D1 and C=3D1 and did not see this warning.
>=20
> What defconfig are you using?

allmodconfig with gcc-10

> Can you check if CONFIG_OF_MDIO is set or not?=C2=A0 That would be the on=
ly=20
> way that warning would come up.

Hm. I don't have the config from this particular build but just running
allmodconfig makes it CONFIG_OF_MDIO=3Dm

> > Also net-next is closed right now, you can post RFCs but normal patches
> > should be deferred until after net-next reopens. =20
>=20
> I know net-next is closed.
>=20
> I pinged David M when it was open about what is meant by "new" patches=20
> in the net-dev FAQ.=C2=A0 So I figured I would send the patches to see wh=
at=20
> the response was.
>=20
> To me these are not new they are in process patches.=C2=A0 My understand =
is=20
> New is v1 patchesets.
>=20
> But now I have the answer.

Oh sorry, I may be wrong in this case, I haven't tracked this series.

