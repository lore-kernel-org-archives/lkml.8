Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F36C761A6
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 611D524654
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="mBcYNJ8p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgBTGuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 01:50:01 -0500
Received: from mail-bn8nam12on2062.outbound.protection.outlook.com ([40.107.237.62]:45696
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725962AbgBTGuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 01:50:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTIjvXa+HPp/ZZuON0b/rv8SOCGO/AXJ88LR7lLpHpQgwRu8QVr0b7kdkQufxAdyK80mNdBWsIvYxMxiYHrMkHW5n7yxDGGaocejW513elcKUHy2jYAbYEM15uBSMkAeqZmC54Q2wU7WCAZXb+YF0jMH6qd1DNw4aMSxfWdxTp7aMzm44wd320dxwYupNizzwzGd4KRDc2hmdIZ6aBN7PCCo1f5sFr2dSsnXPOpC5SjWRiW6EDXGlhQ7Mieaey+76Hcm/Wfa02rs4YjlLA9qJm86uuEQRV5HPqa1SmGN6zoIB1C6rXOFLM+heSQCHalj0Pkpd31vwdAdPEbBVGWjcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXLgZpHCEkMlKmPNIY7+T33KTM2AwgvQZWiEu5zQDjE=;
 b=EXCriE83QcG0poO9q78SYNcBDoQ687jD1nRDF2SMECViVmS0dbrpJLdqkU2C36j4yKjza0vnoLLHJeMuOQNGzo+zFBno3ZgXE9kTlZiEbXQUaQUNZ70HricSkMEwXSyH4ne9a6Rd6z+CFTrwlt/jMspqC5Z5pfjVQRd4Sqwwie6Vb62QCbeBHme+y8eRYGn3iPBMBP0IYvRwjD42/h4mjIfsn4rv4EXF0T2dVEWx5kKcWso72Au+2x/WBcPzvYuchGYaLF7aDRmEO4wKEcCM9lFTLgV4P6FRJbWCqpWH71r+39FkvR5U36Ct6jFdARV6JQVo3/wqSXjQGK4WdvWxeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXLgZpHCEkMlKmPNIY7+T33KTM2AwgvQZWiEu5zQDjE=;
 b=mBcYNJ8pMpwaKodHmKGKI37g1lWl2mNxkb38PFLYpEziPYvnpe4pX0g7a6EFEjoaxS9utl5p4SdQmOIx+oEb6DGUu6mzpfLeV/HLanSVvpzbH1ws2e2ICE7aGvI1pHIeXCpQlhnIrzPQfAONXWJah2+pQEonhSA8s/fGyDTO/Dg=
Received: from SN4PR0201CA0055.namprd02.prod.outlook.com
 (2603:10b6:803:20::17) by SN6PR02MB5485.namprd02.prod.outlook.com
 (2603:10b6:805:ed::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.23; Thu, 20 Feb
 2020 06:49:56 +0000
Received: from SN1NAM02FT038.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by SN4PR0201CA0055.outlook.office365.com
 (2603:10b6:803:20::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.31 via Frontend
 Transport; Thu, 20 Feb 2020 06:49:56 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT038.mail.protection.outlook.com (10.152.72.69) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2750.18
 via Frontend Transport; Thu, 20 Feb 2020 06:49:55 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1j4fel-0006Oy-AT; Wed, 19 Feb 2020 22:49:55 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1j4feg-00039T-7L; Wed, 19 Feb 2020 22:49:50 -0800
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 01K6nlGV018675;
        Wed, 19 Feb 2020 22:49:47 -0800
Received: from [172.30.17.107]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1j4fed-000392-08; Wed, 19 Feb 2020 22:49:47 -0800
Subject: Re: [PATCH] devicetree: zynqmp.dtsi: Add bootmode selection support
To:     =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <dachaac@gmail.com>,
        Mike Looijmans <mike.looijmans@topic.nl>, robh+dt@kernel.org,
        michal.simek@xilinx.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Cc:     m.tretter@pengutronix.de, nava.manne@xilinx.com,
        rajan.vaja@xilinx.com, manish.narani@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200219122036.24575-1-mike.looijmans@topic.nl>
 <07c68809-f65f-91ff-62eb-f12aa8960634@gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <882048d4-9095-1555-935a-335bb96869f2@xilinx.com>
Date:   Thu, 20 Feb 2020 07:49:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <07c68809-f65f-91ff-62eb-f12aa8960634@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39830400003)(346002)(136003)(376002)(396003)(199004)(189003)(44832011)(2906002)(426003)(336012)(2616005)(31686004)(5660300002)(66574012)(70206006)(70586007)(478600001)(9786002)(36756003)(8676002)(81156014)(81166006)(356004)(6666004)(8936002)(110136005)(31696002)(316002)(186003)(4326008)(26005)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB5485;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa530cda-d640-40de-6dbf-08d7b5d11869
X-MS-TrafficTypeDiagnostic: SN6PR02MB5485:
X-Microsoft-Antispam-PRVS: <SN6PR02MB5485F04514AAE25AACCFEC47C6130@SN6PR02MB5485.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 031996B7EF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j66AKZPnIY0e537u+osR+QKndfBTlvflqNe821xOscL+Ac/idSB0bDfiKarkFWsDEVLWudlISrxhxEWFhBWF2Tsdr0zMnQuVcB1j7daLwl2CguN66RS2yQRAOmxLe3WoGUDYpvlQOIqN21jubUheoAVN+6c/s6xvA/Gz1W/NWNqeN0qY4m6gJ8SZlxgKaKAtKQv3narvPEFgL6753Gh3UxzJfO5JbS/Mt7Q5Dez5FEstVJ6pUc/Aw5xpdlqUEpH7moTvELdQ24Y0L44hSbkA7PeubQVcFtmOz0Bu+Ma4loj7M1hCX4aqJiehJuQyCJzX4DcgifCXrOBOqlNufZnDpR5qmkxPV7RnU0P3PDxQnB0oUiRJl0XbB9q6svCK9U88xSDcIPr2xth2PILQDbuAsh5ksK5wyb83Sm96WC1eFRsT2ISy6l2OFqBAFthjVj9LMbouRuJ8+MoUxhkBfQFdaSWrrZYU2HSycw8/MIOdeTnSHt/fzKZFTo1M8xJwNyZs
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2020 06:49:55.7098
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa530cda-d640-40de-6dbf-08d7b5d11869
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5485
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 02. 20 19:23, Vesa Jääskeläinen wrote:
> Hi Mike,
> 
> On 19.2.2020 14.20, Mike Looijmans wrote:
>> Add bootmode override support for ZynqMP devices. Allows one to select
>> a boot device by running "reboot qspi32" for example. Activate config
>> item CONFIG_SYSCON_REBOOT_MODE to make this work.
>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>> ---
>>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 24 ++++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> index 26d926eb1431..4c38d77ecbba 100644
>> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> @@ -246,6 +246,30 @@
>>               };
>>           };
>>   +        /* Clock and Reset control registers for LPD */
>> +        lpd_apb: apb@ff5e0000 {
>> +            compatible = "syscon", "simple-mfd";
>> +            reg = <0x0 0xff5e0000 0x0 0x400>;
>> +            reboot-mode {
>> +                compatible = "syscon-reboot-mode";
>> +                offset = <0x200>;
>> +                mask = <0xf100>;
>> +                /* Bit(8) is the "force user" bit */
>> +                mode-normal = <0x0000>;
>> +                mode-psjtag = <0x0100>;
>> +                mode-qspi24 = <0x1100>;
>> +                mode-qspi32 = <0x2100>;
>> +                mode-sd0    = <0x3100>;
>> +                mode-nand   = <0x4100>;
>> +                mode-sd1    = <0x6100>;
>> +                mode-emmc   = <0x6100>;
>> +                mode-usb0   = <0x7100>;
>> +                mode-pjtag0 = <0x8100>;
>> +                mode-pjtag1 = <0x9100>;
>> +                mode-sd1ls  = <0xe100>;
> 
> This kinda looks a bit misuse of reboot mode support.
> 
> Usually you are signal with reboot-mode that you want to do factory
> reset, enter recovery mode or such things.
> 
> Now this signaling here is telling that this is used for selecting from
> what device to boot from.
> 
> Another problem is that this now modifies all Xilinx Zynq MPSoCs which
> is kinda wrong. This behavior should really be product/board specific
> and not common for all boards -- undoing this in product/board is
> somewhat cumbersome. Now this change hijacks the "reboot <arg>" with
> this behavior which is not so nice.

Another reason is that on arm64 these regs shoulnd't be accessed by non
secure software and you should setup protection not to enable it.

If this functionality is useful for your design please keep it in your
board dts file.

Thanks,
Michal


