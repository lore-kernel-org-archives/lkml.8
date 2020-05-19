Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B57C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 15:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C2EA2075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 15:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="X4vAVDCz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbgESP2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 11:28:38 -0400
Received: from mail-dm6nam10on2080.outbound.protection.outlook.com ([40.107.93.80]:12736
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726203AbgESP2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 11:28:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xm8Lpad4+2F9Ehxn0LeaaP9APl20jE0S1Jr1nDyNNkH+isVkjj2iGoBs3/8A3XlPdIMrVadj5TJHGFm/Ep1P9MyECFuc/jd2lWEIs12uETWNUHfNC6mkr4taOVTAZDeCDNFgu6xIaUut9vjPqFeIm1Jp8638poL43L/vj5l84rZCpBLFWBGIdfdroKa6JmOkEYrE8dn5gj/G0QUtbBHMCUc2iFy5rUFzP/W78sQan1A8Ed5KUsiBHoXXygNurfgLllTgFg3wesjh7rXyzwhhcqRUvCMSzgqyVP5x4W8qsx/ifVdxLa/lKGjQfuOYwr1OKSJLZFTK7lycExbdL2vXgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCkr78K4elGImNK2RCaTA/K0p1ePT4REONIl3tSsaOo=;
 b=oE4V6wxPyZy2XHWl68cC5yZFt5G1FHonghKfouB1zEBiCVRvyodGKJVS4OVxfP9rMLl1TwTCAKh6PoEwwqYMWoe3zQiaEjL/8mPE8Ts5FZDzWJWBUM7ZCI3AnEZmxJH8Q5afaywkv+QZ03dPFz82S42A955bMHk1Uh3nEdLQ/qq4sFPJ/v8hrnsWu1g+MCsauwrFOx6uREBi/ErGgxuEIFuP2df9JAt1eRdpBA6a+GS5O7Uwo4oaKXXSvP5YZBsqAs2cx2sgU8y6ET928YnIx7MVx0T5/4CjRdoMAxAVaGvfICwU0PZzawFqtxRT6IOpu7IR3gNqLGUHhULCC6YgQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=roeck-us.net smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCkr78K4elGImNK2RCaTA/K0p1ePT4REONIl3tSsaOo=;
 b=X4vAVDCzSfBH7oe1fC5EFPYvl0lxBphB21PUx1eD85I3RMNbZ5kfC9W6FRQXF0/Z7u2pPOMdSex1wnmECbSYRdGPDfx2TRMWoE14Gh+PRoKYaJIrzKEVxME9pQENzHyCKMkBBwViQJb07OZ2rO28AyHMuYLDtv5kBLhJztIWQuI=
Received: from CY4PR1701CA0005.namprd17.prod.outlook.com
 (2603:10b6:910:5e::15) by MWHPR02MB2848.namprd02.prod.outlook.com
 (2603:10b6:300:109::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Tue, 19 May
 2020 15:28:34 +0000
Received: from CY1NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2603:10b6:910:5e:cafe::3f) by CY4PR1701CA0005.outlook.office365.com
 (2603:10b6:910:5e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend
 Transport; Tue, 19 May 2020 15:28:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; roeck-us.net; dkim=none (message not signed)
 header.d=none;roeck-us.net; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT009.mail.protection.outlook.com (10.152.75.12) with Microsoft SMTP
 Server id 15.20.3000.19 via Frontend Transport; Tue, 19 May 2020 15:28:33
 +0000
Received: from [149.199.38.66] (port=48033 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jb4A2-0007Qc-QV; Tue, 19 May 2020 08:28:06 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jb4AS-0005bg-IT; Tue, 19 May 2020 08:28:32 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 04JFSS75021237;
        Tue, 19 May 2020 08:28:29 -0700
Received: from [172.30.17.109]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1jb4AO-0005b9-Jp; Tue, 19 May 2020 08:28:28 -0700
Subject: Re: [PATCH 3/3] hwmon: (ina2xx) Add support for ina260
To:     Guenter Roeck <linux@roeck-us.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Franz Forstmayr <forstmayr.franz@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20200224232647.29213-1-forstmayr.franz@gmail.com>
 <20200224232647.29213-3-forstmayr.franz@gmail.com>
 <a78bbb40-9a0c-8acc-841e-7a51447d4dbc@roeck-us.net>
 <bfa786b6-fe62-a5fb-718f-bb9e95b1f051@xilinx.com>
 <616f7b6e-0e11-7c76-3baa-5b90a0967a91@roeck-us.net>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <7e904ebe-6a59-19d8-79a6-875893aa037c@xilinx.com>
Date:   Tue, 19 May 2020 17:28:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <616f7b6e-0e11-7c76-3baa-5b90a0967a91@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(346002)(396003)(376002)(39860400002)(136003)(46966005)(54906003)(70206006)(110136005)(70586007)(31696002)(478600001)(7416002)(31686004)(82310400002)(8676002)(2616005)(356005)(36756003)(81166007)(8936002)(4326008)(5660300002)(53546011)(9786002)(316002)(26005)(336012)(2906002)(44832011)(426003)(82740400003)(47076004)(6666004)(186003)(43740500002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3a965fb-d212-4e99-7077-08d7fc094ae7
X-MS-TrafficTypeDiagnostic: MWHPR02MB2848:
X-Microsoft-Antispam-PRVS: <MWHPR02MB284865A14BBE61485A541F06C6B90@MWHPR02MB2848.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DLy8q+sNtwlLw/CNQacJ4qbWagLTsCrY4ysduTdXt+nWQz1GRDYz3NUx5/XMzZ9Us6uWJHEnDSpz16HvfPBtY3QGiQkfUAyXRlBWSIInUp/CfjgrJ+aJ6k2mWobIvvRAmdq2fSJz/X2beQWMIwXWpVApFDM9Fhb/nOmeKBNHONpFZeJDA8BpKoHWyAXBq69GTtPpGklH3yHrqbMNuUNEeuIXyi978ZcLsBeAdDmX7joFwXaDWPe79q+BJI3eF67tr3mv68qjUfXLgbaAxjboc0oN1cm+BhoONhRrGKexOmZXzelpSvs4ddWYHK6QX8G5JGOx0u2Xke2sUuE/pMPGlkKtQ/JNEIU6MHiZ5F6lQjETlEmdoH9m9aRSR4i+mwNjZ6tK73MSHCPCZ/yMgTyIKw+zgzYCkAU4PLPMgjzdVmUDLE8zRFT9JD2FuOB/DMCoOQq5dffEuO5KfBB0DUfZpV7LcnvWvsEsc71R8dXC9NP4P0Km1RSwNPvWiIs1x8mw6B6O1oP7UzD1b9BnDNrROP8/oEzDiBQrvvTIXA36fvQ=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 15:28:33.7601
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a965fb-d212-4e99-7077-08d7fc094ae7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2848
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 05. 20 16:14, Guenter Roeck wrote:
> On 5/18/20 10:21 PM, Michal Simek wrote:
>> On 26. 02. 20 3:16, Guenter Roeck wrote:
>>> On 2/24/20 3:26 PM, Franz Forstmayr wrote:
>>>> Add initial support for INA260 power monitor with integrated shunt.
>>>> Registers are different from other INA2xx devices, that's why a small
>>>> translation table is used.
>>>>
>>>> Signed-off-by: Franz Forstmayr <forstmayr.franz@gmail.com>
>>>
>>> I think the chip is sufficiently different to other chips that a separate
>>> driver would make much more sense than adding support to the existing
>>> driver.
>>> There is no calibration, registers are different, the retry logic is
>>> not needed. A new driver could use the with_info API and would be much
>>> simpler while at the same time not messing up the existing driver.
>>
>> Isn't it also better to switch to IIO framework?
>> As we discussed in past there are two ina226 drivers. One in hwmon and
>> second based on IIO framework (more advance one?) and would be good to
>> deprecate hwmon one.
> 
> "More advanced" is relative. The ina2xx driver in iio doesn't support
> alert limits (which is queued in the hwmon driver for 5.8), and the
> iio->hwmon bridge doesn't support it either. On top of that, there are
> existing users of the hwmon driver, which would have to be converted
> first. As for ina260, it would be up to the implementer to determine
> if alert limit support is needed or not, and which API would be
> appropriate for the intended use case.

Good to know. If ina260 is done as separate driver I am fine with it.

Thanks,
Michal

