Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74EDC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8473F207FD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgCFJNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 04:13:24 -0500
Received: from ZXSHCAS1.zhaoxin.com ([203.148.12.81]:19282 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726047AbgCFJNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 04:13:24 -0500
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Fri, 6 Mar
 2020 17:13:16 +0800
Received: from [10.32.64.44] (10.32.64.44) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Fri, 6 Mar
 2020 17:13:14 +0800
Subject: Re: [PATCH v1 0/2] x86/Kconfig: modify X86_UMIP depends on CPUs
To:     Sean Christopherson <sean.j.christopherson@intel.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <DavidWang@zhaoxin.com>, <CooperYan@zhaoxin.com>,
        <QiyuanWang@zhaoxin.com>, <HerryYang@zhaoxin.com>
References: <1583390951-4103-1-git-send-email-TonyWWang-oc@zhaoxin.com>
 <20200305155115.GC11500@linux.intel.com>
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Message-ID: <35a6558c-1f92-d921-6998-ce639a8edaf6@zhaoxin.com>
Date:   Fri, 6 Mar 2020 17:12:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200305155115.GC11500@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.32.64.44]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05/03/2020 23:51, Sean Christopherson wrote:
> On Thu, Mar 05, 2020 at 02:49:09PM +0800, Tony W Wang-oc wrote:
>> CONFIG_X86_UMIP is generic since commit b971880fe79f (x86/Kconfig:
>> Rename UMIP config parameter).
>>
>> Some Centaur family 7 CPUs and Zhaoxin family 7 CPUs support the UMIP
>> feature. So, modify X86_UMIP to cover these CPUs too.
> 
> That leaves UMC_32, TRANSMETA_32 and CYRIX_32 as the last CPU_SUP types
> that don't support UMIP.  Maybe it's time to remove the CPU_SUP checks
> altogether, same as X86_SMAP?

While the UMIP is a generic X86 CPU feature, I think this way is better.

Sincerely
TonyWWang-oc
> 
>> Tony W Wang-oc (2):
>>   x86/Kconfig: Make X86_UMIP to cover Centaur CPUs
>>   x86/Kconfig: Make X86_UMIP to cover Zhaoxin CPUs
>>
>>  arch/x86/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> -- 
>> 2.7.4
>>
> .
> 
