Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B63C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD6462073C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="DvbvGU4I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgBLJiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 04:38:22 -0500
Received: from mail-bn8nam11on2079.outbound.protection.outlook.com ([40.107.236.79]:6018
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728731AbgBLJiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 04:38:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hoE1wvf92sU2lL5FxHOZIC+rOJkeWSsRqL5m0fFctB3WfRZ6YDDSjw0zM40yCJKbe2K/mp6hBsGVCmo8CyY0qlt52Mwk3VsJVvwCS5x+jCKouiCMhj57b5t6R/t7FXely5BXDTUDBZG4+sgzFlY041xaymW487ViaSoCqsVi4DX257ILFGvssJxeCHn6Yli/MBwMjRr6midu8+xBhRD5HiDBXZgjgyuNM1EWhMfzIGpTKWHgkELa3p9NNbIW6iuRNABlV1iYQps94icMVQ4f3YxTrt9q94a5xJoednBHSNdH6p962aoEkyvFHLPwPIqxmx9o3LjkSsNDunKruhiJ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1R8uir+yzC0d8o5HVbQfagTIR0r2KisqD4vF2Sh3G8c=;
 b=f7FHuzvng3j9ErJ63VieFWlGYZAK4NyUD6bF4IaxB3tKFXDa2UjHoodHbHFzymh+gGaz1vawIi2u1svz3nUS/8CLb6Ar7eu9mCn3nrC1OJub1uYT6AG/RYo7uXl2+xzIckSYYVlVg6XZJu7BoRsjLTt/byCTANVMaqeDHDNw8TjW0lP7jfhOrNauVPK0WSEky5QfG/+IFe4nKA4Hd033vpFHmnwZewVIVUlOwqkG+8TiFHEBqp2LX2oSJG7TYSGy2DwNC/eWQYhSk/JzrrldkZ/q88z7UXUNGNrxecMOVl58UxCHfGd2pLvgbpt4gfoZDbAkHIt/mfs9xHRFjCKZ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linux-m68k.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1R8uir+yzC0d8o5HVbQfagTIR0r2KisqD4vF2Sh3G8c=;
 b=DvbvGU4Ii8QwqJx8Ka+H69tbrisyG77RuSYCkyZuFTih5qqNlXQuUcn/OwsAyky/YnxhoTJcLb9EaIgsOeuGmDcxfGsmIjuj1IFAtgcQcQue2/CuzScNxiiplrf/vywjzqah48SJ7BAOXiAPV+m9kktrL/gI1qKf3V4doKU+I5s=
Received: from MWHPR02CA0002.namprd02.prod.outlook.com (2603:10b6:300:4b::12)
 by BYAPR02MB4518.namprd02.prod.outlook.com (2603:10b6:a03:10::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.23; Wed, 12 Feb
 2020 09:38:16 +0000
Received: from CY1NAM02FT042.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by MWHPR02CA0002.outlook.office365.com
 (2603:10b6:300:4b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22 via Frontend
 Transport; Wed, 12 Feb 2020 09:38:16 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT042.mail.protection.outlook.com (10.152.75.136) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2707.21
 via Frontend Transport; Wed, 12 Feb 2020 09:38:16 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1j1oTH-0007Vm-IP; Wed, 12 Feb 2020 01:38:15 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1j1oTC-0002qf-BR; Wed, 12 Feb 2020 01:38:10 -0800
Received: from xsj-pvapsmtp01 (mail.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 01C9c1o3010284;
        Wed, 12 Feb 2020 01:38:01 -0800
Received: from [172.30.17.107]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1j1oT2-0002ly-NR; Wed, 12 Feb 2020 01:38:00 -0800
Subject: Re: [PATCH v2] asm-generic: Fix unistd_32.h generation format
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     Max Filippov <jcmvbkbc@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git@xilinx.com,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Chris Zankel <chris@zankel.net>,
        "David S. Miller" <davem@davemloft.net>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Helge Deller <deller@gmx.de>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Matt Turner <mattst88@gmail.com>,
        Rich Felker <dalias@libc.org>,
        Richard Henderson <rth@twiddle.net>,
        Tony Luck <tony.luck@intel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "open list:ALPHA PORT" <linux-alpha@vger.kernel.org>,
        "open list:IA64 (Itanium) PL..." <linux-ia64@vger.kernel.org>,
        "open list:M68K ARCHITECTURE" <linux-m68k@lists.linux-m68k.org>,
        "open list:PARISC ARCHITECTURE" <linux-parisc@vger.kernel.org>,
        "open list:SUPERH" <linux-sh@vger.kernel.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        "open list:SPARC + UltraSPAR..." <sparclinux@vger.kernel.org>
References: <dcdd615f77dacf8a98e18950b66fb5a675277f38.1581498987.git.michal.simek@xilinx.com>
 <CAMo8BfLYM-_SbqmMUCVjwqL7MpA2W7toTg_F6HTY4Sg5QxGzfw@mail.gmail.com>
 <CAMuHMdUZ_e9JsF0fuLxBwdoy7YVLarH6E98z5nKUZ2CccSkV-Q@mail.gmail.com>
 <6128aa3a-a99c-2ab0-82d1-d5c419e4f5b9@xilinx.com>
 <CAMuHMdX3O6aL_yGSfqrbdfPf-HHqqdkMwPHS=Y0WxMRTYOtJ4w@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <1d006656-bd48-0b8e-b893-cddaa5f8f8bc@xilinx.com>
Date:   Wed, 12 Feb 2020 10:37:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdX3O6aL_yGSfqrbdfPf-HHqqdkMwPHS=Y0WxMRTYOtJ4w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(396003)(199004)(189003)(31696002)(356004)(6666004)(2906002)(36756003)(7416002)(31686004)(8936002)(478600001)(44832011)(110136005)(8676002)(81166006)(5660300002)(81156014)(70206006)(70586007)(54906003)(9786002)(4326008)(26005)(336012)(426003)(186003)(316002)(2616005)(53546011)(41533002)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4518;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03aa62c5-57e4-49c5-2cfb-08d7af9f4968
X-MS-TrafficTypeDiagnostic: BYAPR02MB4518:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <BYAPR02MB4518CAB24908D52B261B3306C61B0@BYAPR02MB4518.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0311124FA9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W3fALEJK0oY+oVqx1bZNWe4aQoaxKKJHBNx4lqmwElMAJnuVfvqabTln9g3BtpaM/TXL4cFZDJPPevK4t5be3OY2nnjcT+RrzSUIwdc+0YBC1viUxU0J4LJT+YwQfZrLeHPM8gSD18rIPN0fXqB0PzDgZE77yT5pG+YCyCmPE/EUJ8t7K+rqmgCHN3K5juixt6S1iheO6VgvIpPDvmGWtAHOQRlmQOvZtvu6Xr+3SqUovUMXMqpmOXwWSQ8FhSzjULShzKtqf30btu8BiW5XJ5JTQbsbwNf/KGIQyv0LTlB5BIz/bpC6JTmSUHGlLO00OO4sSqVEhtaKtW/ERrmmgFpO9coXLyg6C1Qj+Z5K3lGlJgUnvltyZEVlSMc+Dkv6fZv8q9Px2Q1ViOrMEE1lrtmsLDQuOIkxxPZQUXHP/sDB85HdhdPK6H33YEoJkAEviPaaD7Hh2IYdjZx0J3fDjbAa1s7aZrErs2IXHmh38SBHzmikV9KM1cQg8XC553wK
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2020 09:38:16.0718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03aa62c5-57e4-49c5-2cfb-08d7af9f4968
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4518
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12. 02. 20 10:32, Geert Uytterhoeven wrote:
> Hi Michal,
> 
> On Wed, Feb 12, 2020 at 10:27 AM Michal Simek <michal.simek@xilinx.com> wrote:
>> On 12. 02. 20 10:25, Geert Uytterhoeven wrote:
>>> On Wed, Feb 12, 2020 at 10:23 AM Max Filippov <jcmvbkbc@gmail.com> wrote:
>>>> On Wed, Feb 12, 2020 at 1:16 AM Michal Simek <michal.simek@xilinx.com> wrote:
>>>>>
>>>>> Generated files are also checked by sparse that's why add newline
>>>>> to remove sparse (C=1) warning.
>>>>>
>>>>> The issue was found on Microblaze and reported like this:
>>>>> ./arch/microblaze/include/generated/uapi/asm/unistd_32.h:438:45:
>>>>> warning: no newline at end of file
>>>>>
>>>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>>>> Reviewed-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
>>>
>>>>> --- a/arch/m68k/kernel/syscalls/syscallhdr.sh
>>>>> +++ b/arch/m68k/kernel/syscalls/syscallhdr.sh
>>>>> @@ -33,4 +33,5 @@ grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
>>>>>         printf "#endif\n"
>>>>>         printf "\n"
>>>>>         printf "#endif /* %s */\n" "${fileguard}"
>>>>
>>>> Here there's already \n at the end, so no need for another one?
>>>
>>> Thanks! I completely missed that.
>>> So I did fix the original while applying ;-)
>>
>> I can drop m68k or align with with others. I would prefer to have the
>> same solution in all these scripts.
> 
> Yeah, it makes sense to align as much as possible.
> IIRC, the original plan was to consolidate more later.
> 
> Note that all other lines are terminated with a "\n" at the end.
> The separate 'printf "\n"' is an extra blank line, not the terminator for the
> previous line.

Should we also get rid of 'printf "\n"' lines or just keep them as they
are today?

M


