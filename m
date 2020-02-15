Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D79C3B1BF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 00:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64101217F4
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 00:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="rOfyZAp/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgBOAhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 19:37:35 -0500
Received: from mail-bn8nam11on2062.outbound.protection.outlook.com ([40.107.236.62]:16914
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727567AbgBOAh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 19:37:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lal7GOGfXlyyecBOkkKwzAZ5BEFFEGWsOsfDJxDeIw2gVFts4NSumRXML9a41W5YRwUvQNCl03PTR9psLZbN4lkdwwUdUrTkzYBZYa/p2L4GbOyL2M6PIBtvy3mnQXDlNpGP5SMtJM2kS4PsIUWim+aM3awFF4qPAu//PR2fhkSQn0OwLJFk0mab380eoLTKikaX9Kjhvfy8brBk2HvB6D0uMXUB4soeBBFcLg0DOou82bfu66wyrZ83qxwKW+/6rlIVkHZzWYWX2bRuJLGwW7mSqEaNzniAWfuC850izv7EJRWUVZ4RS9uUzNM2K+eU4xHhKC4Cn0PamD3Evrq3yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTVZuSyp8EMT2HKD39vRBzg/EbHKvnw/CY36uQpP5mc=;
 b=KMHvStgpa1hp5NCDmtm9+0TW9OeM6PKntj45erv6WEu+LzJohgjEdthv8c7cxwJdTTVHZcS5/fhIx1c2yntQ9SGc/XdbYJkMaNE7zOW2mGX+TcguffbGZcxXqv2KnakD18SS2w/RnOHYXBR0nMYtQqIWy3BniIF7fQIVMpvVo/bF8rKlr+VAaAU/5kjuG83Z5dA/+/ikTFywDf/A9K4CwcVA3wCdLvLgEth33Vsj+vEp9/dc/RzgGnajPA39JSFazUnRDztF/tj7O2BFLbxebdtytnve6uMlLtxyyBH3oGocOwBTyOjDj+YmDPfN/e4QJYqM+xNgc/0XqbcTJIH+uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTVZuSyp8EMT2HKD39vRBzg/EbHKvnw/CY36uQpP5mc=;
 b=rOfyZAp/T8gYqcy6ZrHZMdNqs9BV7xJNPG+noCvuAJa0y8KumBCber18ZGz7aSDhhERN0P7/9Eh7rYxAaKwRFfyHRnsX/JWKQgSYEsvAXxg61E4QxrwFct+2BByZOssXCIqImSTyrf53Ejzg10U3SB8LMYO8QzCKKS2Y+cnuFYk=
Received: from BN6PR02CA0039.namprd02.prod.outlook.com (2603:10b6:404:5f::25)
 by MN2PR02MB6000.namprd02.prod.outlook.com (2603:10b6:208:112::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.23; Sat, 15 Feb
 2020 00:37:26 +0000
Received: from SN1NAM02FT035.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by BN6PR02CA0039.outlook.office365.com
 (2603:10b6:404:5f::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22 via Frontend
 Transport; Sat, 15 Feb 2020 00:37:26 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT035.mail.protection.outlook.com (10.152.72.145) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2729.22
 via Frontend Transport; Sat, 15 Feb 2020 00:37:25 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1j2lSX-00053z-Gm; Fri, 14 Feb 2020 16:37:25 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1j2lSS-0005cp-Cz; Fri, 14 Feb 2020 16:37:20 -0800
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 01F0bGLX010039;
        Fri, 14 Feb 2020 16:37:16 -0800
Received: from [172.19.0.52]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1j2lSO-0005cd-J1; Fri, 14 Feb 2020 16:37:16 -0800
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
References: <20200114145257.GA1910108@kroah.com>
 <BYAPR02MB5992FC37E0D2AD9946414417B80F0@BYAPR02MB5992.namprd02.prod.outlook.com>
 <20200124060339.GB2906795@kroah.com>
 <2D4B924A-D10C-4A90-A8E6-507BF6C30654@xilinx.com>
 <20200128062814.GA2097606@kroah.com>
 <4EF659A1-2844-46B9-9ED6-5A6A20401D9D@xilinx.com>
 <20200131061038.GA2180358@kroah.com>
 <BYAPR02MB40559D6B62C4532C0EAD0281B7070@BYAPR02MB4055.namprd02.prod.outlook.com>
 <20200131093646.GA2271937@kroah.com>
 <3ef20e9d-052f-665c-7fc8-69a1f8bc9bd2@xilinx.com>
 <20200214171005.GB4034785@kroah.com>
From:   Jolly Shah <jolly.shah@xilinx.com>
Message-ID: <c2914eae-bf95-ad51-79a4-07f199f37e27@xilinx.com>
Date:   Fri, 14 Feb 2020 16:37:16 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200214171005.GB4034785@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(54906003)(110136005)(9786002)(5660300002)(31696002)(81166006)(81156014)(8936002)(316002)(8676002)(336012)(478600001)(36756003)(186003)(2906002)(31686004)(26005)(44832011)(53546011)(70206006)(426003)(70586007)(7416002)(2616005)(356004)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR02MB6000;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2414580e-71e9-495f-6948-08d7b1af3ade
X-MS-TrafficTypeDiagnostic: MN2PR02MB6000:
X-Microsoft-Antispam-PRVS: <MN2PR02MB6000A625D07DCE3AF3498442B8140@MN2PR02MB6000.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 03142412E2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ipcVGRrniD/A6m+ChqyCb2xBvbXYKNhMfUqSEmRT1npdBwgAFN7xvW55GUlMlyWcZrr4idLrM8AWtLHCEU0pDDGUBw7L8KDLN4OXJwmCFi1jcd3aAtfzUGLHpoMchlBQEBZKrCrHpLX7boId6xmxucOCqcpr6g2Khq2ozqVweoKFvI4ioeXRbLr5N0LKImLYJb3+Fl/bqNnwkS8D7aVOgPJArq6XtfSyfr/MZUHoIM2MrIGkNfHnS4PDPYErqwINuiqoaBORhD0sObN+XkG0QKlwZnzWaqhEBo4Txp3Xp+TQnErX+HnZBX/d7JSxkauDmd91O1dRb7suIIBGW+K1PCSexXYFGHBg6CPdrLpxzNWeCcmTZBgF4/VI6rSbGdOdy5qjXEGOSY1UrHnE5UpmYy3OsOXQzYycj/bk9SOf8C5tdhObhaYRKNWGeLuhVyjv9U3f05/FRZeXBdfBjUw69pnIwT/Jn7mhVsl2+grZziUZldKqrKlALgxEJd/eHn1EOLiRbZZbq4UZtpNs++eDfQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2020 00:37:25.9430
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2414580e-71e9-495f-6948-08d7b1af3ade
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Thanks for the response.

 > ------Original Message------
 > From: 'Greg Kh' <gregkh@linuxfoundation.org>
 > Sent:  Friday, February 14, 2020 9:10AM
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
> On Mon, Feb 10, 2020 at 04:57:01PM -0800, Jolly Shah wrote:
>> Hi Greg,
>>
>>> ------Original Message------
>>> From: 'Greg Kh' <gregkh@linuxfoundation.org>
>>> Sent:  Friday, January 31, 2020 1:36AM
>>> To: Rajan Vaja <RAJANV@xilinx.com>
>>> Cc: Jolly Shah <JOLLYS@xilinx.com>, Ard Biesheuvel
>> <ard.biesheuvel@linaro.org>, Mingo <mingo@kernel.org>, Matt
>> <matt@codeblueprint.co.uk>, Sudeep Holla <sudeep.holla@arm.com>, Hkallweit1
>> <hkallweit1@gmail.com>, Keescook <keescook@chromium.org>, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com>, Michal Simek <michals@xilinx.com>,
>> Linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux-kernel
>> <linux-kernel@vger.kernel.org>
>>> Subject: Re: [PATCH v2 1/4] firmware: xilinx: Add sysfs interface
>>>
>>> On Fri, Jan 31, 2020 at 09:05:15AM +0000, Rajan Vaja wrote:
>>>> Hi Greg,
>>>>
>>>>> -----Original Message-----
>>>>> From: Greg KH <gregkh@linuxfoundation.org>
>>>>> Sent: 31 January 2020 11:41 AM
>>>>> To: Jolly Shah <JOLLYS@xilinx.com>
>>>>> Cc: ard.biesheuvel@linaro.org; mingo@kernel.org; matt@codeblueprint.co.uk;
>>>>> sudeep.holla@arm.com; hkallweit1@gmail.com; keescook@chromium.org;
>>>>> dmitry.torokhov@gmail.com; Michal Simek <michals@xilinx.com>; Rajan Vaja
>>>>> <RAJANV@xilinx.com>; linux-arm-kernel@lists.infradead.org; linux-
>>>>> kernel@vger.kernel.org
>>>>> Subject: Re: [PATCH v2 1/4] firmware: xilinx: Add sysfs interface
>>>>>
>>>>> EXTERNAL EMAIL
>>>>>
>>>>> On Thu, Jan 30, 2020 at 11:59:03PM +0000, Jolly Shah wrote:
>>>>>> Hi Greg,
>>>>>>
>>>>>> ﻿On 1/27/20, 10:28 PM, "linux-kernel-owner@vger.kernel.org on behalf of Greg
>>>>> KH" <linux-kernel-owner@vger.kernel.org on behalf of
>>>>> gregkh@linuxfoundation.org> wrote:
>>>>>>
>>>>>>       On Mon, Jan 27, 2020 at 11:01:27PM +0000, Jolly Shah wrote:
>>>>>>       >     > > > +     ret = kstrtol(tok, 16, &value);
>>>>>>       >     > > > +     if (ret) {
>>>>>>       >     > > > +             ret = -EFAULT;
>>>>>>       >     > > > +             goto err;
>>>>>>       >     > > > +     }
>>>>>>       >     > > > +
>>>>>>       >     > > > +     ret = eemi_ops->ioctl(0, read_ioctl, reg, 0, ret_payload);
>>>>>>       >     > >
>>>>>>       >     > > This feels "tricky", if you tie this to the device you have your driver
>>>>>>       >     > > bound to, will this make it easier instead of having to go through the
>>>>>>       >     > > ioctl callback?
>>>>>>       >     > >
>>>>>>       >     >
>>>>>>       >     > GGS(general global storage) registers are in PMU space and linux
>>>>> doesn't have access to it
>>>>>>       >     > Hence ioctl is used.
>>>>>>       >
>>>>>>       >     Why not just a "real" call to the driver to make this type of reading?
>>>>>>       >     You don't have ioctls within the kernel for other drivers to call,
>>>>>>       >     that's not needed at all.
>>>>>>       >
>>>>>>       > these registers are for users  and for special needs where users wants
>>>>>>       > to retain values over resets. but as they belong to PMU address space,
>>>>>>       > these interface APIs are provided. They don’t allow access to any
>>>>>>       > other registers.
>>>>>>
>>>>>>       That's not the issue here.  The issue is you are using an "internal"
>>>>>>       ioctl, instead just make a "real" call.
>>>>>>
>>>>>> Sorry I am not clear. Do you mean that we should use linux standard
>>>>>> ioctl interface instead of internal ioctl by mentioning "real" ?
>>>>>
>>>>> No, you should just make a "real" function call to the exact thing you
>>>>> want to do.  Not have an internal multi-plexor ioctl() call that others
>>>>> then call.  This isn't a microkernel :)
>>>> [Rajan] Sorry for multiple back and forth but as I understand, you are suggesting to create a new API for
>>>> Read/write of GGS register instead of using PM_IOCTL API (eemi_ops->ioctl) for multiple purpose. Is my understanding correct?
>>>
>>> That is correct.
>>
>>
>>
>> Would like to clarify purpose of having ioctl API to avoid any confusion.
>> eemi interface apis are defined to be platform independent and allows clock,
>> reset, power etc management through firmware but apart from these generic
>> operations, there are some operations which needs secure access through
>> firmware. Examples are accessing some storage registers(ggs and pggs) for
>> inter agent communication, configuring another agent(RPU) mode, boot device
>> configuration etc. Those operations are covered as ioctls as they are very
>> platform specific. Also only whitelisted operations are allowed through
>> ioctl and is not exposed to user for any random read/write operation.
>>
>> Olof earlier had same concerns. We had clarified the purpose and with his
>> agreement, initial set of ioctls were accepted.
>> (https://www.lkml.org/lkml/2018/9/24/1570)
>>
>> Please suggest the best approach to handle this for current and future
>> patches.
> 
> Ok, in looking further at this, it's both better than I thought, and
> totally worse.
> 
> This interface you all are using where you ask the firmware driver for a
> pointer to a set of operation functions and then make calls through that
> is indicitive of an api that is NOT what we normally use in Linux at
> all.
> 
> Just make the direct call to the firmware driver, no need to muck around
> with tables of function pointers.  In fact, with the spectre changes,
> you just made things slower than needed, and you can get back a bunch of
> throughput by removing that whole middle layer.
> 

arm,scpi is doing the same way and we thought this approach will be more 
acceptable than direct function calls but happy to change as suggested.

> So go do that first please, before adding any new stuff.
> 
> Now for the ioctl, yeah, that's not a "normal" pattern either.  But
> right now you only have 2 "different" ioctls that you call.  So why not
> just turn those 2 into real function calls as well that then makes the
> "ioctl" call to the hardware?  That makes things a lot more obvious on
> the kernel driver side exactly what is going on.
> 

Sure as i understand firmware driver will provide real function calls to 
be used by user drivers and underneath it will call ioctl for desired 
operation. Please correct if I misunderstood.

Thanks,
Jolly Shah


> If you need to add more "ioctl" like calls, just add them as more
> functions, no big deal.  How many more of these are you going to need
> over time?
> 
> But that's not all that big of a deal right now, get rid of that whole
> middle-layer first, that's more important to clean up.  You will get rid
> of a lot of unneeded code and indirection that way, making it simpler
> and easier to understand what exactly is happening.
> 
> thanks,
> 
> greg k-h
> 
