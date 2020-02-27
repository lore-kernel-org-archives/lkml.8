Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33687C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07B0C24693
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W/sVBBNh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbgB0M6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:58:54 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55444 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729019AbgB0M6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:58:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582808333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Om0SRg+/XzRunM3fL3lF2XHexrWaTr/sxkRp+GX1RwY=;
        b=W/sVBBNhp1QXWVCIbgmqXakPPFGBwcU2ohR9Pf1WB/M1YWFAn/6bvwl2qhV4qalVR4vvWL
        qfoiK6PF2lDwYUFddtVuxYU6T+9oR9oKNbTmJIqzyylFkYBiQXbzq/WjQIU42GaV0+hS07
        1oydJahhUNkWWjfFlHH2EJkc2VEMr28=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-baq8B8pwORaWBaP8aGs9Wg-1; Thu, 27 Feb 2020 07:58:47 -0500
X-MC-Unique: baq8B8pwORaWBaP8aGs9Wg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69288477;
        Thu, 27 Feb 2020 12:58:45 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.7a2m.lab.eng.bos.redhat.com [10.16.222.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B9C0E19C58;
        Thu, 27 Feb 2020 12:58:43 +0000 (UTC)
Subject: Re: [PATCH] x86/tsc: Add kernel options to disable CPUID and MSR
 calibrations
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Patrick Geary <patrickg@supermicro.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Daniel Drake <drake@endlessm.com>,
        Michael Zhivich <mzhivich@akamai.com>,
        linux-doc@vger.kernel.org
References: <20200226164308.14468-1-prarit@redhat.com>
 <20200226165407.GB18400@hirez.programming.kicks-ass.net>
 <87k149nd4p.fsf@nanos.tec.linutronix.de>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <64e49d3f-ac4c-84ca-e663-92f87aae1362@redhat.com>
Date:   Thu, 27 Feb 2020 07:58:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87k149nd4p.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/26/20 6:27 PM, Thomas Gleixner wrote:
> Peter Zijlstra <peterz@infradead.org> writes:
>> On Wed, Feb 26, 2020 at 11:43:08AM -0500, Prarit Bhargava wrote:
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>> index dbc22d684627..0316aadfff08 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>> @@ -4942,7 +4942,7 @@
>>>  			See Documentation/admin-guide/mm/transhuge.rst
>>>  			for more details.
>>>  
>>> -	tsc=		Disable clocksource stability checks for TSC.
>>> +	tsc=option[,option...]	Various TSC options.
>>>  			Format: <string>
>>>  			[x86] reliable: mark tsc clocksource as reliable, this
>>>  			disables clocksource verification at runtime, as well
>>> @@ -4960,6 +4960,12 @@
>>>  			in situations with strict latency requirements (where
>>>  			interruptions from clocksource watchdog are not
>>>  			acceptable).
>>> +			[x86] no_cpuid_calibration: Disable the CPUID TSC
>>> +			calibration.  Used in situations where the CPUID
>>> +			TSC khz does not match the actual CPU TSC khz
>>> +			[x86] no_msr_calibration: Disable the MSR TSC
>>> +			calibration.  Used in situations where the MSR
>>> +			TSC khz does not match the actual CPU TSC khz.
>>
>> Do we want to mention that these situations are mostly broken firmware?
>> Also do mention that if you disable these you might not boot due to not
>> having a PIT/HPET at all?
> 
> Right. Same discussion as before.
> 
> Also why do we want no_cpuid_calibration and no_msr_calibration? How


> should Joe User figure out which one to use? This does not make
> sense. The point is that the BIOS/Firmware supplied value in system
> registers is bogus. So something like "skip_firmware_calibration" might
> be better suitable.


no_cpuid_calibration was required for Patrick's case where the CPU was
overclocked and therefore the CPUID khz value was invalid, but the MSR value is
good.  I had to skip both to get to the PIT calibration because I had broken FW.
 I don't see how a single skip_firmware_calibration covers these cases.

> 
> Aside of that this really wants to be combined with the ability to
> supply the actual frequency on the command line as I suggested in the
> other thread to cope with machines which do not expose PIT/HPET or have
> broken variants of them.

tglx, can you give a lore link to the thread?

Thanks,

P.
> 
> Thanks,
> 
>         tglx
> 
> 

