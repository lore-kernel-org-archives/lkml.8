Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA396C3F2D6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 23:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83514206E2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 23:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="a5aN65hc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgCFX4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 18:56:04 -0500
Received: from mail-co1nam11on2065.outbound.protection.outlook.com ([40.107.220.65]:6157
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726397AbgCFX4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 18:56:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKYFgqMt6V/+aO+TennyHjGdhe2mS/J5Id45TSscA05a6LtD94dPbeuBdpqpZl9vMYsWnUYUmQCuTrSYIxDli8lDgQVQrd6QmMQ4AJFmjYfU2cNUVzDZGVjk65MvATXWV8se7z0+70dr3J1O9hUUAwfLkGEafrmn/0osMo1s9tQxntxIR3k0kQYlPBObOQY1PIrMHaEQ/zjciS4FSkewRy3YnG6UKa8wYLye7MN07Gw66QOrKiRXXPzT0SiJLscTUIjntteLg3LKMusloV2Z12b6JyOkn4Htsh4MMfW3z2WOwiMKI3710OrqxYDXL5jtmGsB4mco1ksNJtTT0ZyMsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQW6/te7yKqNqsJenJZqetPDlfW1IPRmRJPzWV7ciRI=;
 b=AznNSZws+gS3A0ISzUqoJgkX26pUERi90x7z9hBbilCVmpE61I6ocsTZXDgkglKqxbMeiYYYKHyw9HPmB+LVtybI1Kyi3AuKQnxbpJLqipXdqzmmAyfy7f3jWdr/2n3Ng6z88xw9REL2ozeyKAwBSP+UKUPrz8ZleaX1jGuEUms2H1EEDMGQtzJXyTeGRptrNSJxxxBZWh+g484r3HIZNnZfJxj77Voy1yWyA9yq2Jc9NOx+XVuT+YvRDqw5hLP8pI8EiXwNeLqrF4dBh5Nmy+JJg7pbEed5WEwTdfamRmspFvfBFuQq8Ui/Ue61mVCw/ofsA07N4knno+VSpe1WRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQW6/te7yKqNqsJenJZqetPDlfW1IPRmRJPzWV7ciRI=;
 b=a5aN65hco6bcoacg2z4JQh18sTKOurR35/U9W0wA/APmHRyubC4HVRE3YhNhM/dPChN6YL+pxL0I9TE7DOV0vGIdKBSgttnMhQHbi+ViH7ZJDRNFY+FMmdvXvIudykvjYZgM7cL7s4iPvECenS1RWRjMOp/PFf0NQEXqRcJmfrc=
Received: from MN2PR01CA0031.prod.exchangelabs.com (2603:10b6:208:10c::44) by
 MN2PR02MB6413.namprd02.prod.outlook.com (2603:10b6:208:1b6::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Fri, 6 Mar
 2020 23:56:01 +0000
Received: from BL2NAM02FT036.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:10c:cafe::77) by MN2PR01CA0031.outlook.office365.com
 (2603:10b6:208:10c::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17 via Frontend
 Transport; Fri, 6 Mar 2020 23:56:01 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT036.mail.protection.outlook.com (10.152.77.154) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2793.11
 via Frontend Transport; Fri, 6 Mar 2020 23:56:01 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jAMoy-0003gm-MG; Fri, 06 Mar 2020 15:56:00 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jAMot-0004i4-In; Fri, 06 Mar 2020 15:55:55 -0800
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 026NtkYS004488;
        Fri, 6 Mar 2020 15:55:46 -0800
Received: from [172.19.0.52]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1jAMok-0004hI-LN; Fri, 06 Mar 2020 15:55:46 -0800
Subject: Re: [PATCH v2 1/4] firmware: xilinx: Add sysfs interface
To:     "'Greg KH'" <gregkh@linuxfoundation.org>,
        Jolly Shah <jolly.shah@xilinx.com>
Cc:     Rajan Vaja <RAJANV@xilinx.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        Michal Simek <michals@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200124060339.GB2906795@kroah.com>
 <2D4B924A-D10C-4A90-A8E6-507BF6C30654@xilinx.com>
 <20200128062814.GA2097606@kroah.com>
 <4EF659A1-2844-46B9-9ED6-5A6A20401D9D@xilinx.com>
 <20200131061038.GA2180358@kroah.com>
 <BYAPR02MB40559D6B62C4532C0EAD0281B7070@BYAPR02MB4055.namprd02.prod.outlook.com>
 <20200131093646.GA2271937@kroah.com>
 <3ef20e9d-052f-665c-7fc8-69a1f8bc9bd2@xilinx.com>
 <20200214171005.GB4034785@kroah.com>
 <c2914eae-bf95-ad51-79a4-07f199f37e27@xilinx.com>
 <20200215005235.GA32359@kroah.com>
From:   Jolly Shah <jolly.shah@xilinx.com>
Message-ID: <23a785fd-3874-b71a-c0f5-d117a9058abf@xilinx.com>
Date:   Fri, 6 Mar 2020 15:55:46 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200215005235.GA32359@kroah.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(396003)(376002)(39860400002)(199004)(189003)(186003)(26005)(426003)(2616005)(2906002)(336012)(44832011)(316002)(8936002)(36756003)(110136005)(54906003)(478600001)(81166006)(356004)(81156014)(7416002)(31696002)(4326008)(70586007)(5660300002)(31686004)(9786002)(70206006)(53546011)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR02MB6413;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 856af57d-6139-42b2-cf5e-08d7c229ec9a
X-MS-TrafficTypeDiagnostic: MN2PR02MB6413:
X-Microsoft-Antispam-PRVS: <MN2PR02MB641311F76B63931B3711CF78B8E30@MN2PR02MB6413.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0334223192
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M9SXiN86G5eQ7lJwHrv83wxolBNYnWRmodGtNmR+uDXCJqri7/TaKgJcottV7HUsmk/Kx5KaN0sbaYF/2lD80fTCl9E+V+ar4ozmJ4IaINLbxq7jjkWlx3GF7Fj4B2dKDhgkptW1cXf3bTtjSRegQh2iYLT9A400CXGUWZJSkJfw9+vKMeIcltZ1LD2Pg49mHJ57GjEMOxwzpY5Z6HkHDbKYDS0u0fIqRhCZzsRhSusLQThHqgVzUhvhhvv15DinxAtlSdwiRHQwWDn9tkAIJCWXU9uawn+xLOahyDFr+7Ns8QBocNLmFWt/aGb8SOCt/LYFJkOeUe8Ay3itw+zAbztU3pOtzuaWnFmtKzcTrTjMN44/l0V9ZwXZPppyu8w7WpsSSvACIhCJ7JdmyEIQyfYLUeF50oPODNSZ0Zzul2tyrnKck3pu9reO7UmZYYwp
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2020 23:56:01.2438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 856af57d-6139-42b2-cf5e-08d7c229ec9a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6413
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

 > ------Original Message------
 > From: 'Greg Kh' <gregkh@linuxfoundation.org>
 > Sent:  Friday, February 14, 2020 4:52PM
 > To: Jolly Shah <jolly.shah@xilinx.com>
 > Cc: Rajan Vaja <RAJANV@xilinx.com>, Ard.biesheuvel@linaro.org 
<ard.biesheuvel@linaro.org>, Mingo@kernel.org <mingo@kernel.org>, 
Matt@codeblueprint.co.uk <matt@codeblueprint.co.uk>, 
Sudeep.holla@arm.com <sudeep.holla@arm.com>, Hkallweit1@gmail.com 
<hkallweit1@gmail.com>, Keescook@chromium.org <keescook@chromium.org>, 
Dmitry.torokhov@gmail.com <dmitry.torokhov@gmail.com>, Michal Simek 
<michals@xilinx.com>, Linux-arm-kernel@lists.infradead.org 
<linux-arm-kernel@lists.infradead.org>, Linux-kernel@vger.kernel.org 
<linux-kernel@vger.kernel.org>
 > Subject: Re: [PATCH v2 1/4] firmware: xilinx: Add sysfs interface
 >
> On Fri, Feb 14, 2020 at 04:37:16PM -0800, Jolly Shah wrote:
>>> Just make the direct call to the firmware driver, no need to muck around
>>> with tables of function pointers.  In fact, with the spectre changes,
>>> you just made things slower than needed, and you can get back a bunch of
>>> throughput by removing that whole middle layer.
>>>
>>
>> arm,scpi is doing the same way and we thought this approach will be more
>> acceptable than direct function calls but happy to change as suggested.
> 
> Just because one random tiny thing does it the wrong way does not mean
> to focus on that design pattern and ignore the thousands of other
> apis/interfaces in the kernel that do not do it that way :)
> 
>>> So go do that first please, before adding any new stuff.
>>>
>>> Now for the ioctl, yeah, that's not a "normal" pattern either.  But
>>> right now you only have 2 "different" ioctls that you call.  So why not
>>> just turn those 2 into real function calls as well that then makes the
>>> "ioctl" call to the hardware?  That makes things a lot more obvious on
>>> the kernel driver side exactly what is going on.
>>>
>>
>> Sure as i understand firmware driver will provide real function calls to be
>> used by user drivers and underneath it will call ioctl for desired
>> operation. Please correct if I misunderstood.
> 
> You do not misunderstand.

Submitted v3 with required changes. Please review.

Thanks,
Jolly Shah

> 
> thanks,
> 
> greg k-h
> 
