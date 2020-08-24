Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EB7C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AB2520706
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="F3+eLfYL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgHXVUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 17:20:30 -0400
Received: from mail-dm6nam12on2043.outbound.protection.outlook.com ([40.107.243.43]:37345
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727860AbgHXVUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 17:20:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hud9FWpjzjdCNStGP0e3RZgyfnrRukBnywSN8NhelItlBreeouzpPTsJL4z8iH+FHqnk33pw6KScyzEA5e3zqkqnrOyo0zxclyBIBETZ25S5uqbXQlxCx4njL7Z7uEMkKjmWKNc1h9wd4YqZL5uizSU9snD6IUSmy4FhQOSFk2rK8MoXp7sIbeN8tcM22gcsUBpC2D5f3JtbJ7MvUPjSja4lf49acCFTPPJPlo8a6sHaBljIVcwlYN9r+SAa2gURrJP2wocv3jvbM1V++NGmA+XupjYee1f/ggY9+VMD/e1nBh1wrdNCBkoldab9JqLVaVglP0o5xiYdI5PrHbDtwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVQYN5p7nCtSgq22tj8UXify46f8jQxhjRc2Jp6Tl7k=;
 b=mYFiA8wzerE1huEYexUziTkZgUwEVlCC0SgU/FTls0GBuLx0kWqiaET95Fi0eYaiK9pExgx7BmF5c98fPmZw/51gkgCxyhOYAsPajBcOxFCcq3XdjaC5+TuN+dExbWuUsRtUyL3meT3bC0rKbP3EN0lM4MIlVtlnEUDoDBbOzlzek49EbgwPp0oR+GxP3gyXUmCx55qIQa64AQID6O3T66Xu8UYW70b5IqOKYsxX7n5dlHIH5EsxAttKC+R9D6toH+bg8u/mQecY4Xb2K99NRJXieXHGtQxvcPe6AjdQ11UwNTqqs1GwNkkgVDApLGVDOnI5UZl5u96d69ukk+GOGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVQYN5p7nCtSgq22tj8UXify46f8jQxhjRc2Jp6Tl7k=;
 b=F3+eLfYLFlp+BQgMt4IfNhn2Y2TbVQ/P5yi+rM4pdv8EfF+UDMICmej42yqSBdYPmMNAV6W/oyiEwVlqKt8nXVrUb+YXoMOmwb2SsrVeLOnEcjMoZlWUiwD07xvbH9xrnA3Zs3onO2ohp7wq6VyJhOAoZiw6gYd5nBXopoBkI/I=
Received: from BYAPR02MB4407.namprd02.prod.outlook.com (2603:10b6:a03:55::31)
 by BYAPR02MB5031.namprd02.prod.outlook.com (2603:10b6:a03:6f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Mon, 24 Aug
 2020 21:19:56 +0000
Received: from BYAPR02MB4407.namprd02.prod.outlook.com
 ([fe80::b0f6:b3a:6543:26f5]) by BYAPR02MB4407.namprd02.prod.outlook.com
 ([fe80::b0f6:b3a:6543:26f5%5]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 21:19:56 +0000
From:   Ben Levinsky <BLEVINSK@xilinx.com>
To:     Stefano Stabellini <stefanos@xilinx.com>
CC:     Michal Simek <michals@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "Ed T. Mooring" <emooring@xilinx.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Jiaying Liang <jliang@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v8 5/5] remoteproc: Add initial zynqmp R5 remoteproc
 driver
Thread-Topic: [PATCH v8 5/5] remoteproc: Add initial zynqmp R5 remoteproc
 driver
Thread-Index: AQHWb5ATV4ChTkO3Pki1oN57qb9mj6k2g4WAgAd0r9CAAgX1AIABKS1ggAaw5KA=
Date:   Mon, 24 Aug 2020 21:19:56 +0000
Message-ID: <BYAPR02MB44077F3D3EE6C9FC11D654BFB5560@BYAPR02MB4407.namprd02.prod.outlook.com>
References: <20200811033213.20088-1-ben.levinsky@xilinx.com>
 <20200811033213.20088-6-ben.levinsky@xilinx.com>
 <alpine.DEB.2.21.2008131116060.15669@sstabellini-ThinkPad-T480s>
 <BYAPR02MB4407487EEA04C681FF99867CB55C0@BYAPR02MB4407.namprd02.prod.outlook.com>
 <alpine.DEB.2.21.2008191340140.15985@sstabellini-ThinkPad-T480s>
 <BYAPR02MB44072DB321E24C3FAC2A11E1B55A0@BYAPR02MB4407.namprd02.prod.outlook.com>
In-Reply-To: <BYAPR02MB44072DB321E24C3FAC2A11E1B55A0@BYAPR02MB4407.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [24.5.142.107]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d8920b3c-50ed-49fe-1ee3-08d84873732a
x-ms-traffictypediagnostic: BYAPR02MB5031:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB5031CF06D11BF48F16326347B5560@BYAPR02MB5031.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:628;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l2ExRivZ5F2semlAxMve6yXdhV/Q/6zHLEycOYj481ZtwQevQYZ0R1XGxdr048nfVoZOLJ6veXJCJoYwL/voOczLnZlIcOgI3M3PzeeZ2aCfpzvUxwy+b4anUFDw20lW8joA2pyVAsACIFFa/dZ96DLpPzcwgc9EzLJeuJUK7JYfZbO7NJ+aYOaYPlY58TNIe6G/6XWnPJivTbSVRM49CO9OEvkb8kgnqmpwRrBhi7pSyD74/UJWAc1g7pYMTFxZ+rX7XNTSAKG4GvsYw/VpVm2antTfXpy8FbJSvaxdpVVEx5wXRIktSi6jFRyXLrZFHKomlcTj/NAqLSqiFMjcuw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB4407.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(346002)(136003)(39860400002)(376002)(83380400001)(33656002)(30864003)(55016002)(86362001)(71200400001)(9686003)(6636002)(478600001)(6506007)(7696005)(26005)(52536014)(5660300002)(2906002)(316002)(54906003)(186003)(53546011)(66946007)(4326008)(66446008)(64756008)(66556008)(66476007)(76116006)(8676002)(6862004)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: OMLFnUYUkMw8o5PM8AkkgLfmSyMMNRS+6lttWON4cLPMA5C5TghuIpDfKj/NPHl3N3uEdIq4p3VOzT/gMkiKfRA6SPdWfq+1jsIGUAanM6Dk63dplsMDe9QJ032esIzxS1cNRqVMWMxFvFeFfk4vokubTwzjbGE85uVQimz/IXkt8BhjcuPS0WKBzpg5XslCKM7rH8hu9/MP2idKnZyYnIYqnAUugRwLIaLHvXGDItBElo80yElyQcgKVsuJv1iMyH4qwliltZybjuWnxg6Bsico2Ey8vkut6vlc6anjne/3co0Dz6iq4me8DdBeh/ACFPI0Vfp0qIcaThJuGEUdnsNij4TWfAfHCHq5qqsA75wNslfIlwYIVvl2kSVnFtvrK3TRBxcR7Yj8idUatKvVK4Vl67VOMbF2ZNEOOs6UWE4IMklN6mumQ3v/i1Qv7zXIE6BTXybjXOlLj2PDnK091MOojXLaY21FvLLW7jDMgpEOP0VpCaUQOfscxPsxmZGCQdUNz6Ah5McAT0hKhpy44bWvKkrwcRRgjzzgq6VHs2qxyuOkqQt6XMWV7sgr1PROoTmd29cE7F8EtcLFxod3ldkHBE92DOSu2dT5Lwr5e5c4H3+IxSmIcZxVC3vL63379q3v+rrR83nYgI711kjM3A==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4407.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8920b3c-50ed-49fe-1ee3-08d84873732a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2020 21:19:56.2255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YtZ7vU7dy7/9LGcjWBE3mn2+WmN9PvBs2qb9+H6k4glRiR5fjSfgUMfUAe+uQqaFeiZPQ2ZO+PUaabFMwWG+Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5031
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefano=20

This is just response to few unanswered comments

Thanks
Ben

> -----Original Message-----
> From: linux-remoteproc-owner@vger.kernel.org <linux-remoteproc-
> owner@vger.kernel.org> On Behalf Of Ben Levinsky
> Sent: Thursday, August 20, 2020 8:13 AM
> To: Stefano Stabellini <stefanos@xilinx.com>
> Cc: Michal Simek <michals@xilinx.com>; devicetree@vger.kernel.org;
> mathieu.poirier@linaro.org; Ed T. Mooring <emooring@xilinx.com>; linux-
> remoteproc@vger.kernel.org; linux-kernel@vger.kernel.org;
> robh+dt@kernel.org; Jiaying Liang <jliang@xilinx.com>; linux-arm-
> kernel@lists.infradead.org
> Subject: RE: [PATCH v8 5/5] remoteproc: Add initial zynqmp R5 remoteproc
> driver
>=20
>=20
> > -----Original Message-----
> > From: Stefano Stabellini <stefano.stabellini@xilinx.com>
> > Sent: Wednesday, August 19, 2020 2:21 PM
> > To: Ben Levinsky <BLEVINSK@xilinx.com>
> > Cc: Stefano Stabellini <stefanos@xilinx.com>; Michal Simek
> > <michals@xilinx.com>; devicetree@vger.kernel.org;
> > mathieu.poirier@linaro.org; Ed T. Mooring <emooring@xilinx.com>; linux-
> > remoteproc@vger.kernel.org; linux-kernel@vger.kernel.org;
> > robh+dt@kernel.org; Jiaying Liang <jliang@xilinx.com>; linux-arm-
> > kernel@lists.infradead.org
> > Subject: RE: [PATCH v8 5/5] remoteproc: Add initial zynqmp R5 remotepro=
c
> > driver
> >
> > On Tue, 18 Aug 2020, Ben Levinsky wrote:
> > > > > +/**
> > > > > + * struct zynqmp_r5_mem - zynqmp rpu memory data
> > > > > + * @pnode_id: TCM power domain ids
> > > > > + * @res: memory resource
> > > > > + * @node: list node
> > > > > + */
> > > > > +struct zynqmp_r5_mem {
> > > > > +	u32 pnode_id[MAX_MEM_PNODES];
> > > > > +	struct resource res;
> > > > > +	struct list_head node;
> > > > > +};
> > > > > +
> > > > > +/**
> > > > > + * struct zynqmp_r5_pdata - zynqmp rpu remote processor private
> data
> > > > > + * @dev: device of RPU instance
> > > > > + * @rproc: rproc handle
> > > > > + * @pnode_id: RPU CPU power domain id
> > > > > + * @mems: memory resources
> > > > > + * @is_r5_mode_set: indicate if r5 operation mode is set
> > > > > + * @tx_mc: tx mailbox client
> > > > > + * @rx_mc: rx mailbox client
> > > > > + * @tx_chan: tx mailbox channel
> > > > > + * @rx_chan: rx mailbox channel
> > > > > + * @mbox_work: mbox_work for the RPU remoteproc
> > > > > + * @tx_mc_skbs: socket buffers for tx mailbox client
> > > > > + * @rx_mc_buf: rx mailbox client buffer to save the rx message
> > > > > + */
> > > > > +struct zynqmp_r5_pdata {
> > > > > +	struct device dev;
> > > > > +	struct rproc *rproc;
> > > > > +	u32 pnode_id;
> > > > > +	struct list_head mems;
> > > > > +	bool is_r5_mode_set;
> > > > > +	struct mbox_client tx_mc;
> > > > > +	struct mbox_client rx_mc;
> > > > > +	struct mbox_chan *tx_chan;
> > > > > +	struct mbox_chan *rx_chan;
> > > > > +	struct work_struct mbox_work;
> > > > > +	struct sk_buff_head tx_mc_skbs;
> > > > > +	unsigned char rx_mc_buf[RX_MBOX_CLIENT_BUF_MAX];
> > > >
> > > > A simple small reordering of the struct fields would lead to small
> > > > memory savings due to alignment.
> > > >
> > > >
> > > [Ben Levinsky] will do. Do you mean ordering in either ascending or
> > descending order?
> >
> > Each field has a different alignment in the struct, so for example afte=
r
> > pnode_id there are probably 4 unused bytes because mems is 64bit
> > aligned.
> >
> >
> [Ben Levinsky] ok will update this so the alignments are done with less
> unused memory per struct allocation.
> > > > > +/*
> > > > > + * TCM needs mapping to R5 relative address and xilinx platform
> mgmt
> > call
> > > > > + */
> > > > > +struct rproc_mem_entry *handle_tcm_parsing(struct device *dev,
> > > > > +					    struct reserved_mem
> *rmem,
> > > > > +					    struct device_node *node,
> > > > > +					    int lookup_idx)
> > > > > +{
> > > > > +	void *va;
> > > > > +	dma_addr_t dma;
> > > > > +	resource_size_t size;
> > > > > +	int ret;
> > > > > +	u32 pnode_id;
> > > > > +	struct resource rsc;
> > > > > +	struct rproc_mem_entry *mem;
> > > > > +
> > > > > +	pnode_id =3D  tcm_addr_to_pnode[lookup_idx][1];
> > > > > +	ret =3D zynqmp_pm_request_node(pnode_id,
> > > > > +				     ZYNQMP_PM_CAPABILITY_ACCESS,
> 0,
> > > > > +
> ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> > > > > +	if (ret < 0) {
> > > > > +		dev_err(dev, "failed to request power node: %u\n",
> > > > pnode_id);
> > > > > +		return -EINVAL;
> > > > > +	}
> > > > > +
> > > > > +	ret =3D of_address_to_resource(node, 0, &rsc);
> > > > > +	if (ret < 0) {
> > > > > +		dev_err(dev, "failed to get resource of memory %s",
> > > > > +			of_node_full_name(node));
> > > > > +		return -EINVAL;
> > > > > +	}
> > > > > +	size =3D resource_size(&rsc);
> > > > > +	va =3D devm_ioremap_wc(dev, rsc.start, size);
> > > > > +	if (!va)
> > > > > +		return -ENOMEM;
> > > > > +
> > > > > +	/* zero out tcm base address */
> > > > > +	if (rsc.start & 0xffe00000) {
> > > > > +		/* R5 can't see anything past 0xfffff so wipe it */
> > > > > +		rsc.start &=3D 0x000fffff;
> > > >
> > > > If that is the case why not do:
> > > >
> > > >   rsc.start &=3D 0x000fffff;
> > > >
> > > > unconditionally? if (rsc.start & 0xffe00000) is superfluous.
> > > >
> > > > But I thought that actually the R5s could see TCM at both the low
> > > > address (< 0x000fffff) and also at the high address (i.e. 0xffe0000=
0).
> > > >
> > > >
> > > [Ben Levinsky] Here yes can make rsc.start &=3D 0x000fffff undconditi=
onal.
> Will
> > update in v9 as such
> > > 		Also, this logic is because this is only for the Xilinx R5
> > mappings of TCM banks that are at (from the TCM point of view) 0x0 and
> > 0x2000
> >
> > What I meant is that as far as I understand from the TRM the RPU should
> > also be able to access the same banks at the same address of the APU,
> > which I imagine is in the 0xffe00000 range. But I could be wrong on
> > this.
> >
> > If we could use the same addresses for RPU and APU, it would simplify
> > this driver.
> >
> >
[Ben Levinsky] right for R5 it is slightly different as it is 32bit so the =
device address values need to be adjusted
> > > > > +		/*
> > > > > +		 * handle tcm banks 1 a and b (0xffe9000 and
> > > > > +		 * 0xffeb0000)
> > > > > +		 */
> > > > > +		if (rsc.start & 0x80000)
> > > > > +			rsc.start -=3D 0x90000;
> > > >
> > > > It is very unclear to me why we have to do this
> > > >
> > > >
> > > [Ben Levinsky] This is for TCM bank 0B and bank 1B to map them to
> > 0x00020000 so that the TCM relative addressing lines up. For example
> > (0xffe90000 & 0x000fffff) - 0x90000 =3D 0x20000
> >
> > Could you please explain the mapping in an in-code comment?
> > The comment currently mentions 0xffe9000 and 0xffeb0000 but:
> >
> > - 0xffe9000 & 0x000fffff =3D 0xe9000
> >   0xe9000 - 0x90000 =3D 0x59000
> >
> > - 0xffeb0000 & 0x000fffff =3D 0xeb000
> >   0xeb000 - 0x90000 =3D 0xeb000
> >
> > Either way we don't get 0x20000. What am I missing?
> >
> [Ben Levinsky] I apologize there is typo in the comment... it should be
> 0xffe90000 and 0xffeb0000
> The output is:
> 0xffe90000 & 0x000fffff =3D 0x90000
> 0x90000 - 0x90000 =3D 0x0
>=20
> And
> 0xffeb0000 & 0x000fffff =3D 0xB0000
> 0xB0000 - 0x90000 =3D 0x20000
>=20
> So these line up for the relative addressing for RPU's view of TCMs
> >
> >
> > > > > +	}
> > > > > +
> > > > > +	dma =3D (dma_addr_t)rsc.start;
> > > >
> > > > Given the way the dma parameter is used by
> > > > rproc_alloc_registered_carveouts, I think it might be best to pass =
the
> > > > original start address (i.e. 0xffe00000) as dma.
> > > >
> > > >
> > > > > +	mem =3D rproc_mem_entry_init(dev, va, dma, (int)size, rsc.start=
,
> > > > > +				   NULL, zynqmp_r5_mem_release,
> > > >
> > > > I don't know too much about the remoteproc APIs, but shouldn't you =
be
> > > > passing zynqmp_r5_rproc_mem_alloc to it instead of NULL?
> > > >
> > > >
> > > [Ben Levinsky] the difference is that for TCM we have to do make the
> > relative address work for TCM, so the dma input to rproc_mem_entry_init=
 is
> > different in TCM case.
> >
> > The dma address is the address as seen by the RPU, is that right?
> > So you are trying to set the dma address to something in the range 0 -
> > 0x20000?
> >
> >
> [Ben Levinsky] yes
> > > > > +				   rsc.name);
> > > > > +	if (!mem)
> > > > > +		return -ENOMEM;
> > > > > +
> > > > > +	return mem;
> > > > > +}
> > > > > +
> > > > > +static int parse_mem_regions(struct rproc *rproc)
> > > > > +{
> > > > > +	int num_mems, i;
> > > > > +	struct zynqmp_r5_pdata *pdata =3D rproc->priv;
> > > > > +	struct device *dev =3D  &pdata->dev;
> > > > > +	struct device_node *np =3D dev->of_node;
> > > > > +	struct rproc_mem_entry *mem;
> > > > > +
> > > > > +	num_mems =3D of_count_phandle_with_args(np, "memory-
> region",
> > > > NULL);
> > > > > +	if (num_mems <=3D 0)
> > > > > +		return 0;
> > > > > +	for (i =3D 0; i < num_mems; i++) {
> > > > > +		struct device_node *node;
> > > > > +		struct reserved_mem *rmem;
> > > > > +
> > > > > +		node =3D of_parse_phandle(np, "memory-region", i);
> > > >
> > > > Check node !=3D NULL ?
> > > >
> > > [Ben Levinsky] will add this in v9
> > > >
> > > > > +		rmem =3D of_reserved_mem_lookup(node);
> > > > > +		if (!rmem) {
> > > > > +			dev_err(dev, "unable to acquire memory-
> region\n");
> > > > > +			return -EINVAL;
> > > > > +		}
> > > > > +
> > > > > +		if (strstr(node->name, "vdev0buffer")) {
> > > >
> > > > vdev0buffer is not described in the device tree bindings, is that
> > > > normal/expected?
> > > >
> > > >
> > > [Ben Levinsky] vdev0buffer is not required, as there might be simple
> > firmware loading with no IPC. Vdev0buffer only needed for IPC.
> >
> > OK, good. It should probably still be described in the device tree
> > binding as optional property.
> >
> >
> > > > > +			/* Register DMA region */
> > > > > +			mem =3D rproc_mem_entry_init(dev, NULL,
> > > > > +						   (dma_addr_t)rmem-
> >base,
> > > > > +						   rmem->size, rmem-
> >base,
> > > > > +						   NULL, NULL,
> > > > > +						   "vdev0buffer");
> > > > > +			if (!mem) {
> > > > > +				dev_err(dev, "unable to initialize
> memory-
> > > > region %s\n",
> > > > > +					node->name);
> > > > > +				return -ENOMEM;
> > > > > +			}
> > > > > +			dev_dbg(dev, "parsed %s at  %llx\r\n", mem-
> >name,
> > > > > +				mem->dma);
> > > > > +		} else if (strstr(node->name, "vdev0vring")) {
> > > >
> > > > Same here
> > > >
> > > >
> > > > > +			int vring_id;
> > > > > +			char name[16];
> > > > > +
> > > > > +			/*
> > > > > +			 * can be 1 of multiple vring IDs per IPC
> channel
> > > > > +			 * e.g. 'vdev0vring0' and 'vdev0vring1'
> > > > > +			 */
> > > > > +			vring_id =3D node->name[14] - '0';
> > > >
> > > > Where does the "14" comes from? Are we sure it is not possible to h=
ave
> a
> > > > node->name smaller than 14 chars?
> > > >
> > > [Ben Levinsky] Presently there are only 2 vrings used per Xilinx Open=
AMP
> > channel to RPU. In Xilinx kernel we have hard-coded names as these are =
the
> > only nodes that use it. For example RPU0vdev0vring0 and RPU1vdev0vring0=
.
> > Hence we only check for vdev0vring and not a sscanf("%*s%i") to parse o=
ut
> > the vring ID or other, cleaner solution.
> >
> > OK, but I think it is best if we use node->name[14] only if we
> > explicitly check for a string of at least 14 characters. Using strstr,
> > it could return the string "vdev0vring" which is less than 14 chars,
> > leading to a bug.
> >
> >
> > > >
> > > > > +			snprintf(name, sizeof(name), "vdev0vring%d",
> > > > vring_id);
> > > > > +			/* Register vring */
> > > > > +			mem =3D rproc_mem_entry_init(dev, NULL,
> > > > > +						   (dma_addr_t)rmem-
> >base,
> > > > > +						   rmem->size, rmem-
> >base,
> > > > > +
> > > > zynqmp_r5_rproc_mem_alloc,
> > > > > +
> > > > zynqmp_r5_rproc_mem_release,
> > > > > +						   name);
> > > > > +			dev_dbg(dev, "parsed %s at %llx\r\n", mem-
> >name,
> > > > > +				mem->dma);
> > > > > +		} else {
> > > > > +			int idx;
> > > > > +
> > > > > +			/*
> > > > > +			 * if TCM update address space for R5 and
> > > > > +			 * make xilinx platform mgmt call
> > > > > +			 */
> > > > > +			for (idx =3D 0; idx <
> ZYNQMP_R5_NUM_TCM_BANKS;
> > > > idx++) {
> > > > > +				if (tcm_addr_to_pnode[idx][0] =3D=3D
> rmem-
> > > > >base)
> > > > > +					break;
> > > >
> > > > There is something I don't quite understand. If the memory region t=
o
> use
> > > > is TCM, why would it be also described under reserved-memory?
> > > > Reserved-memory is for normal memory being reserved, while TCM is
> not
> > > > normal memory. Am I missing something?
> > > >
> > > [Ben Levinsky] I can change this in v9 as discussed. That is, have no=
 TCM
> > under reserved mem. Instead have the banks as nodes in device tree with
> > status=3D"[enabled|disabled]" and if enabled, then try to add memories =
in
> > parse_fw call.
> > > >
> > > > > +			}
> > > > > +
> > > > > +			if (idx !=3D ZYNQMP_R5_NUM_TCM_BANKS) {
> > > > > +				mem =3D handle_tcm_parsing(dev,
> rmem, node,
> > > > idx);
> > > > > +			} else {
> > > > > +				mem =3D rproc_mem_entry_init(dev,
> NULL,
> > > > > +						   (dma_addr_t)rmem-
> >base,
> > > > > +						   rmem->size, rmem-
> >base,
> > > > > +
> > > > zynqmp_r5_rproc_mem_alloc,
> > > > > +
> > > > zynqmp_r5_rproc_mem_release,
> > > > > +						   node->name);
> > > >
> > > > This case looks identical to the vdev0vring above. Is the differenc=
e
> > > > really just in the "name"? If so, can we merge the two cases into o=
ne?
> > > > no, because the devm_ioremap_wc call has to be done before changing
> > the dma address to relative for TCM banks.
> > > >
[Ben Levinsky] ok will clean up to merge where able
> > > > > +			}
> > > > > +
> > > > > +			if (!mem) {
> > > > > +				dev_err(dev,
> > > > > +					"unable to init memory-
> region %s\n",
> > > > > +					node->name);
> > > > > +				return -ENOMEM;
> > > > > +			}
> > > > > +		}
> > > > > +		rproc_add_carveout(rproc, mem);
> > > > > +	}
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +static int zynqmp_r5_parse_fw(struct rproc *rproc, const struct
> > firmware
> > > > *fw)
> > > > > +{
> > > > > +	int ret;
> > > > > +	struct zynqmp_r5_pdata *pdata =3D rproc->priv;
> > > > > +	struct device *dev =3D &pdata->dev;
> > > > > +
> > > > > +	ret =3D parse_mem_regions(rproc);
> > > > > +	if (ret) {
> > > > > +		dev_err(dev, "parse_mem_regions failed %x\n", ret);
> > > > > +		return ret;
> > > > > +	}
> > > > > +
> > > > > +	ret =3D rproc_elf_load_rsc_table(rproc, fw);
> > > > > +	if (ret =3D=3D -EINVAL) {
> > > > > +		dev_info(dev, "no resource table found.\n");
> > > > > +		ret =3D 0;
> > > >
> > > > Why do we want to continue ignoring the error in this case?
> > > >
> > > [Ben Levinsky] as there can be simple firmware loaded onto R5 that do=
 not
> > have resource table. Resource table only needed for specific IPC case.
> >
> > OK, an in-code comment would be good
> >
> >
> > > > > +	struct device *dev;
> > > > > +	struct zynqmp_r5_mem *mem;
> > > > > +	int ret;
> > > > > +	struct property *prop;
> > > > > +	const __be32 *cur;
> > > > > +	u32 val;
> > > > > +	int i;
> > > > > +
> > > > > +	dev =3D &pdata->dev;
> > > > > +	mem =3D devm_kzalloc(dev, sizeof(*mem), GFP_KERNEL);
> > > > > +	if (!mem)
> > > > > +		return -ENOMEM;
> > > > > +	ret =3D of_address_to_resource(node, 0, &mem->res);
> > > > > +	if (ret < 0) {
> > > > > +		dev_err(dev, "failed to get resource of memory %s",
> > > > > +			of_node_full_name(node));
> > > > > +		return -EINVAL;
> > > > > +	}
> > > > > +
> > > > > +	/* Get the power domain id */
> > > > > +	i =3D 0;
> > > > > +	if (of_find_property(node, "pnode-id", NULL)) {
> > > > > +		of_property_for_each_u32(node, "pnode-id", prop,
> cur, val)
> > > > > +			mem->pnode_id[i++] =3D val;
> > > > > +	}
> > > > > +	list_add_tail(&mem->node, &pdata->mems);
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +/**
> > > > > + * zynqmp_r5_release() - ZynqMP R5 device release function
> > > > > + * @dev: pointer to the device struct of ZynqMP R5
> > > > > + *
> > > > > + * Function to release ZynqMP R5 device.
> > > > > + */
> > > > > +static void zynqmp_r5_release(struct device *dev)
> > > > > +{
> > > > > +	struct zynqmp_r5_pdata *pdata;
> > > > > +	struct rproc *rproc;
> > > > > +	struct sk_buff *skb;
> > > > > +
> > > > > +	pdata =3D dev_get_drvdata(dev);
> > > > > +	rproc =3D pdata->rproc;
> > > > > +	if (rproc) {
> > > > > +		rproc_del(rproc);
> > > > > +		rproc_free(rproc);
> > > > > +	}
> > > > > +	if (pdata->tx_chan)
> > > > > +		mbox_free_channel(pdata->tx_chan);
> > > > > +	if (pdata->rx_chan)
> > > > > +		mbox_free_channel(pdata->rx_chan);
> > > > > +	/* Discard all SKBs */
> > > > > +	while (!skb_queue_empty(&pdata->tx_mc_skbs)) {
> > > > > +		skb =3D skb_dequeue(&pdata->tx_mc_skbs);
> > > > > +		kfree_skb(skb);
> > > > > +	}
> > > > > +
> > > > > +	put_device(dev->parent);
> > > > > +}
> > > > > +
> > > > > +/**
> > > > > + * event_notified_idr_cb() - event notified idr callback
> > > > > + * @id: idr id
> > > > > + * @ptr: pointer to idr private data
> > > > > + * @data: data passed to idr_for_each callback
> > > > > + *
> > > > > + * Pass notification to remoteproc virtio
> > > > > + *
> > > > > + * Return: 0. having return is to satisfy the idr_for_each() fun=
ction
> > > > > + *          pointer input argument requirement.
> > > > > + **/
> > > > > +static int event_notified_idr_cb(int id, void *ptr, void *data)
> > > > > +{
> > > > > +	struct rproc *rproc =3D data;
> > > > > +
> > > > > +	(void)rproc_vq_interrupt(rproc, id);
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +/**
> > > > > + * handle_event_notified() - remoteproc notification work funcit=
on
> > > > > + * @work: pointer to the work structure
> > > > > + *
> > > > > + * It checks each registered remoteproc notify IDs.
> > > > > + */
> > > > > +static void handle_event_notified(struct work_struct *work)
> > > > > +{
> > > > > +	struct rproc *rproc;
> > > > > +	struct zynqmp_r5_pdata *pdata;
> > > > > +
> > > > > +	pdata =3D container_of(work, struct zynqmp_r5_pdata,
> mbox_work);
> > > > > +
> > > > > +	(void)mbox_send_message(pdata->rx_chan, NULL);
> > > > > +	rproc =3D pdata->rproc;
> > > > > +	/*
> > > > > +	 * We only use IPI for interrupt. The firmware side may or may
> > > > > +	 * not write the notifyid when it trigger IPI.
> > > > > +	 * And thus, we scan through all the registered notifyids.
> > > > > +	 */
> > > > > +	idr_for_each(&rproc->notifyids, event_notified_idr_cb, rproc);
> > > >
> > > > This looks expensive. Should we at least check whether the notifyid=
 was
> > > > written as first thing before doing the scan?
> > > >
> > > [Ben Levinsky] this will be at most 2 vrings presently per firmware-l=
oad
> and
> > only done when the firmware is loaded so the latency so should not impa=
ct
> > performace or user
> >
> > OK
> >
> >
> > > > > +	/* Get R5 power domain node */
> > > > > +	ret =3D of_property_read_u32(node, "pnode-id", &pdata-
> >pnode_id);
> > > > > +	if (ret) {
> > > > > +		dev_err(dev, "failed to get power node id.\n");
> > > > > +		goto error;
> > > > > +	}
> > > > > +
> > > > > +	/* TODO Check if R5 is running */
> > > > > +
> > > > > +	/* Set up R5 if not already setup */
> > > > > +	ret =3D pdata->is_r5_mode_set ? 0 : r5_set_mode(pdata);
> > > > > +	if (ret) {
> > > > > +		dev_err(dev, "failed to set R5 operation mode.\n");
> > > > > +		return ret;
> > > > > +	}
> > > >
> > > > is_r5_mode_set is set by r5_set_mode(), which is only called here.
> > > > So it looks like this check is important in cases where
> > > > zynqmp_r5_probe() is called twice for the same R5 node. But I don't
> > > > think that is supposed to happen?
> > > >
> > > [Ben Levinsky] this is needed as there are cases where user can repea=
tedly
> > load different firmware so the check is needed in cases like this where=
 rpu is
> > already configured. It is also possible that a user might repeatedly
> > load/unload the module
> >
> > OK

