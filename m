Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA0FC8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 09:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A154214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 09:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="fAK1nlvQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgD3JUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 05:20:09 -0400
Received: from mail-dm6nam10on2061.outbound.protection.outlook.com ([40.107.93.61]:62304
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726127AbgD3JUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 05:20:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNnfnr/hsGy8YYDbXPIGimkguobrVA52LTPf8nzLCwaTS0RnX2MUcm0iiFTPJM7vGlPt4GcVWcdy40MOLotn1Dy9rgrgiFj+xYuwL4eUbjDBLBwoWR4OyYcReKTa6h8piTAzn9JFEeOk2Xm2r0IIfy+LMnA91ETkOwiL+2DxPL32XbDYwU/AqBzFkMZIFKvv7DTu5tTaunzO4/GDMOOwfvEyzi3UHP1ra+hAAIrHMZYZt4PPNDGgkyNQMT0TQ3SEVRXzMKaJB4SJ0ImROfC12GhafZqIZRXUGKkUSngPvobF3adCsLupa6Uezgt5P9aJ33ryYWKx0nMSBMr5uFVukw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qn8YLC8oJATqL3feUX5n0c7fiLFXsd5y0X7y0W+GMGg=;
 b=XkCW+BI8ETs6OhvQZ/G/KunT4x7TV8++aqDI5KqtgjyHzcvxdoKQEEQfBJ00J2NXpNKmCzor0gtOGR+btyKsUwgq7c3mZKfZ8DSh1uHbhsF5MVeQ2lW9Uw+M9awK6A2tiV/u0a0hMJGfnqHPSjOwbZ/gx+J1ypzYhCHLjl1+vqJ8YJ1PdEee6p00G4qlLXf7rA2hmrh+UC9LmBoGD7XSVkrlfQvk5acapVrKixhrNOvj0qtBIRcGORe9HWF73s0VZv2tI+Yzfd9PUHDKTEy7pHqpC9EF0GbFFWvG1o6q16/yWf7yEX/uajMQPjV/jhq9kxmZ7ORuSDXnbG1Jlnj1ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=armlinux.org.uk smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qn8YLC8oJATqL3feUX5n0c7fiLFXsd5y0X7y0W+GMGg=;
 b=fAK1nlvQQBrDh4Py3CgDum2fzfi+mhANQedKeNZrGkdZ5FVu1ZBu6m5zvw9QE3EKzn4n7aczrVUDpbIicZptw0aqchl2/ZQxMAzzYv35hsQFLsvDq183hFRthNqhldvqlTHhTkXZ4SBP0gndINuYKmaT0IP232c+IZ3NMds0Fbo=
Received: from SN4PR0401CA0042.namprd04.prod.outlook.com
 (2603:10b6:803:2a::28) by BN8PR02MB5858.namprd02.prod.outlook.com
 (2603:10b6:408:bc::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 30 Apr
 2020 09:20:06 +0000
Received: from SN1NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2a:cafe::5) by SN4PR0401CA0042.outlook.office365.com
 (2603:10b6:803:2a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Thu, 30 Apr 2020 09:20:06 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; armlinux.org.uk; dkim=none (message not signed)
 header.d=none;armlinux.org.uk; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT057.mail.protection.outlook.com (10.152.73.105) with Microsoft SMTP
 Server id 15.20.2937.19 via Frontend Transport; Thu, 30 Apr 2020 09:20:05
 +0000
Received: from [149.199.38.66] (port=58982 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jU5MM-0007I8-Td; Thu, 30 Apr 2020 02:19:58 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jU5MS-00031A-SF; Thu, 30 Apr 2020 02:20:04 -0700
Received: from [172.30.17.109]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1jU5MN-0002iU-Mj; Thu, 30 Apr 2020 02:19:59 -0700
Subject: Re: [PATCH] ZYNQ: platsmp: Return -ENOMEM after a failed ioremap()
 call in zynq_cpun_start()
To:     Markus Elfring <Markus.Elfring@web.de>,
        Xu Wang <vulab@iscas.ac.cn>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Michal Simek <michal.simek@xilinx.com>
References: <9cf516c9-3a29-fb39-8943-49c906b3eea7@web.de>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <f07532ca-0bf3-7e1b-2d53-6f5555d5e451@xilinx.com>
Date:   Thu, 30 Apr 2020 11:19:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <9cf516c9-3a29-fb39-8943-49c906b3eea7@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(46966005)(2616005)(336012)(8676002)(47076004)(31686004)(44832011)(9786002)(966005)(8936002)(110136005)(54906003)(356005)(81166007)(107886003)(4326008)(82310400002)(70206006)(4744005)(70586007)(5660300002)(316002)(31696002)(426003)(26005)(186003)(82740400003)(36756003)(478600001)(2906002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5794fec-66e4-4872-bd3f-08d7ece7ab6b
X-MS-TrafficTypeDiagnostic: BN8PR02MB5858:
X-Microsoft-Antispam-PRVS: <BN8PR02MB5858792A555BBBCDF518722AC6AA0@BN8PR02MB5858.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NTIE4SRgQp5xY9HqULyDJ/dJNvUiFm8j6nrlO03W7Jkeu6qhUPCa+TdvtwfOoT1dAg/NckaBB+qkygPk3acoWjINxNzrL5hbIygte7RVB2TtNmqsrjOIJA597GtwiJ2LlcuRGX3U+Wsr4ZJUkCrSFxrnzEScGlKkGvv3UiTuz0M1PE0VjsjKfNXTzagyk8oGcDytWSY9uQ/40rR7i7/q8rBqmWYZeOgD8KC8/LhP3ZmqVx2wt1AffmQA+u3zZzIVnBaHiAtaDKWSV6jcQ4v5i1dpUJ5+3MyHS8N87LBkAhlIk7HPh84cyV3er9CLdtOScr8z8juSgFtqfMaFOZ7uWYyIMu4It7JC8WMPihUL25TxaJ5nkdgRM8NORfI8wXo/66E01nl2sm3pndNmPpvlWFEKBU+uN8bl3l8p36+gnU1yd/u2A40xj6jVSd57RghlEQw85ZH6893F/NajZWuqdBahXBqwHU7hbOmoXmYBzSFRTjbUxrMeVNPBt8PjhzLuXh/NRmGxin8+GODD1fJPsPjuSq+8sy5L9pBAFmK/M0/S6SnNGIlz3Gf8uKgN9mm7MD93Pmn3wLiwNYjUTsK4Tw==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 09:20:05.3699
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5794fec-66e4-4872-bd3f-08d7ece7ab6b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR02MB5858
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30. 04. 20 11:00, Markus Elfring wrote:
>> In ioremap we should return -ENOMEM when it reports an
>> memory allocation failure.
> 
> I suggest to improve this change description.
> 
> Will the tag “Fixes” be relevant because of the adjusted error code?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=1d2cc5ac6f6668cc15216d51051103c61467d7e8#n183

I don't think this was found by bisection because arm smp code cares
only about 0 - success and !0. I would expect any static program
analysis tool like coccinelle.

Would be good to rewrite that commit message and simply say that
failures from ioremaps returns -ENOMEM.

Thanks,
Michal

