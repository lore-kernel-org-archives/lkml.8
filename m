Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FB1C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3723E2073C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Vs7ZVFip"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgBLJmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 04:42:54 -0500
Received: from mail-eopbgr760072.outbound.protection.outlook.com ([40.107.76.72]:11366
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728737AbgBLJmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 04:42:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2CbNhIPys6chUJXY0EicN+Bzh654LH1l832mmWHe2OS/M0fEc/sQoLMzinSieuuuRqcx56aAoK9ACJKITITK0DqMDXyfrKUf593gFhef6J7mShsIUgPS6ax30K/svK+hE8n+1acVjfyRjDZKPVMhpTFQy2ggRae0vpKwX2emGaEU3km7l+1YQTjhn9BzFZ2lk6+LtJB0CDFgKGvN2mPL8JzWfE2kwO9TSnsEY1zqb/CXoUAoUEUAwadZuVRUS0NNMP4Uyg6lWVA6ISQTaOSpELfvVmklptkw8YQJzKYtYJI61JnME37HMpa2im8IJgC+K7ysljahRiJrJGxbFq+ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKUXspPdjAX7v9aJ53TWNH183wbUCNUcLzxYPre6KuA=;
 b=jxQHEim9DZiPCuDH1xxqW9L1mZXYZKLW9lK3pZW3yiGwdB6dstUwRhgRv5FL30eftPT+TkJs9uPRVyOBQoJ2qzqmZPy7f6ZEoszHIrsPoHgAi9YVz3uSj7tCYK5TomcwV5RCp33u8tzCx4RzYlPXv0uqIT2JZqhOh/6jmwwx6MHwedXvxZkeqn52+4ctS6f8qTQPfEqg+95V5AmrIxUkHftsDOvyfOh+gUNvgif5hba86uqCYUgUEXXU5sDYprBx7VzAxlBx4IWQ1+wWcYa9qNW89nwuEwG8GsDK1+poB7jb2SSrLQ1x+9y8zh3/AjY8zyRKSmcMNJOvgm4MugJ86Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linux-m68k.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKUXspPdjAX7v9aJ53TWNH183wbUCNUcLzxYPre6KuA=;
 b=Vs7ZVFiplcPxx98nWzuAafX27TkAlo7P+8ZIapCvibgO4aVvMGPJVGn3Msi/HhiZLgzocgjjpq95EUfy11rYM+SrdmNw9b/605IW9Dzz9Gq9lH4qzVoM/R3Vwtftae8Kbm8FxCZEQQ8avr8TGwuK7k6lCi0aQ4mCmxaMdFiOG9o=
Received: from MWHPR02CA0020.namprd02.prod.outlook.com (2603:10b6:300:4b::30)
 by MN2PR02MB6045.namprd02.prod.outlook.com (2603:10b6:208:1b6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.23; Wed, 12 Feb
 2020 09:42:48 +0000
Received: from SN1NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by MWHPR02CA0020.outlook.office365.com
 (2603:10b6:300:4b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22 via Frontend
 Transport; Wed, 12 Feb 2020 09:42:47 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT027.mail.protection.outlook.com (10.152.72.99) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2729.22
 via Frontend Transport; Wed, 12 Feb 2020 09:42:47 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1j1oXe-0007Wj-W6; Wed, 12 Feb 2020 01:42:46 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1j1oXZ-00057C-I7; Wed, 12 Feb 2020 01:42:41 -0800
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 01C9gU6P012696;
        Wed, 12 Feb 2020 01:42:30 -0800
Received: from [172.30.17.107]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1j1oXN-00052L-Rh; Wed, 12 Feb 2020 01:42:30 -0800
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
 <1d006656-bd48-0b8e-b893-cddaa5f8f8bc@xilinx.com>
 <CAMuHMdXaOD5kL+Cg0L=YeX_DqdVgUJXEA8LF-NiHbmkMuXKTaA@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <d93646fa-c844-693c-07a7-7075d0fcf2c9@xilinx.com>
Date:   Wed, 12 Feb 2020 10:42:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXaOD5kL+Cg0L=YeX_DqdVgUJXEA8LF-NiHbmkMuXKTaA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(346002)(376002)(39860400002)(199004)(189003)(6666004)(5660300002)(9786002)(356004)(336012)(36756003)(8936002)(2906002)(31686004)(186003)(26005)(478600001)(44832011)(426003)(4326008)(8676002)(316002)(81156014)(53546011)(70586007)(110136005)(54906003)(2616005)(70206006)(31696002)(7416002)(81166006)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR02MB6045;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac2cecfb-2bed-410b-c74d-08d7af9feb29
X-MS-TrafficTypeDiagnostic: MN2PR02MB6045:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <MN2PR02MB60454BEAC37084BEC32E4D23C61B0@MN2PR02MB6045.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-Forefront-PRVS: 0311124FA9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5bQ0Vb8/HHvRct+XSxBCsDtY+XdLS7MGkaLcge3g+Don3+IVGsLFbuTxiO3jhQPwOfYq2o0YUWqyZNKl+Dj5WxlZjiZnC7s5gukfvlF32JaWOsOuEyx+l951Pq1/i01pqJWrYDnumn2Pwu0itfnb1navElh2Nr/bBsFkut0nAiK5e6nC4kcnFcAlk7cVpJ4e2S4+Q0q1iMV7T2MmcIN2ryFODi1he0M5JNJ3fiiXEXm4Ykh3NnLjKn47yzA/sn4P3j/f/Wmu+8IwlA+NiLo1BqPl9G7TsiJcBy+LJRBjYs3LMXFhbz+ieRT3vUx1ekR2B0AIV42q/VHdk5ED7tsBmdXdBiiu+59+55dRoN0GlGtyAPqFTK3S8D5aZSkVHSWNcHPKi9o2mSXxYDWGTXKycK8XYzM00r4AFXXCAvtZKmMBhHSzoqizDc9Gv/taJ9aOBGqzn9JQH4EgPqP5BGKPjMvQc9Pl8sl4ltAWM1YX78s=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2020 09:42:47.4777
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac2cecfb-2bed-410b-c74d-08d7af9feb29
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6045
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12. 02. 20 10:40, Geert Uytterhoeven wrote:
> Hi Michal,
> 
> On Wed, Feb 12, 2020 at 10:38 AM Michal Simek <michal.simek@xilinx.com> wrote:
>> On 12. 02. 20 10:32, Geert Uytterhoeven wrote:
>>> On Wed, Feb 12, 2020 at 10:27 AM Michal Simek <michal.simek@xilinx.com> wrote:
>>>> On 12. 02. 20 10:25, Geert Uytterhoeven wrote:
>>>>> On Wed, Feb 12, 2020 at 10:23 AM Max Filippov <jcmvbkbc@gmail.com> wrote:
>>>>>> On Wed, Feb 12, 2020 at 1:16 AM Michal Simek <michal.simek@xilinx.com> wrote:
>>>>>>>
>>>>>>> Generated files are also checked by sparse that's why add newline
>>>>>>> to remove sparse (C=1) warning.
>>>>>>>
>>>>>>> The issue was found on Microblaze and reported like this:
>>>>>>> ./arch/microblaze/include/generated/uapi/asm/unistd_32.h:438:45:
>>>>>>> warning: no newline at end of file
>>>>>>>
>>>>>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>>>>>> Reviewed-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
>>>>>
>>>>>>> --- a/arch/m68k/kernel/syscalls/syscallhdr.sh
>>>>>>> +++ b/arch/m68k/kernel/syscalls/syscallhdr.sh
>>>>>>> @@ -33,4 +33,5 @@ grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
>>>>>>>         printf "#endif\n"
>>>>>>>         printf "\n"
>>>>>>>         printf "#endif /* %s */\n" "${fileguard}"
>>>>>>
>>>>>> Here there's already \n at the end, so no need for another one?
>>>>>
>>>>> Thanks! I completely missed that.
>>>>> So I did fix the original while applying ;-)
>>>>
>>>> I can drop m68k or align with with others. I would prefer to have the
>>>> same solution in all these scripts.
>>>
>>> Yeah, it makes sense to align as much as possible.
>>> IIRC, the original plan was to consolidate more later.
>>>
>>> Note that all other lines are terminated with a "\n" at the end.
>>> The separate 'printf "\n"' is an extra blank line, not the terminator for the
>>> previous line.
>>
>> Should we also get rid of 'printf "\n"' lines or just keep them as they
>> are today?
> 
> Usually there is a blank line above the include guard terminator, so IMHO
> it makes sense to have that in generated files, too.

I meant more not to get rid of \n just include them in current prints.
It means like this 'printf "\n#endif /* %s */\n" "${fileguard}"'

M
