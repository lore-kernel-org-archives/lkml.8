Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F397C11D01
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 07:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAEE920801
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 07:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="M9H/AKuF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgBTHB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 02:01:58 -0500
Received: from mail-bn8nam11on2047.outbound.protection.outlook.com ([40.107.236.47]:62433
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725988AbgBTHB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 02:01:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PonjCXFeVjEhTxviIbjPkwwyfRNp6BqAJBEWi9a5JY3oyr9tf+S2Zw2WPhAujUaEX3TT3iTUiH/oMRWXHPFiXdkoS8OuWjFf1zYVGV3h+X8Y0S70l3B0msnuyw7WXiwOAcLhlZX25FmQNyJ22pcmep60rrV0N/tjG18MKzxE5Oj5QMMrEmVwD3e2LrVVKTfnkznSbUjW3ZwpwBM+d44Zc8XjsaTin+G0EbdDrrWl+RgPZU/Iqq44kVnLHL+jURQxUrtcmKLJfyo/DAzF9gk7kkqtLp0W512vWskz8W43T5BpnX0x64q4S+KNVRh/u4XlBG9HydADOKYyNqQCMsQxXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVYeoOaTVSIDHX0IHThUXVneFW7KUV18IHFRWbzwEO4=;
 b=Gx59AMbxhKItVFN37CaW83JLSwM10oPcMYBOGht2wrtawdasoafFymY6Uua0fzRYdgBk99Ga4FhEq/uMGFspQ1QQ34T4UlKYFFjHpXAHer0ib3oR9wOL9URLW4QB56h4IxSK60GUXQqIx5rmylnmcL7vBBLX4PSXXZ+CVAPvtp0kPNxPbvvc+sI2SDGn79F4eWkD2hDqJK8rK1h06pUuKdc2y4cVDiMZO0I/PNF5/FUFW60Bw5V81OC4FkdhB60qcbsznK3pLkRo7dNFOk3RI2yZs/mk2WkLc+yY67g2zBxrZDNF8n234/SheX/Bs8po05hs86udujP+qzSxljhw+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVYeoOaTVSIDHX0IHThUXVneFW7KUV18IHFRWbzwEO4=;
 b=M9H/AKuF1CkF2zgpKLkTRgBnyomW67KlQZqBPJL9B6bvIwIryw8ZoHrdZMJGAkZxQ47+R8+6O+eDhn2CMCm3fNckvW/9PQgDqQ/0VDPjYjyJqck8giHHWDmY2eAjYrJvN7Xzrvo7Fg9JSZ/4aiRQKc/nl9wGY6pWlQc4QHHc1Ss=
Received: from BYAPR02CA0031.namprd02.prod.outlook.com (2603:10b6:a02:ee::44)
 by MWHPR02MB2831.namprd02.prod.outlook.com (2603:10b6:300:106::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.25; Thu, 20 Feb
 2020 07:01:50 +0000
Received: from SN1NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by BYAPR02CA0031.outlook.office365.com
 (2603:10b6:a02:ee::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.29 via Frontend
 Transport; Thu, 20 Feb 2020 07:01:50 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT028.mail.protection.outlook.com (10.152.72.105) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2750.18
 via Frontend Transport; Thu, 20 Feb 2020 07:01:49 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1j4fqH-0006qJ-6d; Wed, 19 Feb 2020 23:01:49 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1j4fqC-00009A-3S; Wed, 19 Feb 2020 23:01:44 -0800
Received: from [172.30.17.107]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1j4fqA-00007s-Ch; Wed, 19 Feb 2020 23:01:42 -0800
Subject: Re: [PATCH] devicetree: zynqmp.dtsi: Add bootmode selection support
To:     Mike Looijmans <mike.looijmans@topic.nl>,
        =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <dachaac@gmail.com>,
        robh+dt@kernel.org, michal.simek@xilinx.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Cc:     m.tretter@pengutronix.de, nava.manne@xilinx.com,
        rajan.vaja@xilinx.com, manish.narani@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200219122036.24575-1-mike.looijmans@topic.nl>
 <07c68809-f65f-91ff-62eb-f12aa8960634@gmail.com>
 <85a5807e-1d66-867f-1d83-36e8a054a511@topic.nl>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <f2592ed7-9f1b-9a23-a6bd-ed8773a7873e@xilinx.com>
Date:   Thu, 20 Feb 2020 08:01:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <85a5807e-1d66-867f-1d83-36e8a054a511@topic.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(376002)(39840400004)(396003)(199004)(189003)(8676002)(53546011)(478600001)(81166006)(70206006)(4326008)(31686004)(6666004)(356004)(2906002)(81156014)(8936002)(66574012)(2616005)(5660300002)(316002)(110136005)(9786002)(336012)(426003)(70586007)(44832011)(26005)(31696002)(36756003)(186003)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2831;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6f6677a-53ef-433f-0ae0-08d7b5d2c1ec
X-MS-TrafficTypeDiagnostic: MWHPR02MB2831:
X-Microsoft-Antispam-PRVS: <MWHPR02MB2831B47687FE6CE08495F34EC6130@MWHPR02MB2831.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 031996B7EF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d62MM8XrNEi9IG1FZ8wUpTCe/pFpsHIYKFMOKy4vTxjK1Ykk2UEKTFHmqrZGQcMZtjFegHwtGcxgxgXAkWJesuZkIn9TaEmzWSeU5fPgq2L1xAEP4f5KE1Ogxespplsg1Kzoh9BN5vNfpMgb+QxRiBnOI79rYXwcU0EcNGLayKmLnSYrBxHZ9MLwQ0uqYoXjw/LRotWhSUqrvUyaeNXXZrX7cLoYg2W6BuEzumHCiyqWcrM5V8XkIU+FbkBh2gQBSCGizdMGFkLngN2yIwicqztFP6yec/aN+TaxYbgS2Y3sTDm/AhFi7BmeyVJ7EcjgohPZ6g6+iPhXR3/V2zgLlJ6NhGlW7a/bXsRUN7xIszsha0A02rZEWB6MEjpl/4juH9N2aH+oUH1kfCE1IvWHBWAcZvtkPifQ0im610V8rmcw5oiNHDVSF1E7Vf5ShRufzrKRb9+voYiVlNJy3VR+MzffL1pktcaaYIa7ws0KmzQNT+KrTTYw5ERw4rnTp5l+
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2020 07:01:49.5964
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f6677a-53ef-433f-0ae0-08d7b5d2c1ec
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2831
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20. 02. 20 7:56, Mike Looijmans wrote:
> On 19-02-2020 19:23, Vesa Jääskeläinen wrote:
>> Hi Mike,
>>
>> On 19.2.2020 14.20, Mike Looijmans wrote:
>>> Add bootmode override support for ZynqMP devices. Allows one to select
>>> a boot device by running "reboot qspi32" for example. Activate config
>>> item CONFIG_SYSCON_REBOOT_MODE to make this work.
>>>
>>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>>> ---
>>>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 24 ++++++++++++++++++++++++
>>>   1 file changed, 24 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>>> b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>>> index 26d926eb1431..4c38d77ecbba 100644
>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>>> @@ -246,6 +246,30 @@
>>>               };
>>>           };
>>> +        /* Clock and Reset control registers for LPD */
>>> +        lpd_apb: apb@ff5e0000 {
>>> +            compatible = "syscon", "simple-mfd";
>>> +            reg = <0x0 0xff5e0000 0x0 0x400>;
>>> +            reboot-mode {
>>> +                compatible = "syscon-reboot-mode";
>>> +                offset = <0x200>;
>>> +                mask = <0xf100>;
>>> +                /* Bit(8) is the "force user" bit */
>>> +                mode-normal = <0x0000>;
>>> +                mode-psjtag = <0x0100>;
>>> +                mode-qspi24 = <0x1100>;
>>> +                mode-qspi32 = <0x2100>;
>>> +                mode-sd0    = <0x3100>;
>>> +                mode-nand   = <0x4100>;
>>> +                mode-sd1    = <0x6100>;
>>> +                mode-emmc   = <0x6100>;
>>> +                mode-usb0   = <0x7100>;
>>> +                mode-pjtag0 = <0x8100>;
>>> +                mode-pjtag1 = <0x9100>;
>>> +                mode-sd1ls  = <0xe100>;
>>
>> This kinda looks a bit misuse of reboot mode support.
>>
>> Usually you are signal with reboot-mode that you want to do factory
>> reset, enter recovery mode or such things.
>>
>> Now this signaling here is telling that this is used for selecting
>> from what device to boot from.
> 
> On the ZynqMP this is the only way to communicate with the ROM.
> 
>> Another problem is that this now modifies all Xilinx Zynq MPSoCs which
>> is kinda wrong. This behavior should really be product/board specific
>> and not common for all boards -- undoing this in product/board is
>> somewhat cumbersome. 
> 
> The boot mode setting is in the SOC, and is not board specific. The ROM
> interprets this field. The only board specific thing is that you may not
> actually have a NAND chip attached to it.
> 
> My idea was that a board could easily add say 'mode-recovery=<0x2100>;'
> to make the QPSI boot the method of recovery. The bootloader also has
> access to this register, so it can see that there was a boot mode
> override in effect.
> 
>> Now this change hijacks the "reboot <arg>" with this behavior which is
>> not so nice.
> 
> If anyone has a better suggestion as to where this should go, I'd be
> more than happy to hear about it. It's the only interface that I could
> find in the kernel to attach a bootmode override to.

IIRC as the part of PSCI 1.1 spec is SYSTEM_RESET2 where you can device
reset_type. IIRC that 0 as warm reset was coming based on discussion
with Xilinx (and maybe others) and I think this is what Xilinx is still
using. But didn't track it if that was really implemented or not.

Thanks,
Michal


