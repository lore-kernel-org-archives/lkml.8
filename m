Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB288C4BA0A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 00:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F3A20732
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 00:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="oMxFH6mk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbgBZAMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 19:12:33 -0500
Received: from mail-dm6nam11on2087.outbound.protection.outlook.com ([40.107.223.87]:31787
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728865AbgBZAMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 19:12:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVtCNw26Bse1Q1W8qmcw222gRjR63FLCJ62sROGqFa9gK1Y2V/u3+IwbErFAhKu0I7QXlgI8whEvbRMs9TosEwjGgK8Iso/2+50d/hWtFp6RHK1lUC1C3v+gvkNudqNtk9rIibCNGL+dbtAIYd9Q9bR6DuTwu6zEvUsVuAkWlOPB0a+sQtFgjmaPUMM5/dRVvKgdd2J1/n8WNz1o2Vs+ENr0aUo1goez5gcfP4teirqwzhRDbdWfREGJfvK9epQ0AIPEKtJjHKlCRJ9NV1LzTl8Ee45N1yLylOqDhtlLeRf+YmuAe/t5UPc1exvf488eUiqB8LQqD0VrYqeDAXATDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icbRTNAp9DBiFSezTuNNcnMOmlLe7vU/rmyNXWIP9rg=;
 b=cnGnxHeW4XoPQk15+puoDZ0ydT5yL7iP2l2AlepyGQ9Fe7yxqI4Y/mQP/wY8T+RfzgmLNsUxLf/tClNqZneMd/Vsfaz1Ytw9DyIe3+tVG1gCmJ+ODUlNynyDx6BRC6j01Qnf9gqUu20Oa9mj5Ki8ZVYUzNRVNQt6wDNxgBn2Ro/kMYU0vutcmNRgSfKZsbY2Z9nvSANegBj3wSQl8QyE3lvsObIf2ODFT9drqhVNXCoMWgzElJs2Dh1QvSQCZApbF5i2z7lvMpi2U6EtCMvvmSuNbcRSLVUxTwRQIOFtuaEpixBlu6iMkR3/qz5ed5FyRxli/7UzXQWgM34JJ3Vu3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icbRTNAp9DBiFSezTuNNcnMOmlLe7vU/rmyNXWIP9rg=;
 b=oMxFH6mkBDZrY+7/+H2rYzjsPAY95w56NU3ZPyE485bu+sjZC8AyvdjnyTqdvk16u/b0wBmH/1uYBSAVGiH/sRnUKzMxXfIoiOcStItiF6mdtI+FxlK94Iw389m+xcoqksB7oG7izNF4p4kYLqDG7kHtDqGPG7k1WXX3qje8J1w=
Received: from MN2PR16CA0026.namprd16.prod.outlook.com (2603:10b6:208:134::39)
 by BN7PR02MB5204.namprd02.prod.outlook.com (2603:10b6:408:2a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.22; Wed, 26 Feb
 2020 00:12:25 +0000
Received: from BL2NAM02FT030.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:134:cafe::c7) by MN2PR16CA0026.outlook.office365.com
 (2603:10b6:208:134::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Wed, 26 Feb 2020 00:12:25 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT030.mail.protection.outlook.com (10.152.77.172) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2750.18
 via Frontend Transport; Wed, 26 Feb 2020 00:12:24 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1j6kJM-0006Jv-DQ; Tue, 25 Feb 2020 16:12:24 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1j6kJH-0006af-AH; Tue, 25 Feb 2020 16:12:19 -0800
Received: from [172.19.0.52]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1j6kJB-0006a4-Cy; Tue, 25 Feb 2020 16:12:13 -0800
Subject: Re: [PATCH 2/2] arch: arm64: xilinx: Make zynqmp_firmware driver
 optional
To:     Michal Simek <michal.simek@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>, ard.biesheuvel@linaro.org,
        mingo@kernel.org, gregkh@linuxfoundation.org,
        matt@codeblueprint.co.uk, sudeep.holla@arm.com,
        hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tejas Patel <tejas.patel@xilinx.com>
References: <1578596764-29351-1-git-send-email-jolly.shah@xilinx.com>
 <1578596764-29351-3-git-send-email-jolly.shah@xilinx.com>
 <e17afc7e-c070-6134-29cb-9fa7b855bf96@xilinx.com>
From:   Jolly Shah <jolly.shah@xilinx.com>
Message-ID: <5a48a2f1-e723-62b7-36b2-1cf847f7fc2e@xilinx.com>
Date:   Tue, 25 Feb 2020 16:12:13 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <e17afc7e-c070-6134-29cb-9fa7b855bf96@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(376002)(136003)(346002)(189003)(199004)(5660300002)(70586007)(2616005)(8936002)(81156014)(8676002)(4326008)(70206006)(107886003)(81166006)(44832011)(426003)(9786002)(7416002)(356004)(31696002)(31686004)(2906002)(186003)(53546011)(336012)(110136005)(36756003)(316002)(478600001)(26005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR02MB5204;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4497a66-d041-4877-c281-08d7ba508ec6
X-MS-TrafficTypeDiagnostic: BN7PR02MB5204:
X-Microsoft-Antispam-PRVS: <BN7PR02MB5204825D8D9233083967BBDDB8EA0@BN7PR02MB5204.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0325F6C77B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: baghoHELcgUTPFir3lOt5h155KjSitE8ddMICi2ynz3xF/005r1Cmf9kqMmUzr1AfOJFW0+7+kQ4lqu0VmOPkkEg3n1ug4WtB1W7Q3MnR3NlP38XNS3hZUPVcM/qo3WRi6k2eMAaN3EPlG8JaikoadCPt4StEXJGKTjFxjdw/fSi37+F32cO7LbwMuLNRgoRMZVqZH7ktDoNQRW7tkwhXAxHALGlYN2K9CJq7pc89DwgSy2cWOFDM+5e13UynhOzI65wUvV0NEWeQR/GWILwhcg2phhRITFZDtXVOzIOttyFuoX2pNalOskgfPjyg+DrHBN5JeFAEdUpP2KGdEMt+6zBGSNHyrRQLiIU7Mf2Qsn/a9PZkU0ZC0NB8k5ir2oO2Eb5Wi+C9z33XvutFna3P1tVB8jc48YlKdffU+/cBBEvWHDn0PyYjCVmmg7uGkkK35u1ovWLI/lL3Tariw8BZGXTN8Sk4y/zFs/thdTANAnwOAR1ed7wK3DH6q8FpwMi
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2020 00:12:24.9932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4497a66-d041-4877-c281-08d7ba508ec6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5204
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

 > ------Original Message------
 > From: Michal Simek <michal.simek@xilinx.com>
 > Sent:  Monday, February 24, 2020 2:43AM
 > To: Jolly Shah <jolly.shah@xilinx.com>, Ard.biesheuvel@linaro.org 
<ard.biesheuvel@linaro.org>, Mingo@kernel.org <mingo@kernel.org>, 'Greg 
Kh' <gregkh@linuxfoundation.org>, Matt@codeblueprint.co.uk 
<matt@codeblueprint.co.uk>, Sudeep.holla@arm.com <sudeep.holla@arm.com>, 
Hkallweit1@gmail.com <hkallweit1@gmail.com>, Keescook@chromium.org 
<keescook@chromium.org>, Dmitry.torokhov@gmail.com 
<dmitry.torokhov@gmail.com>, Michal Simek <michal.simek@xilinx.com>
 > Cc: Rajan Vaja <rajanv@xilinx.com>, 
Linux-arm-kernel@lists.infradead.org 
<linux-arm-kernel@lists.infradead.org>, Linux-kernel@vger.kernel.org 
<linux-kernel@vger.kernel.org>, Tejas Patel <tejas.patel@xilinx.com>
 > Subject: Re: [PATCH 2/2] arch: arm64: xilinx: Make zynqmp_firmware 
driver optional
 >
> On 09. 01. 20 20:06, Jolly Shah wrote:
>> From: Tejas Patel <tejas.patel@xilinx.com>
>>
>> Zynqmp firmware driver requires firmware to be present in system.
>> Zynqmp firmware driver will crash if firmware is not present in system.
>> For example single arch QEMU, may not have firmware, with such setup
>> Linux booting fails.
> 
> 
> I think that moving it to firmware Kconfig is good solution. What it is
> wrong is that description above where I agree with Sudeep.
> It means.
> 1. User should have option to disable zynqmp firmware driver which is
> what this patch allows. It means if someone decides to use different
> firmware mechanism it can do it directly by simply y/n option.
> 
> 2. Autodetection of PMUFW presence is another feature which could be
> implemented to have this driver enabled but different mechanism can be
> used.
> 
> 3. Doing this because of missing feature in QEMU is IMHO wrong. QEMU
> should be fixed and then you don't have any issue if this should be used
> or not.
> 
> Just a summary. Remove that QEMU example from commit message and talk to
> Edgar to fix single QEMU solution to have that regs mapped all the time.

Pushed another patch as suggested. Will sync up with Edgar.

Thanks,
Jolly Shah

> 
> Thanks,
> Michal
> 
