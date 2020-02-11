Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D7DC352A4
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 00:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC1D2072C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 00:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="e8ipBCFy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgBKA50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 19:57:26 -0500
Received: from mail-co1nam11on2056.outbound.protection.outlook.com ([40.107.220.56]:6164
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727120AbgBKA50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 19:57:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CeKEe09MBLUNFQdfCgI1peuXYe9sL2oKUMj9v2JY2MsvJQPU2km21ErrmAFGzryxOvY7lQxP1ijNqn/XIxzLVQKbusDBPzvab6e2GN77CZVtrwtwPjumKzwbCwy8scWoqgQNdQyBBKPvcIzuFsIqjF9OBlIYfkE4+URESTvFI3pUBHYOhOedKWQDx8YyChutU19Zy0vRX/rVLClJ6i/tyjG/9R/Fu2QdZGi/LRtXKz/RAhqp5UM6/OPYGHjdG1qi4kOfvBG9RgyCFglPC5gHBBMVAejDVbtSEDDXjXEb8X1bSI+PAg89Krx/finsJrsooafzz/SKUOlSjTGC5wfGpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaEm4nah8+Cct0kboRh+hxM4iyqnk5afGcvtdxBu7pk=;
 b=ZFAcmVOW40n77JytALXJYNJivV7uyVVfxVMk9Sijon8A4kbhZTglMKjYgt2TQDbAJFeoU36ZsdGWL/rCYzlLlaNEFRQiuN2ztc3nvLaxiXL2SLuI1IAuhudX+u7j6iQxkZ9CKGYsoH5e+Jm4+hyugfVhjrqoDjcrsQPMyb1ORpH3nTCdfKwfwb9Vz24N4L6dom3aSysuK78uEpc413tC9ibyrMg+y/ZKekDpmNd9H2DDIFKFghNtTEpULXAK7rBW6Dq+PA8UG58zgXT8FLg8QM/0fQyZRgpb2jaEKgyVdho0f3JziV7+fxxxlgsIvOvDMWuu1F5Wi44XAw+HbWUWdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaEm4nah8+Cct0kboRh+hxM4iyqnk5afGcvtdxBu7pk=;
 b=e8ipBCFy4W7xQs5D4hMXrC9tumF2qVn6O0o22WQqixHu7Qw2rLZ9g4+bh68eXXh0qxG3F4FycfwztPicny0Ui+S1pwOYrL2AWzadh89wFDZYQsCVoCVQZ5QxEndr+P6yvalDt/Cyge2KX6QZsaWFYlAmXafBbnCv80HEMUE4Wdk=
Received: from BN7PR02CA0007.namprd02.prod.outlook.com (2603:10b6:408:20::20)
 by SN6PR02MB5182.namprd02.prod.outlook.com (2603:10b6:805:69::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.25; Tue, 11 Feb
 2020 00:57:18 +0000
Received: from BL2NAM02FT050.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by BN7PR02CA0007.outlook.office365.com
 (2603:10b6:408:20::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Tue, 11 Feb 2020 00:57:18 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT050.mail.protection.outlook.com (10.152.77.101) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2707.21
 via Frontend Transport; Tue, 11 Feb 2020 00:57:18 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1j1Jra-0004pY-0g; Mon, 10 Feb 2020 16:57:18 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1j1JrU-00065o-Td; Mon, 10 Feb 2020 16:57:12 -0800
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 01B0v1mi025411;
        Mon, 10 Feb 2020 16:57:02 -0800
Received: from [172.19.0.52]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1j1JrJ-00062m-Sr; Mon, 10 Feb 2020 16:57:01 -0800
Subject: Re: [PATCH v2 1/4] firmware: xilinx: Add sysfs interface
To:     "'Greg KH'" <gregkh@linuxfoundation.org>,
        Rajan Vaja <RAJANV@xilinx.com>
Cc:     "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
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
References: <1578527663-10243-1-git-send-email-jolly.shah@xilinx.com>
 <1578527663-10243-2-git-send-email-jolly.shah@xilinx.com>
 <20200114145257.GA1910108@kroah.com>
 <BYAPR02MB5992FC37E0D2AD9946414417B80F0@BYAPR02MB5992.namprd02.prod.outlook.com>
 <20200124060339.GB2906795@kroah.com>
 <2D4B924A-D10C-4A90-A8E6-507BF6C30654@xilinx.com>
 <20200128062814.GA2097606@kroah.com>
 <4EF659A1-2844-46B9-9ED6-5A6A20401D9D@xilinx.com>
 <20200131061038.GA2180358@kroah.com>
 <BYAPR02MB40559D6B62C4532C0EAD0281B7070@BYAPR02MB4055.namprd02.prod.outlook.com>
 <20200131093646.GA2271937@kroah.com>
From:   Jolly Shah <jolly.shah@xilinx.com>
Message-ID: <3ef20e9d-052f-665c-7fc8-69a1f8bc9bd2@xilinx.com>
Date:   Mon, 10 Feb 2020 16:57:01 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200131093646.GA2271937@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(346002)(396003)(39860400002)(199004)(189003)(8936002)(478600001)(26005)(6636002)(36756003)(8676002)(5660300002)(186003)(356004)(81166006)(81156014)(336012)(31686004)(70206006)(4326008)(31696002)(53546011)(426003)(9786002)(70586007)(7416002)(44832011)(54906003)(110136005)(316002)(2906002)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB5182;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40318959-db02-4202-a578-08d7ae8d581c
X-MS-TrafficTypeDiagnostic: SN6PR02MB5182:
X-Microsoft-Antispam-PRVS: <SN6PR02MB5182998F0D67A6F48188E612B8180@SN6PR02MB5182.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0310C78181
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yo7aBNBSxpuJBeViig67a8Z8qQ5z1+9kS+tGgPtGbfZ4Uy3kzyXow2zOOiKkKRwdgCZy27dQzxxjRJLHM3FBG9MFahf/1WdFgrzDNnIduEm080s9u47vdTzzsGDMf4fnYsuhWCgL3svZj+FD6aMCHQsAgiWH6zAj2zV4CoOs8+jT+QGtwSlx/rvRh5GTLFUo5mrIA1vJ09ceO5thlS5bLBC5AdKVdCMkMMfsQ4XzBP0A7ry3mZMjsaS+LtAboCOTtev1woyldhhCDC5+ZAZADk0IVSBZGsP5MH4hQg0RtCZTyDMYhOA1D5eI5htWhGtB7Vt4/4ojG3adBP+gCSilb/6lt6gUI9JLQyvzxczQ1C2JKlPSJxdeEvAfyDLN1gyfhakzXsPBru3V21CIi8yf8/+7mNeJO6cLwe92+lH3p1ne1eHxSW9yH9Kx2MocwTw62/ZJcocr7li00+/7rOcSPdZLg73EG7/DuwkX5jUPdjBAtfgy9/4iq/XSEixxmoVGuDNND3xPJ7Q5tCARelW1DQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 00:57:18.5716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40318959-db02-4202-a578-08d7ae8d581c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5182
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

 > ------Original Message------
 > From: 'Greg Kh' <gregkh@linuxfoundation.org>
 > Sent:  Friday, January 31, 2020 1:36AM
 > To: Rajan Vaja <RAJANV@xilinx.com>
 > Cc: Jolly Shah <JOLLYS@xilinx.com>, Ard Biesheuvel 
<ard.biesheuvel@linaro.org>, Mingo <mingo@kernel.org>, Matt 
<matt@codeblueprint.co.uk>, Sudeep Holla <sudeep.holla@arm.com>, 
Hkallweit1 <hkallweit1@gmail.com>, Keescook <keescook@chromium.org>, 
Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michal Simek 
<michals@xilinx.com>, Linux-arm-kernel 
<linux-arm-kernel@lists.infradead.org>, Linux-kernel 
<linux-kernel@vger.kernel.org>
 > Subject: Re: [PATCH v2 1/4] firmware: xilinx: Add sysfs interface
 >
> On Fri, Jan 31, 2020 at 09:05:15AM +0000, Rajan Vaja wrote:
>> Hi Greg,
>>
>>> -----Original Message-----
>>> From: Greg KH <gregkh@linuxfoundation.org>
>>> Sent: 31 January 2020 11:41 AM
>>> To: Jolly Shah <JOLLYS@xilinx.com>
>>> Cc: ard.biesheuvel@linaro.org; mingo@kernel.org; matt@codeblueprint.co.uk;
>>> sudeep.holla@arm.com; hkallweit1@gmail.com; keescook@chromium.org;
>>> dmitry.torokhov@gmail.com; Michal Simek <michals@xilinx.com>; Rajan Vaja
>>> <RAJANV@xilinx.com>; linux-arm-kernel@lists.infradead.org; linux-
>>> kernel@vger.kernel.org
>>> Subject: Re: [PATCH v2 1/4] firmware: xilinx: Add sysfs interface
>>>
>>> EXTERNAL EMAIL
>>>
>>> On Thu, Jan 30, 2020 at 11:59:03PM +0000, Jolly Shah wrote:
>>>> Hi Greg,
>>>>
>>>> ﻿On 1/27/20, 10:28 PM, "linux-kernel-owner@vger.kernel.org on behalf of Greg
>>> KH" <linux-kernel-owner@vger.kernel.org on behalf of
>>> gregkh@linuxfoundation.org> wrote:
>>>>
>>>>      On Mon, Jan 27, 2020 at 11:01:27PM +0000, Jolly Shah wrote:
>>>>      >     > > > +     ret = kstrtol(tok, 16, &value);
>>>>      >     > > > +     if (ret) {
>>>>      >     > > > +             ret = -EFAULT;
>>>>      >     > > > +             goto err;
>>>>      >     > > > +     }
>>>>      >     > > > +
>>>>      >     > > > +     ret = eemi_ops->ioctl(0, read_ioctl, reg, 0, ret_payload);
>>>>      >     > >
>>>>      >     > > This feels "tricky", if you tie this to the device you have your driver
>>>>      >     > > bound to, will this make it easier instead of having to go through the
>>>>      >     > > ioctl callback?
>>>>      >     > >
>>>>      >     >
>>>>      >     > GGS(general global storage) registers are in PMU space and linux
>>> doesn't have access to it
>>>>      >     > Hence ioctl is used.
>>>>      >
>>>>      >     Why not just a "real" call to the driver to make this type of reading?
>>>>      >     You don't have ioctls within the kernel for other drivers to call,
>>>>      >     that's not needed at all.
>>>>      >
>>>>      > these registers are for users  and for special needs where users wants
>>>>      > to retain values over resets. but as they belong to PMU address space,
>>>>      > these interface APIs are provided. They don’t allow access to any
>>>>      > other registers.
>>>>
>>>>      That's not the issue here.  The issue is you are using an "internal"
>>>>      ioctl, instead just make a "real" call.
>>>>
>>>> Sorry I am not clear. Do you mean that we should use linux standard
>>>> ioctl interface instead of internal ioctl by mentioning "real" ?
>>>
>>> No, you should just make a "real" function call to the exact thing you
>>> want to do.  Not have an internal multi-plexor ioctl() call that others
>>> then call.  This isn't a microkernel :)
>> [Rajan] Sorry for multiple back and forth but as I understand, you are suggesting to create a new API for
>> Read/write of GGS register instead of using PM_IOCTL API (eemi_ops->ioctl) for multiple purpose. Is my understanding correct?
> 
> That is correct.



Would like to clarify purpose of having ioctl API to avoid any confusion.
eemi interface apis are defined to be platform independent and allows 
clock, reset, power etc management through firmware but apart from these 
generic operations, there are some operations which needs secure access 
through firmware. Examples are accessing some storage registers(ggs and 
pggs) for inter agent communication, configuring another agent(RPU) 
mode, boot device configuration etc. Those operations are covered as 
ioctls as they are very platform specific. Also only whitelisted 
operations are allowed through ioctl and is not exposed to user for any 
random read/write operation.

Olof earlier had same concerns. We had clarified the purpose and with 
his agreement, initial set of ioctls were accepted. 
(https://www.lkml.org/lkml/2018/9/24/1570)

Please suggest the best approach to handle this for current and future 
patches.

Thanks,
Jolly Shah


> 
