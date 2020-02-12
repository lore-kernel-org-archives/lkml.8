Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12077C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A1A20848
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="XuIoxiL3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbgBLJ0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 04:26:54 -0500
Received: from mail-bn8nam12on2084.outbound.protection.outlook.com ([40.107.237.84]:64864
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728667AbgBLJ0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 04:26:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DI5ADWh0fl09B2TQFBMwVxBcmC57IHxllL1piwde/WlCF9CeG1g0lJNQ4zlfZDyp64wXNTXFzR65CjLF8HKyXdgLGXWA99GgXtE60s7IYGfdaAPLXgBI5G7D7MqaA7n9VubNGBKVHDG+82oDIA4IG2ovrHzpC1HbMTF8JNpZvDdr26L8vXirRUVlpEPjueCwUcrofhyYrSKFxw/8b3YaOwXBTupDtb4nwL1SA+7ac4+5CFXoGVwvGrXZxw/qRSOL2SRzFytVKR2GXACIyQCbloKySol029ASRz6V0t6ycXXD76VUXMHoFTOYqxhyXSeRINNN+PlDVHzRLD6eqPbHyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFq0cIhqlRG11IxDsBtPmM/DTu2KkVgWYDa51/2Zg8I=;
 b=FC8zDrqVRgYKyp8lpozMBZ04BOn6+BqV+ebEglbab9QIc0iD47zhSyssLNwiD5eqHf1Cs7hx+FCo1GJVnjbw+kg1WYuO6EYZ2bNuBdA7vXzylR5xZ1v9Umdz8FujMW5z+b5QuHi/aWVTTlaBTZrfzhiohx7Cd6sgthYwRyqF5MLDVdc8G+X/iiRPF74fnoDekYbTZpK4RBwJHce9cOwQUqZSSEGgbHjwDkD2dQ/4/G8BI1cmiJKSAS0d1hZnbFG8J2hCVG0E3dljDZGHUJhlTPtHZqk90pEr4qOJ6Yze0CjGH5ZumpBXy92dcP1y+oQ1dZM2jpp/rN11Bdybsa5IsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFq0cIhqlRG11IxDsBtPmM/DTu2KkVgWYDa51/2Zg8I=;
 b=XuIoxiL32Zmq9fGBIdT6mYReZouL1jLXEYqXySYRVS8GaoUDBbe+t9FgSzred/DypCH1oduLoK2JSkwAAoIjf6W8S2KmoDYdKesUtjxvdAn2mGc9rYVGSqbwKPr22mjfAqjAxdBhLBh8GcSs0fy+hflRxYxDskie/DGfeilQUjc=
Received: from BL0PR02CA0021.namprd02.prod.outlook.com (2603:10b6:207:3c::34)
 by MWHPR02MB2478.namprd02.prod.outlook.com (2603:10b6:300:41::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22; Wed, 12 Feb
 2020 09:26:43 +0000
Received: from CY1NAM02FT026.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by BL0PR02CA0021.outlook.office365.com
 (2603:10b6:207:3c::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22 via Frontend
 Transport; Wed, 12 Feb 2020 09:26:43 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT026.mail.protection.outlook.com (10.152.75.157) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2729.22
 via Frontend Transport; Wed, 12 Feb 2020 09:26:42 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1j1oI6-0007Rg-BW; Wed, 12 Feb 2020 01:26:42 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1j1oI1-0000Mh-2t; Wed, 12 Feb 2020 01:26:37 -0800
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 01C9QSRv007207;
        Wed, 12 Feb 2020 01:26:28 -0800
Received: from [172.30.17.107]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1j1oHs-0000K4-Bu; Wed, 12 Feb 2020 01:26:28 -0800
Subject: Re: [PATCH v2] asm-generic: Fix unistd_32.h generation format
To:     Max Filippov <jcmvbkbc@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git@xilinx.com,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Chris Zankel <chris@zankel.net>,
        "David S. Miller" <davem@davemloft.net>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
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
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <dacfbf2c-74b3-3d52-1fdd-d757b4a19c73@xilinx.com>
Date:   Wed, 12 Feb 2020 10:26:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAMo8BfLYM-_SbqmMUCVjwqL7MpA2W7toTg_F6HTY4Sg5QxGzfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(346002)(396003)(136003)(189003)(199004)(426003)(316002)(7416002)(478600001)(2616005)(54906003)(336012)(8676002)(36756003)(110136005)(81156014)(31686004)(81166006)(2906002)(8936002)(53546011)(70206006)(44832011)(26005)(70586007)(9786002)(31696002)(186003)(6666004)(356004)(5660300002)(4326008)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2478;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2414ef4-35de-487c-7194-08d7af9dac37
X-MS-TrafficTypeDiagnostic: MWHPR02MB2478:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <MWHPR02MB247837AA4AF62F1ED7FC9551C61B0@MWHPR02MB2478.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0311124FA9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8X9cpToN5nJSnzjsd+YyZDmNtOYPaD5dHTsQiLZR3jjZaiZvbxdz+nuJGD0TVup7zyHrEKSnr1ZJBScsbaeRXfhV/lgq/ijXSxGDyuUzAhmnAA8hzxvvqT8qc0sjYr5GpCFVKd6rY1Px9ysjp5Jn0CsEYuevtCxfsPuyGBjm0zHsfpkSQdVqNhTu2BZV0a135l1Ftg3Fd0aqYokcnU8FxsTDi+3K12fjygUYayfLSScJbs/g/d06jBpcwTsFB6MIaPWL6uV4+t4nKzns9Dh2MfiCIY9wU19UuoNZTiJtBblcXrB6oepvivUFEpxhb/tH7OR39q2RFEHdR33c6gzyGL3R3fEFpu3lcU3LvixRcW/92HYobnWtnlWUhmdP9u1EP5J3PFpLTcMSkSWO69PdCoCVZ3BKLSY8kfubiB89iTcuANiSr2+ksocOUvKYtjbWDsnEoseoN08iqWQLMfSJpuaZn8WlrH9wttzUVOTDNxdOvxNyO3rrHYZ8N/HXtbNC
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2020 09:26:42.8534
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2414ef4-35de-487c-7194-08d7af9dac37
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2478
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12. 02. 20 10:23, Max Filippov wrote:
> On Wed, Feb 12, 2020 at 1:16 AM Michal Simek <michal.simek@xilinx.com> wrote:
>>
>> Generated files are also checked by sparse that's why add newline
>> to remove sparse (C=1) warning.
>>
>> The issue was found on Microblaze and reported like this:
>> ./arch/microblaze/include/generated/uapi/asm/unistd_32.h:438:45:
>> warning: no newline at end of file
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> Reviewed-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
>> ---
>>
>> Changes in v2:
>> - Update also others archs not just microblaze - Arnd
>> - Align subject and description to match multiarch chagne
>>
>>  arch/alpha/kernel/syscalls/syscallhdr.sh      | 1 +
>>  arch/ia64/kernel/syscalls/syscallhdr.sh       | 1 +
>>  arch/m68k/kernel/syscalls/syscallhdr.sh       | 1 +
>>  arch/microblaze/kernel/syscalls/syscallhdr.sh | 1 +
>>  arch/parisc/kernel/syscalls/syscallhdr.sh     | 1 +
>>  arch/sh/kernel/syscalls/syscallhdr.sh         | 1 +
>>  arch/sparc/kernel/syscalls/syscallhdr.sh      | 1 +
>>  arch/xtensa/kernel/syscalls/syscallhdr.sh     | 1 +
>>  8 files changed, 8 insertions(+)
> 
> For xtensa:
> Acked-by: Max Filippov <jcmvbkbc@gmail.com>
> 
> ...
> 
>> diff --git a/arch/m68k/kernel/syscalls/syscallhdr.sh b/arch/m68k/kernel/syscalls/syscallhdr.sh
>> index 6f357d68ef44..8ac15be01ac2 100644
>> --- a/arch/m68k/kernel/syscalls/syscallhdr.sh
>> +++ b/arch/m68k/kernel/syscalls/syscallhdr.sh
>> @@ -33,4 +33,5 @@ grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
>>         printf "#endif\n"
>>         printf "\n"
>>         printf "#endif /* %s */\n" "${fileguard}"
> 
> Here there's already \n at the end, so no need for another one?

No it is not needed. But I think that make sense to have the same
solution in all these scripts. Above printf is adding newline that's why
I have used the same style.

M

