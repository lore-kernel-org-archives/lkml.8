Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF1FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 23:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B39E22B3F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 23:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="kWBlJYhj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgGaXDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 19:03:48 -0400
Received: from mail-co1nam11on2056.outbound.protection.outlook.com ([40.107.220.56]:10369
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726215AbgGaXDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 19:03:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKZhBwgKRACXJSXsygdiwBfB1RMUQ9/wc9PTSn3cRkYK9CDh/RW8nM/TtlBrxJ8gqmv0j6UuS3r07g2HZ8vDWVgQiBh8JnAb/w/unY8GjyOvYpcsuf2Qa1y+4YotcS1LszUOGvvC9udnOgYmTjnk2QR8WGg835tnX6IiTL6jhv0qnYWmAnuXJsyaFY83Kuto1DAoQKpUM8ndVm1BEqSSJtFUR3OMnbTbd3eO4pIIAHONxcFYBOpO7jhYH0A67K5LPIrdLGkiUzinGpNYpvgWYtB5pdtE+H99qL+ccmZmFU6GWH1s4DKlEyziK+3NBcYpBvpLsYKwB/h6B6JYl4OiDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alQ8S84XnD7wvc1d1fVM8KAP83Iy0kZJR2Zpg7Dq75I=;
 b=mexvUkwkBZ/1vbWy1c1zppVCrHW26aqlPNSil5HF2XkwK0EHJcy9rAwUC2/uzcSR+uZtx24eokA8UaNJvLa+jy/st1Yb8br/6oiOpeAZzoIzSykf8ZfH2oJ1HEy2Y+zr3h1TRGpFp9LI2jc23NB2QlOym8s3ZPWS9SHHmLdn55rPptBUkvHKOzk+WuxeE9xQd9d3HQkM/7bnXKtwOQ3G7FX+a3I3Nc3qja4eMWoApFgCrNxa0dKVWaiYk3jIQyEcykNrThXeAfQEL59MkvqYpV9HwsSDpt00LHh+tt16M82egKHBPIRW4W85InrGdDw8TrNCce09aDkJPlNbpp1iGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alQ8S84XnD7wvc1d1fVM8KAP83Iy0kZJR2Zpg7Dq75I=;
 b=kWBlJYhjVa0g/Sjf2zi2qJnpKhoj6iFX0vcXEslsZTSd3albn3hYX9+SiJAs/dfQMO7cRnLEpBftbyiMG/BugxM0wbb8ILpy67SlRvt832Q0mih063MkSCHnThaJZ8LlzHAhTuX3yuHUhE269i3/lCYk7rpn1FUH5Jae1kejr80=
Received: from DM5PR21CA0011.namprd21.prod.outlook.com (2603:10b6:3:ac::21) by
 BYAPR02MB4822.namprd02.prod.outlook.com (2603:10b6:a03:48::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.21; Fri, 31 Jul 2020 23:03:44 +0000
Received: from CY1NAM02FT031.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:ac:cafe::f8) by DM5PR21CA0011.outlook.office365.com
 (2603:10b6:3:ac::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.3 via Frontend
 Transport; Fri, 31 Jul 2020 23:03:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT031.mail.protection.outlook.com (10.152.75.180) with Microsoft SMTP
 Server id 15.20.3239.17 via Frontend Transport; Fri, 31 Jul 2020 23:03:43
 +0000
Received: from [149.199.38.66] (port=37155 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <stefano.stabellini@xilinx.com>)
        id 1k1e1x-0000TN-I9; Fri, 31 Jul 2020 16:01:37 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <stefano.stabellini@xilinx.com>)
        id 1k1e3z-0000Xe-HT; Fri, 31 Jul 2020 16:03:43 -0700
Received: from [10.23.121.225] (helo=localhost)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <stefanos@xilinx.com>)
        id 1k1e3u-0000VV-4n; Fri, 31 Jul 2020 16:03:38 -0700
Date:   Fri, 31 Jul 2020 16:03:37 -0700 (PDT)
From:   Stefano Stabellini <stefano.stabellini@xilinx.com>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
cc:     Ben Levinsky <ben.levinsky@xilinx.com>, ohad@wizery.com,
        bjorn.andersson@linaro.org, michals@xilinx.com, JOLLYS@xilinx.com,
        RAJANV@xilinx.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernell@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jliang@xilinx.com,
        stefanos@xilinx.com, Wendy Liang <wendy.liang@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ed Mooring <ed.mooring@xilinx.com>, Jason Wu <j.wu@xilinx.com>
Subject: Re: [PATCH v6 5/5] remoteproc: Add initial zynqmp R5 remoteproc
 driver
In-Reply-To: <20200728210002.GA2413713@xps15>
Message-ID: <alpine.DEB.2.21.2007311104400.1767@sstabellini-ThinkPad-T480s>
References: <20200715153317.25643-1-ben.levinsky@xilinx.com> <20200715153317.25643-6-ben.levinsky@xilinx.com> <20200728210002.GA2413713@xps15>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68154215-d20d-4532-309e-08d835a5f919
X-MS-TrafficTypeDiagnostic: BYAPR02MB4822:
X-Microsoft-Antispam-PRVS: <BYAPR02MB482247E9027BA7EC2E7486ACA04E0@BYAPR02MB4822.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lkGHS6K758r/Ay/lFLjrc4t9ttMgDZsqbarGaMcPpD56kRCECEsC9FJzAqAClVrBZgVH2aS18moFaS5S3OCiXuRgD/6RTyPLF5Q4QLj+rv/PaZQYlA0RcPqDpouzxFXisb+xnSqg1RPWpDYFoVoim1P2tWCnhV7u0oLLr5hrUOcycrJ/qWqnHompPacLHtivbmPRv2xGtMXuS+FpJBv2ZWm18xyZlfVpyrmVLujBtrKKOVdL5uuGlqnRk5yfcVhpN0oW6+6Om4/bMXyug/6HDItng65xEwInxQMZyNfp80ejoUlp+ge6n58lnbdyo+WCAgvhD83vS8/36QWz9uW3pgerojYmd5ZIVLmwQcLtFaZgn5E9JX8C85Qrx0w8VQ8all0dONnTN4plyXBsLGKgsg==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(7916004)(39860400002)(376002)(136003)(346002)(396003)(46966005)(47076004)(70206006)(82740400003)(54906003)(316002)(82310400002)(26005)(5660300002)(70586007)(2906002)(4326008)(8936002)(426003)(44832011)(6916009)(107886003)(33716001)(8676002)(9786002)(356005)(83380400001)(186003)(81166007)(9686003)(478600001)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2020 23:03:43.7858
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68154215-d20d-4532-309e-08d835a5f919
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT031.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jul 2020, Mathieu Poirier wrote:
> On Wed, Jul 15, 2020 at 08:33:17AM -0700, Ben Levinsky wrote:
> > R5 is included in Xilinx Zynq UltraScale MPSoC so by adding this
> > remotproc driver, we can boot the R5 sub-system in different
> > configurations.
> > 
> > Acked-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
> > Acked-by: Ben Levinsky <ben.levinsky@xilinx.com>
> > Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> > Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
> > Signed-off-by: Wendy Liang <wendy.liang@xilinx.com>
> > Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> > Signed-off-by: Ed Mooring <ed.mooring@xilinx.com>
> > Signed-off-by: Jason Wu <j.wu@xilinx.com>
> > Tested-by: Ben Levinsky <ben.levinsky@xilinx.com>

[...]

> > +static int zynqmp_r5_remoteproc_probe(struct platform_device *pdev)
> > +{
> > +	int ret, i = 0;
> > +	u32 *lockstep_mode;
> > +	struct device *dev = &pdev->dev;
> > +	struct device_node *nc;
> > +	struct zynqmp_r5_pdata *pdata;
> > +
> > +	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> > +	lockstep_mode = devm_kzalloc(dev, sizeof(u32 *), GFP_KERNEL);
> > +	if (!pdata || !lockstep_mode)
> > +		return -ENOMEM;
> > +
> > +	platform_set_drvdata(pdev, pdata);
> 
> As far as I can tell the above, along with allocating memory for @pdata, is not
> needed since zynqmp_r5_remoteproc_remove() uses rpus[].
> 
> I have only reviewed the _probe() function and already encountered a fair amount
> of fundemantal errors.  As such I will stop my review here. I will need to see a
> reviewed-by tag (on the mailing list) by Stephano or Michal before reviewing the
> next set. 

Let me take this opportunity to say that my Acked-by on this version of
the series was an unintentional miscommunication: I didn't give my
Acked-by as I haven't even read the patches yet.

I'll circle back with Michal and we'll make sure for either of us to do
a round of public reviews on the next version.
