Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869E5C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7E8A20671
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SIyHO821"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732671AbgEMQ5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 12:57:50 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34609 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727120AbgEMQ5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 12:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589389068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q+xvrP5HCSZn98A/eBhzQxvMQQhmNlPPcvFZhur0b14=;
        b=SIyHO821M9SSpWD4oDcLk5kvUzKrs+N+wcwxYZ+gzVhiKiH+Du67mjKR1h71oZkOt8+jIC
        g9mJhlN5nnxgHipTc5wf3YO/hc+wfhl5iTxTpninQDRxTpV5aEKTsxIxKLlhPGs+92Z5Ye
        KGOIte+5mGwWMarw95GuXAHJ1X7S+yI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-_0ztxGaaMAmK_5lareSYIw-1; Wed, 13 May 2020 12:57:44 -0400
X-MC-Unique: _0ztxGaaMAmK_5lareSYIw-1
Received: by mail-wr1-f70.google.com with SMTP id g10so15270wrr.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 09:57:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q+xvrP5HCSZn98A/eBhzQxvMQQhmNlPPcvFZhur0b14=;
        b=rjj9TastjyJ38bCF2OAkLx/u68/AQ88RvDcGl9nUQp2luLwQU8xtxMT/kC4kZ04Lo1
         QnTbC02OTIVRECS/uwW8wGBRknafBGVFr7azODYAJLgQduviicJdXvHiM8Zj/8lLJOgF
         pFUR3mtER6lkYCEwwTb40Ol9DLeYM2r0DZMq7CJlCaTg7ECb1btItOO4FcTLKflbH/Zx
         D2TvWAqz1cuQiXX6RUNIJHnr9lNeH0/ycYApzUbNw5uLaECvd9KCiqlY2M5ZvJeyDsmD
         IkTLNGdiOP3UAjG3ldp3xkMu3OB8wqc5rCcDvXlipeWv//cFHK7BnOz2QWWpQE78m0bH
         2aCw==
X-Gm-Message-State: AGi0PuahmXYMJlMsKtsmea53K6BfstNOvqpoN1N9fb8FlkJPfYwSCgaa
        ixkAcH80vq5NjX8HE/oo7EXvJO+9JFFJSYdyAIg3uz5hQzIm1cssB8BfxqFT++EyZJjDUN6SkjH
        IYYjI8qjmBSu82LfLG626IwLB
X-Received: by 2002:a1c:4b02:: with SMTP id y2mr21762726wma.115.1589389063667;
        Wed, 13 May 2020 09:57:43 -0700 (PDT)
X-Google-Smtp-Source: APiQypKrBJBjE7Y00pTETr4m9i5isoBWAm8ifHUQHTW7HtyCACojXJzTUOKStCNKWMs3GgiRNq9WKQ==
X-Received: by 2002:a1c:4b02:: with SMTP id y2mr21762710wma.115.1589389063368;
        Wed, 13 May 2020 09:57:43 -0700 (PDT)
Received: from [192.168.1.27] (lfbn-lyo-1-134-107.w86-202.abo.wanadoo.fr. [86.202.218.107])
        by smtp.gmail.com with ESMTPSA id d6sm116094wra.63.2020.05.13.09.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 09:57:42 -0700 (PDT)
Subject: Re: [RFC][PATCH 4/5] objtool: Enable compilation of objtool for all
 architectures
To:     Matt Helsley <mhelsley@vmware.com>, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
References: <cover.1588888003.git.mhelsley@vmware.com>
 <9f709ea2ae66cc03b3ff3329baa8f670ccd0e368.1588888003.git.mhelsley@vmware.com>
 <f9eedb02-54fe-fb96-fbcc-5f40f41e571a@redhat.com>
 <20200513155948.GI9040@rlwimi.vmware.com>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <e369f0a9-30fc-5754-8cff-bf238ab0b716@redhat.com>
Date:   Wed, 13 May 2020 17:55:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200513155948.GI9040@rlwimi.vmware.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/13/20 4:59 PM, Matt Helsley wrote:
> On Tue, May 12, 2020 at 06:04:56PM +0100, Julien Thierry wrote:
>> Hi Matt,
>>
>> On 5/11/20 6:35 PM, Matt Helsley wrote:
>>> objtool currently only compiles for x86 architectures. This is
>>> fine as it presently does not support tooling for other
>>> architectures. However, we would like to be able to convert other
>>> kernel tools to run as objtool sub commands because they too
>>> process ELF object files. This will allow us to convert tools
>>> such as recordmcount to use objtool's ELF code.
>>>
>>> Since much of recordmcount's ELF code is copy-paste code to/from
>>> a variety of other kernel tools (look at modpost for example) this
>>> means that if we can convert recordmcount we can convert more.
>>>
>>> We define a "missing" architecture which contains weak definitions
>>> for tools that do not exist on all architectures. In this case the
>>> "check" and "orc" tools do not exist on all architectures.
>>>
>>> To test building for other architectures ($arch below):
>>>
>>> 	cd tools/objtool/arch
>>> 	ln -s missing $arch
>>> 	make O=build-$arch ARCH=$arch tools/objtool
>>>
>>
>> Since the stuff under arch/missing is only weak symbols to make up for
>> missing subcmd implementations, can we put everything in a file
>> subcmd_defaults.c (name up for debate!) that would be always be compiled an
>> linked. And some SUBCMD_XXX is set to "y", the corresponding object file
>> gets compiled and overrides the weak symbols from subcmd_defaults.c .
> 
> Hmm, I like keeping them separated along similar lines to the other
> code because it makes it easier to see the intended correspondence and
> likely will keep the files more readable / smaller. I could
> just move them out of arch/missing and into missing_check.c and so forth.
> 
> What do you think of that?
> 

I do prefer that to the introduction of an arch/missing.

Still, I'm not sure I see much benefit in splitting those small 
implementations in separate files, but it's not a problem either. This 
seems more a matter of taste rather than one approach working better 
than the other. So it's more up to what the maintainer prefer! :)

>>> diff --git a/tools/objtool/Build b/tools/objtool/Build
>>> index 66f44f5cd2a6..fb6e6faf6f10 100644
>>> --- a/tools/objtool/Build
>>> +++ b/tools/objtool/Build
>>> @@ -1,11 +1,12 @@
>>>    objtool-y += arch/$(SRCARCH)/
>>> +
>>> +objtool-$(SUBCMD_CHECK) += check.o
>>> +objtool-$(SUBCMD_ORC) += orc_gen.o
>>> +objtool-$(SUBCMD_ORC) += orc_dump.o
>>> +
>>>    objtool-y += builtin-check.o
>>>    objtool-y += builtin-orc.o
>>> -objtool-y += check.o
>>> -objtool-y += orc_gen.o
>>> -objtool-y += orc_dump.o
>>>    objtool-y += elf.o
>>> -objtool-y += special.o
>>
>> I'm not convinced by the moving of special under arch/x86 and I didn't
>> understand it at first.
>>
>> I guess you did it because it is only used by the check subcmd, which is
>> currently only implemented by x86. Is that the reason?
> 
> Yeah, that was the original reasoning and this is an artifact of the
> previous patch set.
>   
>> I feel that the proper way to do it would be to leave special.c/h where they
>> are and have "objtool-$(SUBCMD_CHECK) += special.o". Unless there was some
>> other motivation for it.
> 
> This makes sense. I'll incorporate that in the next posting.
> 

Great, thanks!

-- 
Julien Thierry

