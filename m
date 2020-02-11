Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E18EC35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 19:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07EA021569
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 19:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Z0bpjKLl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731009AbgBKTiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 14:38:55 -0500
Received: from mail-bn8nam12on2088.outbound.protection.outlook.com ([40.107.237.88]:37729
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728382AbgBKTiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 14:38:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n11m9Ic/CZphsVmah6K2+VcZKq1Bfz9RxXcB2XQfm0h65ZBs4V1pzUb9sBT89o73jcOnjDDGzGO2GV8PKhLYw6LMEKz0g+MUPo0aLwWHLU5cE5UzAFz5tjZJb/9HZu7h3t7a95qB60zi6fs4zIdBpaL+HuEfXXuGkdhlfB24MiH9Dr2gYLMcpmikze079aPLYtnfvm0pMjdbJXrbYDd1ZdOC/AKlRAo+d1KtesJxmA2FYE0YLYSto+riznePUKlL1UOtHIFUfNgpTQzVFdTxVuXc7k/cMA9df+tPwAwaSlg2mLOyHXBHZpBdRVYhaOfKhTh2HcZdv4KRt9WuX66UzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a51F1xe3HzJfGk4cPQBOc8NBZbgDD2TOwwDI5AUG1GQ=;
 b=OqS/NFKrGKqY9FD8TRIpiRlgXWmOME+GLo4ChTjmsbX1zc8EA961Hsad/cuzd1Zh4RqQA7regckwIpAUoMD3axqItZR9bkpEt+BP2YA4cxswyKLOsKFd4gOjaW020+rqKhbeNlbucx48LTOb9anWWng+2HBV9yqZljrozTcrABopJWUL2Lqa7UJXsBl+gDEGvv7hsP/BU2jb7WUGIU7ttgzAAEhhuOkDXQAvaJ2nNCUotHom7tXqQhTA+aH5PnILMHFSG/mL95b78sL+Gl4lSNdWTQxYF9McGLYWTlMrwLQgAi2cw0Ahtkjp3DPa7m+LBIagWeox88/aH7U+JxxX5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a51F1xe3HzJfGk4cPQBOc8NBZbgDD2TOwwDI5AUG1GQ=;
 b=Z0bpjKLlwYK3DG4gajzhsJSW4yH5fTA2Ru4bMNsjFUycNOtlWB/H6qnHhW9xcrluNWI8T7O6uYDK80Rg2piQs5dp5pXGwSpUynAUHFE9GI5NosbQgUGPLf4JFYNjsjDRABdGQvhGqJkRIltZwpGB1EppyIllc6HZ736DtvbsyTs=
Received: from MN2PR02MB5727.namprd02.prod.outlook.com (20.179.85.153) by
 MN2PR02MB6269.namprd02.prod.outlook.com (52.132.175.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Tue, 11 Feb 2020 19:38:46 +0000
Received: from MN2PR02MB5727.namprd02.prod.outlook.com
 ([fe80::e09d:a160:5349:8ed0]) by MN2PR02MB5727.namprd02.prod.outlook.com
 ([fe80::e09d:a160:5349:8ed0%6]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 19:38:46 +0000
From:   Mubin Usman Sayyed <MUBINUSM@xilinx.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        Michal Simek <michals@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Siva Durga Prasad Paladugu <sivadur@xilinx.com>,
        Anirudha Sarangi <anirudh@xilinx.com>
Subject: RE: [PATCH v2] irqchip: xilinx: Add support for multiple instances
Thread-Topic: [PATCH v2] irqchip: xilinx: Add support for multiple instances
Thread-Index: AQHV3C2hje5zExnZvkGSFN2foWGvfagM0R4AgAmTOPA=
Date:   Tue, 11 Feb 2020 19:38:46 +0000
Message-ID: <MN2PR02MB5727EA6929F9F06B60C297C4A1180@MN2PR02MB5727.namprd02.prod.outlook.com>
References: <1580911535-19415-1-git-send-email-mubin.usman.sayyed@xilinx.com>
 <b8e7b9120bc6cd306bda3347cde117ff@kernel.org>
In-Reply-To: <b8e7b9120bc6cd306bda3347cde117ff@kernel.org>
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
x-ms-office365-filtering-correlation-id: 7310531f-4907-4fbb-ecae-08d7af2a029e
x-ms-traffictypediagnostic: MN2PR02MB6269:|MN2PR02MB6269:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR02MB6269A77E453F98E95A5D2EB6A1180@MN2PR02MB6269.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:107;
x-forefront-prvs: 0310C78181
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(189003)(199004)(33656002)(86362001)(4326008)(186003)(26005)(71200400001)(66476007)(66446008)(64756008)(9686003)(55016002)(66556008)(5660300002)(107886003)(2906002)(66946007)(52536014)(76116006)(7696005)(8936002)(81156014)(81166006)(6916009)(316002)(6506007)(54906003)(53546011)(30864003)(8676002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR02MB6269;H:MN2PR02MB5727.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XQxYGtPdc8Ngv3tbNg6uFGYFxSNham3JMon2pSr5TbFzJdEoUBSR6gLb0o7pfcp2RJ7/8ZDnnl/9+GaDEVz2CpX91m0q3ADJ70QF6YejHGnGw5AjuUBwS2R8pxJ0v9nSg8WEz3Q83vF67mKoY7qPZaWbAX/MDZJ9/fqJzG94vysd4dEBgbS2WKKrNafrf6WP6irxNQVhk9dL6TyAC5B7hX7xZLUPnhS4e14UloJP30/t3E4zP7X03CVLc51czoCV9p3ZH5iWbqwu0Fpa+DXo/N1lKAEWV2G7LrgRKv8J5uCrNfKLacZSBFVsjMy2RkmfW8idodgChSfN5n+Tv54cRMxxQrobHlTlmmaPycb5hbiF+DYukQh5PbLJTiMiRtd/12ZVcT8+mei7WkLA9pNvzZQ+OYVHfulGG1qUCBKzzBsj0m0NKY4DvjO92Cu9vkZ0
x-ms-exchange-antispam-messagedata: ivQeKm53ZTnDs/7i9XSZC9PJZYy8D7kU3nn6n7aCi0Gaf4T9FrpngPueeov3MN2XEI0eWY1iNVTLnTvBT1gzTl5uv/SmHBCFWDRdYTIHtj3YJTFL6apWavb9qD8ACCUO3B+r3cTwo0EDHNEiSdRBYQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7310531f-4907-4fbb-ecae-08d7af2a029e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2020 19:38:46.1672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nDd05pbR0fpsxwNlJ8310yVCSbWVVgi0dCWiKS1ks2JxrYurbXTL6LcIABEbHRAQZXYeyqDUGHDOWyQRDotnMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6269
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

> -----Original Message-----
> From: Marc Zyngier <maz@kernel.org>
> Sent: Wednesday, February 5, 2020 10:23 PM
> To: Mubin Usman Sayyed <MUBINUSM@xilinx.com>
> Cc: tglx@linutronix.de; jason@lakedaemon.net; Michal Simek
> <michals@xilinx.com>; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; Siva Durga Prasad Paladugu <sivadur@xilinx.com>;
> Anirudha Sarangi <anirudh@xilinx.com>
> Subject: Re: [PATCH v2] irqchip: xilinx: Add support for multiple instanc=
es
>=20
> On 2020-02-05 14:05, Mubin Usman Sayyed wrote:
> > From: Mubin Sayyed <mubin.usman.sayyed@xilinx.com>
> >
> > This patch adds support for multiple instances of xilinx interrupt
> > controller. Below configurations are supported by driver,
> >
> > - peripheral->xilinx-intc->xilinx-intc->gic
> > - peripheral->xilinx-intc->xilinx-intc
> >
> > Signed-off-by: Anirudha Sarangi <anirudha.sarangi@xilinx.com>
> > Signed-off-by: Mubin Sayyed <mubin.usman.sayyed@xilinx.com>
> > ---
> > Changes for v2:
> >         - Removed write_fn/read_fn hooks, used xintc_write/
> >           xintc_read directly
> >         - Moved primary_intc declaration after xintc_irq_chip
> > ---
> >  drivers/irqchip/irq-xilinx-intc.c | 121
> > +++++++++++++++++++++++---------------
> >  1 file changed, 73 insertions(+), 48 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-xilinx-intc.c
> > b/drivers/irqchip/irq-xilinx-intc.c
> > index e3043de..14cb630 100644
> > --- a/drivers/irqchip/irq-xilinx-intc.c
> > +++ b/drivers/irqchip/irq-xilinx-intc.c
> > @@ -38,29 +38,32 @@ struct xintc_irq_chip {
> >         void            __iomem *base;
> >         struct          irq_domain *root_domain;
> >         u32             intr_mask;
> > +       struct                  irq_chip *intc_dev;
> > +       u32                             nr_irq;
> >  };
> >
> > -static struct xintc_irq_chip *xintc_irqc;
> > +static struct xintc_irq_chip *primary_intc;
> >
> > -static void xintc_write(int reg, u32 data)
> > +static void xintc_write(void __iomem *addr, u32 data)
> >  {
> >         if (static_branch_unlikely(&xintc_is_be))
> > -               iowrite32be(data, xintc_irqc->base + reg);
> > +               iowrite32be(data, addr);
> >         else
> > -               iowrite32(data, xintc_irqc->base + reg);
> > +               iowrite32(data, addr);
> >  }
> >
> > -static unsigned int xintc_read(int reg)
> > +static unsigned int xintc_read(void __iomem *addr)
>=20
> Since you are changing this, please change the return value to reflect th=
e size
> of what you're returning (u32 instead of unsigned int).
[Mubin]: Changed in v3
>=20
> >  {
> >         if (static_branch_unlikely(&xintc_is_be))
> > -               return ioread32be(xintc_irqc->base + reg);
> > +               return ioread32be(addr);
> >         else
> > -               return ioread32(xintc_irqc->base + reg);
> > +               return ioread32(addr);
> >  }
> >
> >  static void intc_enable_or_unmask(struct irq_data *d)  {
> >         unsigned long mask =3D 1 << d->hwirq;
> > +       struct xintc_irq_chip *local_intc =3D
> > irq_data_get_irq_chip_data(d);
> >
> >         pr_debug("irq-xilinx: enable_or_unmask: %ld\n", d->hwirq);
> >
> > @@ -69,47 +72,57 @@ static void intc_enable_or_unmask(struct irq_data
> > *d)
> >          * acks the irq before calling the interrupt handler
> >          */
> >         if (irqd_is_level_type(d))
> > -               xintc_write(IAR, mask);
> > +               xintc_write(local_intc->base + IAR, mask);
> >
> > -       xintc_write(SIE, mask);
> > +       xintc_write(local_intc->base + SIE, mask);
> >  }
> >
> >  static void intc_disable_or_mask(struct irq_data *d)  {
> > +       struct xintc_irq_chip *local_intc =3D
> > irq_data_get_irq_chip_data(d);
> > +
> >         pr_debug("irq-xilinx: disable: %ld\n", d->hwirq);
> > -       xintc_write(CIE, 1 << d->hwirq);
> > +       xintc_write(local_intc->base + CIE, 1 << d->hwirq);
> >  }
> >
> >  static void intc_ack(struct irq_data *d)  {
> > +       struct xintc_irq_chip *local_intc =3D
> > irq_data_get_irq_chip_data(d);
> > +
> >         pr_debug("irq-xilinx: ack: %ld\n", d->hwirq);
> > -       xintc_write(IAR, 1 << d->hwirq);
> > +       xintc_write(local_intc->base + IAR, 1 << d->hwirq);
> >  }
> >
> >  static void intc_mask_ack(struct irq_data *d)  {
> >         unsigned long mask =3D 1 << d->hwirq;
> > +       struct xintc_irq_chip *local_intc =3D
> > irq_data_get_irq_chip_data(d);
> >
> >         pr_debug("irq-xilinx: disable_and_ack: %ld\n", d->hwirq);
> > -       xintc_write(CIE, mask);
> > -       xintc_write(IAR, mask);
> > +       xintc_write(local_intc->base + CIE, mask);
> > +       xintc_write(local_intc->base + IAR, mask);
> >  }
> >
> > -static struct irq_chip intc_dev =3D {
> > -       .name =3D "Xilinx INTC",
> > -       .irq_unmask =3D intc_enable_or_unmask,
> > -       .irq_mask =3D intc_disable_or_mask,
> > -       .irq_ack =3D intc_ack,
> > -       .irq_mask_ack =3D intc_mask_ack,
> > -};
> > +static unsigned int xintc_get_irq_local(struct xintc_irq_chip
> > *local_intc)
> > +{
> > +       int hwirq, irq =3D -1;
>=20
> Type consistency for hwirq.
[Mubin]: Fixed in v3
>=20
> > +
> > +       hwirq =3D xintc_read(local_intc->base + IVR);
> > +       if (hwirq !=3D -1U)
> > +               irq =3D irq_find_mapping(local_intc->root_domain,
> > + hwirq);
> > +
> > +       pr_debug("irq-xilinx: hwirq=3D%d, irq=3D%d\n", hwirq, irq);
> > +
> > +       return irq;
>=20
> That now gives you both -1 and 0 for error values. Please stick with 0.
[Mubin]: Fixed in v3
>=20
> > +}
> >
> >  unsigned int xintc_get_irq(void)
> >  {
> > -       unsigned int hwirq, irq =3D -1;
> > +       int hwirq, irq =3D -1;
> >
> > -       hwirq =3D xintc_read(IVR);
> > +       hwirq =3D xintc_read(primary_intc->base + IVR);
> >         if (hwirq !=3D -1U)
> > -               irq =3D irq_find_mapping(xintc_irqc->root_domain, hwirq=
);
> > +               irq =3D irq_find_mapping(primary_intc->root_domain,
> > hwirq);
> >
> >         pr_debug("irq-xilinx: hwirq=3D%d, irq=3D%d\n", hwirq, irq);
>=20
> I have the ugly feeling I'm reading the same code twice... Surely you can
> make these two functions common code.
[Mubin]:  Upcoming patchset from Michal would be removing xintc_get_irq,  i=
nstead of that  "handle_domain_irq()"  would be used independently.  I hope=
 that is fine.
=20
> >
> > @@ -118,15 +131,18 @@ unsigned int xintc_get_irq(void)
> >
> >  static int xintc_map(struct irq_domain *d, unsigned int irq,
> > irq_hw_number_t hw)  {
> > -       if (xintc_irqc->intr_mask & (1 << hw)) {
> > -               irq_set_chip_and_handler_name(irq, &intc_dev,
> > +       struct xintc_irq_chip *local_intc =3D d->host_data;
> > +
> > +       if (local_intc->intr_mask & (1 << hw)) {
>=20
> BIT(hw)
[Mubin]: Fixed in v3
>=20
> > +               irq_set_chip_and_handler_name(irq,
> > local_intc->intc_dev,
> >                                                 handle_edge_irq,
> > "edge");
> >                 irq_clear_status_flags(irq, IRQ_LEVEL);
> >         } else {
> > -               irq_set_chip_and_handler_name(irq, &intc_dev,
> > +               irq_set_chip_and_handler_name(irq,
> > local_intc->intc_dev,
> >                                                 handle_level_irq,
> > "level");
> >                 irq_set_status_flags(irq, IRQ_LEVEL);
> >         }
> > +       irq_set_chip_data(irq, local_intc);
> >         return 0;
> >  }
> >
> > @@ -138,11 +154,13 @@ static const struct irq_domain_ops
> > xintc_irq_domain_ops =3D {  static void xil_intc_irq_handler(struct
> > irq_desc *desc)  {
> >         struct irq_chip *chip =3D irq_desc_get_chip(desc);
> > +       struct xintc_irq_chip *local_intc =3D
> > +               irq_data_get_irq_handler_data(&desc->irq_data);
> >         u32 pending;
> >
> >         chained_irq_enter(chip, desc);
> >         do {
> > -               pending =3D xintc_get_irq();
> > +               pending =3D xintc_get_irq_local(local_intc);
> >                 if (pending =3D=3D -1U)
> >                         break;
> >                 generic_handle_irq(pending); @@ -153,28 +171,20 @@
> > static void xil_intc_irq_handler(struct irq_desc
> > *desc)
> >  static int __init xilinx_intc_of_init(struct device_node *intc,
> >                                              struct device_node
> > *parent)
> >  {
> > -       u32 nr_irq;
> >         int ret, irq;
> >         struct xintc_irq_chip *irqc;
> > -
> > -       if (xintc_irqc) {
> > -               pr_err("irq-xilinx: Multiple instances aren't
> > supported\n");
> > -               return -EINVAL;
> > -       }
> > +       struct irq_chip *intc_dev;
> >
> >         irqc =3D kzalloc(sizeof(*irqc), GFP_KERNEL);
> >         if (!irqc)
> >                 return -ENOMEM;
> > -
> > -       xintc_irqc =3D irqc;
> > -
> >         irqc->base =3D of_iomap(intc, 0);
> >         BUG_ON(!irqc->base);
> >
> > -       ret =3D of_property_read_u32(intc, "xlnx,num-intr-inputs",
> > &nr_irq);
> > +       ret =3D of_property_read_u32(intc, "xlnx,num-intr-inputs",
> > &irqc->nr_irq);
> >         if (ret < 0) {
> >                 pr_err("irq-xilinx: unable to read
> > xlnx,num-intr-inputs\n");
> > -               goto err_alloc;
> > +               goto error;
> >         }
> >
> >         ret =3D of_property_read_u32(intc, "xlnx,kind-of-intr",
> > &irqc->intr_mask); @@ -183,30 +193,42 @@ static int __init
> > xilinx_intc_of_init(struct device_node *intc,
> >                 irqc->intr_mask =3D 0;
> >         }
> >
> > -       if (irqc->intr_mask >> nr_irq)
> > +       if (irqc->intr_mask >> irqc->nr_irq)
> >                 pr_warn("irq-xilinx: mismatch in kind-of-intr
> > param\n");
> >
> >         pr_info("irq-xilinx: %pOF: num_irq=3D%d, edge=3D0x%x\n",
> > -               intc, nr_irq, irqc->intr_mask);
> > +               intc, irqc->nr_irq, irqc->intr_mask);
> > +
> > +       intc_dev =3D kzalloc(sizeof(*intc_dev), GFP_KERNEL);
> > +       if (!intc_dev) {
> > +               ret =3D -ENOMEM;
> > +               goto error;
> > +       }
> >
> > +       intc_dev->name =3D intc->full_name;
>=20
> No. The world doesn't need to see the OF path of your interrupt controlle=
r in
> /proc/cpuinfo.
> The name that was there before was perfectly descriptive, please stick to=
 it.
[Mubin]: Reverted in v3
>=20
> > +       intc_dev->irq_unmask =3D intc_enable_or_unmask,
> > +       intc_dev->irq_mask =3D intc_disable_or_mask,
> > +       intc_dev->irq_ack =3D intc_ack,
> > +       intc_dev->irq_mask_ack =3D intc_mask_ack,
>=20
> And this structure should stay static, as it was before.
[Mubin]: Reverted in v3
>=20
> > +       irqc->intc_dev =3D intc_dev;
> >
> >         /*
> >          * Disable all external interrupts until they are
> >          * explicity requested.
> >          */
> > -       xintc_write(IER, 0);
> > +       xintc_write(irqc->base + IER, 0);
> >
> >         /* Acknowledge any pending interrupts just in case. */
> > -       xintc_write(IAR, 0xffffffff);
> > +       xintc_write(irqc->base + IAR, 0xffffffff);
> >
> >         /* Turn on the Master Enable. */
> > -       xintc_write(MER, MER_HIE | MER_ME);
> > -       if (!(xintc_read(MER) & (MER_HIE | MER_ME))) {
> > +       xintc_write(irqc->base + MER, MER_HIE | MER_ME);
> > +       if (!(xintc_read(irqc->base + MER) & (MER_HIE | MER_ME))) {
> >                 static_branch_enable(&xintc_is_be);
> > -               xintc_write(MER, MER_HIE | MER_ME);
> > +               xintc_write(irqc->base + MER, MER_HIE | MER_ME);
> >         }
> >
> > -       irqc->root_domain =3D irq_domain_add_linear(intc, nr_irq,
> > +       irqc->root_domain =3D irq_domain_add_linear(intc, irqc->nr_irq,
> >
> > &xintc_irq_domain_ops, irqc);
> >         if (!irqc->root_domain) {
> >                 pr_err("irq-xilinx: Unable to create IRQ domain\n");
> > @@ -225,13 +247,16 @@ static int __init xilinx_intc_of_init(struct
> > device_node *intc,
> >                         goto err_alloc;
> >                 }
> >         } else {
> > -               irq_set_default_host(irqc->root_domain);
> > +               primary_intc =3D irqc;
> > +               irq_set_default_host(primary_intc->root_domain);
> >         }
> >
> >         return 0;
> >
> >  err_alloc:
> > -       xintc_irqc =3D NULL;
> > +       kfree(intc_dev);
> > +error:
> > +       iounmap(irqc->base);
> >         kfree(irqc);
> >         return ret;
> >
> > --
> > 2.7.4
> >
> > This email and any attachments are intended for the sole use of the
> > named recipient(s) and contain(s) confidential information that may be
> > proprietary, privileged or copyrighted under applicable law. If you
> > are not the intended recipient, do not read, copy, or forward this
> > email message or any attachments. Delete this email message and any
> > attachments immediately.
>=20
> Please tell your employer to fix their email server.
[Mubin]: Fixed in v3

Thanks,
Mubin
>=20
> Thanks,
>=20
>          M.
> --
> Jazz is not dead. It just smells funny...
