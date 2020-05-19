Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8E2C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 05:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 839692075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 05:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="SZpl8IOa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgESFVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 01:21:13 -0400
Received: from mail-mw2nam10on2083.outbound.protection.outlook.com ([40.107.94.83]:49081
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726323AbgESFVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 01:21:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKU94xMTss1wLiZUUYq0P4CeLlSgT0A61IuwTNWLdctzljWDwansS2RhCb7TGqOY+a/eWFG7TmYVaYPV/exnwuRTGxBDIc3C4toP1FurpE1rFvIv51YdaByEWBX27nRoTly3iQpkngVGHnsPLOJmLUpx1xfYbqiyZZrINjskGprPX9hgs9H1Ovt1HlsjMH+vdLuqasYRsTq6e5kbwcqVSHJiOCh9AkoYpUl8qjhRWxQFyrvpyo/wM69LQFNpRsTR6SvYJLI23AwNV2ojwovchzUEJIjvuPwIqo1vfC61SYiSeUAFcHKYHL5fXPDhpQA9Eg9Ov1DPtiVKPEQzFfCEnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13KVFf5T8nHUwFjStjhv+0mDcO2r13mojEv5YQLRWvs=;
 b=nuoff2NFtD5aI3tUEDXf7BhBPP3gu7ST7zNVxtgOa0n2qZZQf8//6/q1Akiq2EV5vSQcj8XteOqVaztabWS2ENglggcPimBsDRj955gIN7LqtNG7QwWjNYmn8M9rsQBt9NwmfQLmkATSQvQocbpTHADABE2XkfGZNbO2ta2o4zEAApPONTlo+WAAc23pIniL69uTMQIrLlq3OhiGwUGsZsIYaz0Z9ttZkMCT7TPcvULj46wWj23rugbiWk5pyAyEMCz1/xD7+y97+bnYRnt9jmDnJJeQMl+bhwhw6kM9zf6lID1qDjOWzttBIiuEz9MTEcxa9yF9UoGohTFRPRGdBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13KVFf5T8nHUwFjStjhv+0mDcO2r13mojEv5YQLRWvs=;
 b=SZpl8IOaEsP0/I1s8fp9y6mBy782WGGNWxedwW/COpreoqH8VLdZZGhHB8gRc3FuDyMAYk8dIjMgK269XJsGixV+Ll/FJw7s1673IgQBLA/KnNCsDHLAcrBYXsblJFVE/qRGp8oujAnk/xsRQothkvo8s7Lq2kXMgSUlRafb5LI=
Received: from BL0PR02CA0025.namprd02.prod.outlook.com (2603:10b6:207:3c::38)
 by SN6PR02MB5133.namprd02.prod.outlook.com (2603:10b6:805:68::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Tue, 19 May
 2020 05:21:10 +0000
Received: from BL2NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2603:10b6:207:3c:cafe::f0) by BL0PR02CA0025.outlook.office365.com
 (2603:10b6:207:3c::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend
 Transport; Tue, 19 May 2020 05:21:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT064.mail.protection.outlook.com (10.152.77.119) with Microsoft SMTP
 Server id 15.20.3000.19 via Frontend Transport; Tue, 19 May 2020 05:21:09
 +0000
Received: from [149.199.38.66] (port=45271 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jaugF-0005TM-Lb; Mon, 18 May 2020 22:20:43 -0700
Received: from localhost ([127.0.0.1] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jauge-0007gg-Rx; Mon, 18 May 2020 22:21:08 -0700
Received: from [172.30.17.109]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1jauge-0007fZ-A7; Mon, 18 May 2020 22:21:08 -0700
Subject: Re: [PATCH 3/3] hwmon: (ina2xx) Add support for ina260
To:     Guenter Roeck <linux@roeck-us.net>,
        Franz Forstmayr <forstmayr.franz@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20200224232647.29213-1-forstmayr.franz@gmail.com>
 <20200224232647.29213-3-forstmayr.franz@gmail.com>
 <a78bbb40-9a0c-8acc-841e-7a51447d4dbc@roeck-us.net>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <bfa786b6-fe62-a5fb-718f-bb9e95b1f051@xilinx.com>
Date:   Tue, 19 May 2020 07:21:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <a78bbb40-9a0c-8acc-841e-7a51447d4dbc@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(346002)(396003)(376002)(136003)(39860400002)(46966005)(5660300002)(6666004)(26005)(36756003)(82740400003)(47076004)(186003)(2616005)(8936002)(44832011)(31686004)(9786002)(70206006)(70586007)(2906002)(7416002)(356005)(82310400002)(81166007)(316002)(110136005)(54906003)(4326008)(336012)(53546011)(478600001)(8676002)(426003)(31696002)(4744005)(43740500002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d01f397-ec55-4b62-42e1-08d7fbb47050
X-MS-TrafficTypeDiagnostic: SN6PR02MB5133:
X-Microsoft-Antispam-PRVS: <SN6PR02MB51333E47A537DD4645CEEA8BC6B90@SN6PR02MB5133.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o8vNgVG5J4Luo6jjcaDgay8MdBDWiCFx6t9KxC70KWR908U5t97ZLyZUhKcPjeJlB0q0jLeSWp17h5e72ZDGM3FwCKGSxihMDq196dQ7N56yr34wrusyxwyu+QWWwWbcjoVD+Zp7fyKnQR3Rx35Fa8M0fLWaLOHsGPsidpmDJwkuFKrvPRtDTb3hFknUHqccRuh0WU6Mk6Z9QmxYQEKFfaFafyEJ7VkY9VpSJw+NCYUguncUowsJDd7JCEIt4C6Zui04vjoNHthMZcg7/mfheAxsNnR9p68viPnW2boH3/T6QA8u/zOCnqEdRcy6903ux+eZXWgwGjsF/uMCJQvPefPySlAngyvtAmO8Q8MUaWXjfVaZq4NLVN2a7IHLdPHGehN7xF/anWzcqMJZ0o4p/AEpeqPoshqL19+phYtNtUfAPQkCT2JIfFmWoDEHMs/2mslRQrEPqeAAFGZROl8Q+QUh1rOFsQo9YSR+YfxMgAc30gNOy65UZI3TucegG+WRT27zDx6EDjUjwwF5JcPhk+HFbqht8p1/OrMoeh8CRBo=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 05:21:09.2967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d01f397-ec55-4b62-42e1-08d7fbb47050
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26. 02. 20 3:16, Guenter Roeck wrote:
> On 2/24/20 3:26 PM, Franz Forstmayr wrote:
>> Add initial support for INA260 power monitor with integrated shunt.
>> Registers are different from other INA2xx devices, that's why a small
>> translation table is used.
>>
>> Signed-off-by: Franz Forstmayr <forstmayr.franz@gmail.com>
> 
> I think the chip is sufficiently different to other chips that a separate
> driver would make much more sense than adding support to the existing
> driver.
> There is no calibration, registers are different, the retry logic is
> not needed. A new driver could use the with_info API and would be much
> simpler while at the same time not messing up the existing driver.

Isn't it also better to switch to IIO framework?
As we discussed in past there are two ina226 drivers. One in hwmon and
second based on IIO framework (more advance one?) and would be good to
deprecate hwmon one.
That's why separate driver is necessary.

Thanks,
Michal

