Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1491C55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EF5D215A4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 20:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Njqlt8b8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgDXU7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:59:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57889 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726554AbgDXU7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 16:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587761988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U9IoMv2MqMZRTKXdsbx7ye5WORGaUC+vYyvm1coX4f0=;
        b=Njqlt8b8N6Y6E8ixETPrnzvq9J/z943FNhzb9yS6TNRHeBpZNKThZPzlXp+D7aqVGyLozG
        wXDJMXw0ZV/sCnS57DtIzKjYrMYwJaYsEbZd22x4l/YxTRX3K2G0qbklx6T8k/RFTLZTHo
        DJzPjBdPl3FO2aCLJ7MVNkmacy124B0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-eqojTyfkM_y3vKpfjTi1CA-1; Fri, 24 Apr 2020 16:59:46 -0400
X-MC-Unique: eqojTyfkM_y3vKpfjTi1CA-1
Received: by mail-qt1-f199.google.com with SMTP id y31so12410230qta.16
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 13:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U9IoMv2MqMZRTKXdsbx7ye5WORGaUC+vYyvm1coX4f0=;
        b=klgr2vWd1MI2zFB0S7nCUeQavutsnzR/0cNAWCviAzmuXMJhSbpmiQNYD+uP1U4Q4A
         8Q8scrmaMGVOeex8LyQ21glD03WmQ7VZN7LelH98D8P28XSyT5sG7lGQqP7lTybOmxZ/
         HO+fsf9kQZoEnxvnFAOjLtqXzXjkXxbgFNagQoelZd6wHCnXP/vIKhvKz6Wh7qGpQQyJ
         Knm6Ssbjm0GY/gAGNN8oh9icH1ujz5VrO79mbJ+OSawlug8mDPMDE2wW+SQyQv9qUUkv
         HQt7mLzIT3djsW7fcINKh280hx2vF47htOCNp15UdFJbEY7B1Lym88W4w9qgQskW6ECf
         f5YQ==
X-Gm-Message-State: AGi0PuaMEWa8UTLbIA529tyk9WpFUhIqvIXgC290TljGchHMgJ2rBZIG
        aU9IltVB2VOtckQQVc1sk5tqAFr79My5+jO1zloyBH1v6tF5W4OTO22G09glaYWSTTtYmyaqOb0
        JZT+vyyWr5Yt6KTBPkga2fdIe
X-Received: by 2002:aed:2450:: with SMTP id s16mr11331243qtc.345.1587761986459;
        Fri, 24 Apr 2020 13:59:46 -0700 (PDT)
X-Google-Smtp-Source: APiQypKJZaA2jJePTA2AJiGob94NbVuTTBF4yDeyKSdTk01eGX6a1DAQRmHqIRCrGVJAATKqX19Jbg==
X-Received: by 2002:aed:2450:: with SMTP id s16mr11331227qtc.345.1587761986098;
        Fri, 24 Apr 2020 13:59:46 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id c33sm4927700qtb.76.2020.04.24.13.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 13:59:45 -0700 (PDT)
Date:   Fri, 24 Apr 2020 16:59:38 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Nadav Amit <namit@cs.technion.ac.il>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] kvm: x86: Rename KVM_DEBUGREG_RELOAD to
 KVM_DEBUGREG_NEED_RELOAD
Message-ID: <20200424205938.GB48376@xz-x1>
References: <20200416101509.73526-1-xiaoyao.li@intel.com>
 <20200416101509.73526-2-xiaoyao.li@intel.com>
 <20200423190941.GN17824@linux.intel.com>
 <20200424202103.GA48376@xz-x1>
 <20200424202921.GG30013@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200424202921.GG30013@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 01:29:22PM -0700, Sean Christopherson wrote:
> On Fri, Apr 24, 2020 at 04:21:03PM -0400, Peter Xu wrote:
> > On Thu, Apr 23, 2020 at 12:09:42PM -0700, Sean Christopherson wrote:
> > > On Thu, Apr 16, 2020 at 06:15:07PM +0800, Xiaoyao Li wrote:
> > > > To make it more clear that the flag means DRn (except DR7) need to be
> > > > reloaded before vm entry.
> > > > 
> > > > Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > > > ---
> > > >  arch/x86/include/asm/kvm_host.h | 2 +-
> > > >  arch/x86/kvm/x86.c              | 6 +++---
> > > >  2 files changed, 4 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> > > > index c7da23aed79a..f465c76e6e5a 100644
> > > > --- a/arch/x86/include/asm/kvm_host.h
> > > > +++ b/arch/x86/include/asm/kvm_host.h
> > > > @@ -511,7 +511,7 @@ struct kvm_pmu_ops;
> > > >  enum {
> > > >  	KVM_DEBUGREG_BP_ENABLED = 1,
> > > >  	KVM_DEBUGREG_WONT_EXIT = 2,
> > > > -	KVM_DEBUGREG_RELOAD = 4,
> > > > +	KVM_DEBUGREG_NEED_RELOAD = 4,
> > > 
> > > My vote would be for KVM_DEBUGREG_DIRTY  Any bit that is set switch_db_regs
> > > triggers a reload, whereas I would expect a RELOAD flag to be set _every_
> > > time a load is needed and thus be the only bit that's checked
> > 
> > But then shouldn't DIRTY be set as long as KVM_DEBUGREG_BP_ENABLED is set every
> > time before vmenter?  Then it'll somehow go back to switch_db_regs, iiuc...
> > 
> > IIUC RELOAD actually wants to say "reload only for this iteration", that's why
> > it's cleared after each reload.  So maybe...  RELOAD_ONCE?
> 
> Or FORCE_LOAD, or FORCE_RELOAD?  Those crossed my mind as well.

Yep, FORCE_RELOAD sounds better than DIRTY.

> 
> > (Btw, do we have debug regs tests somewhere no matter inside guest or with
> >  KVM_SET_GUEST_DEBUG?)
> 
> I don't think so?

OK, I'll see whether I can write some up.  Thanks,

-- 
Peter Xu

