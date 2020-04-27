Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3866DC54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 14:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D416206CD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 14:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="TAIZ4cH+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgD0OcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 10:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728058AbgD0OcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 10:32:20 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6626CC0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 07:32:20 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y25so9098473pfn.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 07:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o6gP1IxgOfUu27Scj8dyfwu73IKwIvKKlyMaUpgJZXw=;
        b=TAIZ4cH+ZQDh3PYodMNijnMcHxm0s0DFR5GG20R9TXH3O642T68B69e+UmmZzS7dSm
         NZSZgQw2t8uskqBScXnQehvpPknKc0wZusdtSUiKFP3OQdci2xeAdASNBvBQVCzU0Qer
         2YlLR6hRxcAKChHO9801sxC3Cz6PWB+ybIpt/nlP+VJdGngXvdgYi1YzjylfORkG1Q3d
         ZAkYV+omKon3w5mKQ+9LKL/rlJvZnYwFKBzln831HjY9xz+u4iDl5nbo1dcHYaIURTNc
         c/d01bs9G8lDj9lMtrJyg+h/ou8pntqeDdxUvu2O8sbD3UdD/o8rc8Ezu6rIKaJ5XGuG
         ZSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o6gP1IxgOfUu27Scj8dyfwu73IKwIvKKlyMaUpgJZXw=;
        b=WtflL8sePY5J3jOYhUXxbUz6lLL917drL3MLEWWUCPysRB6+A48dYddPPPsGZOZL9e
         2E2EG4VPtWmhRf6FeIFnCLf/ELHQZdIlwl13tBj1/uO+w1GAmJoUmzyrxMp9bYpJtRXI
         4b1c5WXiHZpDvlUhluQCAfWmnhdcII6Isj2baCrnVcAux+WB8ji4nQZhhZI/sDNAhcu7
         SIqoL5G3K2Ar7Gl+sIkVJa0lvvR4jsaVcbmaWjzBoSE/JTgC+tVbCgldJnx4EVP6zC/G
         32rz55sTn0Cyi3vWKlbpusFnmAK8Enqn+9P/zOLnWHYA71itGsxzZa8NpS7OkOeIzB7D
         a65A==
X-Gm-Message-State: AGi0PuZEcqr4FY49bt8GZHRFqETlyQqIFX2O/ozZvUAe2rpzgZK3Fm15
        ebNkPwzjEgvGS8rFQ9GcnYYdhQ==
X-Google-Smtp-Source: APiQypL84+uU25Z7OwOXQj7FxZ9DIP/2VckcFp0JlCS1zEbbR3O8UoPMNWl0ITP2kT48zmJFZbVhCQ==
X-Received: by 2002:a63:31d6:: with SMTP id x205mr2048020pgx.157.1587997939824;
        Mon, 27 Apr 2020 07:32:19 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id t20sm9238708pjo.13.2020.04.27.07.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 07:32:19 -0700 (PDT)
Subject: Re: [PATCHv3 11/50] c6x: Add show_stack_loglvl()
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        Mark Salter <msalter@redhat.com>, linux-c6x-dev@linux-c6x.org
References: <20200418201944.482088-1-dima@arista.com>
 <20200418201944.482088-12-dima@arista.com>
 <38aeb1431d8245b0c37b5d3d7ec6d9e2f33c330e.camel@perches.com>
 <be2773a5-152d-1d0b-c843-d4f528e40541@i-love.sakura.ne.jp>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <ee8a8bf7-e7d1-6f8b-3482-06f6e88a44ce@arista.com>
Date:   Mon, 27 Apr 2020 15:32:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <be2773a5-152d-1d0b-c843-d4f528e40541@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/26/20 2:06 AM, Tetsuo Handa wrote:
> On 2020/04/26 3:18, Joe Perches wrote:
>> On Sat, 2020-04-18 at 21:19 +0100, Dmitry Safonov wrote:
>>> Currently, the log-level of show_stack() depends on a platform
>>> realization. It creates situations where the headers are printed with
>>> lower log level or higher than the stacktrace (depending on
>>> a platform or user).
>> []
>>> diff --git a/arch/c6x/kernel/traps.c b/arch/c6x/kernel/traps.c
>> []
>>> @@ -344,12 +344,13 @@ asmlinkage int process_exception(struct pt_regs *regs)
>>>  
>>>  static int kstack_depth_to_print = 48;
>>>  
>>> -static void show_trace(unsigned long *stack, unsigned long *endstack)
>>> +static void show_trace(unsigned long *stack, unsigned long *endstack,
>>> +		       const char *loglvl)
>>>  {
>>>  	unsigned long addr;
>>>  	int i;
>>>
>>> -	pr_debug("Call trace:");
>>> +	printk("%sCall trace:", loglvl);
>>
>> These are not equivalent transforms as pr_debug
>> is compiled to nothing unless DEBUG is defined
>> or CONFIG_DYNAMIC_DEBUG is enabled.
> 
> I guess this user is expecting pr_debug() as unconditional printk(KERN_DEBUG), for
> show_trace() and show_stack() will become waste of code if pr_debug() prints nothing.
> If this user wants pr_debug() to be conditional, #ifdef'ing these functions is the better.

Agree.

>> Perhaps all the conversions should be checked
>> for these "not the same" object code changes.

I've checked other architectures - it seems only c6x was printing
backtraces with pr_debug().

Is there a user for hiding all backtraces?
If there is, I think it's better to ifdef-out show_stack() under a new
config HIDE_BACKTRACES or something.

Thanks,
          Dmitry
