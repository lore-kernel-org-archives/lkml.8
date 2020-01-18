Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26CAC33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 02:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C155C21D7D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 02:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730639AbgARCSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 21:18:13 -0500
Received: from ZXSHCAS1.zhaoxin.com ([203.148.12.81]:22444 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727033AbgARCSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 21:18:13 -0500
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Sat, 18 Jan
 2020 10:18:05 +0800
Received: from [10.32.64.11] (10.32.64.11) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Sat, 18 Jan
 2020 10:18:01 +0800
Subject: Re: [PATCH] x86/cpu: remove redundant cpu_detect_cache_sizes
To:     Borislav Petkov <bp@alien8.de>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <DavidWang@zhaoxin.com>, <CooperYan@zhaoxin.com>,
        <QiyuanWang@zhaoxin.com>, <HerryYang@zhaoxin.com>
References: <1579075257-6985-1-git-send-email-TonyWWang-oc@zhaoxin.com>
 <20200117184720.GB31472@zn.tnic>
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Message-ID: <ecc18541-f3c3-b887-0c4d-b9d404b0246b@zhaoxin.com>
Date:   Sat, 18 Jan 2020 10:18:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200117184720.GB31472@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.32.64.11]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/01/2020 02:47, Borislav Petkov wrote:
> On Wed, Jan 15, 2020 at 04:00:57PM +0800, Tony W Wang-oc wrote:
>> Before call cpu_detect_cache_sizes get l2size from CPUID.80000006,
>> these CPUs have called init_intel_cacheinfo get l2size/l3size from
>> CPUID.4.
> 
> Questions:
> 
> * Does CPUID(4) give the same result as CPUID(80000006) on those CPUs?

Yes.
On these CPUs, CPUID(80000006).EBX for x86_tlbsize is reserved,
CPUID(80000006).ECX for l2size has the same result as CPUID(4).

> 
> * cpu_detect_cache_sizes() sets c->x86_tlbsize while
> init_intel_cacheinfo() would set it only when it calls the former
> function - cpu_detect_cache_sizes() - at the end:
> 
>         if (!l2)
>                 cpu_detect_cache_sizes(c);
> 
> Does that happen on those CPUs?

No.
On these CPUs, will not call the function cpu_detect_cache_sizes(c).
l2size will get from CPUID(4) and c->x86_tlbsize remain its default
value of 0.

Sincerely
TonyWWang-oc
