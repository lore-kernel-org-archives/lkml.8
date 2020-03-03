Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6073DC3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 22:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2694D20848
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 22:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="WdVoeNej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgCCWaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 17:30:19 -0500
Received: from mail-eopbgr770075.outbound.protection.outlook.com ([40.107.77.75]:55407
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725796AbgCCWaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 17:30:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FG3usEO8TpBM61LPbNvqBvjyt8FcRKJLtCLc6JAfNIijtC6nws8F3P1ltreXLN3EjQBHvWZi13H4cKR12tyqzP4ac0FgaYuYz5/aQhkRWs3ZSxDz3+NmKsRNvxzBlCJsrhkkMelmRwfd7hMOUdbG7RH5PQLIj4cE2tsPBo2UaseLJ2mYbUeMoD8Z6C1DZVnKx7EvZMgI3f9+ALmP6d98CxPkkXXHn5EahXoqV+xOkMTLvFeYjLP7UvDsVAN5GcKDnrXLQoRa2/4PSWu1lX6CO+h2R+zRGOb7r2K0zpUnrOfMAzGr1pjt8BSnYrWk1lnyahrGLNwglco8ZtWMUtlW8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5L108zBW5eg6LCZFFxyABYk2mgxQhIC90mbNFBf6bB8=;
 b=JuCve9Z4/584JJuUFjH9hFHNUrBqqZ0Shhp9Tr8e47HJLPz++LgIpf0eTeMkuocvUD2bON7MwEhfz4yY8WSsZ/zMbIMa90zUEQPxWnwsXrq+ZF1gjIrGM1/lf9Q28Y0ZKyn0atDtkpPEILOCERQyBjzR4l73EQHtDVHxHAK6WQwSf0lVuGSuCoZk1ybRR8n5wmsML2/FSUmoQyb/OG4d8SMjy08UopHFJRnsREsEzP3HT2dtWb1Bmg7f5E5VL2IA4XyuqOxzFnroYEw3Fcc5IiMzw31P+/7lcUisxjMhq4nGUlNjNIqaEqpGlwVcpRvyVEKIUZKXU18hjM+BJ1qd3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=arm.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5L108zBW5eg6LCZFFxyABYk2mgxQhIC90mbNFBf6bB8=;
 b=WdVoeNejtP/t2xzh33iZgzX7kP3HhX8FujTXUREPcaRkfDWrlJfYwH++7JkUAETx55f5itM71kWD5Ek8Rey2dvfUGLGT/H5oaHdBjX8pstS4Hhlvo0CHzVhQADSvehyP2UieJu0/YEmgPKwoiLxDXBA1VYcU5zL13aZIZXcIyCU=
Received: from SN2PR01CA0072.prod.exchangelabs.com (2603:10b6:800::40) by
 SN6PR02MB5181.namprd02.prod.outlook.com (2603:10b6:805:6d::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.18; Tue, 3 Mar 2020 22:30:15 +0000
Received: from SN1NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2603:10b6:800:0:cafe::c6) by SN2PR01CA0072.outlook.office365.com
 (2603:10b6:800::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend
 Transport; Tue, 3 Mar 2020 22:30:15 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT028.mail.protection.outlook.com (10.152.72.105) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2793.11
 via Frontend Transport; Tue, 3 Mar 2020 22:30:14 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1j9G3J-0000Xq-RN; Tue, 03 Mar 2020 14:30:13 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1j9G3E-0003lV-Lz; Tue, 03 Mar 2020 14:30:08 -0800
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 023MTwrf019326;
        Tue, 3 Mar 2020 14:29:58 -0800
Received: from [172.19.160.178]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1j9G34-0003G9-34; Tue, 03 Mar 2020 14:29:58 -0800
Subject: Re: [PATCH] arch: arm64: xilinx: Make zynqmp_firmware driver optional
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Jolly Shah <jolly.shah@xilinx.com>
Cc:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com,
        rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tejas Patel <tejas.patel@xilinx.com>
References: <1582675460-26914-1-git-send-email-jolly.shah@xilinx.com>
 <20200226114601.GB8613@bogus>
From:   Jolly Shah <jolly.shah@xilinx.com>
Message-ID: <8aed558b-6ff8-5c7c-626e-17f982b12682@xilinx.com>
Date:   Tue, 3 Mar 2020 14:29:57 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200226114601.GB8613@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(376002)(39860400002)(346002)(189003)(199004)(7416002)(81156014)(44832011)(31686004)(31696002)(81166006)(8676002)(336012)(4326008)(36756003)(186003)(5660300002)(26005)(356004)(316002)(107886003)(2906002)(70206006)(478600001)(53546011)(110136005)(9786002)(70586007)(426003)(2616005)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB5181;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1db971c-dbc6-42fb-b335-08d7bfc2719e
X-MS-TrafficTypeDiagnostic: SN6PR02MB5181:
X-Microsoft-Antispam-PRVS: <SN6PR02MB5181A1D90FE8AA7685901CA8B8E40@SN6PR02MB5181.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03319F6FEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zkYRqTlypFytRXGSIbRdi5teuZVREpcejlP/ZNZHAD7x17JWXVAVu0fv/TsizYATJBoa11v//TjX4aY2pXV5TQQtkcYZXVTFDnOa7it0WzAybqhyxXTSHi+inRGhL0Prlh5NS/oa6twB2bhYvGRNyiUmUVExasjom7ubiwqieUPQUV4MmjYvzlXgw4ZvVjeLJ2mOhrInhQ+/joy+s7/UY6/rw8gTaZl5AsHLXHnZaUhItSiyHpGhJbRO8RGyDYG5yecE/WlDVF7YYr3POyYObkI6cY9vxOKxZ1TT/Jgo41xSwLoedsFGZE27Tn5I/WiVkqCfxGDVwPyNGC2nUCuKh21FvgHe1tJ8gn27PG4Xpt/XlcIDOQ+cjde+kQRLL1KjH2bSUbVQDvzI7SWX6zZG8c77+3IF4IzFiVeZThXeJYFKkznFohDO4p6nemStDR6p
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 22:30:14.5880
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1db971c-dbc6-42fb-b335-08d7bfc2719e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

 > ------Original Message------
 > From: Sudeep.holla@arm.com <sudeep.holla@arm.com>
 > Sent:  Wednesday, February 26, 2020 3:46AM
 > To: Jolly Shah <jolly.shah@xilinx.com>
 > Cc: Ard.biesheuvel@linaro.org <ard.biesheuvel@linaro.org>, 
Mingo@kernel.org <mingo@kernel.org>, 'Greg Kh' 
<gregkh@linuxfoundation.org>, Matt@codeblueprint.co.uk 
<matt@codeblueprint.co.uk>, Hkallweit1@gmail.com <hkallweit1@gmail.com>, 
Keescook@chromium.org <keescook@chromium.org>, Dmitry.torokhov@gmail.com 
<dmitry.torokhov@gmail.com>, Michal Simek <michal.simek@xilinx.com>, 
Rajan Vaja <rajanv@xilinx.com>, Linux-arm-kernel@lists.infradead.org 
<linux-arm-kernel@lists.infradead.org>, Linux-kernel@vger.kernel.org 
<linux-kernel@vger.kernel.org>, Tejas Patel <tejas.patel@xilinx.com>, 
Sudeep.holla@arm.com <sudeep.holla@arm.com>
 > Subject: Re: [PATCH] arch: arm64: xilinx: Make zynqmp_firmware driver 
optional
 >
> On Tue, Feb 25, 2020 at 04:04:20PM -0800, Jolly Shah wrote:
>> From: Tejas Patel <tejas.patel@xilinx.com>
>>
>> Make zynqmp_firmware driver as optional to disable it, if user don't
>> want to use default zynqmp firmware interface.
>>
> 
> This patch on it own is simple and looks fine. However I expect the
> single binary to work with and without this option on the same platform.
> If zynqmp_firmware is not critical, the system should continue to work
> fine either way. The zynqmp_firmware driver should gracefully exit with
> error(if any).
> 

Sure. Will address it in next version.

Thanks,
Jolly Shah


> --
> Regards,
> Sudeep
> 
