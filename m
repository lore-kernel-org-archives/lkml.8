Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52E0C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 04:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF65320747
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 04:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587614939;
	bh=3cXqtrPqFZtGEE2QuB6mHOZWYFLevOQfzg71cc2sSAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SgpgEhNCcCNVglMFdnGW735UrLmVdNuBn7cdv1xGLeWvMkVDqRc356NKzf1w/jMo6
	 F3OeLKeLzaN/L8gM50GcED3uovRJjJNJylg1KOz///9PZpXCUKOwWDRceRXDTeOD5s
	 KCPP8gJUTjo4YoHHdxpFV+4pN91Ij497+D9iUk2M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgDWEIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 00:08:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbgDWEIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 00:08:53 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A4F8206B9;
        Thu, 23 Apr 2020 04:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587614932;
        bh=3cXqtrPqFZtGEE2QuB6mHOZWYFLevOQfzg71cc2sSAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0VdaJGo9blhK/GCtS0iW8sKlpbVzK6Jj1xQ8Kx1zs/9xDZ5oJY9QYKcyhlKvixy+s
         meMEoQfxUO+IsQItO/BpzTDYH2qF3ecXo5YnRtVE4stRhXHdtMHqUr9KXsaQt5giCK
         d8vI4vxBzYxEOA/fU+wuNpYoKYb2FjN0tp426JXc=
Date:   Thu, 23 Apr 2020 00:08:50 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "bp@alien8.de" <bp@alien8.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Pedro Alves <palves@redhat.com>,
        Simon Marchi <simark@simark.ca>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 00/17] Enable FSGSBASE instructions
Message-ID: <20200423040850.GY1809@sasha-vm>
References: <20200421195629.GE608746@tassilo.jf.intel.com>
 <5957D3CC-B54B-4A1A-998A-0E6F58589CF4@amacapital.net>
 <20200421205119.GK1809@sasha-vm>
 <CALCETrUGuvMgvcsUWsdmUr-=6c6BpRpOKC1MN+E16g17U7vyMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrUGuvMgvcsUWsdmUr-=6c6BpRpOKC1MN+E16g17U7vyMQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 04:00:16PM -0700, Andy Lutomirski wrote:
>On Tue, Apr 21, 2020 at 1:51 PM Sasha Levin <sashal@kernel.org> wrote:
>>
>> On Tue, Apr 21, 2020 at 01:21:39PM -0700, Andy Lutomirski wrote:
>> >
>> >
>> >> On Apr 21, 2020, at 12:56 PM, Andi Kleen <ak@linux.intel.com> wrote:
>> >>
>> >> ﻿
>> >>>
>> >>> Andi's point is that there is no known user it breaks, and the Intel
>> >>> folks did some digging into potential users who might be affected by
>> >>> this, including 'rr' brought up by Andy, and concluded that there won't
>> >>> be breakage as a result of this patchset:
>> >>>
>> >>>    https://mail.mozilla.org/pipermail/rr-dev/2018-March/000616.html
>> >>>
>> >>> Sure, if you poke at it you could see a behavior change, but is there
>> >>> an actual user that will be affected by it? I suspect not.
>> >>
>> >> Actually we don't know of any behavior changes caused by the kernel
>> >> with selectors.
>> >>
>> >> The application can change itself of course, but only if it uses the
>> >> new instructions, which no current application does.
>> >
>> >If you use ptrace to change the gs selector, the behavior is different on a patched kernel.
>> >
>> >Again, I’m not saying that the change is problematic. But I will say that the fact that anyone involved in this series keeps ignoring this fact makes me quite uncomfortable with the patch set.
>>
>> That's what I referred to with "poke at it". While the behavior may be
>> different, I fail to find anyone who cares.
>>
>> >>
>> >> [This was different in the original patch kit long ago which could
>> >> change behavior on context switch for programs with out of sync selectors,
>> >> but this has been long fixed]
>> >
>> >That’s the issue I was referring to.
>> >
>> >>
>> >> A debugger can also change behavior, but we're not aware of any case
>> >> that it would break.
>> >
>> >How hard did you look?
>>
>> Come on, how does one respond to this?
>>
>> Is there a real use case affected by this? If so, point it out and I'll
>> be happy to go test it. This was already done (per your previous
>> request) for gdb and rr.
>>
>
>gdb and rr are certainly a good start.  If patches show up, I'll take a look.

I'm sorry, but what patches are we talking about?

I just went to gdb to check again that I'm not crazy, and the scenario
you were worried about seems to work just fine:

134			asm volatile ("mov %%gs:(%%rcx), %%rax" : : "c" (offset) : "rax");
(gdb) p printme()
Hi!
$1 = void
(gdb)

Again, please point me to a specific user we break.

-- 
Thanks,
Sasha
