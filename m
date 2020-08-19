Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C65C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 21:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 227C82063A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 21:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="rRvBMN6R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgHSVVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 17:21:19 -0400
Received: from mail-dm6nam12on2086.outbound.protection.outlook.com ([40.107.243.86]:26209
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726646AbgHSVVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 17:21:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RiYOfz+V8TlcRKukASK5tYZksBrIhrvwcULb1tQEmZ/j/2Lr7U7mU0LJl9jQl5+Apw1fQlyXPcyw82JDCaMTwup5pHL8sJKmnnppESLU+Jo+YUiOZGVhP2jL3mzobI9/VkodC22xrfdH/kPli8KbsCssn/lAeqILFTnFbwT8ju8d/xDCnh5by94V/7Rkvjz5FQg/DzsWsCuuPcBYKB4nOPCYksCQlejUsFdoMgv591p8X6ifk0kgTD78viCC/UjRo5XQJ7d9wmrjnNWewwnRrAY4en3sdOLSwoNeEmQU8dRw3w+3eK+wK0IOe4A3MqO7npmD0c8tJgLix80KIj/L1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+nhGxL5h5y1G6I8QfOk5RdT0kbHrJvCHSfligzqf14=;
 b=HLob8h/Kf7QP4N7DkOYMH3oE6apwZ5/AfyTiES1ffxGAPjS/4UNe4T49PSp9zjlmMY0MTub5WBLfUe4uwm/algtX2RjCrh4c/pvvxzUi3Eq9FtpwIwhjnQwnE7ECmqhv58SpRA1ET2a3nNjpF1lsCtw4fU17X6pLIiSVGQFU5RDaZKlyr37oPDxkmT2JCRaShmsDvbOCXPJ7bcZGX1xn/BLcsxWf165nI4TJi59RI8NovZSgve6B/xVM6x2UUhiVM2CdFJMOAxLot4GuJpsXCM5NuaZogMZye/bARZBlDbU/F+zUOrh4blF+LB+2UKfKnLyOzzIqCWXbeLNYQKXaQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+nhGxL5h5y1G6I8QfOk5RdT0kbHrJvCHSfligzqf14=;
 b=rRvBMN6R5wRmqESxzMnC6Bbh4XvZemORPbe4TS9Iz+FPd3UGDzndyZ10lQBJL6hovZviqsBCyGqxN78SFrJnfuuFPFSxf4GZxtu98/JpoQA8pCtnDmjwVeItkDo6MLrcKXF7MxgCz7H7U0uYBerhvQ6LfRt+peeigYJaxUFfUus=
Received: from SN4PR0401CA0047.namprd04.prod.outlook.com
 (2603:10b6:803:2a::33) by DM6PR02MB5707.namprd02.prod.outlook.com
 (2603:10b6:5:7e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Wed, 19 Aug
 2020 21:21:11 +0000
Received: from SN1NAM02FT0055.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2a:cafe::ac) by SN4PR0401CA0047.outlook.office365.com
 (2603:10b6:803:2a::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Wed, 19 Aug 2020 21:21:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT0055.mail.protection.outlook.com (10.97.5.78) with Microsoft SMTP
 Server id 15.20.3305.24 via Frontend Transport; Wed, 19 Aug 2020 21:21:10
 +0000
Received: from [149.199.38.66] (port=36746 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <stefano.stabellini@xilinx.com>)
        id 1k8VVq-0000h8-LP; Wed, 19 Aug 2020 14:20:50 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <stefano.stabellini@xilinx.com>)
        id 1k8VWA-000657-Ja; Wed, 19 Aug 2020 14:21:10 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 07JLL5Es015337;
        Wed, 19 Aug 2020 14:21:05 -0700
Received: from [10.23.123.104] (helo=localhost)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <stefanos@xilinx.com>)
        id 1k8VW5-00063x-DH; Wed, 19 Aug 2020 14:21:05 -0700
Date:   Wed, 19 Aug 2020 14:21:04 -0700 (PDT)
From:   Stefano Stabellini <stefano.stabellini@xilinx.com>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Ben Levinsky <BLEVINSK@xilinx.com>
cc:     Stefano Stabellini <stefanos@xilinx.com>,
        Michal Simek <michals@xilinx.com>,
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
In-Reply-To: <BYAPR02MB4407487EEA04C681FF99867CB55C0@BYAPR02MB4407.namprd02.prod.outlook.com>
Message-ID: <alpine.DEB.2.21.2008191340140.15985@sstabellini-ThinkPad-T480s>
References: <20200811033213.20088-1-ben.levinsky@xilinx.com> <20200811033213.20088-6-ben.levinsky@xilinx.com> <alpine.DEB.2.21.2008131116060.15669@sstabellini-ThinkPad-T480s> <BYAPR02MB4407487EEA04C681FF99867CB55C0@BYAPR02MB4407.namprd02.prod.outlook.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0b0d8e5-e2b6-4bdb-3a39-08d84485cb83
X-MS-TrafficTypeDiagnostic: DM6PR02MB5707:
X-Microsoft-Antispam-PRVS: <DM6PR02MB570768FBFD9B8378D75806D0A05D0@DM6PR02MB5707.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8q89LGHCV0c9FhxFtqfUiW9ac2omyiloez2lrv9A71/XIJdnZBM6D3sR53yKR6Zym06et2N4+WBAMIwKG2pwGMJWTthbYVy5UT5hysECaJa2Ch2t1RYvRHDEnL2DxFK5/Owbyk/dv2upPsZqmmIB4QzNyX3/i5JLp9z6hfbxG6VKlATw9V3xq3J5ZxgfYP3DPEm/2SGu3miff05SwricccvcACl9wVtyCB3qZw1JlFsGIKUBa+E6N4viWcMIyLaUCKtlG8AD3Zom2H7M59+kHvHFi6TuIcTuHrcF+NqQ4NV/lG8wjw0JrtnCrE0AQdIX7zgEb8+gwPDTa7UevTMMV3upyc10CsD9Qz8z1mWABZTVBDKTcpd97mC006DJW2o6oDPV5mHpGHlvJrKRuVycKQ==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(7916004)(396003)(346002)(376002)(136003)(39860400002)(46966005)(316002)(478600001)(33716001)(8936002)(356005)(54906003)(8676002)(82310400002)(6636002)(426003)(26005)(30864003)(336012)(9786002)(44832011)(81166007)(5660300002)(4326008)(2906002)(9686003)(82740400003)(47076004)(70206006)(186003)(6862004)(83380400001)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 21:21:10.8589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b0d8e5-e2b6-4bdb-3a39-08d84485cb83
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0055.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5707
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Aug 2020, Ben Levinsky wrote:
> > > +/**
> > > + * struct zynqmp_r5_mem - zynqmp rpu memory data
> > > + * @pnode_id: TCM power domain ids
> > > + * @res: memory resource
> > > + * @node: list node
> > > + */
> > > +struct zynqmp_r5_mem {
> > > +	u32 pnode_id[MAX_MEM_PNODES];
> > > +	struct resource res;
> > > +	struct list_head node;
> > > +};
> > > +
> > > +/**
> > > + * struct zynqmp_r5_pdata - zynqmp rpu remote processor private data
> > > + * @dev: device of RPU instance
> > > + * @rproc: rproc handle
> > > + * @pnode_id: RPU CPU power domain id
> > > + * @mems: memory resources
> > > + * @is_r5_mode_set: indicate if r5 operation mode is set
> > > + * @tx_mc: tx mailbox client
> > > + * @rx_mc: rx mailbox client
> > > + * @tx_chan: tx mailbox channel
> > > + * @rx_chan: rx mailbox channel
> > > + * @mbox_work: mbox_work for the RPU remoteproc
> > > + * @tx_mc_skbs: socket buffers for tx mailbox client
> > > + * @rx_mc_buf: rx mailbox client buffer to save the rx message
> > > + */
> > > +struct zynqmp_r5_pdata {
> > > +	struct device dev;
> > > +	struct rproc *rproc;
> > > +	u32 pnode_id;
> > > +	struct list_head mems;
> > > +	bool is_r5_mode_set;
> > > +	struct mbox_client tx_mc;
> > > +	struct mbox_client rx_mc;
> > > +	struct mbox_chan *tx_chan;
> > > +	struct mbox_chan *rx_chan;
> > > +	struct work_struct mbox_work;
> > > +	struct sk_buff_head tx_mc_skbs;
> > > +	unsigned char rx_mc_buf[RX_MBOX_CLIENT_BUF_MAX];
> > 
> > A simple small reordering of the struct fields would lead to small
> > memory savings due to alignment.
> > 
> > 
> [Ben Levinsky] will do. Do you mean ordering in either ascending or descending order?

Each field has a different alignment in the struct, so for example after
pnode_id there are probably 4 unused bytes because mems is 64bit
aligned.


> > > +/*
> > > + * TCM needs mapping to R5 relative address and xilinx platform mgmt call
> > > + */
> > > +struct rproc_mem_entry *handle_tcm_parsing(struct device *dev,
> > > +					    struct reserved_mem *rmem,
> > > +					    struct device_node *node,
> > > +					    int lookup_idx)
> > > +{
> > > +	void *va;
> > > +	dma_addr_t dma;
> > > +	resource_size_t size;
> > > +	int ret;
> > > +	u32 pnode_id;
> > > +	struct resource rsc;
> > > +	struct rproc_mem_entry *mem;
> > > +
> > > +	pnode_id =  tcm_addr_to_pnode[lookup_idx][1];
> > > +	ret = zynqmp_pm_request_node(pnode_id,
> > > +				     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
> > > +				     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> > > +	if (ret < 0) {
> > > +		dev_err(dev, "failed to request power node: %u\n",
> > pnode_id);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	ret = of_address_to_resource(node, 0, &rsc);
> > > +	if (ret < 0) {
> > > +		dev_err(dev, "failed to get resource of memory %s",
> > > +			of_node_full_name(node));
> > > +		return -EINVAL;
> > > +	}
> > > +	size = resource_size(&rsc);
> > > +	va = devm_ioremap_wc(dev, rsc.start, size);
> > > +	if (!va)
> > > +		return -ENOMEM;
> > > +
> > > +	/* zero out tcm base address */
> > > +	if (rsc.start & 0xffe00000) {
> > > +		/* R5 can't see anything past 0xfffff so wipe it */
> > > +		rsc.start &= 0x000fffff;
> > 
> > If that is the case why not do:
> > 
> >   rsc.start &= 0x000fffff;
> > 
> > unconditionally? if (rsc.start & 0xffe00000) is superfluous.
> > 
> > But I thought that actually the R5s could see TCM at both the low
> > address (< 0x000fffff) and also at the high address (i.e. 0xffe00000).
> > 
> > 
> [Ben Levinsky] Here yes can make rsc.start &= 0x000fffff undconditional. Will update in v9 as such
> 		Also, this logic is because this is only for the Xilinx R5 mappings of TCM banks that are at (from the TCM point of view) 0x0 and 0x2000

What I meant is that as far as I understand from the TRM the RPU should
also be able to access the same banks at the same address of the APU,
which I imagine is in the 0xffe00000 range. But I could be wrong on
this.

If we could use the same addresses for RPU and APU, it would simplify
this driver.


> > > +		/*
> > > +		 * handle tcm banks 1 a and b (0xffe9000 and
> > > +		 * 0xffeb0000)
> > > +		 */
> > > +		if (rsc.start & 0x80000)
> > > +			rsc.start -= 0x90000;
> > 
> > It is very unclear to me why we have to do this
> > 
> > 
> [Ben Levinsky] This is for TCM bank 0B and bank 1B to map them to 0x00020000 so that the TCM relative addressing lines up. For example (0xffe90000 & 0x000fffff) - 0x90000 = 0x20000

Could you please explain the mapping in an in-code comment?
The comment currently mentions 0xffe9000 and 0xffeb0000 but:

- 0xffe9000 & 0x000fffff = 0xe9000
  0xe9000 - 0x90000 = 0x59000

- 0xffeb0000 & 0x000fffff = 0xeb000
  0xeb000 - 0x90000 = 0xeb000

Either way we don't get 0x20000. What am I missing?



> > > +	}
> > > +
> > > +	dma = (dma_addr_t)rsc.start;
> > 
> > Given the way the dma parameter is used by
> > rproc_alloc_registered_carveouts, I think it might be best to pass the
> > original start address (i.e. 0xffe00000) as dma.
> > 
> > 
> > > +	mem = rproc_mem_entry_init(dev, va, dma, (int)size, rsc.start,
> > > +				   NULL, zynqmp_r5_mem_release,
> > 
> > I don't know too much about the remoteproc APIs, but shouldn't you be
> > passing zynqmp_r5_rproc_mem_alloc to it instead of NULL?
> > 
> > 
> [Ben Levinsky] the difference is that for TCM we have to do make the relative address work for TCM, so the dma input to rproc_mem_entry_init is different in TCM case. 

The dma address is the address as seen by the RPU, is that right?
So you are trying to set the dma address to something in the range 0 -
0x20000?


> > > +				   rsc.name);
> > > +	if (!mem)
> > > +		return -ENOMEM;
> > > +
> > > +	return mem;
> > > +}
> > > +
> > > +static int parse_mem_regions(struct rproc *rproc)
> > > +{
> > > +	int num_mems, i;
> > > +	struct zynqmp_r5_pdata *pdata = rproc->priv;
> > > +	struct device *dev =  &pdata->dev;
> > > +	struct device_node *np = dev->of_node;
> > > +	struct rproc_mem_entry *mem;
> > > +
> > > +	num_mems = of_count_phandle_with_args(np, "memory-region",
> > NULL);
> > > +	if (num_mems <= 0)
> > > +		return 0;
> > > +	for (i = 0; i < num_mems; i++) {
> > > +		struct device_node *node;
> > > +		struct reserved_mem *rmem;
> > > +
> > > +		node = of_parse_phandle(np, "memory-region", i);
> > 
> > Check node != NULL ?
> > 
> [Ben Levinsky] will add this in v9
> > 
> > > +		rmem = of_reserved_mem_lookup(node);
> > > +		if (!rmem) {
> > > +			dev_err(dev, "unable to acquire memory-region\n");
> > > +			return -EINVAL;
> > > +		}
> > > +
> > > +		if (strstr(node->name, "vdev0buffer")) {
> > 
> > vdev0buffer is not described in the device tree bindings, is that
> > normal/expected?
> > 
> > 
> [Ben Levinsky] vdev0buffer is not required, as there might be simple firmware loading with no IPC. Vdev0buffer only needed for IPC. 

OK, good. It should probably still be described in the device tree
binding as optional property.


> > > +			/* Register DMA region */
> > > +			mem = rproc_mem_entry_init(dev, NULL,
> > > +						   (dma_addr_t)rmem->base,
> > > +						   rmem->size, rmem->base,
> > > +						   NULL, NULL,
> > > +						   "vdev0buffer");
> > > +			if (!mem) {
> > > +				dev_err(dev, "unable to initialize memory-
> > region %s\n",
> > > +					node->name);
> > > +				return -ENOMEM;
> > > +			}
> > > +			dev_dbg(dev, "parsed %s at  %llx\r\n", mem->name,
> > > +				mem->dma);
> > > +		} else if (strstr(node->name, "vdev0vring")) {
> > 
> > Same here
> > 
> > 
> > > +			int vring_id;
> > > +			char name[16];
> > > +
> > > +			/*
> > > +			 * can be 1 of multiple vring IDs per IPC channel
> > > +			 * e.g. 'vdev0vring0' and 'vdev0vring1'
> > > +			 */
> > > +			vring_id = node->name[14] - '0';
> > 
> > Where does the "14" comes from? Are we sure it is not possible to have a
> > node->name smaller than 14 chars?
> > 
> [Ben Levinsky] Presently there are only 2 vrings used per Xilinx OpenAMP channel to RPU. In Xilinx kernel we have hard-coded names as these are the only nodes that use it. For example RPU0vdev0vring0 and RPU1vdev0vring0. Hence we only check for vdev0vring and not a sscanf("%*s%i") to parse out the vring ID or other, cleaner solution.

OK, but I think it is best if we use node->name[14] only if we
explicitly check for a string of at least 14 characters. Using strstr,
it could return the string "vdev0vring" which is less than 14 chars,
leading to a bug.


> > 
> > > +			snprintf(name, sizeof(name), "vdev0vring%d",
> > vring_id);
> > > +			/* Register vring */
> > > +			mem = rproc_mem_entry_init(dev, NULL,
> > > +						   (dma_addr_t)rmem->base,
> > > +						   rmem->size, rmem->base,
> > > +
> > zynqmp_r5_rproc_mem_alloc,
> > > +
> > zynqmp_r5_rproc_mem_release,
> > > +						   name);
> > > +			dev_dbg(dev, "parsed %s at %llx\r\n", mem->name,
> > > +				mem->dma);
> > > +		} else {
> > > +			int idx;
> > > +
> > > +			/*
> > > +			 * if TCM update address space for R5 and
> > > +			 * make xilinx platform mgmt call
> > > +			 */
> > > +			for (idx = 0; idx < ZYNQMP_R5_NUM_TCM_BANKS;
> > idx++) {
> > > +				if (tcm_addr_to_pnode[idx][0] == rmem-
> > >base)
> > > +					break;
> > 
> > There is something I don't quite understand. If the memory region to use
> > is TCM, why would it be also described under reserved-memory?
> > Reserved-memory is for normal memory being reserved, while TCM is not
> > normal memory. Am I missing something?
> > 
> [Ben Levinsky] I can change this in v9 as discussed. That is, have no TCM under reserved mem. Instead have the banks as nodes in device tree with status="[enabled|disabled]" and if enabled, then try to add memories in parse_fw call.
> > 
> > > +			}
> > > +
> > > +			if (idx != ZYNQMP_R5_NUM_TCM_BANKS) {
> > > +				mem = handle_tcm_parsing(dev, rmem, node,
> > idx);
> > > +			} else {
> > > +				mem = rproc_mem_entry_init(dev, NULL,
> > > +						   (dma_addr_t)rmem->base,
> > > +						   rmem->size, rmem->base,
> > > +
> > zynqmp_r5_rproc_mem_alloc,
> > > +
> > zynqmp_r5_rproc_mem_release,
> > > +						   node->name);
> > 
> > This case looks identical to the vdev0vring above. Is the difference
> > really just in the "name"? If so, can we merge the two cases into one?
> > no, because the devm_ioremap_wc call has to be done before changing the dma address to relative for TCM banks.
> > 
> > > +			}
> > > +
> > > +			if (!mem) {
> > > +				dev_err(dev,
> > > +					"unable to init memory-region %s\n",
> > > +					node->name);
> > > +				return -ENOMEM;
> > > +			}
> > > +		}
> > > +		rproc_add_carveout(rproc, mem);
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int zynqmp_r5_parse_fw(struct rproc *rproc, const struct firmware
> > *fw)
> > > +{
> > > +	int ret;
> > > +	struct zynqmp_r5_pdata *pdata = rproc->priv;
> > > +	struct device *dev = &pdata->dev;
> > > +
> > > +	ret = parse_mem_regions(rproc);
> > > +	if (ret) {
> > > +		dev_err(dev, "parse_mem_regions failed %x\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	ret = rproc_elf_load_rsc_table(rproc, fw);
> > > +	if (ret == -EINVAL) {
> > > +		dev_info(dev, "no resource table found.\n");
> > > +		ret = 0;
> > 
> > Why do we want to continue ignoring the error in this case?
> > 
> [Ben Levinsky] as there can be simple firmware loaded onto R5 that do not have resource table. Resource table only needed for specific IPC case.

OK, an in-code comment would be good


> > > +	struct device *dev;
> > > +	struct zynqmp_r5_mem *mem;
> > > +	int ret;
> > > +	struct property *prop;
> > > +	const __be32 *cur;
> > > +	u32 val;
> > > +	int i;
> > > +
> > > +	dev = &pdata->dev;
> > > +	mem = devm_kzalloc(dev, sizeof(*mem), GFP_KERNEL);
> > > +	if (!mem)
> > > +		return -ENOMEM;
> > > +	ret = of_address_to_resource(node, 0, &mem->res);
> > > +	if (ret < 0) {
> > > +		dev_err(dev, "failed to get resource of memory %s",
> > > +			of_node_full_name(node));
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	/* Get the power domain id */
> > > +	i = 0;
> > > +	if (of_find_property(node, "pnode-id", NULL)) {
> > > +		of_property_for_each_u32(node, "pnode-id", prop, cur, val)
> > > +			mem->pnode_id[i++] = val;
> > > +	}
> > > +	list_add_tail(&mem->node, &pdata->mems);
> > > +	return 0;
> > > +}
> > > +
> > > +/**
> > > + * zynqmp_r5_release() - ZynqMP R5 device release function
> > > + * @dev: pointer to the device struct of ZynqMP R5
> > > + *
> > > + * Function to release ZynqMP R5 device.
> > > + */
> > > +static void zynqmp_r5_release(struct device *dev)
> > > +{
> > > +	struct zynqmp_r5_pdata *pdata;
> > > +	struct rproc *rproc;
> > > +	struct sk_buff *skb;
> > > +
> > > +	pdata = dev_get_drvdata(dev);
> > > +	rproc = pdata->rproc;
> > > +	if (rproc) {
> > > +		rproc_del(rproc);
> > > +		rproc_free(rproc);
> > > +	}
> > > +	if (pdata->tx_chan)
> > > +		mbox_free_channel(pdata->tx_chan);
> > > +	if (pdata->rx_chan)
> > > +		mbox_free_channel(pdata->rx_chan);
> > > +	/* Discard all SKBs */
> > > +	while (!skb_queue_empty(&pdata->tx_mc_skbs)) {
> > > +		skb = skb_dequeue(&pdata->tx_mc_skbs);
> > > +		kfree_skb(skb);
> > > +	}
> > > +
> > > +	put_device(dev->parent);
> > > +}
> > > +
> > > +/**
> > > + * event_notified_idr_cb() - event notified idr callback
> > > + * @id: idr id
> > > + * @ptr: pointer to idr private data
> > > + * @data: data passed to idr_for_each callback
> > > + *
> > > + * Pass notification to remoteproc virtio
> > > + *
> > > + * Return: 0. having return is to satisfy the idr_for_each() function
> > > + *          pointer input argument requirement.
> > > + **/
> > > +static int event_notified_idr_cb(int id, void *ptr, void *data)
> > > +{
> > > +	struct rproc *rproc = data;
> > > +
> > > +	(void)rproc_vq_interrupt(rproc, id);
> > > +	return 0;
> > > +}
> > > +
> > > +/**
> > > + * handle_event_notified() - remoteproc notification work funciton
> > > + * @work: pointer to the work structure
> > > + *
> > > + * It checks each registered remoteproc notify IDs.
> > > + */
> > > +static void handle_event_notified(struct work_struct *work)
> > > +{
> > > +	struct rproc *rproc;
> > > +	struct zynqmp_r5_pdata *pdata;
> > > +
> > > +	pdata = container_of(work, struct zynqmp_r5_pdata, mbox_work);
> > > +
> > > +	(void)mbox_send_message(pdata->rx_chan, NULL);
> > > +	rproc = pdata->rproc;
> > > +	/*
> > > +	 * We only use IPI for interrupt. The firmware side may or may
> > > +	 * not write the notifyid when it trigger IPI.
> > > +	 * And thus, we scan through all the registered notifyids.
> > > +	 */
> > > +	idr_for_each(&rproc->notifyids, event_notified_idr_cb, rproc);
> > 
> > This looks expensive. Should we at least check whether the notifyid was
> > written as first thing before doing the scan?
> > 
> [Ben Levinsky] this will be at most 2 vrings presently per firmware-load and only done when the firmware is loaded so the latency so should not impact performace or user

OK


> > > +	/* Get R5 power domain node */
> > > +	ret = of_property_read_u32(node, "pnode-id", &pdata->pnode_id);
> > > +	if (ret) {
> > > +		dev_err(dev, "failed to get power node id.\n");
> > > +		goto error;
> > > +	}
> > > +
> > > +	/* TODO Check if R5 is running */
> > > +
> > > +	/* Set up R5 if not already setup */
> > > +	ret = pdata->is_r5_mode_set ? 0 : r5_set_mode(pdata);
> > > +	if (ret) {
> > > +		dev_err(dev, "failed to set R5 operation mode.\n");
> > > +		return ret;
> > > +	}
> > 
> > is_r5_mode_set is set by r5_set_mode(), which is only called here.
> > So it looks like this check is important in cases where
> > zynqmp_r5_probe() is called twice for the same R5 node. But I don't
> > think that is supposed to happen?
> > 
> [Ben Levinsky] this is needed as there are cases where user can repeatedly load different firmware so the check is needed in cases like this where rpu is already configured. It is also possible that a user might repeatedly load/unload the module

OK

