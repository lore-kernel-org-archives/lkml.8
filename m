Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48F4C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B02272078B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="XndmATdh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgGJRm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 13:42:56 -0400
Received: from mail-eopbgr750084.outbound.protection.outlook.com ([40.107.75.84]:12814
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726962AbgGJRmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 13:42:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HeVfTYTvgTZxK4lCyWEZ6bZwRtkOeTFx/SFLkD/Ij97N8kh3571/twWylrMMjLjAjgvoRtMzrCTIGfpWWmGosl0+efEMJcZAET0UIsT3QwT0et4lv2cZqo1PO43Y1NWrrimHk0CUQgBctmN5Qk2E2fdFYCqX7HxEHzTwowcial1WyhXeHTMAhgfHxh+OgJ5RbpxD4I2MD5N9CiwXD3sEyfgYiy3aG7xzzwIr0FjAnZgezDNFoo+vM05VGDIGpVTRxyL7iH5EGbaqDsv1tiE9aS9T/FD6l0H7cZ42WhKEGU1bTeeZ0xqaaZzf4tF7ox6nlwexFOCno5pZevujj9J29w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7mZzv7Xl/KY/HtaYlkOQSAy9lO8krjgsxp4FLAY7sM=;
 b=YgLx5zC7Trz33FEAdb1DR2TOK6UC1VY2AuSXa1QOkabvT040Q/mtbLXWzHwGbeKuDHFCdwXppJR/ts9oYTCVVwk1ROdSBvHh1/xnFfJ6b+gjSlLP5xzS2MRbmDsLXlnmgo98IeCKbAkI+7wDhYGEa/zq36paUWMWFpwlKfqAWQ6MGGF+jYa3djWqR3i1av9hRMnVyig6Qhk/K31a0fa9nqiujbJg/zvxmnbVxdZMZch4fxN/7wjKVPOylFwlfiYvfbDp5nt+cydQfc8lLWlrYMuLBK+orxakqwWgicxygfDOrdZxBBdWgPu8vZvuY43kxn0X60eGUBtzaUQaAMShkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7mZzv7Xl/KY/HtaYlkOQSAy9lO8krjgsxp4FLAY7sM=;
 b=XndmATdh/2rnL9FJIp7oUA+mRU/1eq9YnGpAaYsq6gO1oNVk15Q84gOibSu9K6jGiO8BwqvWOi4qW1GFP0WOIrlxSp/l6D8d6jfdmKj4FL0z4Xrg+JuKHstnCngAKH3yt5NyTK3H24hZCCmL6DbSd9YXVeXxhL2dgEVgivvNHBA=
Received: from MN2PR15CA0058.namprd15.prod.outlook.com (2603:10b6:208:237::27)
 by DM5PR02MB3894.namprd02.prod.outlook.com (2603:10b6:4:b1::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Fri, 10 Jul
 2020 17:42:50 +0000
Received: from BL2NAM02FT030.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:237:cafe::81) by MN2PR15CA0058.outlook.office365.com
 (2603:10b6:208:237::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend
 Transport; Fri, 10 Jul 2020 17:42:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT030.mail.protection.outlook.com (10.152.77.172) with Microsoft SMTP
 Server id 15.20.3174.21 via Frontend Transport; Fri, 10 Jul 2020 17:42:50
 +0000
Received: from [149.199.38.66] (port=52371 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <stefano.stabellini@xilinx.com>)
        id 1jtx1N-0005rt-TG; Fri, 10 Jul 2020 10:41:13 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <stefano.stabellini@xilinx.com>)
        id 1jtx2w-0000B6-0G; Fri, 10 Jul 2020 10:42:50 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 06AHgj2Z020161;
        Fri, 10 Jul 2020 10:42:45 -0700
Received: from [10.23.120.244] (helo=localhost)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <stefanos@xilinx.com>)
        id 1jtx2q-0000AD-VH; Fri, 10 Jul 2020 10:42:45 -0700
Date:   Fri, 10 Jul 2020 10:42:44 -0700 (PDT)
From:   Stefano Stabellini <stefano.stabellini@xilinx.com>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
cc:     Stefano Stabellini <stefano.stabellini@xilinx.com>,
        Rob Herring <robh@kernel.org>,
        Ben Levinsky <BLEVINSK@xilinx.com>,
        "ohad@wizery.com" <ohad@wizery.com>,
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
In-Reply-To: <20200630022029.GC407764@builder.lan>
Message-ID: <alpine.DEB.2.21.2007101023470.4124@sstabellini-ThinkPad-T480s>
References: <1587749770-15082-1-git-send-email-ben.levinsky@xilinx.com> <1587749770-15082-5-git-send-email-ben.levinsky@xilinx.com> <20200511221755.GA13585@bogus> <BYAPR02MB44077C8B7B7FD23FDE8E31B8B5B00@BYAPR02MB4407.namprd02.prod.outlook.com>
 <CAL_JsqLGo380SRYska+xGgJhgF8NCRvY56ewafvSCU6c-LmhZw@mail.gmail.com> <alpine.DEB.2.21.2006291734370.8121@sstabellini-ThinkPad-T480s> <20200630022029.GC407764@builder.lan>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(7916004)(396003)(39860400002)(136003)(346002)(376002)(46966005)(478600001)(8676002)(26005)(5660300002)(44832011)(426003)(9786002)(336012)(186003)(2906002)(81166007)(82310400002)(356005)(9686003)(316002)(8936002)(33716001)(6916009)(83380400001)(70586007)(107886003)(54906003)(4326008)(70206006)(47076004)(82740400003);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ec5cbec-15ab-4463-9daf-08d824f8aa82
X-MS-TrafficTypeDiagnostic: DM5PR02MB3894:
X-Microsoft-Antispam-PRVS: <DM5PR02MB38940C23640C9790BF30B32AA0650@DM5PR02MB3894.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ISK0oNbGxf+sH2GYI/jLr/UkA+I/a5VQfyBQV8Wc24gvee5V8dBqPzI32t9/dL6HCZxnSFIGVoKrbRQKRN5IDqyuIdH8mYfT2HgjGy5NXdNy2V8F0f6cwkesebHNFz7BJlNfwunwuS1+0Qxbza+zmnlrEW8utTHZj0cpvRHqcGcPOFFuMqtL3LAhFJVONupNBw7CTt+BiBgypTaaKOLf++2aY8FKZB14tSVo1/6I84wyxGQaqoBiHDemDhHQfLPuBfeuZqmcLkhAm9XtDz1krYKtuncCqlW6nRqtJfwH/ai/JzTsN4F2GZ5s/dBhgBCALLyuIeTAv/WRSpV0hbxeXWVBud1omwXC8rPzGfU/eEVN6DOwsMUylMYnlyvrjGu+3Fz267LHVJYNgaBMY3zD/TO26QuwifYE3/vUYnJBYL6qMh+/nCulAR0sCL2N1Yil2mkS/oGULoWvY6shejj87yV+aL87I4tqgTLfTZLgjQ=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 17:42:50.3981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec5cbec-15ab-4463-9daf-08d824f8aa82
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT030.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3894
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the late reply, a couple of conferences kept me busy.


On Mon, 29 Jun 2020, Bjorn Andersson wrote:
> > However, given the fragmentation of the remoteproc bindings across
> > multiple vendors (they are all different), I think it is a good idea for
> > Linux, for System Device Tree, and in general to come up with simpler
> > remoteproc bindings, more aligned between the vendors. If nothing else,
> > it is going to make Lopper's development easier.
> > 
> 
> In my view the big reason for the fragmentation between bindings is
> because they all describe different hardware. There has been common
> properties of remoteprocs discussed, but apart from the firmware-name
> property I don't think we have agreed on any.

Yeah, it is as you wrote.

I meant to say that there might be room for improvement if the vendors
come together and agree on a few more common properties. However, I
don't have any concrete suggestions on this yet.  Also, as mentioned, we
can work with today's bindings just fine from a system device tree
perspective.


> Can you give some examples of how you will be able to describe the
> hardware involved in powering/clocking resources surrounding your
> remoteproc and the necessary resources in a "simpler and vendor neutral"
> way that then can be further lopped(?) into something that Linux can use
> to control any remoteproc?

The description at the system device tree level looks a bit different,
which might make the problem a bit easier, or at least different.

Let me give you some context. Lopper
(https://github.com/devicetree-org/lopper) is a tool that takes a system
device tree as input and generates one or more traditional device trees
as output (i.e. today's device tree for Linux.)

System device tree comes with the description of multiple "execution
domains" (https://connect.linaro.org/resources/ltd20/ltd20-205/) and
the ability to assign resources to each of them. That part is
vendor-neutral.  We also have the ability to define a vendor-specific
flag when assigning resources.

All together it enables us to describe an openamp/remoteproc system with
only very few vendor-specific info. I am working on a full example of an
input system device tree with openamp information and the resulting
traditional Linux devicetree. I'll make sure to reach out when I have it
ready.



> > So I think it is a good idea to take this opportunity to simplify the
> > Xilinx remoteproc bindings as you suggested. The idea of to removing the
> > TCM nodes is a good one. In addition I asked Ben to have a look at
> > whether the mboxes and mbox-names properties can be removed too.
> > 
> 
> If your remoteproc uses a mailbox for signaling, then this should be
> described in devicetree. This will allow you to reuse components in
> other designs where either part is replaced or reused.

OK
