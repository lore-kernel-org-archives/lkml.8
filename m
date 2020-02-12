Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5280CC352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 17:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3543A2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 17:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgBLRRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 12:17:09 -0500
Received: from mail.netline.ch ([148.251.143.178]:59978 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbgBLRRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 12:17:09 -0500
Received: from localhost (localhost [127.0.0.1])
        by netline-mail3.netline.ch (Postfix) with ESMTP id 514DB2A604B;
        Wed, 12 Feb 2020 18:17:06 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
        by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id TidibmeR2N2o; Wed, 12 Feb 2020 18:17:06 +0100 (CET)
Received: from thor (252.80.76.83.dynamic.wline.res.cust.swisscom.ch [83.76.80.252])
        by netline-mail3.netline.ch (Postfix) with ESMTPSA id 01A9A2A6046;
        Wed, 12 Feb 2020 18:17:05 +0100 (CET)
Received: from [::1]
        by thor with esmtp (Exim 4.93)
        (envelope-from <michel@daenzer.net>)
        id 1j1vdJ-000ow8-2f; Wed, 12 Feb 2020 18:17:05 +0100
Subject: Re: [PATCH v2] drm/i915: Disable
 -Wtautological-constant-out-of-range-compare
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        dri-devel@lists.freedesktop.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
References: <20200211050808.29463-1-natechancellor@gmail.com>
 <20200211061338.23666-1-natechancellor@gmail.com>
 <4c806435-f32d-1559-9563-ffe3fa69f0d1@daenzer.net>
 <20200211203935.GA16176@ubuntu-m2-xlarge-x86>
 <f3a6346b-2abf-0b6a-3d84-66e12f700b2b@daenzer.net>
 <20200212170734.GA16396@ubuntu-m2-xlarge-x86>
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <d81a2cfe-79b6-51d4-023e-0960c0593856@daenzer.net>
Date:   Wed, 12 Feb 2020 18:17:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200212170734.GA16396@ubuntu-m2-xlarge-x86>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-12 6:07 p.m., Nathan Chancellor wrote:
> On Wed, Feb 12, 2020 at 09:52:52AM +0100, Michel Dänzer wrote:
>> On 2020-02-11 9:39 p.m., Nathan Chancellor wrote:
>>> On Tue, Feb 11, 2020 at 10:41:48AM +0100, Michel Dänzer wrote:
>>>> On 2020-02-11 7:13 a.m., Nathan Chancellor wrote:
>>>>> A recent commit in clang added -Wtautological-compare to -Wall, which is
>>>>> enabled for i915 so we see the following warning:
>>>>>
>>>>> ../drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:1485:22: warning:
>>>>> result of comparison of constant 576460752303423487 with expression of
>>>>> type 'unsigned int' is always false
>>>>> [-Wtautological-constant-out-of-range-compare]
>>>>>         if (unlikely(remain > N_RELOC(ULONG_MAX)))
>>>>>             ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
>>>>>
>>>>> This warning only happens on x86_64 but that check is relevant for
>>>>> 32-bit x86 so we cannot remove it.
>>>>
>>>> That's suprising. AFAICT N_RELOC(ULONG_MAX) works out to the same value
>>>> in both cases, and remain is a 32-bit value in both cases. How can it be
>>>> larger than N_RELOC(ULONG_MAX) on 32-bit (but not on 64-bit)?
>>>>
>>>
>>> Hi Michel,
>>>
>>> Can't this condition be true when UINT_MAX == ULONG_MAX?
>>
>> Oh, right, I think I was wrongly thinking long had 64 bits even on 32-bit.
>>
>>
>> Anyway, this suggests a possible better solution:
>>
>> #if UINT_MAX == ULONG_MAX
>> 	if (unlikely(remain > N_RELOC(ULONG_MAX)))
>> 		return -EINVAL;
>> #endif
>>
>>
>> Or if that can't be used for some reason, something like
>>
>> 	if (unlikely((unsigned long)remain > N_RELOC(ULONG_MAX)))
>> 		return -EINVAL;
>>
>> should silence the warning.
> 
> I do like this one better than the former.

FWIW, one downside of this one compared to all alternatives (presumably)
is that it might end up generating actual code even on 64-bit, which
always ends up skipping the return.


-- 
Earthling Michel Dänzer               |               https://redhat.com
Libre software enthusiast             |             Mesa and X developer
