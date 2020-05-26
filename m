Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFF2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 22:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD30D208C9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 22:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b="JnoP0s8U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391772AbgEZWDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 18:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389257AbgEZWDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 18:03:38 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA4CC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 15:03:38 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id x12so17555832qts.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 15:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rTFMxWp77ePnHD0ORPCMt/yKht2/8qZoBd8k4HF0H7Y=;
        b=JnoP0s8UwlVpKzWckzJhE+WcmR4uU4zHli1bCf15SOZL4bnMiDLTLwY342Nwdlojmf
         6ISVP1Dna3sP7uofKTGEYAfQoQhOU+IutsJcXcmgyxPzDGudIMNYs2TZhHbeX6R1bugh
         ei6qzbZ8WspM5oxcRRkSOjluci4YkqpOQmCxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rTFMxWp77ePnHD0ORPCMt/yKht2/8qZoBd8k4HF0H7Y=;
        b=OM9GGftiwGJpoldGi5KdBkffyaKwt+KMAM8Dm0jZPsLr1LFQk8b8cemppU7OUu2xqm
         qo63HtWj1fbVkWwMURML54t0cAwXbem0l/VibtTumkRBH5m1XLFADiHqx9tYdDv+oAQX
         XdGrsHIB+/jEdS5n2JkkOaj9vKijQFkxgGVk7tLV17zLjzSYqBaQwqooaVrHPUcfzgpH
         Dc/lUhDN07rE+N1Wq1OLM7utkyfVISlQUQ3P+e3p9wwDKIceX8ms/OYGIsyfdf30Yq7Y
         0ynLYH6UfBovm5/0YJZhJRxyb3x6XdyCpMTeodCGhSakEb3GRt4adzZgQljmkf1kmSXo
         3/HA==
X-Gm-Message-State: AOAM533f1YRVnUBbL81QH0UhyLMvMrYg4I/ko8VWKX/8aNgA7If9YLPn
        ea6kNmLyV0n30Tsc3mYjWPWaPKiDL1BCWg==
X-Google-Smtp-Source: ABdhPJxH/1GUIrwxvzywJuq6058LIkydvkMMmfTPCuYL5FMd7+LyFzFLNb9HtxcXQRYZ5OlIMkwAQg==
X-Received: by 2002:ac8:2781:: with SMTP id w1mr1062706qtw.33.1590530617356;
        Tue, 26 May 2020 15:03:37 -0700 (PDT)
Received: from pepe.local (71-142-124-255.lightspeed.rlghnc.sbcglobal.net. [71.142.124.255])
        by smtp.gmail.com with ESMTPSA id n184sm815050qkf.0.2020.05.26.15.03.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 15:03:36 -0700 (PDT)
Subject: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
To:     Sasha Levin <sashal@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        bp@alien8.de, luto@kernel.org, hpa@zytor.com,
        dave.hansen@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, chang.seok.bae@intel.com
References: <0186c22a8a6be1516df0703c421faaa581041774.camel@linux.intel.com>
 <20200515164013.GF29995@sasha-vm>
 <c566b89cc3ef6c164160cc56a820abac3fd70839.camel@linux.intel.com>
 <20200518153407.GA499505@tassilo.jf.intel.com>
 <371e6a92cad25cbe7a8489785efa7d3457ecef3b.camel@linux.intel.com>
 <87v9ksvoaq.fsf@nanos.tec.linutronix.de>
 <20200519164853.GA19706@linux.intel.com>
 <7eb45e02-03bf-0af0-c915-794bf49d66d7@cs.unc.edu>
 <87h7w7qy18.fsf@nanos.tec.linutronix.de>
 <c5fffcd1-c262-7046-a047-67de2bbccd78@cs.unc.edu>
 <20200526202739.GG33628@sasha-vm>
From:   Don Porter <porter@cs.unc.edu>
Message-ID: <7a25e82a-9ef1-f13b-be42-2d7a693592b4@cs.unc.edu>
Date:   Tue, 26 May 2020 18:03:35 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200526202739.GG33628@sasha-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/20 4:27 PM, Sasha Levin wrote:
> On Tue, May 26, 2020 at 08:42:09AM -0400, Don Porter wrote:
>> On 5/22/20 8:45 PM, Thomas Gleixner wrote:
>>> let me clarify, that despite your intentions:
>>>
>>>     - there is not a single word in any paper, slide deck, documentation
>>>       etc. which mentions that loading this module and enabling FSGSBASE
>>>       behind the kernels back is a fully unpriviledged root hole.
>>>
>>>     - the module lacks a big fat warning emitted to dmesg, that this
>>>       turns the host kernel into a complete security disaster.
>>>
>>>     - the module fails to set the TAINT_CRAP flag when initialized.
>>>
>>> This shows a pretty obvious discrepancy between intention and action.
>>
>> I think there is a significant misunderstanding here.  This line of 
>> research assumes the kernel is already compromised and behaving 
>> adversarially toward a more trusted application.  Thus, the attack 
>> surface under scrutiny in these projects is between the enclave and 
>> the rest of the system.  Not that we want kernels to be rooted, or 
>> make this easier, but exploits happen in practice.
>>
>> The threat model for Graphene, and most SGX papers, is quite explicit: 
>> we assume that Intel’s CPU package, the software in the enclave, and 
>> possibly Intel’s Attestation Service (IAS) are the only trusted 
>> components.  Any other software should be assumed compromised, and one 
>> can even assume memory is physically tampered or that one has plugged 
>> in an adversarial device. It is not a question of the limitations of 
>> the kernel, the threat model assumes that the kernel is already rooted.
> 
> You really have to look beyond just what Graphene guarantees at this
> point; it does not live on it's own island and it's success isn't
> measured purely based on how well it handles it's threat model.
> 
> Yes, the threat model assumes the kernel was rooted, but you don't go
> off and set the root password to '12345678' on those machines, right?
> Attackers would be more than happy to run botnets, spam mailers, and
> host child porn on your servers if you give them the opportunity, let's
> not do that.

I think we are in agreement and have a common interest here.

>> For the community these papers are typically written to, this 
>> assumption would be well understood.  And thus it is common to see 
>> code artifacts that might emulate or even undermine security of 
>> untrusted components. Not appropriate for production use, but for the 
>> typical audience, this risk would be understood.  And, initially, when 
>> people started using Graphene, I checked who they were - almost 
>> exclusively SGX researchers who would have this context.  It has only 
>> been recently that the interest has grown to a level that these sorts 
>> of warnings need to be revised for a more general audience.  But the 
>> point that we should revise our readme and warnings for a more general 
>> audience is well taken.
> 
> I'm really worried about the disconnect between how you view the current
> state of Graphene (and the industry) vs Intel and the various cloud
> providers.
> 
> You keep suggesting that its just past the academic research state,
> while Intel and the big cloud providers are already pushing it to
> external customers.  Every one of those cloud providers has a preview/GA
> secure enclave offering.
> 

I wonder if you are conflating Graphene with SGX?  I understand that 
many cloud vendors are offering SGX in preview/GA, but there are other 
frameworks to build these offerings on, such as Intel's SGX SDK or 
Haven.  It would be news to me if every major cloud vendor were putting 
Graphene in production.
