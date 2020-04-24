Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8C0C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8E0F214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hz9zno4b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbgDXUVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:21:10 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47199 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728379AbgDXUVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 16:21:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587759667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rXw5lZJhw85ciOou4EBdbk3YqKsJHjQueqWvCGOssSI=;
        b=Hz9zno4bobbf4QloLiBZqKRRfepqhkos/kr8gy6/noLsr6/LUQuLHOJUArltCNyIu+574h
        aXEpe78E7gcVuajEDKBLvSk5FrOc0WY5WmBhcpscagxjvsJ2GMUUsOC5+fGAGUeYR/VeIW
        ry7s0OpkEZ4VMwZ65CA0bgoJOusb4vQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-_MtP2LJ_O8qykpp3DDpaVQ-1; Fri, 24 Apr 2020 16:21:06 -0400
X-MC-Unique: _MtP2LJ_O8qykpp3DDpaVQ-1
Received: by mail-qv1-f69.google.com with SMTP id ck5so10954544qvb.18
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:21:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rXw5lZJhw85ciOou4EBdbk3YqKsJHjQueqWvCGOssSI=;
        b=NbW5aczVsrwgbbDBiNMue9N/ljkkfHlaCuZc58rDJqgecSr+bLFzNRHcbOam7rVD4A
         F98Nb5X/gdrBNCx6FgwVhrgQhSB5tkVn5BGsVjGIpSxq3L0fPot4pYdyUpIjsc5bHJWl
         PyGpsMERi/rGfizs28510MinyNMHnYzmsuE7n3/FmjQ5HgypYKkSb2N62EjH9GCl15Ln
         i4rv0YlTInsisOflIi5Xqq5ZV1xqcCy0wgaN8nyVHZm7E8vQs4LnCZGu0aTZs61mw6wj
         v+pAUk3oIFrWQFYofoH1mR0GkURockRyDJK7qgp5jXZjRcNmRv487r666K6mDaS/JYTX
         GDOA==
X-Gm-Message-State: AGi0PubWzwJgPUnsgjynhFLs8mGWb5t14CkkQZyxpQz+eBUktWhEyqe8
        bPdXDCkseW7wON2P8qXGeDBWe0rHet2FZqxUS6Q4RZUPCmfCGkG5KyUARNwH1uDS8MF1IV/W5sf
        vymVd5NAxH8SDOfAtXigvAnfm
X-Received: by 2002:aed:2744:: with SMTP id n62mr11883392qtd.112.1587759665808;
        Fri, 24 Apr 2020 13:21:05 -0700 (PDT)
X-Google-Smtp-Source: APiQypLosHedl4+HJNNfXQLB7BcTG5F83yEgf4jDw1y2BrBe1GKEfq219Np0WT8QWevw2abxbY2mBg==
X-Received: by 2002:aed:2744:: with SMTP id n62mr11883362qtd.112.1587759665480;
        Fri, 24 Apr 2020 13:21:05 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id o67sm4384051qkc.2.2020.04.24.13.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 13:21:04 -0700 (PDT)
Date:   Fri, 24 Apr 2020 16:21:03 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Nadav Amit <namit@cs.technion.ac.il>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] kvm: x86: Rename KVM_DEBUGREG_RELOAD to
 KVM_DEBUGREG_NEED_RELOAD
Message-ID: <20200424202103.GA48376@xz-x1>
References: <20200416101509.73526-1-xiaoyao.li@intel.com>
 <20200416101509.73526-2-xiaoyao.li@intel.com>
 <20200423190941.GN17824@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200423190941.GN17824@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 12:09:42PM -0700, Sean Christopherson wrote:
> On Thu, Apr 16, 2020 at 06:15:07PM +0800, Xiaoyao Li wrote:
> > To make it more clear that the flag means DRn (except DR7) need to be
> > reloaded before vm entry.
> > 
> > Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > ---
> >  arch/x86/include/asm/kvm_host.h | 2 +-
> >  arch/x86/kvm/x86.c              | 6 +++---
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> > index c7da23aed79a..f465c76e6e5a 100644
> > --- a/arch/x86/include/asm/kvm_host.h
> > +++ b/arch/x86/include/asm/kvm_host.h
> > @@ -511,7 +511,7 @@ struct kvm_pmu_ops;
> >  enum {
> >  	KVM_DEBUGREG_BP_ENABLED = 1,
> >  	KVM_DEBUGREG_WONT_EXIT = 2,
> > -	KVM_DEBUGREG_RELOAD = 4,
> > +	KVM_DEBUGREG_NEED_RELOAD = 4,
> 
> My vote would be for KVM_DEBUGREG_DIRTY  Any bit that is set switch_db_regs
> triggers a reload, whereas I would expect a RELOAD flag to be set _every_
> time a load is needed and thus be the only bit that's checked

But then shouldn't DIRTY be set as long as KVM_DEBUGREG_BP_ENABLED is set every
time before vmenter?  Then it'll somehow go back to switch_db_regs, iiuc...

IIUC RELOAD actually wants to say "reload only for this iteration", that's why
it's cleared after each reload.  So maybe...  RELOAD_ONCE?

(Btw, do we have debug regs tests somewhere no matter inside guest or with
 KVM_SET_GUEST_DEBUG?)

Thanks,

-- 
Peter Xu

