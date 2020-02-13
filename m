Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82162C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 14:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E485218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 14:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbgBMOhW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 09:37:22 -0500
Received: from mga11.intel.com ([192.55.52.93]:21000 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbgBMOhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 09:37:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 06:37:21 -0800
X-IronPort-AV: E=Sophos;i="5.70,437,1574150400"; 
   d="scan'208";a="227248670"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 06:37:18 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Michel =?utf-8?Q?D=C3=A4nzer?= <michel@daenzer.net>,
        Nathan Chancellor <natechancellor@gmail.com>
Cc:     clang-built-linux@googlegroups.com,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [Intel-gfx] [PATCH v2] drm/i915: Disable -Wtautological-constant-out-of-range-compare
In-Reply-To: <d81a2cfe-79b6-51d4-023e-0960c0593856@daenzer.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200211050808.29463-1-natechancellor@gmail.com> <20200211061338.23666-1-natechancellor@gmail.com> <4c806435-f32d-1559-9563-ffe3fa69f0d1@daenzer.net> <20200211203935.GA16176@ubuntu-m2-xlarge-x86> <f3a6346b-2abf-0b6a-3d84-66e12f700b2b@daenzer.net> <20200212170734.GA16396@ubuntu-m2-xlarge-x86> <d81a2cfe-79b6-51d4-023e-0960c0593856@daenzer.net>
Date:   Thu, 13 Feb 2020 16:37:15 +0200
Message-ID: <877e0qy2n8.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2020, Michel Dänzer <michel@daenzer.net> wrote:
> On 2020-02-12 6:07 p.m., Nathan Chancellor wrote:
>> On Wed, Feb 12, 2020 at 09:52:52AM +0100, Michel Dänzer wrote:
>>> On 2020-02-11 9:39 p.m., Nathan Chancellor wrote:
>>>> On Tue, Feb 11, 2020 at 10:41:48AM +0100, Michel Dänzer wrote:
>>>>> On 2020-02-11 7:13 a.m., Nathan Chancellor wrote:
>>>>>> A recent commit in clang added -Wtautological-compare to -Wall, which is
>>>>>> enabled for i915 so we see the following warning:
>>>>>>
>>>>>> ../drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:1485:22: warning:
>>>>>> result of comparison of constant 576460752303423487 with expression of
>>>>>> type 'unsigned int' is always false
>>>>>> [-Wtautological-constant-out-of-range-compare]
>>>>>>         if (unlikely(remain > N_RELOC(ULONG_MAX)))
>>>>>>             ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
>>>>>>
>>>>>> This warning only happens on x86_64 but that check is relevant for
>>>>>> 32-bit x86 so we cannot remove it.
>>>>>
>>>>> That's suprising. AFAICT N_RELOC(ULONG_MAX) works out to the same value
>>>>> in both cases, and remain is a 32-bit value in both cases. How can it be
>>>>> larger than N_RELOC(ULONG_MAX) on 32-bit (but not on 64-bit)?
>>>>>
>>>>
>>>> Hi Michel,
>>>>
>>>> Can't this condition be true when UINT_MAX == ULONG_MAX?
>>>
>>> Oh, right, I think I was wrongly thinking long had 64 bits even on 32-bit.
>>>
>>>
>>> Anyway, this suggests a possible better solution:
>>>
>>> #if UINT_MAX == ULONG_MAX
>>> 	if (unlikely(remain > N_RELOC(ULONG_MAX)))
>>> 		return -EINVAL;
>>> #endif
>>>
>>>
>>> Or if that can't be used for some reason, something like
>>>
>>> 	if (unlikely((unsigned long)remain > N_RELOC(ULONG_MAX)))
>>> 		return -EINVAL;
>>>
>>> should silence the warning.
>> 
>> I do like this one better than the former.
>
> FWIW, one downside of this one compared to all alternatives (presumably)
> is that it might end up generating actual code even on 64-bit, which
> always ends up skipping the return.

I like this better than the UINT_MAX == ULONG_MAX comparison because
that creates a dependency on the type of remain.

Then again, a sufficiently clever compiler could see through the cast,
and flag the warning anyway...

BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
