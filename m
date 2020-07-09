Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59170C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 21:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C07D20708
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 21:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b/LxY9o8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgGIVvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 17:51:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33835 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726228AbgGIVvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 17:51:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594331462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7G6B2009DX8rgdJqYq+U2U+PjSYBEAPjrZTKPAYQ4X0=;
        b=b/LxY9o8WyWzKvy1ew2n3VTAxCp6HDvFk1qvOGVQ3GLXw07o4AhabCfhrLi8RQHdw0AEsA
        bCilz/16C5CkqundmS8EO1xyUIOARH9qj9yVosQS3k2bJbGovpxRLVlcbldofGlgXObO+z
        s3eevkuap9NkSC6rMPlMamrzQzc76po=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-Luo_3HJUOMG8JNwpvaC5xw-1; Thu, 09 Jul 2020 17:50:58 -0400
X-MC-Unique: Luo_3HJUOMG8JNwpvaC5xw-1
Received: by mail-qk1-f200.google.com with SMTP id i145so2887419qke.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 14:50:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7G6B2009DX8rgdJqYq+U2U+PjSYBEAPjrZTKPAYQ4X0=;
        b=uACw4DslQ6BPQz1nN59XhnZV0o9zmf42C8rlEOpkrWfpsMNDeFdxe9h/ghjVQ2LxeM
         MuTNeyeMoOXOcgECk26YOxC/B3VMDGHC0K11Lb3a2+zWo1AmV61QFhsCe0c1SuOOLKY8
         p2WdnhtH1tzNg3Ja0PXzSujwFkRgjaJSCNnfJ6dtBLQDfP/Nqy2++BYq+6cjtNPMawb6
         TT+MkWg/QRNST7K4sPmJwknOAZweCRu/icSXC6Bi5X3IB8t969IC7Ro22Y0z4Hut+uAN
         U6NVW9IZOJNFAi/+tkI7SdxkAz1zLvOTSFPY8e7LSEz7CeDNUjjRibau13lz/Pfi8+Mc
         knAA==
X-Gm-Message-State: AOAM533iKfU3+uOZEWNnv81F35c1nxHkcP80ZtyTkTOOTrqornQcEbqQ
        s35iXl9ekgRZtUHFtfVneppyFbuvpTnNwqXxsdOkG+Rk8ae2vPc/LpE0yuuEjyRPwUgCuY3DP/l
        zhKe8Ydn1Z80rNE1+848d7+48
X-Received: by 2002:a05:620a:1233:: with SMTP id v19mr50454231qkj.119.1594331458069;
        Thu, 09 Jul 2020 14:50:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6LZYRhshzZyYbH12rRvHvRkx/eD2Ird8z6I0EFHOCtFnypYj0i/SxXRObCM34za83auq0+g==
X-Received: by 2002:a05:620a:1233:: with SMTP id v19mr50454212qkj.119.1594331457733;
        Thu, 09 Jul 2020 14:50:57 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c8:6f::1f4f])
        by smtp.gmail.com with ESMTPSA id t9sm5350125qke.68.2020.07.09.14.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 14:50:56 -0700 (PDT)
Date:   Thu, 9 Jul 2020 17:50:46 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH 1/2] KVM: X86: Move ignore_msrs handling upper the stack
Message-ID: <20200709215046.GJ199122@xz-x1>
References: <1cebc562-89e9-3806-bb3c-771946fc64f3@redhat.com>
 <20200625162540.GC3437@linux.intel.com>
 <20200626180732.GB175520@xz-x1>
 <20200626181820.GG6583@linux.intel.com>
 <47b90b77-cf03-6087-b25f-fcd2fd313165@redhat.com>
 <20200630154726.GD7733@linux.intel.com>
 <20200709182220.GG199122@xz-x1>
 <20200709192440.GD24919@linux.intel.com>
 <20200709210919.GI199122@xz-x1>
 <20200709212652.GX24919@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200709212652.GX24919@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 02:26:52PM -0700, Sean Christopherson wrote:
> On Thu, Jul 09, 2020 at 05:09:19PM -0400, Peter Xu wrote:
> > Again, using host_initiated or not should be a different issue?  Frankly
> > speaking, I don't know whether it's an issue or not, but it's different from
> > what this series wants to do, because it'll be the same before/after this
> > series. Am I right?
> 
> I'm arguing that the TSX thing should be
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 5eb618dbf211..e1fd5ac0df96 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -1015,7 +1015,7 @@ bool kvm_cpuid(struct kvm_vcpu *vcpu, u32 *eax, u32 *ebx,
>                 *edx = entry->edx;
>                 if (function == 7 && index == 0) {
>                         u64 data;
> -                       if (!__kvm_get_msr(vcpu, MSR_IA32_TSX_CTRL, &data, true) &&
> +                       if (!kvm_get_msr(vcpu, MSR_IA32_TSX_CTRL, &data) &&
>                             (data & TSX_CTRL_CPUID_CLEAR))
>                                 *ebx &= ~(F(RTM) | F(HLE));
>                 }
> 
> At which point hoisting the ignored message up a few levels is pointless
> because the only users of __kvm_*et_msr() will do the explicit ignored_check.
> And I'm also arguing that KVM should never use __kvm_get_msr() for its own
> actions, as host_initiated=true should only be used for host VMM accesses and
> host_initiated=false actions should go through the proper checks and never
> get to the ignored_msrs logic (assuming no KVM bug).
> 
> > Or, please explain what's the "overruled objection" that you're talking about..
> 
> Sean: Objection your honor.
> Paolo: Overruled, you're wrong.
> Sean: Phooey.
> 
> My point is that even though I still object to this series, Paolo has final
> say.

I could be wrong, but I feel like Paolo was really respecting your input, as
always. It's just as simple as a 2:1 vote, isn't it? (I can still count myself
in for the vote, right? :)

Btw, you didn't reply to my other email:

  https://lore.kernel.org/kvm/20200626191118.GC175520@xz-x1/

Let me change the question a bit - Do you think e.g. we should never use
rdmsr*_safe() in the Linux kernel as long as the MSR has a bit somewhere
telling whether the MSR exists (so we should never trigger #GP on these MSRs)?
I think it's a similar question that we're discussing here..

-- 
Peter Xu

