Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6E7C4BA3C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 07:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 393F820732
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 07:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ozgbh7ue"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbgB0HpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 02:45:17 -0500
Received: from mail-dm6nam12on2089.outbound.protection.outlook.com ([40.107.243.89]:6124
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728385AbgB0HpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 02:45:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ii5kyFTDK2fS2Sm1mvA1RAdQPJTnKXFYq5WBSAWIKnNbIi6r2BvRGciQQKPs4Dt8X0vFKlJJn290dDySTiDLV6fZ1PQEAnYx4pQV/2n6iKFiswy6oHedX/laOGLQNhVAZrpqFP3MFUKzt1uAeg/RbGD0VSfPtALp+UNJM85DqUgqgxubEnNMoljmZPcUrCjKIRkMWtXhZuVsVMtir3DGZs++QXjqcWBTQUg1Osf93BIJh38Mkx7fLobmtzeHqbWASWY447YYge/Fnkzj+mefGM6tN0E8w/3NFtygjlbM6z1NBKIPF1zrPXflAY+Z8/+TnVjzEpdlOvW+WSPHg7a7sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akZi8cmjc/vuquXyEQCeRmFYUUHvBAj0FWnjpsQIB5g=;
 b=eh+uQUljBOKVOes1kz68BXs/f4NP0OEizJMu97tCwblFnZoFRQF0NEV9mmB/K/KWycf5ojCXutShh0aZADNlfrr90b5tLDlILJe3nZMSM8XSlZoVyD7KV7VFWKCt8saxsBOhaIW3t5v3Od3syMxCU+rJss0muWWVCbAD9l5k6oOEaGGnhoR/t55O1j/l5PTkqamvydmglMmCk0b2jG2wTiGzxdSkP7fiOZZAEAOXuPODR0gmxzyD5xxUfkvP0fokWnoo3M1I/Fi4GTamsorRkRrjYnwTvQWnfJApoNhlsgKjiiZa4EDJM3mebnE4f8SUYQ3o+tUh09tKzexYIxbwqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akZi8cmjc/vuquXyEQCeRmFYUUHvBAj0FWnjpsQIB5g=;
 b=ozgbh7ueTH7ez62MatS78SnrnGdMAIfzPHnbwL1RUtfByk0d55A/2I142WcMGwJ8GfoaPG2b3UZ6rasH4bzZoe8odHxnxp/2w5OsRHz7FIE/+sySpIQQkqIGgw0AEaNdixB8k5NUlLsyqDYKOcxnvWIK/Qrh9YpLIuOUut+1jfA=
Received: from SN1PR12CA0046.namprd12.prod.outlook.com (2603:10b6:802:20::17)
 by DM6PR02MB7066.namprd02.prod.outlook.com (2603:10b6:5:25b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Thu, 27 Feb
 2020 07:45:14 +0000
Received: from SN1NAM02FT033.eop-nam02.prod.protection.outlook.com
 (2603:10b6:802:20:cafe::e9) by SN1PR12CA0046.outlook.office365.com
 (2603:10b6:802:20::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21 via Frontend
 Transport; Thu, 27 Feb 2020 07:45:14 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT033.mail.protection.outlook.com (10.152.72.133) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2772.15
 via Frontend Transport; Thu, 27 Feb 2020 07:45:13 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1j7Dr7-0005ZU-Bp; Wed, 26 Feb 2020 23:45:13 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1j7Dr2-0004Lb-8i; Wed, 26 Feb 2020 23:45:08 -0800
Received: from [172.30.17.108]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1j7Dqs-00042E-9d; Wed, 26 Feb 2020 23:44:58 -0800
Subject: Re: [PATCH] ARM: dts: zynq: Add support for Z-turn Lite board
To:     =?UTF-8?Q?Joni_Lepist=c3=b6?= <joni.m.lepisto@gmail.com>,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     Michal Simek <michal.simek@xilinx.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20200226090337.16065-1-joni.m.lepisto@gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <5e1b9f81-af5c-3091-5d62-ea2d938bae83@xilinx.com>
Date:   Thu, 27 Feb 2020 08:44:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200226090337.16065-1-joni.m.lepisto@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(136003)(376002)(396003)(199004)(189003)(2616005)(70586007)(70206006)(9786002)(426003)(31696002)(316002)(4326008)(31686004)(44832011)(6666004)(356004)(8936002)(36756003)(4744005)(8676002)(26005)(186003)(81156014)(478600001)(81166006)(5660300002)(336012)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB7066;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74095eaa-2d58-40bd-55e6-08d7bb58fafa
X-MS-TrafficTypeDiagnostic: DM6PR02MB7066:
X-Microsoft-Antispam-PRVS: <DM6PR02MB70663E8770A9EFB0691533EBC6EB0@DM6PR02MB7066.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03264AEA72
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +r8l93wR/mHolSjyOi0u+PajAz3zn6X0B3GlufAFDSwUkYvyjk9a/uyCaVTIhRSo2ibsSsmqAc8q9VqI73nqc5GOYbmiEFARn71zSg6hjBeYtzx8JipadPsZCIgZKmNbeOQB0320Q0MlROcRKXkNSGSLTqXqhQOiOSM8jKRPx8dw9/nJYlvgF0eadqex6YrJy1SuqFon/mrHzrTXNHuoQoKAW4mvcdchUn/+6yoZMYobsHnR4wATU1WTy3bep8bCzR9v6lP86ck+hhemcOuy1p7qSCN1pC+fR38mng9PtoPh+pzVtHGFMUVJ/C5MigTy0zrYQcTY4ztgJ+6ORJiwh4I0b+L1AQ6IKZluS3xPBhAdQS/sxIRT3YQU2KqDdMjDYoB/9YJ48KKD3hhsVNIxBt7+VGC5fExXdv40/fXodY8YNC6rNhXdTYkpviLZl/x2
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 07:45:13.7319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74095eaa-2d58-40bd-55e6-08d7bb58fafa
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB7066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26. 02. 20 10:03, Joni Lepistö wrote:
> Add a dts for MYIR Z-turn Lite and respective target in Makefile
> based on the existing Z-turn dts which is compatible except for
> memory size.

Just a side note - I can't see any reason to duplicate the whole dts
file if it is just the same - you can simply #include "zynq-zturn.dts"
and then change/rewrite things.

Second thing is that myir,zynq-zturn is not even listed in any yaml
binding file that's why dtbs_check will fail.

I expect you use standard boot flow via u-boot which can detect and
update memory size automatically for you. It means for kernel you can
even place there <0 0> and u-boot will fill it.

Just a summary I don't think it is worth to add support to this board in
Linux. And in U-Boot you should enable memory autodetection and you will
get support for this lite board for free.

Thanks,
Michal
