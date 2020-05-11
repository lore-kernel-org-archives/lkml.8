Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE04C54E4A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA12F206F9
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="cj5fp7/o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbgEKNf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 09:35:57 -0400
Received: from mail-dm6nam10on2044.outbound.protection.outlook.com ([40.107.93.44]:3776
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729641AbgEKNf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 09:35:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AfvbPahEaklgcy2Ct14UCz8hhb/R1L3T2GSl6+aeYtlXIrsnKbQpFH0tVvK72TCQnU3nRqQBb8fdojrivjU07mZ9+Aru4JEIFJtOOZQlAMCoPYlm7Pq4GSaXfCqW1yFjdN0IYv6HJkPNmN8L5cg5MsPp6U5y1aCA2u0jCS9gQHltxed7z/esZxq0cWpo3logBW56odaD4zJUv74wgqcw84yPEwMPSQjW4EbIWgfci5kAl8WYK5kAXfu3jQ0X734288NVXZ8pIsxRrunVp/3UdWoYrdVCFa3jQKLb00UzVZ04kZLzi1LBhJivA4y1zWeS4ZTjdO4amDQJkD5P+HbFXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dflejfvhuOBN+DL3FkCbGO5Ivetq1tFbX3DPvytpa3M=;
 b=VgdHeaJKWpVLTTvoGaA23TN2KsIlVNkYxUcndmXJIkxKZ9YqbAKRowWy6zxcq6MBXOZRmdMCiBF1Y0Jg4nKNeR5fHUo47azJBCHcP78W71XRydyh+LTraVhKphe8KZhRBKDhqJ+Fx3PQl7KcGvUL1h0rYk/Z5OQX06hD+gynXc2YwMivGw3dMjcfxE4Rox8JMCbVlFGc6kAutPvAr/BpPg/RQIMh+jb20AN1crVz5RW7nEMHYLkWZmlJVJKxE0FqIe/nW6gMNNTAzmMrYKyoWjjc1jHcmHkKbLdGhiJhWit+xlMapKh/gvNKlaeSq9tuLCpflsgsMBD8H1NoN61z+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dflejfvhuOBN+DL3FkCbGO5Ivetq1tFbX3DPvytpa3M=;
 b=cj5fp7/oE50WkS2tl2san3IkU8rvvOtTVmdg7cb0YVZTacrPbsXkdvjWD7KPKYB+DuDRvlucv8LtToyPwJMkoUCObgBzKA5tpBMT0EfpvI4Zy76RRTFIqa4w6PAAT0I06CihYsabd0V5IAaIlQPekG1gF/CBr3ij2OoCwrgZEf4=
Received: from CY4PR13CA0034.namprd13.prod.outlook.com (2603:10b6:903:99::20)
 by BYAPR02MB5608.namprd02.prod.outlook.com (2603:10b6:a03:96::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.35; Mon, 11 May
 2020 13:35:53 +0000
Received: from CY1NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:99:cafe::e4) by CY4PR13CA0034.outlook.office365.com
 (2603:10b6:903:99::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.11 via Frontend
 Transport; Mon, 11 May 2020 13:35:52 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT008.mail.protection.outlook.com (10.152.75.59) with Microsoft SMTP
 Server id 15.20.2979.29 via Frontend Transport; Mon, 11 May 2020 13:35:52
 +0000
Received: from [149.199.38.66] (port=58594 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jY8an-0004YE-1F; Mon, 11 May 2020 06:35:37 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jY8b1-00074x-Vi; Mon, 11 May 2020 06:35:52 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 04BDZlqL027781;
        Mon, 11 May 2020 06:35:47 -0700
Received: from [172.30.17.109]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1jY8ax-00073g-Ah; Mon, 11 May 2020 06:35:47 -0700
Subject: Re: [PATCH v2] ARM: dts: zynq: Fix ethernet PHY for v5 schematics
To:     "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ZYNQ ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Anton Gerasimov <tossel@gmail.com>
References: <752db40d-5aed-4a97-a050-bc1376547f87@xilinx.com>
 <20200428100350.12699-1-matwey@sai.msu.ru>
 <CAJs94Eb0k-Yf7FrOJwyusBqnYvnxsbD=2vxybbSAvLg0ZJ210w@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <d836ad5a-051f-96e7-d0cd-1d53848b32b7@xilinx.com>
Date:   Mon, 11 May 2020 15:35:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAJs94Eb0k-Yf7FrOJwyusBqnYvnxsbD=2vxybbSAvLg0ZJ210w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(396003)(136003)(39860400002)(376002)(346002)(46966005)(33430700001)(70586007)(36756003)(186003)(70206006)(356005)(81166007)(2616005)(426003)(316002)(110136005)(31686004)(33440700001)(5660300002)(44832011)(82310400002)(31696002)(82740400003)(47076004)(966005)(6666004)(2906002)(8936002)(336012)(478600001)(8676002)(9786002)(26005)(130900200001)(43740500002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3d1ced1-295b-4262-5397-08d7f5b03970
X-MS-TrafficTypeDiagnostic: BYAPR02MB5608:
X-Microsoft-Antispam-PRVS: <BYAPR02MB5608DE8B6DBF6650186C2B00C6A10@BYAPR02MB5608.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 04004D94E2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dl4gG6zW6T5tFApACj8JNWVaBktRpXuIpsooLkZfm/Qs5BCC4v0haaXzApVSrTJ6BxLw+FTduQA70suP97WS/8R9RrZHN3NbLZuR3uwlwuM5uV6QxW2xw7FbffvEkXmldK20sIscZIqv4anPj3ywVjwOboCsVx/OxMcONbjOQOnHfPZq3rvHManNu5EPEhayayrYGAjz4Qc6R3am2vyJN0fEMoT1k1xR9aJf1ww/uRkUd0lfmciYcy4oFGz8GK3B44UWo9R1CVVQdo9W46oHcU0jE3GgpetGnCgGBgHen3PVwp/UM0Tqm7xGNidNFVmQaJ77hHF7VmlDFA8PCo/g5bbEYCSF8F/w0k6xF8ASwcOdIuyU8zCxKe898EAjpaFXnxiPO7ffNBXaBhQMDCJ3P0pFGL/Ys8Sq8UCE8LPqponWUBfc9JhNP0UjK7RtaHKj6OEy5tHbn/g4GLD2+AUGRVfy5+rMuVJMoXA1vfvPf2VMgEiKC/4+VEaD57FxWeiNU9X/dK/rphmtc0lOEzHXOt32Jydi8BfQ8r0FxzrR8EiOjjhMtoVgmsR9LPYxWI0jBopwLtuIOQLjDF9ESpPJVdQ4gyWU/8Y88IS0nwkiv6vSD/vu4cgJOES7DVI3MYgq/1nnwACfu+hg69kFOBZklcjpNqEpLBXCbb1jl9G4yQox5ntmLObHeOxOM3acS5zXne293x5qOyEpt2GWrLO/COuc+o1AqoAIF0svLTwqlbE=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2020 13:35:52.2836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d1ced1-295b-4262-5397-08d7f5b03970
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5608
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 01. 05. 20 18:10, Matwey V. Kornilov wrote:
> Hi Anton,
> 
> I hope you are doing good. Could you please check this patch, since
> you are initial author of zynq-zturn.dts and I suppose you do have the
> "v4" board variant to test.
> 
> вт, 28 апр. 2020 г. в 13:04, Matwey V. Kornilov <matwey@sai.msu.ru>:
>>
>> There are at least two different versions existing for MYIR Zturn:
>>
>>  * v4 schematics has Atheros AR8035 PHY at 0b000
>>      http://www.myirtech.com/download/Zynq7000/Z-TURNBOARD_schematic.pdf
>>  * v5 schematics has Micrel KSZ9031 PHY at 0b011
>>      v5 schematics available at DVD disk supplied with the board
>>
>> Specify both PHYs to make ethernet interface working for any board
>> revision. This commit relies on of_mdiobus_register() behavior.
>> When phy-handle is missed, every nested PHY node is considered,
>> while ENODEVs are ignored.
>>
>> Before the patch:
>>
>> [   28.295002] macb e000b000.ethernet eth0: Could not attach PHY (-19)
>>
>> After the patch:
>>
>> [   28.257365] macb e000b000.ethernet eth0: PHY [e000b000.ethernet-ffffffff:00] driver [Micrel KSZ9031 Gigabit PHY] (irq=POLL)
>> [   28.257384] macb e000b000.ethernet eth0: configuring for phy/rgmii-id link mode
>>
>> Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
> 
> Cc: Anton Gerasimov <tossel@gmail.com>
> 
>> ---
>> Changes since v1:
>>  - reworded commit message
>>
>>  arch/arm/boot/dts/zynq-zturn.dts | 13 ++++++++++---
>>  1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/zynq-zturn.dts b/arch/arm/boot/dts/zynq-zturn.dts
>> index 5ec616ebca08..07da9cf60d02 100644
>> --- a/arch/arm/boot/dts/zynq-zturn.dts
>> +++ b/arch/arm/boot/dts/zynq-zturn.dts
>> @@ -67,10 +67,17 @@
>>  &gem0 {
>>         status = "okay";
>>         phy-mode = "rgmii-id";
>> -       phy-handle = <&ethernet_phy>;
>>
>> -       ethernet_phy: ethernet-phy@0 {
>> -               reg = <0x0>;
>> +       ethernet-phy@0 {
>> +               compatible = "ethernet-phy-ieee802.3-c22";
>> +               reg = <0>;
>> +               max-speed = <1000>;
>> +       };
>> +
>> +       ethernet-phy@3 {
>> +               compatible = "ethernet-phy-ieee802.3-c22";
>> +               reg = <3>;
>> +               max-speed = <1000>;
>>         };
>>  };
>>
>> --
>> 2.16.4
>>
> 
> 

Anton: Waiting for your testing.

Thanks,
Michal

