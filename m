Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36576C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 21:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1FC4206CC
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 21:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="bfeuIZ4f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388485AbgBNVDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 16:03:43 -0500
Received: from mail-mw2nam12on2042.outbound.protection.outlook.com ([40.107.244.42]:29917
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726191AbgBNVDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 16:03:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCOSAPQko51iltOa/qN8L4ZRPLKFHp9eoTloRlzS59wrj52Yh8SS8S+RLjuy4GoTfvJqMQjy13GJAB8fYvJ4rrqw4Dka9vz0Y5FuH7LcE49nTFmN2adBBYrARj40SpXOniomNHFtn99RddnUxYWyzkVLHkPg7Mz9K1GEmcdvzXLt7HAVWpCaVZMWFgNDfBQ2dajKwf1ai97+PMq9udKi6A1nOw2nhOh4BmwagFGI4Iq5U++fVXmNOkJ/lvFHavR/0/D784gy70JE8pSmM3BH3TTz7HJrvfT1yiCGiBv7z9Fxggo+1p4wu7KQUnjX79y9jf45wGsq9jSB/DoB3P1A5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPpaYwKn7cX/eJihFmdyxkPBy7m3DCIEJS8XbwF4a/0=;
 b=LbhomZX68/WSdk8tu4RnVAKSHMPRJ/X7hAebPWdymDbxhK4v8VJ/RJ4qvX8u0uR1DzbBn/Z0shVHLo/7zfI+Yk+DBYl9fgoqh53fEx6V/CJmAx0zFV2Q7wn+uwLVLM+TsbEcP1375LygKipDeX2+JuEiukQcrSmUCq3bvwhz0opoGujiF8RUot/IWn+lwP61eq6ubaAy6cwnK20bg6SdFVpm3f5Fxd3qCB7sStm40gWjUHU1XVTmUC3KuhVS0PjznECwThnyTwSlTZ8OO/FdcIFj+K1PL4qVSEOnV0ZmXLEB/ZJxFoJGPWD4ebaNEgN0isKd5GkHjBPsPIknp+pkuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPpaYwKn7cX/eJihFmdyxkPBy7m3DCIEJS8XbwF4a/0=;
 b=bfeuIZ4fiIwonI/i9aNw0NYRgtca3xCSMtAsQop3BLh187k66zlKUCH5cFEE62R+/5fjb4JYXb3jbwwcSkhih2P1HrqOc2xldJcMllS36duXu8UgiZHHxLRTIhTTIVLBzKU8HeNntBTT1EoExGnci+nsl7XFLunh48r9B4UqkZs=
Received: from DM6PR02MB5819.namprd02.prod.outlook.com (20.179.55.89) by
 DM6PR02MB5435.namprd02.prod.outlook.com (20.177.222.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Fri, 14 Feb 2020 21:02:04 +0000
Received: from DM6PR02MB5819.namprd02.prod.outlook.com
 ([fe80::88bf:6a72:fe27:4870]) by DM6PR02MB5819.namprd02.prod.outlook.com
 ([fe80::88bf:6a72:fe27:4870%7]) with mapi id 15.20.2729.027; Fri, 14 Feb 2020
 21:02:04 +0000
From:   Mubin Usman Sayyed <MUBINUSM@xilinx.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "maz@kernel.org" <maz@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Siva Durga Prasad Paladugu <sivadur@xilinx.com>,
        Anirudha Sarangi <anirudh@xilinx.com>
Subject: RE: [PATCH v3] irqchip: xilinx: Add support for multiple instances
Thread-Topic: [PATCH v3] irqchip: xilinx: Add support for multiple instances
Thread-Index: AQHV4Q33kSWlIlx6yEiVh3YqKC599KgZCICAgAIYBBA=
Date:   Fri, 14 Feb 2020 21:02:03 +0000
Message-ID: <DM6PR02MB58196595A0738896146A09EDA1150@DM6PR02MB5819.namprd02.prod.outlook.com>
References: <20200211190303.7991-1-mubin.usman.sayyed@xilinx.com>
 <871rqy3dda.fsf@nanos.tec.linutronix.de>
In-Reply-To: <871rqy3dda.fsf@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MUBINUSM@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fec4f603-ffa9-41e7-ff9e-08d7b19124b1
x-ms-traffictypediagnostic: DM6PR02MB5435:|DM6PR02MB5435:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR02MB54354E0F2BF5ECF97940D667A1150@DM6PR02MB5435.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 03137AC81E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(199004)(189003)(110136005)(8676002)(66446008)(76116006)(316002)(107886003)(66946007)(4326008)(64756008)(66476007)(66556008)(186003)(8936002)(54906003)(81156014)(5660300002)(81166006)(478600001)(26005)(52536014)(53546011)(71200400001)(6506007)(2906002)(9686003)(33656002)(55016002)(7696005)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5435;H:DM6PR02MB5819.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UaVYinhMCU2kKhXjD1pz7VABaJELm1YbteeMG/FepnuX/UVz67FkUKUQ9+vcGO97vVHLwdojC/BA/feqz8cwwK/3eQEjwXplGi0B1f9U3zweDUGCKbNe+0Cy8gMMVLItoN+yAyWES8e9e0TBsq8saZ+UP/y/QEOWX/b55Hf8O2oPgQ0+r01Fh6/WX/Sd4gFOydRIWLSx/mSpAMyEly2OHSEToR1DOGbguVGPF3nwdQ3dzsEKUoTzIhJASI1Jpul5MFJaR6aCsfl58BSpcki8rjYXb0Fk2ARc2rdSIO6zlqgsU4/X9Dzmu+h9skHYpDXhVsFvrTG6UhktZF4TwzHAtGdFnGzRz8pfBuys/EoDUsh6iuoZonSBo/7swzX/r9BOZ8WjN6sY24+AXdFBsFkIuJUoNYRqVwuvH+LJ0trPBB0aILBvocyKwxxXdWvkGsBP
x-ms-exchange-antispam-messagedata: +Kk98/62gPGcaUVX0VOeaj3NY1cSZ0I9AnQv7giPwqb423MQhpAuAAQD+ptVJGk54Fg/weBgmU+W3QGtXk7UeTFBtm+qj0Me0XzaoZ69NAQCv980GFskxpyrANfcAcSCECXYTon6tTfupBGoXTuh2Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fec4f603-ffa9-41e7-ff9e-08d7b19124b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2020 21:02:03.8115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YvK/zb+S0dR1lTkrDGYOkpnlRMeC6cl1wbYBIGvf2ey2WvHEL2MQnFweYDqGpkWPIz7jKXL5QQPowwROg8dJew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5435
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Thanks for the review. Please see my inline replies.

> -----Original Message-----
> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Thursday, February 13, 2020 5:31 PM
> To: Mubin Usman Sayyed <MUBINUSM@xilinx.com>;
> jason@lakedaemon.net; maz@kernel.org; Michal Simek
> <michals@xilinx.com>; linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org; Siva Durga Prasad Paladugu
> <sivadur@xilinx.com>; Anirudha Sarangi <anirudh@xilinx.com>; Mubin
> Usman Sayyed <MUBINUSM@xilinx.com>
> Subject: Re: [PATCH v3] irqchip: xilinx: Add support for multiple instanc=
es
>=20
> Mubin,
>=20
> Mubin Usman Sayyed <mubin.usman.sayyed@xilinx.com> writes:
>=20
> > From: Mubin Sayyed <mubin.usman.sayyed@xilinx.com>
> >
> > This patch adds support for multiple instances of
>=20
> git grep 'This patch' Documentation/process/submitting-patches.rst
[Mubin]: I will re-phrase it in next version.
>=20
> > xilinx interrupt controller. Below configurations are supported by
> > driver,
> >
> > - peripheral->xilinx-intc->xilinx-intc->gic
> > - peripheral->xilinx-intc->xilinx-intc
>=20
> This is really not much of an explanation.
[Mubin]: Will elaborate in next version
>=20
> > Signed-off-by: Anirudha Sarangi <anirudha.sarangi@xilinx.com>
> > Signed-off-by: Mubin Sayyed <mubin.usman.sayyed@xilinx.com>
>=20
> This Signed-off-by chain is incorrect. See chapter 11 and 12 in the same
> document.
[Mubin]:  Sure, I will check and fix it. I ran checkpatch, it didn't report=
ed errors/warning related to that.=20
>=20
> > @@ -38,29 +38,32 @@ struct xintc_irq_chip {
> >  	void		__iomem *base;
> >  	struct		irq_domain *root_domain;
> >  	u32		intr_mask;
> > +	struct		irq_chip *intc_dev;
> > +	u32		nr_irq;
> >  };
> >
> > -static struct xintc_irq_chip *xintc_irqc;
> > +static struct xintc_irq_chip *primary_intc;
> >
> > -static void xintc_write(int reg, u32 data)
> > +static void xintc_write(struct xintc_irq_chip *irqc, int reg, u32
> > +data)
> >  {
> >  	if (static_branch_unlikely(&xintc_is_be))
> > -		iowrite32be(data, xintc_irqc->base + reg);
> > +		iowrite32be(data, irqc->base + reg);
> >  	else
> > -		iowrite32(data, xintc_irqc->base + reg);
> > +		iowrite32(data, irqc->base + reg);
> >  }
> >
> > -static unsigned int xintc_read(int reg)
> > +static u32 xintc_read(struct xintc_irq_chip *irqc, int reg)
> >  {
> >  	if (static_branch_unlikely(&xintc_is_be))
> > -		return ioread32be(xintc_irqc->base + reg);
> > +		return ioread32be(irqc->base + reg);
> >  	else
> > -		return ioread32(xintc_irqc->base + reg);
> > +		return ioread32(irqc->base + reg);
> >  }
> >
> >  static void intc_enable_or_unmask(struct irq_data *d)  {
> > -	unsigned long mask =3D 1 << d->hwirq;
> > +	unsigned long mask =3D BIT(d->hwirq);
> > +	struct xintc_irq_chip *irqc =3D irq_data_get_irq_chip_data(d);
>=20
> Please order your local variables in reverse fir tree order:
>=20
> 	struct xintc_irq_chip *irqc =3D irq_data_get_irq_chip_data(d);
>         unsigned long mask =3D BIT(d->hwirq);
>=20
> which is the preferred coding style in this subsystem and way simpler to
> read.
[Mubin]: I will fix  all such  instances in next version
>=20
> >  static void intc_mask_ack(struct irq_data *d)  {
> > -	unsigned long mask =3D 1 << d->hwirq;
> > +	unsigned long mask =3D BIT(d->hwirq);
> > +	struct xintc_irq_chip *irqc =3D irq_data_get_irq_chip_data(d);
>=20
> Ditto.
>=20
> >  	pr_debug("irq-xilinx: disable_and_ack: %ld\n", d->hwirq);
> > -	xintc_write(CIE, mask);
> > -	xintc_write(IAR, mask);
> > +	xintc_write(irqc, CIE, mask);
> > +	xintc_write(irqc, IAR, mask);
> >  }
> > +static unsigned int xintc_get_irq_local(struct xintc_irq_chip *irqc)
> > +{
> > +	u32 hwirq;
> > +	unsigned int irq =3D 0;
>=20
> Same.
>=20
> > +	hwirq =3D xintc_read(irqc, IVR);
> > +	if (hwirq !=3D -1U)
> > +		irq =3D irq_find_mapping(irqc->root_domain, hwirq);
> > +
> > +	pr_debug("irq-xilinx: hwirq=3D%d, irq=3D%d\n", hwirq, irq);
>=20
> Are these pr_debugs all over the please really required? I can understand
> that you use them for development, but are they useful once the stuff
> works?
[Mubin]  They might be useful to debug interrupt issues. Do you want me to =
remove them?
>=20
> > +	return irq;
> > +}
> > +
> >  unsigned int xintc_get_irq(void)
> >  {
> > -	unsigned int hwirq, irq =3D -1;
> > +	u32 hwirq;
> > +	unsigned int irq =3D -1;
>=20
> See above.
>=20
> > -	hwirq =3D xintc_read(IVR);
> > +	hwirq =3D xintc_read(primary_intc, IVR);
> >  	if (hwirq !=3D -1U)
> > -		irq =3D irq_find_mapping(xintc_irqc->root_domain, hwirq);
> > +		irq =3D irq_find_mapping(primary_intc->root_domain, hwirq);
> >
> >  	pr_debug("irq-xilinx: hwirq=3D%d, irq=3D%d\n", hwirq, irq);
> >
> > @@ -138,12 +164,14 @@ static const struct irq_domain_ops
> > xintc_irq_domain_ops =3D {  static void xil_intc_irq_handler(struct
> > irq_desc *desc)  {
> >  	struct irq_chip *chip =3D irq_desc_get_chip(desc);
> > +	struct xintc_irq_chip *irqc =3D
> > +		irq_data_get_irq_handler_data(&desc->irq_data);
>=20
> Please avoid these ugly line breaks and put the initialization of the var=
iable in
> to the code below the declaration.
[Mubin]: Will do in next version
>=20
> >  	/* Turn on the Master Enable. */
> > -	xintc_write(MER, MER_HIE | MER_ME);
> > -	if (!(xintc_read(MER) & (MER_HIE | MER_ME))) {
> > +	xintc_write(irqc, MER, MER_HIE | MER_ME);
> > +	if (!(xintc_read(irqc, MER) & (MER_HIE | MER_ME))) {
> >  		static_branch_enable(&xintc_is_be);
>=20
> I see it's existing logic, but this lacks a comment how it's determined t=
hat
> xintc is big endian. Looks like some weird "write works?"
> probing. Why?
>=20
> > +	xintc_write(irqc, MER, MER_HIE | MER_ME);
>=20
> So this writes MER_HIE | MER_ME into MER
>=20
> > +	if (!(xintc_read(irqc, MER) & (MER_HIE | MER_ME))) {
>=20
> but this checks just whether ONE of the bits is set. Shouldn't it check f=
or MER
> =3D=3D (MER_HIE | MER_ME), i.e. read back what was written?

[Mubin]:  Agreed, will fix it in v4.

Thanks,
Mubin
>=20
> Thanks,
>=20
>         tglx
