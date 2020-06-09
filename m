Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E8DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 19:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 796042076A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 19:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MQPnb2JF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389258AbgFITbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 15:31:14 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51235 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728679AbgFITbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 15:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591731068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F9dJdYadzEO2bKen+k695+nu1VEX+tghWgfADxXcezo=;
        b=MQPnb2JFwWCi9Z9yragplUNLGM2X0sAe+H2YHz9WtdiY62LtCIX2FVj/FPRq5KHECAaEe6
        aMOb9qbAbOAof8Ul6sss/DegWILxTS+P0HNNsT8TotV9q6yqjve0V2Vrk7qukilQzwcqAr
        al/6nD+f0MHn1yIhi02GoBzVpUgtwcs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-2jMhCUY1P1mgNpjGyffn2g-1; Tue, 09 Jun 2020 15:31:07 -0400
X-MC-Unique: 2jMhCUY1P1mgNpjGyffn2g-1
Received: by mail-wm1-f71.google.com with SMTP id k185so833549wme.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 12:31:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F9dJdYadzEO2bKen+k695+nu1VEX+tghWgfADxXcezo=;
        b=BX2zbKig4UngrLVsp5+ZCmDOFxTZqhWgd3gS5o2QawyDryQ7hyIbywYT8eJmmId3P7
         x7gsE6XOsIEkRLr12mpdXufURvWmKc4S6dtjUdV9GGuKJGyRctOhI4W3mg5E67P3b0Fa
         +acSNnqjNnsNoOwdUOzhKxqmhA2Koygre4675MGWoduJHmgDjhzBQ4fnZXtUD4oThd4W
         /68PiUuSNRXBetgYoQSH4Rq7/K07si2dEFDt4ji2RsvsI3KvpkTBa7M5aqReRUI0KeuI
         b8WyOMZqfKONegIOz6xmJ+BnmgIvj/KVG/AO44Dkdbsb5N90z74i5wO8LB8dRhrMRnmY
         N7vQ==
X-Gm-Message-State: AOAM533Q2mMhHOfCuJuXSB9YkAJYCstM/wi75i4sI8fRiRFoGdBHgiU/
        e1EAoGIjy1pVbEYrjgqy/PVkF47sJN+t3KxTMZM432dQrJ0CNN2cWXHKOH0iLvhMVWePBUezd3D
        tLFwH7/YKrJTmrGyo6/+1uhHF
X-Received: by 2002:adf:f507:: with SMTP id q7mr6016967wro.353.1591731066157;
        Tue, 09 Jun 2020 12:31:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHkj86I28FraeOP1PhHSi5A6Fch/qbf9NWhYUvWXyKQRo3jAr7Y+HR7JI1BlkZnUTl6Edohg==
X-Received: by 2002:adf:f507:: with SMTP id q7mr6016953wro.353.1591731065925;
        Tue, 09 Jun 2020 12:31:05 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:499:3d00:cd47:f651:9d80:157a? ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id j5sm4667666wrm.57.2020.06.09.12.31.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 12:31:05 -0700 (PDT)
Subject: Re: [RFC][PATCH v4 01/32] objtool: Prepare to merge recordmcount
To:     Matt Helsley <mhelsley@vmware.com>, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
References: <cover.1591125127.git.mhelsley@vmware.com>
 <4a71852d8ca0a245588159a6bbdc064619de91d9.1591125127.git.mhelsley@vmware.com>
 <1e2783f2-6b52-d750-ecc5-4e3d6d7dba4f@redhat.com>
 <20200609154221.GC1284251@rlwimi.vmware.com>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <35bd9eee-a4c4-dac0-0c6e-aaa3b8004b86@redhat.com>
Date:   Tue, 9 Jun 2020 20:31:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200609154221.GC1284251@rlwimi.vmware.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/9/20 4:42 PM, Matt Helsley wrote:
> On Tue, Jun 09, 2020 at 09:54:33AM +0100, Julien Thierry wrote:
>> Hi Matt,
>>
>> On 6/2/20 8:49 PM, Matt Helsley wrote:
>>> Move recordmcount into the objtool directory. We keep this step separate
>>> so changes which turn recordmcount into a subcommand of objtool don't
>>> get obscured.
>>>
>>> Signed-off-by: Matt Helsley <mhelsley@vmware.com>
> 
> <snip>
> 
>>> diff --git a/Makefile b/Makefile
>>> index 04f5662ae61a..d353a0a65a71 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -844,6 +844,7 @@ ifdef CONFIG_DYNAMIC_FTRACE
>>>    	ifdef CONFIG_HAVE_C_RECORDMCOUNT
>>>    		BUILD_C_RECORDMCOUNT := y
>>>    		export BUILD_C_RECORDMCOUNT
>>> +		objtool_target := tools/objtool FORCE
>>>    	endif
>>>    endif
>>>    endif
>>> @@ -1023,10 +1024,10 @@ endif
>>>    export mod_sign_cmd
>>>    HOST_LIBELF_LIBS = $(shell pkg-config libelf --libs 2>/dev/null || echo -lelf)
>>> +has_libelf := $(call try-run,\
>>> +		echo "int main() {}" | $(HOSTCC) -xc -o /dev/null $(HOST_LIBELF_LIBS) -,1,0)
>>
>> Maybe there could be some build dependency, e.g. CONFIG_OBJTOOL_SUBCMDS that
>> sets the "objtool_target" and "has_libelf" when selected.
>>
>> Then the CONFIG_UNWINDER_ORC, RECORD_MCOUNT and STACK_VALIDATION would just
>> had to select that config option.
> 
> That might save a good amount of control flow in the Makefiles.
> 
> We could take it one step further and have specific CONFIG_OBJTOOL_<subcmd>
> which might help us remove the per-architecture control-flow in
> the multi-arch subcmd support found in tools/objtool/Makefile.
> > What do folks think of that -- too far?
> 

I wasn't completely sure I understood before I saw your reply on the 
next patch. I don't think it's too far, it's cleaner! The current way 
was good enough to deal with only two x86 specific objtool subcommands.

Since you're adding another one and it is likely that more will be added 
in the future, I think it's worth having something a bit more structured 
:) .

>>
>>>    ifdef CONFIG_STACK_VALIDATION
>>> -  has_libelf := $(call try-run,\
>>> -		echo "int main() {}" | $(HOSTCC) -xc -o /dev/null $(HOST_LIBELF_LIBS) -,1,0)
>>>      ifeq ($(has_libelf),1)
>>>        objtool_target := tools/objtool FORCE
>>>      else
>>> @@ -1163,13 +1164,15 @@ uapi-asm-generic:
>>>    PHONY += prepare-objtool
>>>    prepare-objtool: $(objtool_target)
>>> -ifeq ($(SKIP_STACK_VALIDATION),1)
>>> -ifdef CONFIG_UNWINDER_ORC
>>> +ifneq ($(has_libelf),1)
>>> +  ifdef CONFIG_UNWINDER_ORC
>>>    	@echo "error: Cannot generate ORC metadata for CONFIG_UNWINDER_ORC=y, please install libelf-dev, libelf-devel or elfutils-libelf-devel" >&2
>>>    	@false
>>> -else
>>> +  else
>>> +    ifeq ($(SKIP_STACK_VALIDATION),1)
>>>    	@echo "warning: Cannot use CONFIG_STACK_VALIDATION=y, please install libelf-dev, libelf-devel or elfutils-libelf-devel" >&2
>>
>>
>> I think this would be more readable without the else branch:
>>
>> 	ifneq ($(has_libelf),1)
>> 		ifdef <some objtool command config>
>> 			<warn about unavailability>
> 
> Note: error not warn
> 

Good point. But since those are errors, you don't need the "else" :)

>> 		endif
>> 		ifdef <another objtool command config>
>> 			<warn ...>
>> 		endif
>> 		<...>
>> 	endif
> 
> I think the next patch, which makes recordmcount a subcmd, makes it a
> little clearer what the pattern is because it adds another ifdef block
> in the way you suggest.
> 
> As for the else around the SKIP_STACK_VALIDATION check -- it is special
> in a couple ways -- at least as best I can tell.
> 
> It's not a CONFIG_* -- it actually breaks the normal pattern with
> CONFIG_* in that..
> 

Yes but $(SKIP_STACK_VALIDATION) == 1 is actually just 
CONFIG_STACK_VALIDATION && ($(has_libelf) != 1). And since you are 
already in the ifneq ($(has_libelf),1) branch, checking 
$(SKIP_STACK_VALIDATION) == 1 is the same as CONFIG_STACK_VALIDATION 
being defined.

> It's about a judgement call that it's OK to merely warn and skip the
> stack validation rather than produce an error. The other, CONFIG_*
> blocks produce errors.
> 

To me this is minor, we could also imagine another command CONFIG_ 
performing another action than warning or error when libelf is not 
available.

Anyway, this was just a suggestion, I don't want to insist to much on this.

Cheers,

-- 
Julien Thierry

