Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433A4C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE1120749
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KgOMUmFA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgCMKru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 06:47:50 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50604 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726364AbgCMKru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 06:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584096468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dPrgSzBfc7q8f+uwHFPFc6bQv9S6g5kmlxz5FMlhB9Q=;
        b=KgOMUmFAQ5oOyw8tWBFjJpRBhAoQiBNIwa0wS2SksDCY3xb9aFCRuVGxzmW8KMb5bRWg4D
        i2ug7UYmklAInKrChRwak/60iWpK7I/Ok0l/D3lVAWWPL3Ca5JjwMNIqd4FsK6osQIAynN
        I/hUV0yq6If2Vdsox0pfqAlNtonMrtw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-VEa1wpunOtqIUyxe-IDwPw-1; Fri, 13 Mar 2020 06:47:44 -0400
X-MC-Unique: VEa1wpunOtqIUyxe-IDwPw-1
Received: by mail-wr1-f70.google.com with SMTP id w6so4073464wrm.16
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 03:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dPrgSzBfc7q8f+uwHFPFc6bQv9S6g5kmlxz5FMlhB9Q=;
        b=kTFkn7huaD+p4DhF0XNPgp4z4yUMTjVlFQmc9qMbM72/yNjxRSZ46hydN8ylLEbv4v
         yr0zu7gRfLp/jVZ3b0Tcb9A/IrKUiBmPszX+6affMmFIg5HqitD5Zr8BG7JckRkAq0/Y
         xTsIUpH3rnynY7VK8QtVxUkJxag2b8FeZstfXD0znH6RVI2Sl6Fdq+QIjhZy/5wvlQsg
         AZ54JM+pk18qRyq58xwclZyf54pNCDh0kZK+JL+I9Qjul8swOyIvlzO0fkUPVEeDZmQS
         Qot+7/0mzV5AjB+tHUMZntxJUOt0Azi4H9TVcWv3ZosZ8DbP8NjCDModVdppadrmrTl3
         oE2A==
X-Gm-Message-State: ANhLgQ0c/fO8ihsXvIig5Zr1bhVbvAa1Ej+Gn9X8Jkx/VNOFvi9pdtHP
        PKRoNwAHit83oTMt1kzY+DDOIH1cKflKoHvBBD+uvzvdsFXP2R9ZRThVMwO5A3bs/P0lhKmhoOT
        DvHatJ1vaSS+1sWl0AON3xgMb
X-Received: by 2002:a1c:a502:: with SMTP id o2mr10010531wme.94.1584096462644;
        Fri, 13 Mar 2020 03:47:42 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvojnKTEjmlRlO9kdgJ45rg8UbmBKZbxo1vDBMjVYHzZqI1zSjuXbpdmYhKAaGketBd1E3HtQ==
X-Received: by 2002:a1c:a502:: with SMTP id o2mr10010508wme.94.1584096462339;
        Fri, 13 Mar 2020 03:47:42 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id x13sm16792955wmj.5.2020.03.13.03.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2020 03:47:41 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] x86/purgatory: Make sure we fail the build if
 purgatory.ro has missing symbols
To:     Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20200311214601.18141-1-hdegoede@redhat.com>
 <20200311214601.18141-3-hdegoede@redhat.com>
 <20200312001006.GA170175@rani.riverdale.lan>
 <3d58e77d-41e5-7927-fe84-4c058015e469@redhat.com>
 <20200312114225.GB15619@zn.tnic>
 <899f366e-385d-bafa-9051-4e93dc9ba321@redhat.com>
 <20200312125032.GC15619@zn.tnic>
 <20200313044235.GA1159234@rani.riverdale.lan>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <69a22dce-b339-90a8-fbfb-30a285c23b5a@redhat.com>
Date:   Fri, 13 Mar 2020 11:47:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200313044235.GA1159234@rani.riverdale.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/13/20 5:42 AM, Arvind Sankar wrote:
> On Thu, Mar 12, 2020 at 01:50:39PM +0100, Borislav Petkov wrote:
>> On Thu, Mar 12, 2020 at 12:58:24PM +0100, Hans de Goede wrote:
>>> My version of this patch has already been tested this way. It is
>>
>> Tested with kexec maybe but if the 0day bot keeps finding breakage, that
>> ain't good enough.
>>
>>> 1. Things are already broken, my patch just exposes the brokenness
>>> of some configs, it is not actually breaking things (well it breaks
>>> the build, changing a silent brokenness into an obvious one).
>>
>> As I already explained, that is not good enough.
>>
>>> 2. I send out the first version of this patch on 7 October 2019, it
>>> has not seen any reaction until now. So I'm sending out new versions
>>> quickly now that this issue is finally getting some attention...
>>
>> And that is never the right approach.
>>
>> Maintainers are busy as hell so !urgent stuff gets to wait. Spamming
>> them with more patchsets does not help - fixing stuff properly does.
>>
>> So, to sum up: if Arvind's approach is the better one, then we should do
>> that and s390 should be fixed this way too. And all tested. And we will
>> remove the hurry element from it all since it has not been noticed so
>> far so it is not urgent and we can take our time and fix it properly.
>>
>> Ok?
>>
>> Thx.
>>
>> -- 
>> Regards/Gruss,
>>      Boris.
>>
>> https://people.kernel.org/tglx/notes-about-netiquette
> 
> If I could try to summarize the situation here:
> - the purgatory requires filtering out certain CFLAGS/other settings set
>    for the generic kernel in order to work correctly
> - the patch proposed by Hans de Goede will detect missing filters at
>    build time rather than when kexec is executed
> - the filtering is currently not perfect as demonstrated by issues that
>    0day bot is finding -- but the patchset will find these problems at
>    build time rather than runtime
> - there might be a slight optimization as proposed by me [1] but it
>    might have problems as in [2] even if it seems to work
> 
> I think the patch as of v5 [0] is useful right now, to catch CFLAGS
> additions that aren't currently being filtered correctly. The real
> problem is that there exist CFLAGS that should be used for all source
> files in the kernel, and there are CFLAGS (eg tracing, stack check etc)
> that should only be used for the kernel proper. For special
> compilations, such as boot stubs, vdso's, purgatory we should have the
> generic CFLAGS but not the kernel-proper CFLAGS. The issue currently is
> that these special compilations need to filter out all the flags added
> for kernel-proper, and this is a moving target as more tracing/sanity
> flags get added.  Neither the solution of simply re-initializing CFLAGS
> (which will miss generic CFLAGS) nor trying to filter out CFLAGS (which
> will miss new kernel-proper CFLAGS) works very well. I think ideally
> splitting these into independent variables, i.e. BASE_FLAGS that can be
> used for everything, and KERNEL_FLAGS only to be used for the kernel
> proper is likely eventually the better solution, rather than conflating
> both into KBUILD_CFLAGS.
> 
> But to move forward incrementally, patch v5 is probably the cleanest. My
> suggestion in [1] I'm thinking is changing things significantly for
> kexec, by changing the purgatory from a relocatable object file into an
> actual executable, and might have knock-on implications that need to be
> reviewed and tested carefully before it can be merged, as shown by [2].
> 
> [0] https://lore.kernel.org/lkml/20200312114951.56009-1-hdegoede@redhat.com/
> [1] https://lore.kernel.org/lkml/20200312001006.GA170175@rani.riverdale.lan/
> [2] https://lore.kernel.org/lkml/20200312182322.GA506594@rani.riverdale.lan/

Thank you for taking such a detailed look at this.

Given your concerns about the alternative fix you proposed I agree that
it is best to just move forward with my v5 patch-set for now; and then we
can try to improve the missing-symbols check in the future.

Regards,

Hans



