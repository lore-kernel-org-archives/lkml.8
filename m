Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D9BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 12:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBCA62088E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 12:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b="ScvtDOLS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389248AbgEZMmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 08:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389225AbgEZMmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 08:42:12 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70F2C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 05:42:12 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id f89so9326355qva.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 05:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z3eUlw4d7JhKcqJekZlvEbMvGS+RBHR9H50aKdVRMb8=;
        b=ScvtDOLSpsSIBd0RttL8GRXP9qIY/iIhCYInALGiyO0ZHnM7dumbs/kGkjyQXt5UFK
         XWRF6nLhf4JCKXlB1H0k5hdhcXQg9W9p8r2foJk4QYeecPjHZgfNy4bfIbu3kWOSKi53
         oD/LTb4pzAzKKLyfFwQC+PQ/NOIF5TCRscfHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z3eUlw4d7JhKcqJekZlvEbMvGS+RBHR9H50aKdVRMb8=;
        b=C4SAGrysbF7cshXgWtIn77EIMAG/yGXMvLbTYvNxTmKy8YZdpGGeDMJ+8XAE+bv+He
         L0d0J2gnxDeVtfksjcCjmtny1VYlnM17WuUcWBhaXtv0YrAyADByiBmRCwDFBjJCPPVz
         KHipG1l3bzWO5M40/gSOd5BXwlCQ73hIcyhazxwmYKlQRvHMvrRlWePHYNntv1hGQcSj
         7ElWYQCl1T/RUTVEyxUKjvdKbafmjO/nwe3nnr3qEPg7gscvxPzrM6JpC2tQtsF1tlS3
         1uIEQz/4OXbYMO/WlqvA2aWKCCmLx8FxaqtItTCjtxX8jPEgv6nvCXaFSqp10QsF7Pwu
         Zq9w==
X-Gm-Message-State: AOAM532Mz+dHhRPOisoErwC1LV2RAVQpcO/rlBxceFVfo9/kQboPqMV+
        lXdnx98SCagzqlyS2E1MinZ7zw==
X-Google-Smtp-Source: ABdhPJyu8Ok+X30CPQ+dSKo7EBnnPvyVPmMrx46sKfREDLDiBIjggVURqF3mP3i1qYjdfNbvuqezfw==
X-Received: by 2002:a0c:fc45:: with SMTP id w5mr19758654qvp.75.1590496931646;
        Tue, 26 May 2020 05:42:11 -0700 (PDT)
Received: from pepe.local (71-142-124-255.lightspeed.rlghnc.sbcglobal.net. [71.142.124.255])
        by smtp.gmail.com with ESMTPSA id a62sm10241541qkg.71.2020.05.26.05.42.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 05:42:10 -0700 (PDT)
Subject: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
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
 <7eb45e02-03bf-0af0-c915-794bf49d66d7@cs.unc.edu>
 <87h7w7qy18.fsf@nanos.tec.linutronix.de>
From:   Don Porter <porter@cs.unc.edu>
Message-ID: <c5fffcd1-c262-7046-a047-67de2bbccd78@cs.unc.edu>
Date:   Tue, 26 May 2020 08:42:09 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <87h7w7qy18.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 5/22/20 8:45 PM, Thomas Gleixner wrote:
> Don,
> 
> Don Porter <porter@cs.unc.edu> writes:
>> On 5/19/20 12:48 PM, Jarkko Sakkinen wrote:
>>> On Tue, May 19, 2020 at 01:03:25AM +0200, Thomas Gleixner wrote:
>>>>
>>>> That justifies to write books which recommend to load a kernel module
>>>> which creates a full unpriviledged root hole. I bet none of these papers
>>>> ever mentioned that.
>>
>> I wanted to clarify that we never intended the Graphene kernel module
>> you mention for production use, as well as to comment in support of this
>> patch.
> 
> let me clarify, that despite your intentions:
> 
>      - there is not a single word in any paper, slide deck, documentation
>        etc. which mentions that loading this module and enabling FSGSBASE
>        behind the kernels back is a fully unpriviledged root hole.
> 
>      - the module lacks a big fat warning emitted to dmesg, that this
>        turns the host kernel into a complete security disaster.
> 
>      - the module fails to set the TAINT_CRAP flag when initialized.
> 
> This shows a pretty obvious discrepancy between intention and action.

I think there is a significant misunderstanding here.  This line of 
research assumes the kernel is already compromised and behaving 
adversarially toward a more trusted application.  Thus, the attack 
surface under scrutiny in these projects is between the enclave and the 
rest of the system.  Not that we want kernels to be rooted, or make this 
easier, but exploits happen in practice.

The threat model for Graphene, and most SGX papers, is quite explicit: 
we assume that Intel’s CPU package, the software in the enclave, and 
possibly Intel’s Attestation Service (IAS) are the only trusted 
components.  Any other software should be assumed compromised, and one 
can even assume memory is physically tampered or that one has plugged in 
an adversarial device. It is not a question of the limitations of the 
kernel, the threat model assumes that the kernel is already rooted.

For the community these papers are typically written to, this assumption 
would be well understood.  And thus it is common to see code artifacts 
that might emulate or even undermine security of untrusted components. 
Not appropriate for production use, but for the typical audience, this 
risk would be understood.  And, initially, when people started using 
Graphene, I checked who they were - almost exclusively SGX researchers 
who would have this context.  It has only been recently that the 
interest has grown to a level that these sorts of warnings need to be 
revised for a more general audience.  But the point that we should 
revise our readme and warnings for a more general audience is well taken.

> Having proper in kernel FSGSBASE support is the only solution to that
> problem and this has been true since the whole SGX frenzy started. Intel
> failed to upstream FSGSBASE since 2015 (sic!). See
> 
>    https://lore.kernel.org/lkml/alpine.DEB.2.21.1903261010380.1789@nanos.tec.linutronix.de/
> 
> for a detailed time line. And that mail is more than a year old.
> 
> Since then there happened even more trainwrecks including the revert of
> already queued patches a few days before the 5.3 merge window opened.
> 
> After that we saw yet more broken variants of that patch set including
> the fail to provide information which is required to re-merge that.
> 
> Instead of providing that information the next version re-introduced the
> wreckage which was carefully sorted out during earlier review cycles up
> to the revert.
> 
> So you (and everybody else who has interrest in SGX) just sat there,
> watched and hoped that this will solve itself magically. And with that
> "hope" argument you really want to make me believe that all of this was
> against your intentions?
> 
> It's beyond hillarious that the renewed attempt to get FSGSBASE support
> merged does not come from the company which has the main interest to get
> this solved, i.e Intel.

Yes!  I think we are in agreement that we expected Intel to upstream 
this support - it is their product. I don’t see why I am personally 
responsible to come to the aid of a multi-billion dollar corporation in 
my free time, or that it is wrong to at least let them try first and see 
how far they get.

Until recently, we were doing proof-of-concept research, not product 
development, and there are limited hours in the day.  I also hasten to 
say that the product of research is an article, the software artifact 
serves as documentation of the experiment.  In contrast, the product of 
software development is software.  It takes significant time and effort 
to convert one to the other.  Upstreaming code is of little scientific 
interest.  But things have changed for our project; we had no users in 
2015 and we are now un-cutting corners that are appropriate for research 
but inappropriate for production.  For a research artifact with an 
audience that knew the risks, we shipped a module because it was easier 
to maintain and install than a kernel patch.

Also, there is a chicken-and-egg problem here: AFAIU a kernel patch 
needs a userspace demonstration to motivate merging.  We can’t do a 
userspace demonstration without this feature.  My main interest in 
showing up for this discussion was to try to make the case that, 
compared to 2015, there is a more convincing userspace demonstration and 
larger population of interested users.

> 
> Based on your argumentation that all of this is uninteded, I assume that
> the pull request on github which removes this security hole from
> graphene:
> 
>          https://github.com/oscarlab/graphene/pull/1529
> 
> is perfectly fine, right?

As far as the patch and pull request, I personally think the right thing 
to do is add the warnings you suggest, help test this or another kernel 
patch, and advise users that patching their kernel is more secure than 
this module.  I am not in favor of fully deleting the module, in the 
interest of transparency and reproducibility.

> 
> Looking at the advertising which all involved parties including the
> Confidential Computing Consortium are conducting, plus the fact that
> Intel has major investments in SGX supporting companies and projects,
> this is one of the worst marketing scams I've seen in decades.
> 
> This all violates the fundamental engineering principle of "correctnes
> first" and I'm flabbergasted that academic research has degraded into
> the "features first" advocating domain.
> 
> What's worse it that public funded research is failing to serve the
> public interest and instead is acting as an advertsiing machine for their
> corporate sponsors.

Finally, I must rebut the claim that my research abuses public funds to 
advertise for Intel.  I have been working on this problem since before I 
knew SGX existed, and have been completely transparent regarding 
subsequent collaborations with Intel.  I believe that understanding the 
pros and cons of different techniques to harden an application against a 
compromised kernel is in the public interest, and my research projects 
have been reviewed and overseen according to standard practices at both 
the university and US government funding agencies.  The expectations of 
agencies in the US funding research are the paper, the insights, and 
proof-of-concept software; converting proof-of-concept software into 
production quality is generally considered a “nice to have”.

- Don

