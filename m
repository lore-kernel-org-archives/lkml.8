Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E21C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 08:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC2520772
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 08:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dfdgAQd8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbgCZIB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 04:01:26 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:47929 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726279AbgCZIBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 04:01:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585209683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RJQEHD1Ows+hM3qEdzrVtapLFzvX7w+mPGqMQ54jHjc=;
        b=dfdgAQd84MhroGXfDthoYySvgyUkWBfqshE98cuY0vFuzIaGxhob+DOTpkfCun5ypZqJa0
        3En5hE6UVlTdxTnMLbNSxjZ+czuQjTnY7wcV8IdVLaR1BAX7q+T/SThsH8wi0FL1PFGta5
        cLIr4tlnoeeLc+4ZJTwtc0eCue3GWwg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-NbOknJugNtuXePa-kzi4cg-1; Thu, 26 Mar 2020 04:01:22 -0400
X-MC-Unique: NbOknJugNtuXePa-kzi4cg-1
Received: by mail-wm1-f69.google.com with SMTP id s15so1834990wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 01:01:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RJQEHD1Ows+hM3qEdzrVtapLFzvX7w+mPGqMQ54jHjc=;
        b=sAB43Ww+/HcVz47SiH8aU8S7WCHUTX/zilpGKaTuOq2spDuvk3zTg3HAoEDeS6vkiC
         QFV+FWDzy0GaFHL1iwUVj9fGpQDxLQmnIMugI15q0REoSowLicRYaLJW6XQptRbRFQnM
         bKnOSk7mhhGC2ev0c+yS2nITMszLHoIntHjSBGsrxYfWl3tkMOT+aNRCou7Zbs7i6Sc/
         cDUhB7q+bXz214AlVUNG28xaPmVXuZEb7yjoUAwzRy1ggSiWgdFEC2S03xnnpZbXrjGJ
         AUh31b48qT1TxgP6sKEheghJiMfCZfbjLsQEC1e4vNzR73TtIezJpvs/dz6iX4l98axC
         xQ6w==
X-Gm-Message-State: ANhLgQ2mAiwDm0qYh70+L4tzQUgjHjdo3mmjDIHsUbg7srQCPNH/SRck
        C7bbAWKXiySuvdWTwaU+iqYsiVtLtY26/FGS+0kQOnaIKsawjrgO/UX+ijbe1opu6R9O4pbTOFI
        P4uFYSDFOa8q+kpJRnsCfEo7g
X-Received: by 2002:a7b:c051:: with SMTP id u17mr1819000wmc.150.1585209680962;
        Thu, 26 Mar 2020 01:01:20 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtb3KkNGE9dbBjniJ2El19flvQdOIpIUXw84Dn8sx/bYR/Y/0OWQrFeSni9SBX0KbEtrOZyWQ==
X-Received: by 2002:a7b:c051:: with SMTP id u17mr1818967wmc.150.1585209680674;
        Thu, 26 Mar 2020 01:01:20 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:58d:8400:ecf6:58e2:9c06:a308? ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id o9sm2456132wrx.48.2020.03.26.01.01.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2020 01:01:19 -0700 (PDT)
Subject: Re: [PATCH v3 26/26] objtool: Add STT_NOTYPE noinstr validation
To:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
References: <20200324153113.098167666@infradead.org>
 <20200324160925.470421121@infradead.org>
 <20200324221616.2tdljgyay37aiw2t@treble>
 <20200324223455.GV2452@worktop.programming.kicks-ass.net>
 <20200325144211.irnwnly37fyhapvx@treble>
 <20200325155348.GA20696@hirez.programming.kicks-ass.net>
 <20200325164046.p2oxemcjnj2tnxbz@treble>
 <20200325165050.GC20696@hirez.programming.kicks-ass.net>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <bda9603b-df93-8012-ec2b-b3feceab530c@redhat.com>
Date:   Thu, 26 Mar 2020 08:01:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200325165050.GC20696@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/25/20 4:50 PM, Peter Zijlstra wrote:
> On Wed, Mar 25, 2020 at 11:40:46AM -0500, Josh Poimboeuf wrote:
>> On Wed, Mar 25, 2020 at 04:53:48PM +0100, Peter Zijlstra wrote:
>>> On Wed, Mar 25, 2020 at 09:42:11AM -0500, Josh Poimboeuf wrote:
>>>> Sure, but couldn't validate_unwind_hints() and
>>>> validate_reachable_instructions() be changed to *only* run on
>>>> .noinstr.text, for the vmlinux case?  That might help converge the
>>>> vmlinux and !vmlinux paths.
>>>
>>> You're thinking something like so then?
>>
>> Not exactly.  But I don't want to keep churning this patch set.  I can
>> add more patches later, so don't worry about it.
>>
>> But I was thinking it would eventually be good to have the top-level
>> check() be like
>>
>> 	sec = NULL;
>> 	if (!validate_all)
>> 		sec = find_section_by_name(file->elf, ".noinstr.text");
>>
>> 	ret = validate_functions(&file, sec);
>> 	if (ret < 0)
>> 		goto out;
>> 	warnings += ret;
>>
>> 	ret = validate_unwind_hints(&file, sec);
>> 	if (ret < 0)
>> 		goto out;
>> 	warnings += ret;
>>
>> 	if (!warnings) {
>> 		ret = validate_reachable_instructions(&file, sec);
>> 		if (ret < 0)
>> 			goto out;
>> 		warnings += ret;
>> 	}
>>
>> 	if (!validate_all)
>> 		goto out;
>>
>> 	ret = validate_retpoline(&file);
>> 	....
>>
>> that way the general flow is the same regardless...
> 
> Ah,... I see what you mean, there's two little wrinkles with that:
> 
>   - validate_reachable_instructions() is strictly superluous, it does no
>     additional validation between the !vmlinux and vmlinux mode, so I'd
>     put that if (!validate_all) goto out, one up.
> 
>   - tglx has a patch adding .entry.text to be considered as noinstr as a
>     whole, which has:
> 
> 
> @@ -2636,11 +2637,16 @@ static int validate_vmlinux_functions(st
>   	int warnings = 0;
>   
>   	sec = find_section_by_name(file->elf, ".noinstr.text");
> -	if (!sec)
> -		return 0;
> +	if (sec) {
> +		warnings += validate_section(file, sec);
> +		warnings += validate_unwind_hints(file, sec);
> +	}
>   
> -	warnings += validate_section(file, sec);
> -	warnings += validate_unwind_hints(file, sec);
> +	sec = find_section_by_name(file->elf, ".entry.text");
> +	if (sec) {
> +		warnings += validate_section(file, sec);
> +		warnings += validate_unwind_hints(file, sec);
> +	}
>   
>   	return warnings;
>   }
> 
> Anyway, yes, we can do this on top.
> 
> I was going to commit the first 17 patches to tip/core/objtool and
> repost the remaining 13 once more. And then see how much pain I did to
> Julien's patches :-)
> 

I appreciate the concideration for my patches but, since your patches 
have been posted a few times already and were already reviewed, you 
might as well commit them. I'll rebase my patches on top and see the 
state of things (I'll need to do that with the whole arm64 series anyway).

I'll try to post the new version fast enough so I'm not behind some 
other major objtool changes :) .

In the mean time I'll have a look at this series and see what I might 
have to change for the rest of the arm64-objtool set!

Thanks,

-- 
Julien Thierry

