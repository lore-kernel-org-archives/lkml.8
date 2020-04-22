Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77241C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 14:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53C362077D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 14:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="t1f11tze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgDVONU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 10:13:20 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59042 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgDVONT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 10:13:19 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03MDwgoI055667;
        Wed, 22 Apr 2020 14:12:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=ZV2dTZE76GuHVFcrIlNmPhF2BlnBeLy7oz/maxvdvFo=;
 b=t1f11tze3ABFON+3ypjcoF2u3DqtWifTu+VWgLn5s57ySZt4gq8R07mUJuPRs09jC2hP
 yP/Mqv8lqPrPyqtynR7ixbKmP/zCn/AXUm+U1IVQhcQagcYEkGG5sHj5SGZs6i9DLeTP
 XJsyMk3DBiKLHuzWkF/yy8ptDv+r/9tc5EzxMw0MZQPIwijE+75vukDMEhqKo5GktlvR
 JBoYYqOBRzUjVrJqA5LVEEjif6VYlnF2cG5ayHiHtwBhcCLCT7LUzB9NG9LAyS9In61D
 q6XMUR4SmQyQzClG6a7mLCpXceq5kdpx6wBCfKe8LSYwhxBXiLkUbdHWijcss2Hs/8lm Sw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 30jhyc1wjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Apr 2020 14:12:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03ME8RP7114346;
        Wed, 22 Apr 2020 14:12:50 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 30gb1jn4dh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Apr 2020 14:12:50 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03MECnYb016668;
        Wed, 22 Apr 2020 14:12:49 GMT
Received: from [192.168.0.190] (/68.201.65.98)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 22 Apr 2020 07:12:48 -0700
Subject: Re: [BISECTED]: Kernel panic (was: Linux 5.7-rc2)
To:     Giovanni Gherdovich <ggherdovich@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Harald Arnesen <harald@skogtun.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wiQsJu-ZFjt7+c9FVD5R40khtZiihrT+7O3UaVvHYz=HQ@mail.gmail.com>
 <428bac87-b6dd-0867-c8f8-622cd606de3e@skogtun.org>
 <CAHk-=wiX+NT2yxtdPszH9U_S96MCNQA56GJFXY45mZc47yG5KQ@mail.gmail.com>
 <20200421212347.GV2483@worktop.programming.kicks-ass.net>
 <1587546150.9537.84.camel@suse.cz>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
Autocrypt: addr=dave.kleikamp@oracle.com; prefer-encrypt=mutual; keydata=
 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
 rnNNL3zBkwD3nWcTxFnX
Message-ID: <5b9531e1-e0ae-cf5d-84f2-6bbb5c2cd089@oracle.com>
Date:   Wed, 22 Apr 2020 09:12:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1587546150.9537.84.camel@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9598 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004220112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9598 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 clxscore=1011 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004220112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/20 4:02 AM, Giovanni Gherdovich wrote:
> Linus, Peter:
> 
> the panic seen by Harald Arnesen (and Dave Kleikamp) is unrelated to
> virtualization, and happens on all machines that have a CPU with less than 4
> physical cores. It's a very serious (and very stupid) bug in the original
> version of my code and is fixed by patch 2/4 "x86, sched: Account for CPUs
> with less than 4 cores in freq. invariance" in the series 
> 
> https://lore.kernel.org/lkml/20200416054745.740-1-ggherdovich@suse.cz
> 
> Harald, Dave:
> 
> for peace of mind, can you please share the output of
> 
>   turbostat --interval 1 sleep 0

This is a Lenovo T410.

turbostat version 20.03.20 - Len Brown <lenb@kernel.org>
CPUID(0): GenuineIntel 0xb CPUID levels; 0x80000008 xlevels; family:model:stepping 0x6:25:5 (6:37:5)
CPUID(1): SSE3 MONITOR SMX EIST TM2 TSC MSR ACPI-TM HT TM
CPUID(6): APERF, TURBO, DTS, No-PTM, No-HWP, No-HWPnotify, No-HWPwindow, No-HWPepp, No-HWPpkg, No-EPB
cpu0: MSR_IA32_MISC_ENABLE: 0x00850089 (TCC EIST MWAIT PREFETCH TURBO)
CPUID(7): No-SGX
cpu0: MSR_MISC_PWR_MGMT: 0x00400000 (ENable-EIST_Coordination DISable-EPB DISable-OOB)
cpu0: MSR_PLATFORM_INFO: 0x90020011200
9 * 133.3 = 1200.0 MHz max efficiency frequency
18 * 133.3 = 2399.9 MHz base frequency
cpu0: MSR_IA32_POWER_CTL: 0x00000000 (C1E auto-promotion: DISabled)
cpu0: MSR_TURBO_RATIO_LIMIT: 0x00001416
20 * 133.3 = 2666.6 MHz max turbo 2 active cores
22 * 133.3 = 2933.3 MHz max turbo 1 active cores
cpu0: MSR_PKG_CST_CONFIG_CONTROL: 0x00000403 (UNlocked, pkg-cstate-limit=3 (pc6))
current_driver: intel_idle
current_governor_ro: menu
cpu0: POLL: CPUIDLE CORE POLL IDLE
cpu0: C1: MWAIT 0x00
cpu0: C1E: MWAIT 0x01
cpu0: C3: MWAIT 0x10
cpu0: C6: MWAIT 0x20
cpu0: cpufreq driver: acpi-cpufreq
cpu0: cpufreq governor: ondemand
cpufreq boost: 1
cpu0: MSR_IA32_TEMPERATURE_TARGET: 0x00690a00 (105 C)
0.001871 sec
Node	Core	CPU	Avg_MHz	Busy%	Bzy_MHz	TSC_MHz	IRQ	SMI	POLL	C1	C1E	C3	C6	POLL%	C1%	C1E%	C3%	C6%	CPU%c1	CPU%c3	CPU%c6	CoreTmp	Pkg%pc3	Pkg%pc6
-	-	-	395	26.14	1493	2430	12	0	0	1	1	10	0	0.00	1.50	0.59	73.54	0.00	28.45	45.41	0.00	63	0.00	0.00
-1	0	0	239	16.27	1473	2397	3	0	0	1	0	2	0	0.00	5.92	0.00	79.10	0.00	51.50	32.23	0.00	62	0.00	0.00
-1	0	1	784	50.12	1574	2385	3	0	0	0	1	2	0	0.00	0.00	2.37	47.20	0.00	17.26
-1	2	2	171	10.80	1598	2373	2	0	0	0	0	2	0	0.00	0.00	0.00	90.00	0.00	30.33	58.88	0.00	63
-1	2	3	358	27.42	1319	2377	4	0	0	0	0	4	0	0.00	0.00	0.00	72.18	0.00	14.64
