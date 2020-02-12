Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A12C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 216C521569
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="oL8HlP+K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbgBLJ1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 04:27:38 -0500
Received: from mail-dm6nam11on2067.outbound.protection.outlook.com ([40.107.223.67]:13921
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728587AbgBLJ1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 04:27:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvZQycBYkqhR0ydKOZL5hfqqvPcDCUn58+t9v+f6ZfB/ZJTFPXl4TL4PgFfFStul59cEesAdJ0gSSIFBJtHI4G0f6Bx6rwDtOdUKbyH5W79z8fZuOp4DYFnIti3J5sVZE5fAAM9T7iU3AeJez9L/6kpAYY6n1GLZP4K+A3Y3GLKEb2p5RdCATFl5SeO9qNsmPNXIg54da4C0iKXK4kRa41r9WKcmUHOF+kLlVJu4/Lo6JmPHr0smwoZTMujf8LquPhkZkWUINNOxqNKTMdOOihegBdtBfcWuyCFivvYV/FeY2sNp1//HLfCCDz5P6OpVEwNSaLtivwBnW59xLawdzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSFMHYweFAn3Bp2O3H9V7jtO3967wtffEOeI26+GwNU=;
 b=kLap6JBv+KVPVaVz2oS8N4o5PBK01GvO99zjz+rtSNMAiXW0xD5uDn7V/btqxanlLA/riH18FHe0NG81JM0+RNKATKVS9Cszw4yvWCgNu+/Zg7N+g0k9saVyybOWMtIOAuVh9tv5L60VtHMBkgOpfqSpIXI5jpUqXopLIPEfxOKCw2P4SdHP1CgsCgZ2mPV5ongJG9PTh96fIh1g0w2lxX+fkDjRKT35DuoL4OM55lD2qkWAZ+1zHgP1o1u1nV+6zNrRIUxOkwtKLZZzU2oqj8m/kXXtiGGweOTp7j5HH2+4oiLzjUeauaYZKE7K7uDLu4UvSzNGAwnACanYeuuFtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linux-m68k.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSFMHYweFAn3Bp2O3H9V7jtO3967wtffEOeI26+GwNU=;
 b=oL8HlP+K+xendDGw8A6Af39DbcTcbfrKygj96kkMJmv+EwMhFCsZWqrRj/Ohs3F9XixIb5+2e9hT2zFsWNdDdsWGaXh9BhJnLbEHMaSIRX24ADbZX1wpIvy6msr8jj3w9WORGz72uYi6KttXWkMWkRjdPfYui+t/zPk4FpdMCoM=
Received: from DM6PR02CA0118.namprd02.prod.outlook.com (2603:10b6:5:1b4::20)
 by SN6PR02MB4413.namprd02.prod.outlook.com (2603:10b6:805:a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.25; Wed, 12 Feb
 2020 09:27:33 +0000
Received: from SN1NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::208) by DM6PR02CA0118.outlook.office365.com
 (2603:10b6:5:1b4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22 via Frontend
 Transport; Wed, 12 Feb 2020 09:27:33 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT018.mail.protection.outlook.com (10.152.72.122) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2729.22
 via Frontend Transport; Wed, 12 Feb 2020 09:27:33 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1j1oIu-0007Ru-Ky; Wed, 12 Feb 2020 01:27:32 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1j1oIp-0000iw-FR; Wed, 12 Feb 2020 01:27:27 -0800
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 01C9RN3P007570;
        Wed, 12 Feb 2020 01:27:23 -0800
Received: from [172.30.17.107]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1j1oIl-0000fT-HF; Wed, 12 Feb 2020 01:27:23 -0800
Subject: Re: [PATCH v2] asm-generic: Fix unistd_32.h generation format
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Max Filippov <jcmvbkbc@gmail.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
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
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <6128aa3a-a99c-2ab0-82d1-d5c419e4f5b9@xilinx.com>
Date:   Wed, 12 Feb 2020 10:27:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUZ_e9JsF0fuLxBwdoy7YVLarH6E98z5nKUZ2CccSkV-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(396003)(39860400002)(136003)(199004)(189003)(186003)(2906002)(426003)(9786002)(336012)(110136005)(54906003)(44832011)(2616005)(8936002)(316002)(8676002)(81166006)(478600001)(31686004)(81156014)(5660300002)(7416002)(31696002)(4326008)(6666004)(36756003)(356004)(70586007)(26005)(70206006)(53546011)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4413;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4bd0be8f-02b9-4041-540f-08d7af9dca1f
X-MS-TrafficTypeDiagnostic: SN6PR02MB4413:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <SN6PR02MB4413920DDF5929CECD539F5FC61B0@SN6PR02MB4413.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0311124FA9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xAqd0IE9uEssIDjxHmscaMS9V2YYUmWa8S1pM/vMY1wH+XR8S8XqQ03mLUDftvZZsAH0NJYyF0dNRXCQP0g5BzgNv6PoBK+pyCgHpVNC2X4BsprigpY+881qOBi3oaEcLEuYCN9xQYlr5nGcVEVx7JS+iHeulWkodieSgWspioMjD0kgk9p0VVOE2g2xUF3iKDSJi86t31tBV5xsw9DGx8ug25/EC3Jf5Oib83qoDC4CsoWl+0Ij+zCqc1o99MGX03zcX3QQmnZU0/2y/AoGlixsxsGrzN818b0/5qxrg0CEPb1OzH3OyaItaOdU/XSMabvSERBLQX1hXM27pXJ2NW3qLO8YioSpbKcr8XhwNH2eNRgT22Pe6cPucBIZ8HGJqjyK4NiXI8M/Wv8tXyDOHrEj1ih1vkOS8xlZAlVNxbHpZrSywUpNMb1VnJHSBgIvM4Dc7iUJHPq1ykxd2S4QgdzF8tXsyxbXDxGkjIs0/rM=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2020 09:27:33.0870
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd0be8f-02b9-4041-540f-08d7af9dca1f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4413
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12. 02. 20 10:25, Geert Uytterhoeven wrote:
> Hi Max,
> 
> On Wed, Feb 12, 2020 at 10:23 AM Max Filippov <jcmvbkbc@gmail.com> wrote:
>> On Wed, Feb 12, 2020 at 1:16 AM Michal Simek <michal.simek@xilinx.com> wrote:
>>>
>>> Generated files are also checked by sparse that's why add newline
>>> to remove sparse (C=1) warning.
>>>
>>> The issue was found on Microblaze and reported like this:
>>> ./arch/microblaze/include/generated/uapi/asm/unistd_32.h:438:45:
>>> warning: no newline at end of file
>>>
>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>> Reviewed-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
> 
>>> --- a/arch/m68k/kernel/syscalls/syscallhdr.sh
>>> +++ b/arch/m68k/kernel/syscalls/syscallhdr.sh
>>> @@ -33,4 +33,5 @@ grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
>>>         printf "#endif\n"
>>>         printf "\n"
>>>         printf "#endif /* %s */\n" "${fileguard}"
>>
>> Here there's already \n at the end, so no need for another one?
> 
> Thanks! I completely missed that.
> So I did fix the original while applying ;-)

I can drop m68k or align with with others. I would prefer to have the
same solution in all these scripts.

Thanks,
Michal
