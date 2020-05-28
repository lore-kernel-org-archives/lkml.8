Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1F9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 10:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC2F6208A7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 10:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387905AbgE1K3s convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 06:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387891AbgE1K3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 06:29:22 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E022C05BD1E
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 03:29:22 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jeFmk-0004AL-85; Thu, 28 May 2020 12:29:14 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 949F0100D01; Thu, 28 May 2020 12:29:13 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Don Porter <porter@cs.unc.edu>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Sasha Levin <sashal@kernel.org>,
        linux-kernel@vger.kernel.org, bp@alien8.de, luto@kernel.org,
        hpa@zytor.com, dave.hansen@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, chang.seok.bae@intel.com
Subject: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
In-Reply-To: <c5fffcd1-c262-7046-a047-67de2bbccd78@cs.unc.edu>
References: <20200511045311.4785-1-sashal@kernel.org> <0186c22a8a6be1516df0703c421faaa581041774.camel@linux.intel.com> <20200515164013.GF29995@sasha-vm> <c566b89cc3ef6c164160cc56a820abac3fd70839.camel@linux.intel.com> <20200518153407.GA499505@tassilo.jf.intel.com> <371e6a92cad25cbe7a8489785efa7d3457ecef3b.camel@linux.intel.com> <87v9ksvoaq.fsf@nanos.tec.linutronix.de> <20200519164853.GA19706@linux.intel.com> <7eb45e02-03bf-0af0-c915-794bf49d66d7@cs.unc.edu> <87h7w7qy18.fsf@nanos.tec.linutronix.de> <c5fffcd1-c262-7046-a047-67de2bbccd78@cs.unc.edu>
Date:   Thu, 28 May 2020 12:29:13 +0200
Message-ID: <87d06opd3a.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don,

Don Porter <porter@cs.unc.edu> writes:
> On 5/22/20 8:45 PM, Thomas Gleixner wrote:
> The threat model for Graphene, and most SGX papers, is quite explicit: 
> we assume that Intel’s CPU package, the software in the enclave, and 
> possibly Intel’s Attestation Service (IAS) are the only trusted 
> components.  Any other software should be assumed compromised, and one 
> can even assume memory is physically tampered or that one has plugged in 
> an adversarial device. It is not a question of the limitations of the 
> kernel, the threat model assumes that the kernel is already rooted.

I'm well aware about that model and that the research is focussed on
this.

> For the community these papers are typically written to, this assumption 
> would be well understood.  And thus it is common to see code artifacts 
> that might emulate or even undermine security of untrusted
> components.

No disagreement here.

> Not appropriate for production use, but for the typical audience, this 
> risk would be understood.  And, initially, when people started using 
> Graphene, I checked who they were - almost exclusively SGX researchers 
> who would have this context.  It has only been recently that the 
> interest has grown to a level that these sorts of warnings need to be 
> revised for a more general audience.  But the point that we should 
> revise our readme and warnings for a more general audience is well
> taken.

The problem is that this has spread out. And it's not only Graphene.

As at least two different incarnations originate from Intel written by
two different Intel people, it's really on Intel to get the message out
that enabling FSGSBASE behind the kernels back is a horrible idea.

>> It's beyond hillarious that the renewed attempt to get FSGSBASE support
>> merged does not come from the company which has the main interest to get
>> this solved, i.e Intel.
>
> Yes!  I think we are in agreement that we expected Intel to upstream 
> this support - it is their product. I don’t see why I am personally 
> responsible to come to the aid of a multi-billion dollar corporation in 
> my free time, or that it is wrong to at least let them try first and see 
> how far they get.

You surely are not responsible. It's definitely Intel's fault.

> Until recently, we were doing proof-of-concept research, not product 
> development, and there are limited hours in the day.  I also hasten to 
> say that the product of research is an article, the software artifact 
> serves as documentation of the experiment.  In contrast, the product of 
> software development is software.  It takes significant time and effort 
> to convert one to the other.  Upstreaming code is of little scientific 
> interest.  But things have changed for our project; we had no users in 
> 2015 and we are now un-cutting corners that are appropriate for research 
> but inappropriate for production.  For a research artifact with an 
> audience that knew the risks, we shipped a module because it was easier 
> to maintain and install than a kernel patch.

I understand that and with a big fat warning and documentation from
start I wouldn't have complained so vehemently. 

> Also, there is a chicken-and-egg problem here: AFAIU a kernel patch 
> needs a userspace demonstration to motivate merging.  We can’t do a 
> userspace demonstration without this feature.  My main interest in 
> showing up for this discussion was to try to make the case that, 
> compared to 2015, there is a more convincing userspace demonstration and 
> larger population of interested users.

As one of the X86 maintainers I have to say that we were perfectly
willing to merge FSGSBASE even without the SGX background. There are
perfect other reasons to do so.

> As far as the patch and pull request, I personally think the right thing 
> to do is add the warnings you suggest, help test this or another kernel 
> patch, and advise users that patching their kernel is more secure than 
> this module.  I am not in favor of fully deleting the module, in the 
> interest of transparency and reproducibility.

Fair enough.

> Finally, I must rebut the claim that my research abuses public funds to 
> advertise for Intel.  I have been working on this problem since before I 
> knew SGX existed, and have been completely transparent regarding 
> subsequent collaborations with Intel.  I believe that understanding the 
> pros and cons of different techniques to harden an application against a 
> compromised kernel is in the public interest, and my research projects 
> have been reviewed and overseen according to standard practices at both 
> the university and US government funding agencies.  The expectations of 
> agencies in the US funding research are the paper, the insights, and 
> proof-of-concept software; converting proof-of-concept software into 
> production quality is generally considered a “nice to have”.

Sorry for that innuendo. Now that my anger and general frustration about
this whole disaster have calmed down, I surely would not write that
again.

Thanks,

        Thomas
