Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92097C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 06:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59B5220773
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 06:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="osoh3xz1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390107AbgFYGkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 02:40:10 -0400
Received: from mail-co1nam11on2050.outbound.protection.outlook.com ([40.107.220.50]:6091
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727999AbgFYGkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 02:40:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHb0wlfkVfGegt7ycgch9Duqk+seEKqfmjVTb7w6ycvM9KszOmQVVg+NPtkgbM99s8OFV01SouDlrf5IHWeMAflxD0C23FEw2lytbbsYMyhMEjNKLvTZmstIXljqQ/ZmYmSmirOgiuH+q9x4OtZ1Tpwa0iHWuBO1crMTnh3xWlJfq/u1llOf3qNuNEe/cNcmy2M+9CNv7ArOkNXGGuzGx49QA2PKSSCm1gVL54oSO/w8KBtWaMXKoL4Uqrbede+cGEc4rVndDtEvIr+BIkKltyFbq48XPj8hMoqgZM1CbIEzdUTZROM36/zfqp8P//b7mVhA8QIonASqf4dvFVz9JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2W2QBLaKYU8jO1PlAsMuDCATObYhH+In1GliwTW0ztw=;
 b=mI6sq5RS4Nvc6tipXp/F8Ud1ZfpNFQOPDUnn/8djY1mioNwJds/uEUd91eA1VaaFLE0cTYf9jnkr+FPbOJP0nSHkkK3GQ4QyefL1LOkPJYETPxW289yjtwiQzSXEd5U3f+jkzGL1p5kl4l0fNpI9F6pOahs4YGfWitywJhRuAxW1AOcq5MZ2N5B7HYu5USWc6tmThIvuEHZjJzLR0/IS8Pc+0e/4kz7Tg7VZTJBODFyD/Ef6UKFbCYRY4XWm/OmiLFFbeDr52gALOhmDMc7XL8D9OD68ilrKgtY7crbebRSHbQR4NUyZBFv5zrQnbfy2UI/czuvGxGEID6IbL3J4Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=ideasonboard.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2W2QBLaKYU8jO1PlAsMuDCATObYhH+In1GliwTW0ztw=;
 b=osoh3xz16BiLifKGn7URfPYIC68BbC6ApEh+UzMJCJ8uCAg6jRi1/9pwXjgFcaRMyqr1FqX6jmeAM4lqe2GaQobvf+NczyTcxL6tPa9ohVUGDoZyBMyPGlbVA39DhAaIsDzr+HRtxdB8Go9WFYfbxQJ7fVt64denVPXK02auZ4E=
Received: from MN2PR19CA0026.namprd19.prod.outlook.com (2603:10b6:208:178::39)
 by CH2PR02MB6261.namprd02.prod.outlook.com (2603:10b6:610:e::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Thu, 25 Jun
 2020 06:40:05 +0000
Received: from BL2NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:178:cafe::5d) by MN2PR19CA0026.outlook.office365.com
 (2603:10b6:208:178::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend
 Transport; Thu, 25 Jun 2020 06:40:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; ideasonboard.com; dkim=none (message not signed)
 header.d=none;ideasonboard.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT009.mail.protection.outlook.com (10.152.77.68) with Microsoft SMTP
 Server id 15.20.3131.20 via Frontend Transport; Thu, 25 Jun 2020 06:40:04
 +0000
Received: from [149.199.38.66] (port=48911 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1joLX7-0005iB-LD; Wed, 24 Jun 2020 23:38:49 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1joLYK-0005q0-CP; Wed, 24 Jun 2020 23:40:04 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 05P6dx8F026214;
        Wed, 24 Jun 2020 23:39:59 -0700
Received: from [172.30.17.109]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1joLYE-0005f7-Ju; Wed, 24 Jun 2020 23:39:59 -0700
Subject: Re: [PATCH v8 2/3] phy: zynqmp: Add PHY driver for the Xilinx ZynqMP
 Gigabit Transceiver
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
References: <20200513172239.26444-1-laurent.pinchart@ideasonboard.com>
 <20200513172239.26444-3-laurent.pinchart@ideasonboard.com>
 <20200624151121.GF2324254@vkoul-mobl>
 <20200624163927.GF5980@pendragon.ideasonboard.com>
 <20200624172635.GI2324254@vkoul-mobl>
 <20200624211458.GA29023@pendragon.ideasonboard.com>
From:   Michal Simek <michal.simek@xilinx.com>
Autocrypt: addr=michals@xilinx.com; keydata=
 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
 0Z1MQlmNcq2bhOMzTxuXX2NDzUZs4aqEyZQ=
Message-ID: <334fc22f-2b29-7924-ed03-def63aa78d7e@xilinx.com>
Date:   Thu, 25 Jun 2020 08:39:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200624211458.GA29023@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(376002)(136003)(346002)(396003)(39860400002)(46966005)(26005)(44832011)(336012)(47076004)(186003)(9786002)(426003)(8936002)(53546011)(82740400003)(8676002)(107886003)(6666004)(2616005)(83380400001)(70586007)(4326008)(82310400002)(31696002)(5660300002)(356005)(54906003)(36756003)(316002)(110136005)(70206006)(2906002)(81166007)(31686004)(478600001)(43740500002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7fb39be-3a78-4909-b905-08d818d29841
X-MS-TrafficTypeDiagnostic: CH2PR02MB6261:
X-Microsoft-Antispam-PRVS: <CH2PR02MB626191B56D6312C4C5A54E08C6920@CH2PR02MB6261.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0445A82F82
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: no+QNLDFdiqKW7Ny72aE53C+rJgHMwEu4kux+AyN7fXabOS/iaO732BQ5hBVULLU+JJiwzNG7Ywv4rOuiT6Wdc+FMiAA7MrI/Bm/FaCSeU5bs4JpXnJ9iagLkDBVHsIzWKgTbS1hBetG39emS+DwLDxt0mS6HEnRK95sIdrDAEtX8mnNkeWETn3Fltutpe64+I14feC0QRg4dnEImvRpRi0O7kdQKac+uy30gdScmFHhtteqC4ckvB2wtbQKe87EZuGPHWG0EpkrfN5DJCa53jORWhSDqzcWtRMngLNQHCsnzOb16N4zb6XpQ7TSAZso8NB7INeuYyyDNu4CSrDLBmV13V6XKOTaBYDF4yL7f5DzDMKwxZNPK4LtYsvwA1z6zivWhknCEb8Y6eRsXxQU7O2yC7OESQtq0IJ06bHAXpvPyxEhbjFMFjzBJZo3//jl
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2020 06:40:04.9498
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7fb39be-3a78-4909-b905-08d818d29841
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6261
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent and Vinod,

On 24. 06. 20 23:14, Laurent Pinchart wrote:
> Hi Vinod,
> 
> On Wed, Jun 24, 2020 at 10:56:35PM +0530, Vinod Koul wrote:
>> On 24-06-20, 19:39, Laurent Pinchart wrote:
>>
>>>>> +/* Number of GT lanes */
>>>>> +#define NUM_LANES			4
>>>>
>>>> Should this be coded in driver like this? Maybe future versions of
>>>> hardware will have more lanes..? Why not describe this in DT?
>>>
>>> This macro is used to avoid hardcoding 4 in the driver, to make sure
>>> that all the code that deal with the number of lanes use a consistent
>>> value and is readable. There's no foreseen new version of the IP that
>>> would have more lane, so I don't think this should go in DT. Otherwise
>>> we'd have to encode there pretty much any parameter that could one day
>>> possibly change in a different universe :-)
>>>
>>> Let's also note that even when parameters change between IP versions, it
>>> doesn't always make sense to specify them explicitly in DT. It's totally
>>> fine to have a table of parameter values in the driver, indexed by
>>> compatible string. Whether to set a parameter explicitly in DT or handle
>>> it in the driver usually depends on how frequently that parameter can
>>> change, if it can vary between different integrations of the same IP
>>> version, ...
>>>
>>> In this specific case, as there's no foreseen change, we can't really
>>> tell how it would change if it did one day. I thus think hardcoding the
>>> parameter in the driver is fine, and in the worst case, we can add a
>>> parameter in DT later and default to 4 if not specified. Same reasoning
>>> for CONTROLLERS_PER_LANE.
>>
>> yeah not every parameter can be coded and we should use compatible as
>> well, but I would disagree with no future revision planned. It will
>> happen not now, but sometime in year or so :) Been around devices has
>> taught me that only constant thing is change in hardware!
> 
> I don't dispute it will not happen, my point is that, without a new
> revision planned, we don't have enough information to tell which option
> would be best to support future revisions. As I know we won't be blocked
> (both compat string matching and adding new optional properties with
> appropriate defaults will be viable options), I'm not concerned.

I also don't think this should got to DT. If there is any change in
number of lanes in future very likely there will be also different
changes connected to that as well. Then we can have discussion if makes
sense to even use this driver or write different one because of
different feature set and handling.
Also if IP doesn't change still it can become optional DT parameter with
default to 4 if not defined.

Thanks,
Michal

