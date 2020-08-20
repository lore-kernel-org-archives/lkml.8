Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9BAC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 15:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 491D92086A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 15:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="sXgJCAAx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgHTPN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 11:13:29 -0400
Received: from mail-eopbgr750055.outbound.protection.outlook.com ([40.107.75.55]:19425
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727920AbgHTPNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 11:13:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b13Z+JZorhL3XHfyaGVY9+eVmLAbcRzK8wDFx0wKdAlgzeiRKfupa230WUB6kN+oYLd/MihhBkcNubD1dItjSB1d/hN0xkoGqepVoGkee/YbEyLlUMhvffRrH/zmZE1g1nYUSr6OuRvadcgqwrQVHAy4e7b7aWrpgqGbpylXAFvW6bRRkYNAXgbxQsacnpUwb4+pNcaORYp1MY60tkCV2ISqDKyIJAkwjnkSDoNMJtN0+aRhC8Jt3cizKgO6XvUYhWqb3GftQm4oJIy0lRBo2QIE7LHzHn5m3fZGPJOJiI9XLW/30eg2f30VrmpEix79vUeZU89/U0FKQGig9vazrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6duGQ41xnN7LQPFMbKT6Xb32iZ99IkIPHYiy13mQLY=;
 b=aU1eFnC0iBW7a06QTk2aEGinbaZTSfkczFfz/2NcAdSLAFRDPN1C+MB8zuvi2QCHIIQc3O5gwODEgefcMdrorPm7zWsqYZJsZTsvFeBazfELmraSkHoyvuJPLRVQLiRMS4NG7Eu8PqAUIJwlSw3egoiblo0WzHAktRvS1d61HnudNmDnALmMD1s65GuWQAXWD7wOLV8nxItpNIL0bVCnoV/bSJD1DYRxzzUj/Xe1zhEt2d49M9jT2zT7mLOgm1r26yeYyL+kEuAahtaUFFh0QHMutfYXzeymGINoK9hrWnriGTBbR/Ugz/TYYHlGRBaEMYtVzcnPTKcxXl6xY1ee7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6duGQ41xnN7LQPFMbKT6Xb32iZ99IkIPHYiy13mQLY=;
 b=sXgJCAAxcy3aAWGLzW7UbjXr+2zgfNipyDhLDAxKKG9iKjy7rk3FuJfwtTUL7tJoLZ54rjQ79Hw5TOLWrApLnhR2VHWtWGKHQn8jz/Xco96Wzh4vP8bVoc+qiUCeGuNdAS6qohZb6SHmPg+tv1YD9yYdR386se46g8kNs7VLnzI=
Received: from BYAPR02MB4407.namprd02.prod.outlook.com (2603:10b6:a03:55::31)
 by BY5PR02MB6550.namprd02.prod.outlook.com (2603:10b6:a03:1d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Thu, 20 Aug
 2020 15:13:18 +0000
Received: from BYAPR02MB4407.namprd02.prod.outlook.com
 ([fe80::b0f6:b3a:6543:26f5]) by BYAPR02MB4407.namprd02.prod.outlook.com
 ([fe80::b0f6:b3a:6543:26f5%5]) with mapi id 15.20.3305.024; Thu, 20 Aug 2020
 15:13:18 +0000
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
Thread-Index: AQHWb5ATV4ChTkO3Pki1oN57qb9mj6k2g4WAgAd0r9CAAgX1AIABKS1g
Date:   Thu, 20 Aug 2020 15:13:17 +0000
Message-ID: <BYAPR02MB44072DB321E24C3FAC2A11E1B55A0@BYAPR02MB4407.namprd02.prod.outlook.com>
References: <20200811033213.20088-1-ben.levinsky@xilinx.com>
 <20200811033213.20088-6-ben.levinsky@xilinx.com>
 <alpine.DEB.2.21.2008131116060.15669@sstabellini-ThinkPad-T480s>
 <BYAPR02MB4407487EEA04C681FF99867CB55C0@BYAPR02MB4407.namprd02.prod.outlook.com>
 <alpine.DEB.2.21.2008191340140.15985@sstabellini-ThinkPad-T480s>
In-Reply-To: <alpine.DEB.2.21.2008191340140.15985@sstabellini-ThinkPad-T480s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [99.174.248.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 92f30c51-7d1e-46c2-d7a4-08d8451b9186
x-ms-traffictypediagnostic: BY5PR02MB6550:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR02MB65506A6A690C12F6829AB6DEB55A0@BY5PR02MB6550.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a/vG3XI6SurqVgUPs9fgoYRQNRjBXkSFnD82arOUZh3iRgGlh2aiOBzgIsNdZqERR5+9iuKBlNPGlaGICejI15j19INvQXoEwT5o3NHD8C172CaJt4E31LQv32lKdTZHpE3ReiGZ/L+dU1IvSCPP2oj1GoYFYThpoA++NNjhONGRpPPnkg32GuVpmNqQX+CqsFmbkotDoDzOvzJM0Z6bHDfQREeryVqhGSj6K6kAbyHTeVYNFhsBahfW5jZM+tRbhQU161osPFDpnsJUxGFC8O3L6tDxiRV2uM3jvIJ+7mmq0lRK+kfISdQ5gJjEoolo+NbKeLepuLDwrmYlXqO4UQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB4407.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(39860400002)(366004)(136003)(396003)(64756008)(66476007)(26005)(478600001)(316002)(55016002)(66446008)(83380400001)(6862004)(186003)(66556008)(5660300002)(33656002)(2906002)(8676002)(52536014)(9686003)(6636002)(76116006)(7696005)(86362001)(66946007)(4326008)(54906003)(6506007)(53546011)(71200400001)(8936002)(30864003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: +V3ax75WVtnLFUqxOXVr3mJpl9faECSVRn2ci5vSFFtgibvBeT8J0vlFu2Fk4flZH7HtTIsL3EBpNYGHhBi4TEhCNFPYMRBw+oeDHwjVHV4QVDTN1C4MEag7agZhYVZaDBtrnetALUk8qj0s6R2ZTZrjB6vSjDxGY57A9ZTbdchUwgSRzv1LI6uKbtV5ZbCX+OQbh8WUZRpV4hpWnd9eWlcguz0Lk+yu0FLYOH25cMx0sgKfFwEpZ2rNFcoeU2iPtwnLADIkh7/mEXbz3CPNBYPPln7h5Ve7yk7qpcfA9GBZCPZqsuSnO24gyzk9Ug6OY098Idexb5qYeLnAvn8y+G9psW9NkvpCIcArdY5jWumAzFj2hivPxfzY9fyeFvjLgTNCDq2svtOOKNVVwL4BNuvjo2WUalKqhlfOpK5ed/A14Bt5H2bccw+WmoBj/sRP9NMgZPOTPt5tjQ20Odb/ikEzL8MfAhYe5O+vwJAS8x5l3vpb+TsTklhYGDnhCyTXNnaEUSH2bgiIsSVZs30iGjknRrQ2n5Nq1xCxFdJ93cEzMlX70CK3E1Gz7h0skNaEjWj/P34EVgyD/i+UVXfOnml9eEop70bHphURITSj3Rbo1c21hdXiINGpTWk5AX8qFpk7IA5fNdI6yJBmq25slg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4407.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f30c51-7d1e-46c2-d7a4-08d8451b9186
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2020 15:13:17.8613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nY1fHon8oPKAdJ0efDG6pzuCDIqQSassRpNGhKTxpSSODP4pdwiWILBtdF/2+WsiE7QRtF2tjp3YJrWAhufmkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6550
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Stefano Stabellini <stefano.stabellini@xilinx.com>
> Sent: Wednesday, August 19, 2020 2:21 PM
> To: Ben Levinsky <BLEVINSK@xilinx.com>
> Cc: Stefano Stabellini <stefanos@xilinx.com>; Michal Simek
> <michals@xilinx.com>; devicetree@vger.kernel.org;
> mathieu.poirier@linaro.org; Ed T. Mooring <emooring@xilinx.com>; linux-
> remoteproc@vger.kernel.org; linux-kernel@vger.kernel.org;
> robh+dt@kernel.org; Jiaying Liang <jliang@xilinx.com>; linux-arm-
> kernel@lists.infradead.org
> Subject: RE: [PATCH v8 5/5] remoteproc: Add initial zynqmp R5 remoteproc
> driver
>=20
> On Tue, 18 Aug 2020, Ben Levinsky wrote:
> > > > +/**
> > > > + * struct zynqmp_r5_mem - zynqmp rpu memory data
> > > > + * @pnode_id: TCM power domain ids
> > > > + * @res: memory resource
> > > > + * @node: list node
> > > > + */
> > > > +struct zynqmp_r5_mem {
> > > > +	u32 pnode_id[MAX_MEM_PNODES];
> > > > +	struct resource res;
> > > > +	struct list_head node;
> > > > +};
> > > > +
> > > > +/**
> > > > + * struct zynqmp_r5_pdata - zynqmp rpu remote processor private da=
ta
> > > > + * @dev: device of RPU instance
> > > > + * @rproc: rproc handle
> > > > + * @pnode_id: RPU CPU power domain id
> > > > + * @mems: memory resources
> > > > + * @is_r5_mode_set: indicate if r5 operation mode is set
> > > > + * @tx_mc: tx mailbox client
> > > > + * @rx_mc: rx mailbox client
> > > > + * @tx_chan: tx mailbox channel
> > > > + * @rx_chan: rx mailbox channel
> > > > + * @mbox_work: mbox_work for the RPU remoteproc
> > > > + * @tx_mc_skbs: socket buffers for tx mailbox client
> > > > + * @rx_mc_buf: rx mailbox client buffer to save the rx message
> > > > + */
> > > > +struct zynqmp_r5_pdata {
> > > > +	struct device dev;
> > > > +	struct rproc *rproc;
> > > > +	u32 pnode_id;
> > > > +	struct list_head mems;
> > > > +	bool is_r5_mode_set;
> > > > +	struct mbox_client tx_mc;
> > > > +	struct mbox_client rx_mc;
> > > > +	struct mbox_chan *tx_chan;
> > > > +	struct mbox_chan *rx_chan;
> > > > +	struct work_struct mbox_work;
> > > > +	struct sk_buff_head tx_mc_skbs;
> > > > +	unsigned char rx_mc_buf[RX_MBOX_CLIENT_BUF_MAX];
> > >
> > > A simple small reordering of the struct fields would lead to small
> > > memory savings due to alignment.
> > >
> > >
> > [Ben Levinsky] will do. Do you mean ordering in either ascending or
> descending order?
>=20
> Each field has a different alignment in the struct, so for example after
> pnode_id there are probably 4 unused bytes because mems is 64bit
> aligned.
>=20
>=20
[Ben Levinsky] ok will update this so the alignments are done with less unu=
sed memory per struct allocation.
> > > > +/*
> > > > + * TCM needs mapping to R5 relative address and xilinx platform mg=
mt
> call
> > > > + */
> > > > +struct rproc_mem_entry *handle_tcm_parsing(struct device *dev,
> > > > +					    struct reserved_mem *rmem,
> > > > +					    struct device_node *node,
> > > > +					    int lookup_idx)
> > > > +{
> > > > +	void *va;
> > > > +	dma_addr_t dma;
> > > > +	resource_size_t size;
> > > > +	int ret;
> > > > +	u32 pnode_id;
> > > > +	struct resource rsc;
> > > > +	struct rproc_mem_entry *mem;
> > > > +
> > > > +	pnode_id =3D  tcm_addr_to_pnode[lookup_idx][1];
> > > > +	ret =3D zynqmp_pm_request_node(pnode_id,
> > > > +				     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
> > > > +				     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> > > > +	if (ret < 0) {
> > > > +		dev_err(dev, "failed to request power node: %u\n",
> > > pnode_id);
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > > +	ret =3D of_address_to_resource(node, 0, &rsc);
> > > > +	if (ret < 0) {
> > > > +		dev_err(dev, "failed to get resource of memory %s",
> > > > +			of_node_full_name(node));
> > > > +		return -EINVAL;
> > > > +	}
> > > > +	size =3D resource_size(&rsc);
> > > > +	va =3D devm_ioremap_wc(dev, rsc.start, size);
> > > > +	if (!va)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	/* zero out tcm base address */
> > > > +	if (rsc.start & 0xffe00000) {
> > > > +		/* R5 can't see anything past 0xfffff so wipe it */
> > > > +		rsc.start &=3D 0x000fffff;
> > >
> > > If that is the case why not do:
> > >
> > >   rsc.start &=3D 0x000fffff;
> > >
> > > unconditionally? if (rsc.start & 0xffe00000) is superfluous.
> > >
> > > But I thought that actually the R5s could see TCM at both the low
> > > address (< 0x000fffff) and also at the high address (i.e. 0xffe00000)=
.
> > >
> > >
> > [Ben Levinsky] Here yes can make rsc.start &=3D 0x000fffff undcondition=
al. Will
> update in v9 as such
> > 		Also, this logic is because this is only for the Xilinx R5
> mappings of TCM banks that are at (from the TCM point of view) 0x0 and
> 0x2000
>=20
> What I meant is that as far as I understand from the TRM the RPU should
> also be able to access the same banks at the same address of the APU,
> which I imagine is in the 0xffe00000 range. But I could be wrong on
> this.
>=20
> If we could use the same addresses for RPU and APU, it would simplify
> this driver.
>=20
>=20
> > > > +		/*
> > > > +		 * handle tcm banks 1 a and b (0xffe9000 and
> > > > +		 * 0xffeb0000)
> > > > +		 */
> > > > +		if (rsc.start & 0x80000)
> > > > +			rsc.start -=3D 0x90000;
> > >
> > > It is very unclear to me why we have to do this
> > >
> > >
> > [Ben Levinsky] This is for TCM bank 0B and bank 1B to map them to
> 0x00020000 so that the TCM relative addressing lines up. For example
> (0xffe90000 & 0x000fffff) - 0x90000 =3D 0x20000
>=20
> Could you please explain the mapping in an in-code comment?
> The comment currently mentions 0xffe9000 and 0xffeb0000 but:
>=20
> - 0xffe9000 & 0x000fffff =3D 0xe9000
>   0xe9000 - 0x90000 =3D 0x59000
>=20
> - 0xffeb0000 & 0x000fffff =3D 0xeb000
>   0xeb000 - 0x90000 =3D 0xeb000
>=20
> Either way we don't get 0x20000. What am I missing?
>=20
[Ben Levinsky] I apologize there is typo in the comment... it should be 0xf=
fe90000 and 0xffeb0000
The output is:
0xffe90000 & 0x000fffff =3D 0x90000
0x90000 - 0x90000 =3D 0x0

And=20
0xffeb0000 & 0x000fffff =3D 0xB0000=20
0xB0000 - 0x90000 =3D 0x20000

So these line up for the relative addressing for RPU's view of TCMs
>=20
>=20
> > > > +	}
> > > > +
> > > > +	dma =3D (dma_addr_t)rsc.start;
> > >
> > > Given the way the dma parameter is used by
> > > rproc_alloc_registered_carveouts, I think it might be best to pass th=
e
> > > original start address (i.e. 0xffe00000) as dma.
> > >
> > >
> > > > +	mem =3D rproc_mem_entry_init(dev, va, dma, (int)size, rsc.start,
> > > > +				   NULL, zynqmp_r5_mem_release,
> > >
> > > I don't know too much about the remoteproc APIs, but shouldn't you be
> > > passing zynqmp_r5_rproc_mem_alloc to it instead of NULL?
> > >
> > >
> > [Ben Levinsky] the difference is that for TCM we have to do make the
> relative address work for TCM, so the dma input to rproc_mem_entry_init i=
s
> different in TCM case.
>=20
> The dma address is the address as seen by the RPU, is that right?
> So you are trying to set the dma address to something in the range 0 -
> 0x20000?
>=20
>=20
[Ben Levinsky] yes=20
> > > > +				   rsc.name);
> > > > +	if (!mem)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	return mem;
> > > > +}
> > > > +
> > > > +static int parse_mem_regions(struct rproc *rproc)
> > > > +{
> > > > +	int num_mems, i;
> > > > +	struct zynqmp_r5_pdata *pdata =3D rproc->priv;
> > > > +	struct device *dev =3D  &pdata->dev;
> > > > +	struct device_node *np =3D dev->of_node;
> > > > +	struct rproc_mem_entry *mem;
> > > > +
> > > > +	num_mems =3D of_count_phandle_with_args(np, "memory-region",
> > > NULL);
> > > > +	if (num_mems <=3D 0)
> > > > +		return 0;
> > > > +	for (i =3D 0; i < num_mems; i++) {
> > > > +		struct device_node *node;
> > > > +		struct reserved_mem *rmem;
> > > > +
> > > > +		node =3D of_parse_phandle(np, "memory-region", i);
> > >
> > > Check node !=3D NULL ?
> > >
> > [Ben Levinsky] will add this in v9
> > >
> > > > +		rmem =3D of_reserved_mem_lookup(node);
> > > > +		if (!rmem) {
> > > > +			dev_err(dev, "unable to acquire memory-region\n");
> > > > +			return -EINVAL;
> > > > +		}
> > > > +
> > > > +		if (strstr(node->name, "vdev0buffer")) {
> > >
> > > vdev0buffer is not described in the device tree bindings, is that
> > > normal/expected?
> > >
> > >
> > [Ben Levinsky] vdev0buffer is not required, as there might be simple
> firmware loading with no IPC. Vdev0buffer only needed for IPC.
>=20
> OK, good. It should probably still be described in the device tree
> binding as optional property.
>=20
>=20
> > > > +			/* Register DMA region */
> > > > +			mem =3D rproc_mem_entry_init(dev, NULL,
> > > > +						   (dma_addr_t)rmem->base,
> > > > +						   rmem->size, rmem->base,
> > > > +						   NULL, NULL,
> > > > +						   "vdev0buffer");
> > > > +			if (!mem) {
> > > > +				dev_err(dev, "unable to initialize memory-
> > > region %s\n",
> > > > +					node->name);
> > > > +				return -ENOMEM;
> > > > +			}
> > > > +			dev_dbg(dev, "parsed %s at  %llx\r\n", mem->name,
> > > > +				mem->dma);
> > > > +		} else if (strstr(node->name, "vdev0vring")) {
> > >
> > > Same here
> > >
> > >
> > > > +			int vring_id;
> > > > +			char name[16];
> > > > +
> > > > +			/*
> > > > +			 * can be 1 of multiple vring IDs per IPC channel
> > > > +			 * e.g. 'vdev0vring0' and 'vdev0vring1'
> > > > +			 */
> > > > +			vring_id =3D node->name[14] - '0';
> > >
> > > Where does the "14" comes from? Are we sure it is not possible to hav=
e a
> > > node->name smaller than 14 chars?
> > >
> > [Ben Levinsky] Presently there are only 2 vrings used per Xilinx OpenAM=
P
> channel to RPU. In Xilinx kernel we have hard-coded names as these are th=
e
> only nodes that use it. For example RPU0vdev0vring0 and RPU1vdev0vring0.
> Hence we only check for vdev0vring and not a sscanf("%*s%i") to parse out
> the vring ID or other, cleaner solution.
>=20
> OK, but I think it is best if we use node->name[14] only if we
> explicitly check for a string of at least 14 characters. Using strstr,
> it could return the string "vdev0vring" which is less than 14 chars,
> leading to a bug.
>=20
>=20
> > >
> > > > +			snprintf(name, sizeof(name), "vdev0vring%d",
> > > vring_id);
> > > > +			/* Register vring */
> > > > +			mem =3D rproc_mem_entry_init(dev, NULL,
> > > > +						   (dma_addr_t)rmem->base,
> > > > +						   rmem->size, rmem->base,
> > > > +
> > > zynqmp_r5_rproc_mem_alloc,
> > > > +
> > > zynqmp_r5_rproc_mem_release,
> > > > +						   name);
> > > > +			dev_dbg(dev, "parsed %s at %llx\r\n", mem->name,
> > > > +				mem->dma);
> > > > +		} else {
> > > > +			int idx;
> > > > +
> > > > +			/*
> > > > +			 * if TCM update address space for R5 and
> > > > +			 * make xilinx platform mgmt call
> > > > +			 */
> > > > +			for (idx =3D 0; idx < ZYNQMP_R5_NUM_TCM_BANKS;
> > > idx++) {
> > > > +				if (tcm_addr_to_pnode[idx][0] =3D=3D rmem-
> > > >base)
> > > > +					break;
> > >
> > > There is something I don't quite understand. If the memory region to =
use
> > > is TCM, why would it be also described under reserved-memory?
> > > Reserved-memory is for normal memory being reserved, while TCM is not
> > > normal memory. Am I missing something?
> > >
> > [Ben Levinsky] I can change this in v9 as discussed. That is, have no T=
CM
> under reserved mem. Instead have the banks as nodes in device tree with
> status=3D"[enabled|disabled]" and if enabled, then try to add memories in
> parse_fw call.
> > >
> > > > +			}
> > > > +
> > > > +			if (idx !=3D ZYNQMP_R5_NUM_TCM_BANKS) {
> > > > +				mem =3D handle_tcm_parsing(dev, rmem, node,
> > > idx);
> > > > +			} else {
> > > > +				mem =3D rproc_mem_entry_init(dev, NULL,
> > > > +						   (dma_addr_t)rmem->base,
> > > > +						   rmem->size, rmem->base,
> > > > +
> > > zynqmp_r5_rproc_mem_alloc,
> > > > +
> > > zynqmp_r5_rproc_mem_release,
> > > > +						   node->name);
> > >
> > > This case looks identical to the vdev0vring above. Is the difference
> > > really just in the "name"? If so, can we merge the two cases into one=
?
> > > no, because the devm_ioremap_wc call has to be done before changing
> the dma address to relative for TCM banks.
> > >
> > > > +			}
> > > > +
> > > > +			if (!mem) {
> > > > +				dev_err(dev,
> > > > +					"unable to init memory-region %s\n",
> > > > +					node->name);
> > > > +				return -ENOMEM;
> > > > +			}
> > > > +		}
> > > > +		rproc_add_carveout(rproc, mem);
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int zynqmp_r5_parse_fw(struct rproc *rproc, const struct
> firmware
> > > *fw)
> > > > +{
> > > > +	int ret;
> > > > +	struct zynqmp_r5_pdata *pdata =3D rproc->priv;
> > > > +	struct device *dev =3D &pdata->dev;
> > > > +
> > > > +	ret =3D parse_mem_regions(rproc);
> > > > +	if (ret) {
> > > > +		dev_err(dev, "parse_mem_regions failed %x\n", ret);
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	ret =3D rproc_elf_load_rsc_table(rproc, fw);
> > > > +	if (ret =3D=3D -EINVAL) {
> > > > +		dev_info(dev, "no resource table found.\n");
> > > > +		ret =3D 0;
> > >
> > > Why do we want to continue ignoring the error in this case?
> > >
> > [Ben Levinsky] as there can be simple firmware loaded onto R5 that do n=
ot
> have resource table. Resource table only needed for specific IPC case.
>=20
> OK, an in-code comment would be good
>=20
>=20
> > > > +	struct device *dev;
> > > > +	struct zynqmp_r5_mem *mem;
> > > > +	int ret;
> > > > +	struct property *prop;
> > > > +	const __be32 *cur;
> > > > +	u32 val;
> > > > +	int i;
> > > > +
> > > > +	dev =3D &pdata->dev;
> > > > +	mem =3D devm_kzalloc(dev, sizeof(*mem), GFP_KERNEL);
> > > > +	if (!mem)
> > > > +		return -ENOMEM;
> > > > +	ret =3D of_address_to_resource(node, 0, &mem->res);
> > > > +	if (ret < 0) {
> > > > +		dev_err(dev, "failed to get resource of memory %s",
> > > > +			of_node_full_name(node));
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > > +	/* Get the power domain id */
> > > > +	i =3D 0;
> > > > +	if (of_find_property(node, "pnode-id", NULL)) {
> > > > +		of_property_for_each_u32(node, "pnode-id", prop, cur, val)
> > > > +			mem->pnode_id[i++] =3D val;
> > > > +	}
> > > > +	list_add_tail(&mem->node, &pdata->mems);
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +/**
> > > > + * zynqmp_r5_release() - ZynqMP R5 device release function
> > > > + * @dev: pointer to the device struct of ZynqMP R5
> > > > + *
> > > > + * Function to release ZynqMP R5 device.
> > > > + */
> > > > +static void zynqmp_r5_release(struct device *dev)
> > > > +{
> > > > +	struct zynqmp_r5_pdata *pdata;
> > > > +	struct rproc *rproc;
> > > > +	struct sk_buff *skb;
> > > > +
> > > > +	pdata =3D dev_get_drvdata(dev);
> > > > +	rproc =3D pdata->rproc;
> > > > +	if (rproc) {
> > > > +		rproc_del(rproc);
> > > > +		rproc_free(rproc);
> > > > +	}
> > > > +	if (pdata->tx_chan)
> > > > +		mbox_free_channel(pdata->tx_chan);
> > > > +	if (pdata->rx_chan)
> > > > +		mbox_free_channel(pdata->rx_chan);
> > > > +	/* Discard all SKBs */
> > > > +	while (!skb_queue_empty(&pdata->tx_mc_skbs)) {
> > > > +		skb =3D skb_dequeue(&pdata->tx_mc_skbs);
> > > > +		kfree_skb(skb);
> > > > +	}
> > > > +
> > > > +	put_device(dev->parent);
> > > > +}
> > > > +
> > > > +/**
> > > > + * event_notified_idr_cb() - event notified idr callback
> > > > + * @id: idr id
> > > > + * @ptr: pointer to idr private data
> > > > + * @data: data passed to idr_for_each callback
> > > > + *
> > > > + * Pass notification to remoteproc virtio
> > > > + *
> > > > + * Return: 0. having return is to satisfy the idr_for_each() funct=
ion
> > > > + *          pointer input argument requirement.
> > > > + **/
> > > > +static int event_notified_idr_cb(int id, void *ptr, void *data)
> > > > +{
> > > > +	struct rproc *rproc =3D data;
> > > > +
> > > > +	(void)rproc_vq_interrupt(rproc, id);
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +/**
> > > > + * handle_event_notified() - remoteproc notification work funciton
> > > > + * @work: pointer to the work structure
> > > > + *
> > > > + * It checks each registered remoteproc notify IDs.
> > > > + */
> > > > +static void handle_event_notified(struct work_struct *work)
> > > > +{
> > > > +	struct rproc *rproc;
> > > > +	struct zynqmp_r5_pdata *pdata;
> > > > +
> > > > +	pdata =3D container_of(work, struct zynqmp_r5_pdata, mbox_work);
> > > > +
> > > > +	(void)mbox_send_message(pdata->rx_chan, NULL);
> > > > +	rproc =3D pdata->rproc;
> > > > +	/*
> > > > +	 * We only use IPI for interrupt. The firmware side may or may
> > > > +	 * not write the notifyid when it trigger IPI.
> > > > +	 * And thus, we scan through all the registered notifyids.
> > > > +	 */
> > > > +	idr_for_each(&rproc->notifyids, event_notified_idr_cb, rproc);
> > >
> > > This looks expensive. Should we at least check whether the notifyid w=
as
> > > written as first thing before doing the scan?
> > >
> > [Ben Levinsky] this will be at most 2 vrings presently per firmware-loa=
d and
> only done when the firmware is loaded so the latency so should not impact
> performace or user
>=20
> OK
>=20
>=20
> > > > +	/* Get R5 power domain node */
> > > > +	ret =3D of_property_read_u32(node, "pnode-id", &pdata->pnode_id);
> > > > +	if (ret) {
> > > > +		dev_err(dev, "failed to get power node id.\n");
> > > > +		goto error;
> > > > +	}
> > > > +
> > > > +	/* TODO Check if R5 is running */
> > > > +
> > > > +	/* Set up R5 if not already setup */
> > > > +	ret =3D pdata->is_r5_mode_set ? 0 : r5_set_mode(pdata);
> > > > +	if (ret) {
> > > > +		dev_err(dev, "failed to set R5 operation mode.\n");
> > > > +		return ret;
> > > > +	}
> > >
> > > is_r5_mode_set is set by r5_set_mode(), which is only called here.
> > > So it looks like this check is important in cases where
> > > zynqmp_r5_probe() is called twice for the same R5 node. But I don't
> > > think that is supposed to happen?
> > >
> > [Ben Levinsky] this is needed as there are cases where user can repeate=
dly
> load different firmware so the check is needed in cases like this where r=
pu is
> already configured. It is also possible that a user might repeatedly
> load/unload the module
>=20
> OK

