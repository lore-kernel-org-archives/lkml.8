Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBF7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 06:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B366E204EA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 06:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qpJmvPB8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgHEGaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 02:30:19 -0400
Received: from mail-eopbgr00051.outbound.protection.outlook.com ([40.107.0.51]:15427
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725920AbgHEGaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 02:30:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TtXt5GRybgHUmgqOVl8wz3J+UkaRp0hQYMbUkv7WKMFDUfwT935QOi08nO/ccaIX3izlvFpZ+JYgexdIGEMuhamdHL6nKTIhJAR3s+A0aW/P5B+2irx4SdlWw1EnJA5OC2v9eWakOeoCLwyL9uVbio3P532bAFLpvpoT6o6XqQ8m4GFxn7A7qXs4hP0QP9CUPZs8kF8ThzaRn8JZ/2pV7IvzoLIlsBQf/D4oqOcoCZ8XDXCliGXOxpF/KdA3uOo4ftEKOaHLZ+dLhWeCX9sdG0k5SC926UgAYMUxsx7QipZGx9cV9kpDrK00SRBCIJvQ41TRMFdxYoYAMViJeq8KcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRKnfypiumTTYBRIobsy7/9qsDexB9L7sBSz2ri6Nrc=;
 b=RTrMC85Wf+oAvE94XLjZqItjnH0uyFzTEylxbUwNX8nw5pv2IS1J7HnHBqF+Ft8dAktSsoH89pXZh9coJD9pLqqaOZiRdhN7iKExJb4mIiLdQynWYiOGVVJGcV8q0rEivtxIZLDpYcQ2OfCyh7jcZgjfwRCOxROUd6M5ffYhfQlcgBInrO0U4uf8ajCCh1guqehJLwxbUQkJbJp5/wtlXl72KxMRGik3glaBcGQTFw3l3gNEUk1dTOF1U9FkVr7US3sdgAzf0/gtEMzP2dH/8fJumZqDPiHWOy2xwLrRu3e+4o2Qd0/dTY0N9rXXiTaqtfHuE8zv8l9HOygqdYXr2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRKnfypiumTTYBRIobsy7/9qsDexB9L7sBSz2ri6Nrc=;
 b=qpJmvPB8p6dAJQu0JHgccb4J1fdHtqG8RAAkLa54AhiQiJpQsoygXVK27TltKTNc/yPwTDvkEGTldxG0zcD40xfufj/X9SCp7S3jjGYv27OFkbINe0BpJV/M+bKPoFLoQKkRfqTinEJIzbVgzVpYs3ib3dvta0OtYFk2T3mqnwA=
Received: from VI1PR0402MB3824.eurprd04.prod.outlook.com
 (2603:10a6:803:22::18) by VI1PR04MB5680.eurprd04.prod.outlook.com
 (2603:10a6:803:e8::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Wed, 5 Aug
 2020 06:30:14 +0000
Received: from VI1PR0402MB3824.eurprd04.prod.outlook.com
 ([fe80::167:b586:586e:e024]) by VI1PR0402MB3824.eurprd04.prod.outlook.com
 ([fe80::167:b586:586e:e024%5]) with mapi id 15.20.3239.021; Wed, 5 Aug 2020
 06:30:14 +0000
From:   Jason Liu <jason.hui.liu@nxp.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     "will@kernel.org" <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] arm64: kexec: no need to do irq_chip->irq_mask if it
 already masked
Thread-Topic: [PATCH 1/1] arm64: kexec: no need to do irq_chip->irq_mask if it
 already masked
Thread-Index: AQHWaj3ZMAA/XWH8SkmG3qCWNnZEoaknvUCAgAErEuA=
Date:   Wed, 5 Aug 2020 06:30:13 +0000
Message-ID: <VI1PR0402MB3824CCEEB23EF38126BEF50DAE4B0@VI1PR0402MB3824.eurprd04.prod.outlook.com>
References: <20200804085657.10776-1-jason.hui.liu@nxp.com>
 <20200804102025.GA15199@bogus>
In-Reply-To: <20200804102025.GA15199@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0fa1f741-4173-4892-e95e-08d8390902fd
x-ms-traffictypediagnostic: VI1PR04MB5680:
x-microsoft-antispam-prvs: <VI1PR04MB568077DAECBF8B6CDD5C6839AE4B0@VI1PR04MB5680.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3X53HFkVY8wiiTa+jCKj250UT7ATK2az9XGtw67q2mfHDlvUrUhcDhXR6HV6wEMx93opWCKjFq/CVMsGdCS/chwkn82wiWA0QXV7fpfIvNlQ3oAtRdx43KFeLlBLFsM//69NQcZvLPd00zzqUo8ghQ4inq+puemkA99LONlQO3pAyJRJqMSfstUWxl0LuUbZ3WCBUxRqwxaNdJfSbOllBkRNWsN+aNxEA/5qBouLHQo5hKspYzWL/cJ7mbEfgu+HTShMCrZFIllfmpJoxm7076OdRvxp85yPQ5C7i5yuuoBbRyDGHZghbRuMkwas9X/X2UGBxOIznpXmnfhuXcPVpg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3824.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(83380400001)(8676002)(6916009)(4326008)(52536014)(26005)(55016002)(8936002)(9686003)(186003)(316002)(76116006)(478600001)(66446008)(86362001)(2906002)(6506007)(54906003)(53546011)(64756008)(66946007)(5660300002)(71200400001)(7696005)(66476007)(66556008)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: HNsg9aI8JulEEAHJIDxc8LDUb220kfiToqFl5Mdub/1P0lRAMnc6S/u90FvuvcYuVcrLkUaklUZxdqmumouOKihenwBTl9T7g1LmmuVmYEqSSofMnNdjyloa9uvEUMhcmSxSrWkdpnOnaQskTzmrk/pbahcdE/N5bz5iD04H2CkWX/nHZU2ECO5Ga2d0nVM4GWN3J0JKxEA3SnCJ8s/RyuxRaYtNjio69CscWm07SvJL9C80NwP4wIWb0jY/reqB78TF9uVF1bWQomBzTUdx7zc35BNtljjtDEkEX8GIIL/NU9LAw9vdI9P2wmfUzbtIBLsNWaGAboysXH5cNCgmOnUGr8VF2XEnOtqq2+Sx0yMU59BinyTrGgO78TmDNb3BIbYDg60tVX/3SeH4ZeGhdB6uyr3v0f53j9Ihh9rJ+S51WNVvlO0dJNfWPZPmDqQ8Zv91aovT1IaURRnVqhohrg6fgg2b6imiHjKLjeJUOjW71rzwW6wGYpgfGBBrnGYxX7FEOax5Kcnyfy6/D4O4Chh5psUHYYiOeJnjr5i5nGBGDmqCxhD+z2hTzJ88LLFh8WRxgolNy8jkx0nWa52W4noi8zXMkPYi81SBUMhCeS4UWjWog+XYKHDje9ID70GPz8rbcIij+Pj1uGZ3CSiF5w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3824.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa1f741-4173-4892-e95e-08d8390902fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2020 06:30:13.9689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QVyXjAwrLo873bBj7a34JREX0WOpIH2EKkD4ti+pocbJ7Jf+NZte/zNqR79oQzE7PIOFhqPJ7XSzE20+mSifUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5680
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Sudeep Holla <sudeep.holla@arm.com>
> Sent: Tuesday, August 4, 2020 6:20 PM
> To: Jason Liu <jason.hui.liu@nxp.com>
> Cc: will@kernel.org; catalin.marinas@arm.com; ashal@kernel.org;
> maz@kernel.org; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 1/1] arm64: kexec: no need to do irq_chip->irq_mask i=
f it
> already masked
>=20
> +Marc Z
>=20
> On Tue, Aug 04, 2020 at 04:56:57PM +0800, Jason Liu wrote:
> > No need to do the irq_chip->irq_mask() if it already masked.
> > BTW, unconditionally do the irq_chip->irq_mask() will also bring
> > issues when the irq_chip in the runtime PM suspend. Accessing
> > registers of the irq_chip will bring in the exceptions. For example on =
the i.MX:
> >
>=20
> The change looks good and is inline with the additional checks we do for =
eoi
> and disable. However, the imx_irqsteer_irq_mask is not safe to be called =
with
> runtime suspend.=20

Yes, you are right. imx_irqsteer_irq_mask can not be called with irqchip ru=
ntime suspend.
IMO, this might apply to all platforms which implement the irq_chip->mask f=
unction with
directly access the registers.

> What happens if some driver using the irq on this chip calls
> disable_irq when this irqchip is suspended ?

IMO, only free_irq will call the irq_chip_pm_put which will bring the irqch=
ip to suspend if that irq is the last user.
Otherwise, the irqchip is in active state. free_irq will set the IRQ state =
to DISABLED and MASKED.
So, if the irqchip in suspend state, which means all the irqs(associated wi=
th irqchip) were DISABLED and MASKED.
If call the common API disable_irq, that is fine due to the disable_irq wil=
l nop if the irq was DISABLED and masked.=20

>=20
> --
> Regards,
> Sudeep
