Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2123BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 19:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAEB12067B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 19:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TJm5UMR1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730376AbgFITLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 15:11:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52555 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726903AbgFITLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 15:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591729893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o+3s8pHFjLY4ydg5m7TokmENlM8QSVe8RKNoTIXHs6I=;
        b=TJm5UMR1uKtOUlqfINjinFC5fpS8gSaBS9P9NjnrvCwbxGt7CVb3weyNYojRiZ/3TzCXiT
        Td3qABiQogz1AldABI4LsVwby7iMD2uhJZoUVGIlrsjjB8HCSHuiN7+3A5FYF6Hzor/WfI
        pV4YkIW5oFaQVdVbWr3bq1q3BMOBM+c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-nK1YHghINjCU3YAC9y2Fdg-1; Tue, 09 Jun 2020 15:11:28 -0400
X-MC-Unique: nK1YHghINjCU3YAC9y2Fdg-1
Received: by mail-wr1-f71.google.com with SMTP id f4so8998296wrp.21
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 12:11:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o+3s8pHFjLY4ydg5m7TokmENlM8QSVe8RKNoTIXHs6I=;
        b=KjyGr7myV6+8GAUcgaovBIlCmJgKNcaN7BKSdHy9ZZQSQlSZ7FlWDkPywEjinFaTLc
         Cml3uE3faYS0uMb8YWc1NI+MM7Eil40YklguF3UfGsXGzXlow6E59nepPHl+ezrRoz04
         KArqglzCK/gVk94jxaY8Kh6FSkT1W1axYpRsKDwAUlNrYLtm/9PXiAA3hgdNXuF/yMDl
         fW2ZF/EcW4xbboqyzop1z76a9EYZ5lQVx54vZAS+O9uYd10kTnzmFugTYxrHz2IO2FNl
         xMJidLH9ueMfIhm+AkHlEJbhl8V+uBf0JUmbQ9YS/a40ePN+GHJfUybNxnml/7n9L+bi
         e2OQ==
X-Gm-Message-State: AOAM5315QEkPMC4cpXb71jzix44qlrRFu/HN1X5yjsf4InOZgYUnpHdh
        rPBSvAdX4scYTVRaOMMi751NDIthU2MFtirztkTcziBkmDDC0dc3heEIeeW0pj4zjfmopVJYFZf
        OsjIHY3hE6n0swLVTHLdj8/yn
X-Received: by 2002:a1c:1983:: with SMTP id 125mr5364617wmz.43.1591729887633;
        Tue, 09 Jun 2020 12:11:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyd8f+ntAfyOZpSYnvf9CpzK1vvvsEco10cw/lrAXupUK8i0t0zqL1pjfT9tc0bym5maDqQew==
X-Received: by 2002:a1c:1983:: with SMTP id 125mr5364601wmz.43.1591729887336;
        Tue, 09 Jun 2020 12:11:27 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:499:3d00:cd47:f651:9d80:157a? ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id s2sm3793377wmh.11.2020.06.09.12.11.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 12:11:26 -0700 (PDT)
Subject: Re: [RFC][PATCH v4 02/32] objtool: Make recordmcount into mcount
 subcmd
To:     Matt Helsley <mhelsley@vmware.com>, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
References: <cover.1591125127.git.mhelsley@vmware.com>
 <0d44e0b1b8ebce4af8b90f73e351a003ef016005.1591125127.git.mhelsley@vmware.com>
 <fe3e0e4e-4f13-5193-c684-f995c8310e54@redhat.com>
 <20200609183951.GE1284251@rlwimi.vmware.com>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <c7011f00-23d2-5d14-d0bb-9d29c4a24c15@redhat.com>
Date:   Tue, 9 Jun 2020 20:11:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200609183951.GE1284251@rlwimi.vmware.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/9/20 7:39 PM, Matt Helsley wrote:
> On Tue, Jun 09, 2020 at 10:00:59AM +0100, Julien Thierry wrote:
>> Hi Matt,
>>
>> On 6/2/20 8:49 PM, Matt Helsley wrote:
>>> Rather than a standalone executable merge recordmcount as a sub command
>>> of objtool. This is a small step towards cleaning up recordmcount and
>>> eventually sharing  ELF code with objtool.
>>>
>>> For the initial step all that's required is a bit of Makefile changes
>>> and invoking the former main() function from recordmcount.c because the
>>> subcommand code uses similar function arguments as main when dispatching.
>>>
>>> objtool ignores some object files that tracing does not, specifically
>>> those with OBJECT_FILES_NON_STANDARD Makefile variables. For this reason
>>> we keep the recordmcount_dep separate from the objtool_dep. When using
>>> objtool mcount we can also, like the other objtool invocations, just
>>> depend on the binary rather than the source the binary is built from.
>>>
>>> Subsequent patches will gradually convert recordmcount to use
>>> more and more of libelf/objtool's ELF accessor code. This will both
>>> clean up recordmcount to be more easily readable and remove
>>> recordmcount's crude accessor wrapping code.
>>>
>>> Signed-off-by: Matt Helsley <mhelsley@vmware.com>
>>> ---
> ...
>>> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
>>> index 743647005f64..ae74647b06fa 100644
>>> --- a/kernel/trace/Kconfig
>>> +++ b/kernel/trace/Kconfig
>>> @@ -59,7 +59,7 @@ config HAVE_NOP_MCOUNT
>>>    config HAVE_C_RECORDMCOUNT
>>>    	bool
>>>    	help
>>> -	  C version of recordmcount available?
>>> +	  C version of objtool mcount available?
>>
>> The "C version" doesn't make much sense here. "Objtool mcount available?" or
>> "mcount subcommand of objtool available?" perhaps?
> 
> Agreed, "C version" is nonsense at this point.
> 
> Looking at the other HAVE_* help messages in that Kconfig suggests:
> 
> 	Arch supports objtool mcount subcommand
> 
> So I've changed it to that.
> 

Yes, that seems good.

>>> diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
>>> index 285474a77fe9..ffef73f7f47e 100644
>>> --- a/tools/objtool/Makefile
>>> +++ b/tools/objtool/Makefile
>>> @@ -31,12 +31,6 @@ OBJTOOL_IN := $(OBJTOOL)-in.o
>>>    LIBELF_FLAGS := $(shell pkg-config libelf --cflags 2>/dev/null)
>>>    LIBELF_LIBS  := $(shell pkg-config libelf --libs 2>/dev/null || echo -lelf)
>>> -RECORDMCOUNT := $(OUTPUT)recordmcount
>>> -RECORDMCOUNT_IN := $(RECORDMCOUNT)-in.o
>>> -ifeq ($(BUILD_C_RECORDMCOUNT),y)
>>> -all:  $(RECORDMCOUNT)
>>> -endif
>>> -
>>>    all: $(OBJTOOL)
>>>    INCLUDES := -I$(srctree)/tools/include \
>>> @@ -55,13 +49,47 @@ AWK = awk
>>>    SUBCMD_CHECK := n
>>>    SUBCMD_ORC := n
>>> +SUBCMD_MCOUNT := n
>>>    ifeq ($(SRCARCH),x86)
>>>    	SUBCMD_CHECK := y
>>>    	SUBCMD_ORC := y
>>> +	SUBCMD_MCOUNT := y
>>> +endif
>>> +
>>> +ifeq ($(SRCARCH),arm)
>>> +	SUBCMD_MCOUNT := y
>>> +endif
>>> +
>>> +ifeq ($(SRCARCH),arm64)
>>> +	SUBCMD_MCOUNT := y
>>> +endif
>>> +
>>> +ifeq ($(SRCARCH),ia64)
>>> +	SUBCMD_MCOUNT := y
>>> +endif
>>> +
>>> +ifeq ($(SRCARCH),mips)
>>> +	SUBCMD_MCOUNT := y
>>> +endif
>>> +
>>> +ifeq ($(SRCARCH),powerpc)
>>> +	SUBCMD_MCOUNT := y
>>> +endif
>>> +
>>> +ifeq ($(SRCARCH),s390)
>>> +	SUBCMD_MCOUNT := y
>>> +endif
>>> +
>>> +ifeq ($(SRCARCH),sh)
>>> +	SUBCMD_MCOUNT := y
>>> +endif
>>> +
>>> +ifeq ($(SRCARCH),sparc)
>>> +	SUBCMD_MCOUNT := y
>>
>> Is there some arch for which MCOUNT is not supported? If not you could just
>> have MCOUNT default to 'y' and avoid adding all those tests (or maybe reduce
>> the numbers and set to 'n' only for arches not supporting it).
> 
> Yes, there are some which it does not support. For those architectures
> we keep recordmcount.pl around.
> 
> It occured to me that with your suggestion to use more CONFIG_ variables
> we could eliminate this pattern and replace it with these pseudo-patches:
> 
> +++ b/kernel/trace/Kconfig
> 
> +config OBJTOOL_SUBCMD_MCOUNT
> +	bool
> +	depends on HAVE_C_RECORDMCOUNT
> +	select OBJTOOL_SUBCMDS
> +	help
> +	  Record mcount call locations using objtool
> 
> and then change the Makefiles to use the CONFIG_ variables
> rather than have one ifeq block per arch:
> 
> +++ b/tools/objtool/Makefile
> 
> +SUBCMD_MCOUNT := $(CONFIG_OBJTOOL_SUBCMD_MCOUNT)
> 
> Does this seem like a good use of CONFIG_ variables or is it going too
> far?
> 

Definitely seems like a good idea to me! Will be a nice improvement.

Cheers,

-- 
Julien Thierry

