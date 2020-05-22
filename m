Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82E3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 20:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89F3D2073B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 20:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b="h3xvlsAC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731002AbgEVUOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 16:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730893AbgEVUOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 16:14:25 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04895C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 13:14:25 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id f83so11903279qke.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 13:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8/GGNNisCG4EBVYkbH1n9wN7BF8tFWxg1dpjlvjo2DM=;
        b=h3xvlsACySQjdSGbKcN4eN70OowwqoTviS00R4lIU8nA3+9dvSYx0gjFs2pKNzZuM4
         4o8D4Rs4pvUFL/v85K9wT8PavcdHR0XZAh5/Rwggp0BLkXbU1uOPYH/YMOcyKKv0AiaF
         ouK0m7sfpAgzd863ZkaVMY8U4vvY5xL/pIuEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8/GGNNisCG4EBVYkbH1n9wN7BF8tFWxg1dpjlvjo2DM=;
        b=n5nhfg6n7V/2N43DokFdeedcnRhosfwQxFP9S1CN+dKZ84vhdAfH3W/kL8CwIAJdcJ
         EHR1/BJxZDOU7zzWrk13+4ZsUMNSY0U1dCN+zfqc3CA2dven/KVNwjxE1pMMJ6ohKHyc
         YuO8dZ7IS5/2gZkU9J8SFSFnkY0XrK8x8uwqgyC7aheKK9kKfySHwvjxpqaVjK12EhRA
         voeTRpeicxGkDJax6xLtx9RxMc87OfNoy095qtixHbNVklySRd1hZYklEEhyX87qHAjR
         +Drrsaiav6jLCODHlafksp1Gw3x1MCRO4SUqmK/2IBJGy5oMTXERL8Yj0+D2kRUBVgJW
         q5wA==
X-Gm-Message-State: AOAM53066o5d2KZ38+pOc+xdI4913B/jo30fD2XDVARrM4sos9jUZWMd
        P7JSkmyLXS8QtaCZzGwb2Ytj6w==
X-Google-Smtp-Source: ABdhPJwKnj6badmVHHcoHGqVhSfb+CAdYxXnusSUBoaO7txrdrdGTNnvAp+VHPIyqMR0CJFIhUS2Qw==
X-Received: by 2002:a05:620a:56a:: with SMTP id p10mr16679551qkp.287.1590178464170;
        Fri, 22 May 2020 13:14:24 -0700 (PDT)
Received: from pepe.local (71-142-124-255.lightspeed.rlghnc.sbcglobal.net. [71.142.124.255])
        by smtp.gmail.com with ESMTPSA id c68sm8324571qke.129.2020.05.22.13.14.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 13:14:23 -0700 (PDT)
Subject: Re: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Andi Kleen <ak@linux.intel.com>, Sasha Levin <sashal@kernel.org>,
        linux-kernel@vger.kernel.org, bp@alien8.de, luto@kernel.org,
        hpa@zytor.com, dave.hansen@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, chang.seok.bae@intel.com
References: <20200511045311.4785-1-sashal@kernel.org>
 <0186c22a8a6be1516df0703c421faaa581041774.camel@linux.intel.com>
 <20200515164013.GF29995@sasha-vm>
 <c566b89cc3ef6c164160cc56a820abac3fd70839.camel@linux.intel.com>
 <20200518153407.GA499505@tassilo.jf.intel.com>
 <371e6a92cad25cbe7a8489785efa7d3457ecef3b.camel@linux.intel.com>
 <87v9ksvoaq.fsf@nanos.tec.linutronix.de>
 <20200519164853.GA19706@linux.intel.com>
From:   Don Porter <porter@cs.unc.edu>
Message-ID: <7eb45e02-03bf-0af0-c915-794bf49d66d7@cs.unc.edu>
Date:   Fri, 22 May 2020 16:14:20 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200519164853.GA19706@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/20 12:48 PM, Jarkko Sakkinen wrote:
> On Tue, May 19, 2020 at 01:03:25AM +0200, Thomas Gleixner wrote:
>> Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> writes:
>>> On Mon, 2020-05-18 at 08:34 -0700, Andi Kleen wrote:
>>>>> Yes, for SGX this is functional feature because enclave entry points,
>>>>> thread control structures (aka TCS's), reset FSBASE and GSBASE registers
>>>>> to fixed (albeit user defined) values. And syscall's can be done only
>>>>> outside of enclave.
>>>>>
>>>>> This is a required feature for fancier runtimes (such as Graphene).
>>>>
>>>> Can you please explain a bit more? What do they need GS for?
>>>
>>> Apparently, uses only wrfsbase:
>>>
>>> https://raw.githubusercontent.com/oscarlab/graphene/master/Pal/src/host/Linux-SGX/db_misc.c
>>>
>>> I'm not too familiar with the codebase yet but by reading some research
>>> papers in the past the idea is to multiplex one TCS for multiple virtual
>>> threads inside the enclave.
>>>
>>> E.g. TCS could represent a vcpu for a libos type of container and on
>>> entry would pick on a thread and set fsbase accordingly for a thread
>>> control block.
>>
>> That justifies to write books which recommend to load a kernel module
>> which creates a full unpriviledged root hole. I bet none of these papers
>> ever mentioned that.
> 
> Fully agree that oot lkm for this is a worst idea ever.
> 
> That's why I want to help with this.
> 
> /Jarkko
> 

 >

Hi all, and apologies for the resend,

I wanted to clarify that we never intended the Graphene kernel module 
you mention for production use, as well as to comment in support of this 
patch.

Setting the fs register in userspace is an essential feature for running 
legacy code in SGX.  We have been following LKML discussions on this 
instruction for years, and hoping this feature would be supported by 
Linux, so that we can retire this module.  To our knowledge, every SGX 
library OS has a similar module, waiting for this or a similar patch to 
be merged into Linux.  This indicates a growing user base that needs 
this instruction.

Just for some history, Graphene was originally a research 
proof-of-concept that started in my lab, and has since received 
substantial contributions as an open source project from companies 
including Intel.  This code base is explicitly not intended or ready for 
production use at this point, as it is still missing essential features.

We wrote the kernel module as a way to get something working quickly, so 
that we could focus on studying more difficult aspects of porting code 
to SGX.  We had always assumed that the Linux community would eventually 
offer a correct and safe mechanism to enable this instruction, but we 
generally err on the side of publishing code we write for research 
studies as open source in the interest of supporting reproducibility and 
further science.

Nonetheless, Graphene is moving towards adoption in production systems, 
and we are actively working to make the code base secure and robust. 
This issue has been on our to-do list before a production release.  It 
would certainly make our lives easier to deprecate our module and just 
use a robust, in-kernel implementation.

All the best,
Don Porter
Graphene Maintainer
https://grapheneproject.io/
