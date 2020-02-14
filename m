Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73568C3B19F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 558BA222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbgBNPgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:36:23 -0500
Received: from mail.netline.ch ([148.251.143.178]:57912 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729260AbgBNPgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:36:23 -0500
Received: from localhost (localhost [127.0.0.1])
        by netline-mail3.netline.ch (Postfix) with ESMTP id C35892A6046;
        Fri, 14 Feb 2020 16:36:19 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
        by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id hkjvpc2T5O5o; Fri, 14 Feb 2020 16:36:19 +0100 (CET)
Received: from thor (252.80.76.83.dynamic.wline.res.cust.swisscom.ch [83.76.80.252])
        by netline-mail3.netline.ch (Postfix) with ESMTPSA id 2BE0F2A6045;
        Fri, 14 Feb 2020 16:36:19 +0100 (CET)
Received: from localhost ([::1])
        by thor with esmtp (Exim 4.93)
        (envelope-from <michel@daenzer.net>)
        id 1j2d0r-000ACQ-Qm; Fri, 14 Feb 2020 16:36:17 +0100
Subject: Re: [PATCH] drm/i915: Cast remain to unsigned long in eb_relocate_vma
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, clang-built-linux@googlegroups.com
References: <20200214054706.33870-1-natechancellor@gmail.com>
 <87v9o965gg.fsf@intel.com>
 <158166913989.4660.10674824117292988120@skylake-alporthouse-com>
 <87o8u1wfqs.fsf@intel.com>
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <ff302c03-d012-a80d-b818-b7feababb86b@daenzer.net>
Date:   Fri, 14 Feb 2020 16:36:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <87o8u1wfqs.fsf@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-14 12:49 p.m., Jani Nikula wrote:
> On Fri, 14 Feb 2020, Chris Wilson <chris@chris-wilson.co.uk> wrote:
>> Quoting Jani Nikula (2020-02-14 06:36:15)
>>> On Thu, 13 Feb 2020, Nathan Chancellor <natechancellor@gmail.com> wrote:
>>>> A recent commit in clang added -Wtautological-compare to -Wall, which is
>>>> enabled for i915 after -Wtautological-compare is disabled for the rest
>>>> of the kernel so we see the following warning on x86_64:
>>>>
>>>>  ../drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:1433:22: warning:
>>>>  result of comparison of constant 576460752303423487 with expression of
>>>>  type 'unsigned int' is always false
>>>>  [-Wtautological-constant-out-of-range-compare]
>>>>          if (unlikely(remain > N_RELOC(ULONG_MAX)))
>>>>             ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
>>>>  ../include/linux/compiler.h:78:42: note: expanded from macro 'unlikely'
>>>>  # define unlikely(x)    __builtin_expect(!!(x), 0)
>>>>                                             ^
>>>>  1 warning generated.
>>>>
>>>> It is not wrong in the case where ULONG_MAX > UINT_MAX but it does not
>>>> account for the case where this file is built for 32-bit x86, where
>>>> ULONG_MAX == UINT_MAX and this check is still relevant.
>>>>
>>>> Cast remain to unsigned long, which keeps the generated code the same
>>>> (verified with clang-11 on x86_64 and GCC 9.2.0 on x86 and x86_64) and
>>>> the warning is silenced so we can catch more potential issues in the
>>>> future.
>>>>
>>>> Link: https://github.com/ClangBuiltLinux/linux/issues/778
>>>> Suggested-by: Michel Dänzer <michel@daenzer.net>
>>>> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
>>>
>>> Works for me as a workaround,
>>
>> But the whole point was that the compiler could see that it was
>> impossible and not emit the code. Doesn't this break that?
> 
> It seems that goal and the warning are fundamentally incompatible.

Not really:

    if (sizeof(remain) >= sizeof(unsigned long) &&
	unlikely(remain > N_RELOC(ULONG_MAX)))
             return -EINVAL;

In contrast to the cast, this doesn't generate any machine code on 64-bit:

https://godbolt.org/z/GmUE4S

but still generates the same code on 32-bit:

https://godbolt.org/z/hAoz8L


-- 
Earthling Michel Dänzer               |               https://redhat.com
Libre software enthusiast             |             Mesa and X developer
