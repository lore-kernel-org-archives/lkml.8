Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E34C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 20:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B9A2208B8
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 20:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590524862;
	bh=Edt6mv5jFjLc0hMk8pkqKYwHwm1kLVYWzlbWfnQQ7u8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WFe8Vd5OetE6BfFV07EXrB2ubE7DKDnb2Rjwb7KJnWEb2WwYhnmYuRp7RymqX6xZk
	 iBhkHuI6aL8g3Il3dP5RGtOeG2kDYqO1OF6Qse/5Uv7EYEQ+LzqsKMzjVKK9ekmmg6
	 rvGOt5n0/cwp5HvxCRvc2Z1N3Y1z/w4WKzdGeCaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391206AbgEZU1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 16:27:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:50994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389853AbgEZU1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 16:27:41 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E17120899;
        Tue, 26 May 2020 20:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590524860;
        bh=Edt6mv5jFjLc0hMk8pkqKYwHwm1kLVYWzlbWfnQQ7u8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j99DPnZ8uJ2ea89kwBRqCvc+jthtzhkrBm6V2u4qHNkZfHkSz9956Oop2z09L4qun
         +db3hFxGvmeQF1lDc6ad7dCyYbg4RNXTkcsxV7PZfbAXATUqB30E0nlTMkq8tDTM2a
         hIVJQONjWoRurD+97K7x6t9cF3GZhgG8EDsnrP2o=
Date:   Tue, 26 May 2020 16:27:39 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Don Porter <porter@cs.unc.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        bp@alien8.de, luto@kernel.org, hpa@zytor.com,
        dave.hansen@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, chang.seok.bae@intel.com
Subject: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
Message-ID: <20200526202739.GG33628@sasha-vm>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c5fffcd1-c262-7046-a047-67de2bbccd78@cs.unc.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 08:42:09AM -0400, Don Porter wrote:
>On 5/22/20 8:45 PM, Thomas Gleixner wrote:
>>let me clarify, that despite your intentions:
>>
>>     - there is not a single word in any paper, slide deck, documentation
>>       etc. which mentions that loading this module and enabling FSGSBASE
>>       behind the kernels back is a fully unpriviledged root hole.
>>
>>     - the module lacks a big fat warning emitted to dmesg, that this
>>       turns the host kernel into a complete security disaster.
>>
>>     - the module fails to set the TAINT_CRAP flag when initialized.
>>
>>This shows a pretty obvious discrepancy between intention and action.
>
>I think there is a significant misunderstanding here.  This line of 
>research assumes the kernel is already compromised and behaving 
>adversarially toward a more trusted application.  Thus, the attack 
>surface under scrutiny in these projects is between the enclave and 
>the rest of the system.  Not that we want kernels to be rooted, or 
>make this easier, but exploits happen in practice.
>
>The threat model for Graphene, and most SGX papers, is quite explicit: 
>we assume that Intel’s CPU package, the software in the enclave, and 
>possibly Intel’s Attestation Service (IAS) are the only trusted 
>components.  Any other software should be assumed compromised, and one 
>can even assume memory is physically tampered or that one has plugged 
>in an adversarial device. It is not a question of the limitations of 
>the kernel, the threat model assumes that the kernel is already 
>rooted.

You really have to look beyond just what Graphene guarantees at this
point; it does not live on it's own island and it's success isn't
measured purely based on how well it handles it's threat model.

Yes, the threat model assumes the kernel was rooted, but you don't go
off and set the root password to '12345678' on those machines, right?
Attackers would be more than happy to run botnets, spam mailers, and
host child porn on your servers if you give them the opportunity, let's
not do that.

>For the community these papers are typically written to, this 
>assumption would be well understood.  And thus it is common to see 
>code artifacts that might emulate or even undermine security of 
>untrusted components. Not appropriate for production use, but for the 
>typical audience, this risk would be understood.  And, initially, when 
>people started using Graphene, I checked who they were - almost 
>exclusively SGX researchers who would have this context.  It has only 
>been recently that the interest has grown to a level that these sorts 
>of warnings need to be revised for a more general audience.  But the 
>point that we should revise our readme and warnings for a more general 
>audience is well taken.

I'm really worried about the disconnect between how you view the current
state of Graphene (and the industry) vs Intel and the various cloud
providers.

You keep suggesting that its just past the academic research state,
while Intel and the big cloud providers are already pushing it to
external customers.  Every one of those cloud providers has a preview/GA
secure enclave offering.

-- 
Thanks,
Sasha
