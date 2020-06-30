Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94309C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 00:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B74620781
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 00:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="omzNQ+l2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgF3Ah0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 20:37:26 -0400
Received: from mail-eopbgr770040.outbound.protection.outlook.com ([40.107.77.40]:59303
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726899AbgF3AhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 20:37:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0Vkn4/Lhx8ar2fTnDy6dNz+SpBjNX+dOgN341myQpgYsmkCVQQjgjYygkHod9kwCpEcA5XzHxlBw4lnfmxGDfl+OFZAvk8+Vti+ZliMe02hN9OlwCa1RoGXexFEl0YRJg7DLPWvfcAvJR0jy4n4CBsdAd8PiywLD6u44xrQt9UCGIiZqLEBBtBPFPELtNxiA5YxpbUzsPpZckOIw9mNHhJngmfm+uqTHugIOMfOv60bOhPenxJ6pEUBpUITvx+I7ggUZkkv/FJ8845+ZZ76HWpAh0X+xeWhgX0QxvZiiO4Su4pLxHi9yFqnXAzicWIkso37hNZnO9BlWiQygX6PuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/I4IEY3BGgm+0yi5c+G6fFoNP02lZecbmfs8IRD4+4Q=;
 b=OAw6K/GHFlI2h9D/qVPunSgA75s1r0ds+QtE71Fxctwqy4EfZiyGI+gT2NYocAgAAra+Y55hxb3uj30Yb7hAg20pXW5QZjXVH+CoLjb3fJWy9G/8kWuD5/+vdgjGF0A7ZTx4TNUn8WfDDTJSH4DvVywi+pgbxjPqZb/jE/j7xG9bzuuvkwfS/1x46xq7QPDcYHpytyRgXv/t7yxFqYEBiNf/Si09qrAQjZYOX/NCmywB3Lnu7qHVl/7z3ymTVPvSb3KF2Ywi6A8iSDxf3bQZ6GURW1Bu+RueEgZlWTsWq/ItuZmoU38w+iBfWgpZp+O4CgBJf87oVCp9jbc0i7yA1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/I4IEY3BGgm+0yi5c+G6fFoNP02lZecbmfs8IRD4+4Q=;
 b=omzNQ+l2TAoTb/eDyYt6PHNHpwFzgfrf2HV0372k/B9tXTSJcXeqh+ZdHVpBDATcMTYXVL+xQ8Dq1irMJDO355+K7uNtaZpQwYPfYaPtdQrDVLGjqCL+kHoNBsNUkCpMbLMhZXXiUyHPAzwAJLtJ7ZhfSD+xpdLSrRlKaVt8QFo=
Received: from SN4PR0501CA0079.namprd05.prod.outlook.com
 (2603:10b6:803:22::17) by DM5PR02MB3864.namprd02.prod.outlook.com
 (2603:10b6:4:b4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Tue, 30 Jun
 2020 00:37:21 +0000
Received: from SN1NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:22:cafe::39) by SN4PR0501CA0079.outlook.office365.com
 (2603:10b6:803:22::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.10 via Frontend
 Transport; Tue, 30 Jun 2020 00:37:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT032.mail.protection.outlook.com (10.152.72.126) with Microsoft SMTP
 Server id 15.20.3131.20 via Frontend Transport; Tue, 30 Jun 2020 00:37:21
 +0000
Received: from [149.199.38.66] (port=37946 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <stefano.stabellini@xilinx.com>)
        id 1jq4Fj-0005Bx-D0; Mon, 29 Jun 2020 17:35:59 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <stefano.stabellini@xilinx.com>)
        id 1jq4H2-0007Gw-S4; Mon, 29 Jun 2020 17:37:20 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 05U0bCFq011323;
        Mon, 29 Jun 2020 17:37:12 -0700
Received: from [10.23.120.6] (helo=localhost)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <stefanos@xilinx.com>)
        id 1jq4Gu-0007FO-Fx; Mon, 29 Jun 2020 17:37:12 -0700
Date:   Mon, 29 Jun 2020 17:37:12 -0700 (PDT)
From:   Stefano Stabellini <stefano.stabellini@xilinx.com>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Rob Herring <robh@kernel.org>
cc:     Ben Levinsky <BLEVINSK@xilinx.com>,
        "ohad@wizery.com" <ohad@wizery.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Michal Simek <michals@xilinx.com>,
        Jolly Shah <JOLLYS@xilinx.com>, Rajan Vaja <RAJANV@xilinx.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stefano Stabellini <stefanos@xilinx.com>
Subject: Re: [PATCH v4 4/5] dt-bindings: remoteproc: Add documentation for
 ZynqMP R5 rproc bindings
In-Reply-To: <CAL_JsqLGo380SRYska+xGgJhgF8NCRvY56ewafvSCU6c-LmhZw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2006291734370.8121@sstabellini-ThinkPad-T480s>
References: <1587749770-15082-1-git-send-email-ben.levinsky@xilinx.com> <1587749770-15082-5-git-send-email-ben.levinsky@xilinx.com> <20200511221755.GA13585@bogus> <BYAPR02MB44077C8B7B7FD23FDE8E31B8B5B00@BYAPR02MB4407.namprd02.prod.outlook.com>
 <CAL_JsqLGo380SRYska+xGgJhgF8NCRvY56ewafvSCU6c-LmhZw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(7916004)(376002)(346002)(396003)(39860400002)(136003)(46966005)(53546011)(8936002)(426003)(9786002)(478600001)(4326008)(356005)(47076004)(81166007)(54906003)(70586007)(70206006)(8676002)(5660300002)(336012)(186003)(82310400002)(2906002)(107886003)(44832011)(9686003)(6916009)(82740400003)(316002)(33716001)(26005);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f0db55e-a943-467e-a12e-08d81c8dc01b
X-MS-TrafficTypeDiagnostic: DM5PR02MB3864:
X-Microsoft-Antispam-PRVS: <DM5PR02MB386454C6F2DD409C385C27B6A06F0@DM5PR02MB3864.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0450A714CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cu0pSfqybQc1DO5SxkfkFHuMfeJCoEK0hIflMXIeltFyhVy727z/40rR8XiyJJTdIy9uNJer1z5CnaT5aReixXSwEbP4UZ6QF9bWnLJ/6jsi1NksNhzoxeN2xTKkj+5iJHzATDUCQ4Pk71nJn2dQP91Fvl8Dd7BiFL96UXxQ0rzeiDh5KqtS9YB+IwbXRfoyT74oZ8r+hQ4f9KaHNd6IdHYmorrKFX/yFIoVBOLYHqtkaDVt1zANBioANxK3OGxzfmUwJofhBkDG5PorxM8zmlqd99WFL/gspVtN4MukfVEUZJhaym+suxDQV8RaSCoVJW0x+24KlH13xkeaPuoArn91fAXGsPScWmew9WnSEc9l46DArpRrUQ6ZVJ+Scq1y+tmFOTxa0LyCMNFgUctzCw==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2020 00:37:21.1797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0db55e-a943-467e-a12e-08d81c8dc01b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT032.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3864
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jun 2020, Rob Herring wrote:
> On Tue, May 26, 2020 at 11:40 AM Ben Levinsky <BLEVINSK@xilinx.com> wrote:
> >
> > Hi Rob,
> >
> > The Xilinx R5 Remoteproc driver has been around for a long time -- admittedly we should have upstreamed it long ago. The driver in the current form is using an "classic" remoteproc device tree node as described here.
> 
> I would rather not have 2 possible bindings to maintain. If there's
> been no rush to upstream this til now, then it can wait longer.
> 
> >
> > I am working with Stefano to come up with an appropriate System Device Tree representation but it is not going to be ready right away. Our preference would be to upstream the remoteproc node and driver in their current forms while system device tree is maturing.
> 
> There's obviously going to still need to be some sort of description
> of the interface between cores, but this has parts that obviously
> conflict with what's getting defined for system DT. The TCMs are the
> most obvious. If you can remove (or hardcode in the driver) what
> conflicts, then perhaps this can be upstreamed now.


Hi Rob,

Sorry it took a while to answer back but we wanted to do some research
to make sure the reply is correct.


The System Device Tree version of the OpenAMP remoteproc bindings aims
at being simpler and vendor-neutral. As anything else System Device
Tree, Lopper will read it and generate a "traditional" device tree with
the existing remoteproc bindings. In that sense, it might not affect
Linux directly.

However, given the fragmentation of the remoteproc bindings across
multiple vendors (they are all different), I think it is a good idea for
Linux, for System Device Tree, and in general to come up with simpler
remoteproc bindings, more aligned between the vendors. If nothing else,
it is going to make Lopper's development easier.


So I think it is a good idea to take this opportunity to simplify the
Xilinx remoteproc bindings as you suggested. The idea of to removing the
TCM nodes is a good one. In addition I asked Ben to have a look at
whether the mboxes and mbox-names properties can be removed too.

Ben will reply with a simplified bindings proposal.
