Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47959C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 02:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B51120708
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 02:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgGGCon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 22:44:43 -0400
Received: from ZXSHCAS1.zhaoxin.com ([203.148.12.81]:51916 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726434AbgGGCon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 22:44:43 -0400
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 7 Jul 2020
 10:44:39 +0800
Received: from [10.32.56.62] (10.32.56.62) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 7 Jul 2020
 10:44:36 +0800
Subject: Re: [PATCH] x86/cpufeatures: Add new Zhaoxin CPU features
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <x86@kernel.org>, <hpa@zytor.com>,
        <pawan.kumar.gupta@linux.intel.com>, <jpoimboe@redhat.com>,
        <peterz@infradead.org>, <thellstrom@vmware.com>,
        <mgross@linux.intel.com>, <kim.phillips@amd.com>,
        <linux-kernel@vger.kernel.org>, <DavidWang@zhaoxin.com>,
        <CooperYan@zhaoxin.com>, <QiyuanWang@zhaoxin.com>,
        <HerryYang@zhaoxin.com>, <CobeChen@zhaoxin.com>
References: <1593429689-25131-1-git-send-email-TonyWWang-oc@zhaoxin.com>
 <20200706160228.GA4663@agluck-desk2.amr.corp.intel.com>
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Message-ID: <3de2dfe9-0b17-d32b-1924-149722ac96fd@zhaoxin.com>
Date:   Tue, 7 Jul 2020 10:43:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200706160228.GA4663@agluck-desk2.amr.corp.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.32.56.62]
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/07/2020 00:02, Luck, Tony wrote:
> On Mon, Jun 29, 2020 at 07:21:29PM +0800, Tony W Wang-oc wrote:
>> Add new Zhaoxin CPU features for enumeration in /proc/cpuinfo:
>> SM2, SM2_EN, SM3, SM4, SM3_EN, SM4_EN, PARALLAX, PARALLAX_EN,
>> TM3, TM3_EN, RNG2, RNG2_EN, PHE2, PHE2_EN, RSA, RSA_EN.
>>
>> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 0]  SM2
>> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 1]  SM2_EN
>> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 4]  SM3 SM4
>> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 5]  SM3_EN SM4_EN
>> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 16] PARALLAX
>> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 17] PARALLAX_EN
>> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 20] TM3
>> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 21] TM3_EN
>> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 22] RNG2
>> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 23] RNG2_EN
>> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 25] PHE2
>> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 26] PHE2_EN
>> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 27] RSA
>> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 28] RSA_EN
>>
>> SM2, SM3, SM4 are Chinese Cipher Security algorithm.
>> PARALLAX is a feature that automatically adjusts processors's voltage
>> as a function of temperature.
>> TM3 is Zhaoxin CPU Thermal Monitor v3.
>> RNG2 is Zhaoxin Random Number Generation v2.
>> PHE2 is Zhaoxin Padlock Hash Engine v2.
>> RSA is Zhaoxin hardware support for RSA algorithm.
> 
> Boris is on vacation, so I'll ask the question that he would ask
> if he were here ... "Are there some follow-up patches that use all
> of these feature bits?"

No for up to now.

Sincerely
TonyWWang-oc

> 
> Just adding bits to /proc/cpuinfo is of limited use.
> 
> -Tony
> .
> 
