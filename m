Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0749EC2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D15FE2072F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A18pYFHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbgDHQP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 12:15:56 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55245 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729684AbgDHQPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 12:15:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586362554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lvM1P2WGZ/np78HQHUOoI9HNyhQUS1baX7i0NmmAhUU=;
        b=A18pYFHDmZ9z4YUB4MQW3QIcGvdkzYW+vitbRwduzN8y6KeZJ8joDvYrhIQglfSehIUUcX
        mj/IDE/AFsUMnljha8dpZkNvPQc8s6E7j3ChSgxjILawmqx3IL39IjjnVHz4d5V7PivKgF
        1eNICG28BGDbpuYU2IoXiB7r3Fm04hQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-6XpQp7f1P8-k32V39EXHUA-1; Wed, 08 Apr 2020 12:15:53 -0400
X-MC-Unique: 6XpQp7f1P8-k32V39EXHUA-1
Received: by mail-wr1-f71.google.com with SMTP id t13so4519066wru.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 09:15:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lvM1P2WGZ/np78HQHUOoI9HNyhQUS1baX7i0NmmAhUU=;
        b=Mhe243jCOziS5CXMYi7jYrFwhPHU5xSUYQjGYyLX2EAtgJifp37KsD3pVNZRtuNTKI
         wT4hjyTqv4HeN78OSeqk02AednucBKqnr3Oazq8y8KnqtTui51kNj6yn7MaHPprcMEdm
         shRMGc7MVRyTiAggpo3kZ5JYqm2hadSNVOL5HSbYfdQY5j5/6arw46r797l51nOz1MoF
         o02C+OEjnzjT/fF/T/i0AlZ1Cd8WOha6ZoXHjkyrYVMSYBV+REuoSWBZM3k2ZuDVtsFX
         CsgmhAIFQBZ7tvIc+AxxlH2IY3oAW36mcD8LApDz0YWr0sf0z8SW7mCfROYx/1Jy1tZ3
         7VAg==
X-Gm-Message-State: AGi0PuYQlaCnisOg+ULM7UhgTtnnywSUTJ+1KauWciA2dusNoAzb6QJe
        /CWR0WJGKxaD+aUm7mlNJIFZuCtl9Hntwk2AKSCA/REyPO18kyRID7kLhLrWSP0+V1xHjHZ+Tpa
        3rJT5ZzWBbggBBGhpDPH7tbUo
X-Received: by 2002:a1c:197:: with SMTP id 145mr5305586wmb.42.1586362551801;
        Wed, 08 Apr 2020 09:15:51 -0700 (PDT)
X-Google-Smtp-Source: APiQypJi+OCrxr8G55DImLVK+jLjssllB0kBV40XzPlKKNVIHvXzCcWlSTFzFLhWvTBT9K7I+oOClg==
X-Received: by 2002:a1c:197:: with SMTP id 145mr5305492wmb.42.1586362550651;
        Wed, 08 Apr 2020 09:15:50 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9c71:ae6b:ee1c:2d9e? ([2001:b07:6468:f312:9c71:ae6b:ee1c:2d9e])
        by smtp.gmail.com with ESMTPSA id i8sm38772638wrb.41.2020.04.08.09.15.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2020 09:15:49 -0700 (PDT)
Subject: Re: [PATCH 4/4] x86,module: Detect CRn and DRn manipulation
To:     Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, sean.j.christopherson@intel.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kenny@panix.com, jeyu@kernel.org, rasmus.villemoes@prevas.dk,
        fenghua.yu@intel.com, xiaoyao.li@intel.com, nadav.amit@gmail.com,
        thellstrom@vmware.com, tony.luck@intel.com,
        gregkh@linuxfoundation.org, jannh@google.com,
        keescook@chromium.org, David.Laight@aculab.com,
        dcovelli@vmware.com, mhiramat@kernel.org
References: <20200407110236.930134290@infradead.org>
 <20200407111007.429362016@infradead.org>
 <20200408092726.7c2bda01@gandalf.local.home>
 <20200408154419.GP20730@hirez.programming.kicks-ass.net>
 <20200408154602.GA24869@infradead.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2b0dc69c-f7f9-985d-fc40-8b7bbd927e4f@redhat.com>
Date:   Wed, 8 Apr 2020 18:15:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200408154602.GA24869@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/20 17:46, Christoph Hellwig wrote:
> On Wed, Apr 08, 2020 at 05:44:19PM +0200, Peter Zijlstra wrote:
>> On Wed, Apr 08, 2020 at 09:27:26AM -0400, Steven Rostedt wrote:
>>> On Tue, 07 Apr 2020 13:02:40 +0200
>>> Peter Zijlstra <peterz@infradead.org> wrote:
>>
>>>> +		if (insn_is_mov_CRn(&insn) || insn_is_mov_DRn(&insn)) {
>>>> +			pr_err("Module writes to CRn or DRn, please use the proper accessors: %s\n", mod->name);
>>>> +			return -ENOEXEC;
>>>> +		}
>>>> +
>>>
>>> Something like this should be done for all modules, not just out of tree
>>> modules.
>>
>> I'm all for it; but people were worried scanning all modules was too
>> expensive (I don't really believe it is, module loading just can't be a
>> hot-path). Also, in-tree modules are audited a lot more than out of tree
>> magic voodoo crap.
> 
> Scanning all modules seems safer.  While we're at it - can be move the
> kvm bits using VMX to be always in the core kernel and just forbid
> modules from using those instructions entirely?

I suppose we could use PVOPS-style patching for the more
performance-critical cases, but VMREAD/VMWRITE does not seem like a
particularly bad thing to allow modules and VMLAUNCH/VMRESUME have very
peculiar calling conventions around them.

However, I wouldn't mind it if VMCLEAR/VMPTRLD and the associated kdump
cleanup code were moved to core kernel code.

Paolo

