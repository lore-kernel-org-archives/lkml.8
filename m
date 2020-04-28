Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D8AC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51EDA20575
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rO220pzN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731238AbgD1Sra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730851AbgD1SrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:47:23 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447F9C03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 11:47:23 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id c18so6387037ile.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 11:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KoCNgzdwIuXjlJSUOdO4yyYJyVpoTgFZrzjKxnpEZi8=;
        b=rO220pzNzM3a+H1KYm5QBMcl/fEuqAh35tLkRk1QNXkpdeaL2kKwvxSpg6bZX4GZXD
         yUveR7vUOW+O2g7f/F5sr7mUbZPDtS98ERIWq2CeqZ0U9bLovZ3WEmFXmfhWK4wzsaqa
         VNbdjVrPbg7mjuZtz5tU25cKpIPJ695O0qVMm2sTLFCysbQgTh3jH1ymfGPCdLp4vaTI
         69vdjF1k9BGEEE3Ys0zBQ96OIOslNyKI55I1wMpyA9hCWOX61Nh/54vQ8LNxLhjSzDDq
         ib4Xc7lMTdg0KEIHwcBMyThE0Zptq4j5HIx9lZPRBbzqdAqowE5MHfMIlJ04sm4Uuk8g
         Mgbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KoCNgzdwIuXjlJSUOdO4yyYJyVpoTgFZrzjKxnpEZi8=;
        b=t+TUD8IpBesb8n3BmD9AijL46mVC0DRXHd14Gwct7Tjk7c5+iiHQAOk4BfNIcf8gtG
         ssIkWKnx8oEpIY6oqq428E7tnV5ca7gptSk2sh6Ls1pKRjNAC0yFCJ+KhcSV59/CTsGI
         zY85mfNysh2glOXW5U2KupqJ6pgJnv89BDgfw2sfrxSXB6dwcl6YHGoFmi+ReGPdJ0Pb
         yJXpF8kT+uVHjetWNDkryOOmcxR0fQWNhgPawpDf975Y1KuL9/50B7F4QdyPVHXbuR74
         dNManZiyimBfOQJVXf4EPck+6w2wgnkqCvvf2iaT5Q2v+0RFda5p81JQh7fx0V3uPNZ9
         GHDA==
X-Gm-Message-State: AGi0PubwiwA3sInpzdRQLSKaJVXTXcHaDefC49lezq1uaNbowRLwooHp
        EAwXTozsQ+PRPRHDM53OvIO/vBe3tFFDG1T+Ceh3hg==
X-Google-Smtp-Source: APiQypKCil1UPL1+1J/3/O1rhnojP17NOIllMYWa0RqW4VJTJHHWAbOZsy2NrekLO5Nlr5bL9MWczKgMt5cNr1VcE8E=
X-Received: by 2002:a92:d186:: with SMTP id z6mr26810990ilz.119.1588099642177;
 Tue, 28 Apr 2020 11:47:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200428173217.5430-1-sean.j.christopherson@intel.com>
In-Reply-To: <20200428173217.5430-1-sean.j.christopherson@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 28 Apr 2020 11:47:11 -0700
Message-ID: <CALMp9eQp4sMbQ0Sa_BL2fd0m8=_M61XRS8KhN6uiNod4OrtwXQ@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: nVMX: Tweak handling of failure code for nested
 VM-Enter failure
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 10:32 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Use an enum for passing around the failure code for a failed VM-Enter
> that results in VM-Exit to provide a level of indirection from the final
> resting place of the failure code, vmcs.EXIT_QUALIFICATION.  The exit
> qualification field is an unsigned long, e.g. passing around
> 'u32 exit_qual' throws up red flags as it suggests KVM may be dropping
> bits when reporting errors to L1.  This is a red herring because the
> only defined failure codes are 0, 2, 3, and 4, i.e. don't come remotely
> close to overflowing a u32.
>
> Setting vmcs.EXIT_QUALIFICATION on entry failure is further complicated
> by the MSR load list, which returns the (1-based) entry that failed, and
> the number of MSRs to load is a 32-bit VMCS field.  At first blush, it
> would appear that overflowing a u32 is possible, but the number of MSRs
> that can be loaded is hardcapped at 4096 (limited by MSR_IA32_VMX_MISC).
>
> In other words, there are two completely disparate types of data that
> eventually get stuffed into vmcs.EXIT_QUALIFICATION, neither of which is
> an 'unsigned long' in nature.  This was presumably the reasoning for
> switching to 'u32' when the related code was refactored in commit
> ca0bde28f2ed6 ("kvm: nVMX: Split VMCS checks from nested_vmx_run()").
>
> Using an enum for the failure code addresses the technically-possible-
> but-will-never-happen scenario where Intel defines a failure code that
> doesn't fit in a 32-bit integer.  The enum variables and values will
> either be automatically sized (gcc 5.4 behavior) or be subjected to some
> combination of truncation.  The former case will simply work, while the
> latter will trigger a compile-time warning unless the compiler is being
> particularly unhelpful.
>
> Separating the failure code from the failed MSR entry allows for
> disassociating both from vmcs.EXIT_QUALIFICATION, which avoids the
> conundrum where KVM has to choose between 'u32 exit_qual' and tracking
> values as 'unsigned long' that have no business being tracked as such.
> To cement the split, set vmcs12->exit_qualification directly from the
> entry error code or failed MSR index instead of bouncing through a local
> variable.
>
> Opportunistically rename the variables in load_vmcs12_host_state() and
> vmx_set_nested_state() to call out that they're ignored, set exit_reason
> on demand on nested VM-Enter failure, and add a comment in
> nested_vmx_load_msr() to call out that returning 'i + 1' can't wrap.
>
> No functional change intended.
>
> Reported-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Jim Mattson <jmattson@google.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
