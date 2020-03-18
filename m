Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD3EC5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A910C2071C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nxk4jPo4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgCRUET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 16:04:19 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:34639 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726596AbgCRUET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 16:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584561857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0xpZ3zAXO8VSPcveIW3cgTKZpnWgucU9u/urAvYcVOA=;
        b=Nxk4jPo4lfDrdhxzqOyEh/IaslWwLiDn/QikUqBpkAMh81o7tceTi7W8KZ+aFZVCxpdTwY
        WlwrxXDUsvLZzEixgMW7FA4ZI9Isy4SKi2fRGFwdoQG+3tngUemgoi6O83PEH/7vP3eqpu
        5F3nkFW/ljqjnPQd9+mQLWleQuVOhrc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-2122T4cRPmekeJz8jAtosA-1; Wed, 18 Mar 2020 16:04:13 -0400
X-MC-Unique: 2122T4cRPmekeJz8jAtosA-1
Received: by mail-wm1-f71.google.com with SMTP id m4so145929wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 13:04:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0xpZ3zAXO8VSPcveIW3cgTKZpnWgucU9u/urAvYcVOA=;
        b=KojNm01eLOkyYcHFQ31kYMK4nCeUuPzbhZe/tRZBroVa7lQymMCbwbMwVeMh7/Bova
         3eu1MZCGiIP3ApXf8ska8reYgQ+YyBGBoOoK0xt2h/DaufD/TTIiWZ+N4eLNqUu6jMlq
         gP6Vu4/DTYiYeSXmz6xPaNQSj1yXEM0FmZlanMI1GzOaxhUcqRlkEipnAjYARFmZUhP0
         zwlcC/EpAQ76NrXEtZyxCDzVtWXmUn33618hUev0sgySEkNmHyF/+wbo4EAJbsefQpr1
         A6PsGG4ucl+MAaeirbRrjm7T5OzsZU4qNxLC9U0wNMwHSQ+JxsArGezXp3XSTBcvGpdd
         JkJA==
X-Gm-Message-State: ANhLgQ1kYttndWoVsAoSOS8O/3myQnuCiAEMy6tM3FuVSRMb5fb0U773
        kNWO8TRj02/tdG7mm6UV8zf+imaOopfnxy36uFCBxixGs+KI9fCQpyXfhzOPXYr7nh9Omxn16nc
        3Yrt/hsEVAgxJnMzeIC/ZkZTw
X-Received: by 2002:a1c:b7c2:: with SMTP id h185mr7073117wmf.67.1584561852766;
        Wed, 18 Mar 2020 13:04:12 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuhZIINopkV/I2Rp63cmArVM07sr1FfqYPsmcaVefnj1ka4kXzkjZ4RiFxbqgukP/5SJormNw==
X-Received: by 2002:a1c:b7c2:: with SMTP id h185mr7073083wmf.67.1584561852432;
        Wed, 18 Mar 2020 13:04:12 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id u144sm3723075wmu.39.2020.03.18.13.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 13:04:11 -0700 (PDT)
Date:   Wed, 18 Mar 2020 16:04:07 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Yan Zhao <yan.y.zhao@intel.com>,
        Jason Wang <jasowang@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v6 03/14] KVM: X86: Don't track dirty for
 KVM_SET_[TSS_ADDR|IDENTITY_MAP_ADDR]
Message-ID: <20200318200407.GA103005@xz-x1>
References: <20200309214424.330363-4-peterx@redhat.com>
 <202003110908.UE6SBwLU%lkp@intel.com>
 <20200311163906.GG479302@xz-x1>
 <20200311170940.GH21852@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200311170940.GH21852@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 10:09:40AM -0700, Sean Christopherson wrote:
> On Wed, Mar 11, 2020 at 12:39:06PM -0400, Peter Xu wrote:
> > On Wed, Mar 11, 2020 at 09:10:04AM +0800, kbuild test robot wrote:
> > > Hi Peter,
> > > 
> > > Thank you for the patch! Perhaps something to improve:
> > > 
> > > [auto build test WARNING on tip/auto-latest]
> > > [also build test WARNING on vhost/linux-next linus/master v5.6-rc5 next-20200310]
> > > [cannot apply to kvm/linux-next linux/master]
> > > [if your patch is applied to the wrong git tree, please drop us a note to help
> > > improve the system. BTW, we also suggest to use '--base' option to specify the
> > > base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> > > 
> > > url:    https://github.com/0day-ci/linux/commits/Peter-Xu/KVM-Dirty-ring-interface/20200310-070637
> > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 12481c76713078054f2d043b3ce946e4814ac29f
> > > reproduce:
> > >         # apt-get install sparse
> > >         # sparse version: v0.6.1-174-g094d5a94-dirty
> > >         make ARCH=x86_64 allmodconfig
> > >         make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
> > > 
> > > If you fix the issue, kindly add following tag
> > > Reported-by: kbuild test robot <lkp@intel.com>
> > > 
> > > 
> > > sparse warnings: (new ones prefixed by >>)
> > > 
> > >    arch/x86/kvm/x86.c:2599:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@    expected void const [noderef] <asn:1> * @@    got  const [noderef] <asn:1> * @@
> > >    arch/x86/kvm/x86.c:2599:38: sparse:    expected void const [noderef] <asn:1> *
> > >    arch/x86/kvm/x86.c:2599:38: sparse:    got unsigned char [usertype] *
> > >    arch/x86/kvm/x86.c:7501:15: sparse: sparse: incompatible types in comparison expression (different address spaces):
> > >    arch/x86/kvm/x86.c:7501:15: sparse:    struct kvm_apic_map [noderef] <asn:4> *
> > >    arch/x86/kvm/x86.c:7501:15: sparse:    struct kvm_apic_map *
> > > >> arch/x86/kvm/x86.c:9794:31: sparse: sparse: incorrect type in return expression (different address spaces) @@    expected void [noderef] <asn:1> * @@    got n:1> * @@
> > 
> > I'm not sure on how I can reproduce this locally, and also I'm not
> > very sure I understand this warning.  I'd be glad to know if anyone
> > knows...
> > 
> > If without further hints, I'll try to remove the __user for
> > __x86_set_memory_region() and use a cast on the callers next.
> 
> Ah, it's complaining that the ERR_PTR() returns in __x86_set_memory_region()
> aren't explicitly casting to a __user pointer.
> 
> Part of me wonders if something along the lines of your original approach
> of keeping the "int" return and passing a "void __user **p_hva" would be
> cleaner overall, as opposed to having to cast everywhere.  The diff would
> certainly be smaller.  E.g.
> 
> int __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa, u32 size,
> 			    void __user **p_hva)
> {
> 	...
> 
> 	if (p_hva)
> 		*p_hva = (void __user *)hva;
> 
>         return 0;
> }

Returning an adress still has some advantage on one less param.  To
avoid going back and forth, I defined ERR_PTR_USR() and used there to
fix the sparse warnings.  Thanks,

-- 
Peter Xu

