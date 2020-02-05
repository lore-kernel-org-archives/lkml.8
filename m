Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB473C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBDF920730
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HJyG7aCp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbgBEPrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 10:47:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22734 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727029AbgBEPrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 10:47:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580917643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7nlVGeHpp9SUIG8wrpMffu8Rdrv8R00fvHa/mYaOU0g=;
        b=HJyG7aCp2iBoUkNtwJyBEDTzSvSnjuvIGd8ig0egruScMNoWmyDrRE0FuyrfVYTXtKtbDN
        bFdQAW1fCn/lLYO8ScUX0NEuOhH73eRK2XD0hSFsJScUat6xz3f+pA+tEqNb/7lJMm30ud
        xsGknoRvns4NEhzseoPhUhoX6Y9fYIA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-ed22qHClMi2JY2IdfJulFw-1; Wed, 05 Feb 2020 10:47:02 -0500
X-MC-Unique: ed22qHClMi2JY2IdfJulFw-1
Received: by mail-qv1-f69.google.com with SMTP id cn2so1747609qvb.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 07:47:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7nlVGeHpp9SUIG8wrpMffu8Rdrv8R00fvHa/mYaOU0g=;
        b=tl2Fe8O2sGkviH3UUe8AY7z4psKVP4Kmg68D11EcoRdyCGxvuL0y5KzLnb7lCaSM4u
         6JkfSnnBGx/bM6nyp2feONxi/quPaYKbyLfYhdRj0mK4Qkxy4qAmw7VpsgKnoIt+oGwT
         7rHyMQ9sxkLWtRG+YnquB/6O3c8R9FbeOT+U+otvmbKT1Urmf7aOWXO6DlZJ2EGzhraK
         65n841EVaeDcpF06+ezFIXRhI9Y1qmj2AmGx7ke9VNHNL5vJnt02Ni7l1TkI7B48avx+
         J/kdOTj7jmDdFHivX8yaMToZyXMDmtNDoZFunJBmTpG77YKXFlAT0srTq5cMg6/vc1A6
         Fi2g==
X-Gm-Message-State: APjAAAVColv12pbn84S6VYostbk7qVSWW4BbA+cB6itMn3bZ6QAzvMVH
        y52VLZ8kGe/bhdObfpO7snyTcyy+hD3SdMk/lil6Cfv/Jvy3BlTZ/cgACt/vrd+NZtCBb2Slv9Y
        /M3P1NfTfCx3Y8LTp0XpSEpjZ
X-Received: by 2002:ac8:43c1:: with SMTP id w1mr33141986qtn.156.1580917622335;
        Wed, 05 Feb 2020 07:47:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqyR3gtl04B5/ivAmSsxK+0IHBbTQlobHqHrH3aYmEjs8G/RJ/srgXoWDoXwLSsFiE3ITI4dCw==
X-Received: by 2002:ac8:43c1:: with SMTP id w1mr33141949qtn.156.1580917622035;
        Wed, 05 Feb 2020 07:47:02 -0800 (PST)
Received: from dev.jcline.org ([136.56.87.133])
        by smtp.gmail.com with ESMTPSA id h7sm6394qke.30.2020.02.05.07.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 07:47:01 -0800 (PST)
Date:   Wed, 5 Feb 2020 10:46:59 -0500
From:   Jeremy Cline <jcline@redhat.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm/arm64: Fix up includes for trace.h
Message-ID: <20200205154659.GA83976@dev.jcline.org>
References: <20200205134146.82678-1-jcline@redhat.com>
 <e3446187abb20eb2a95eae1f51b36ca1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3446187abb20eb2a95eae1f51b36ca1@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 03:18:05PM +0000, Marc Zyngier wrote:
> On 2020-02-05 13:41, Jeremy Cline wrote:
> > Fedora kernel builds on armv7hl began failing recently because
> > kvm_arm_exception_type and kvm_arm_exception_class were undeclared in
> > trace.h. Add the missing include.
> > 
> > Signed-off-by: Jeremy Cline <jcline@redhat.com>
> > ---
> > 
> > I've not dug very deeply into what exactly changed between commit
> > b3a608222336 (the last build that succeeded) and commit 14cd0bd04907,
> > but my guess was commit 0e20f5e25556 ("KVM: arm/arm64: Cleanup MMIO
> > handling").
> > 
> > Fedora's build config is available at
> > https://src.fedoraproject.org/rpms/kernel/blob/master/f/kernel-armv7hl-fedora.config
> 
> This config doesn't have KVM enabled.
> 

Whoops, I did indeed mean
https://src.fedoraproject.org/rpms/kernel/blob/master/f/kernel-armv7hl-lpae-fedora.config.
Sorry about that.

> > 
> >  virt/kvm/arm/trace.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/virt/kvm/arm/trace.h b/virt/kvm/arm/trace.h
> > index 204d210d01c2..cc94ccc68821 100644
> > --- a/virt/kvm/arm/trace.h
> > +++ b/virt/kvm/arm/trace.h
> > @@ -4,6 +4,7 @@
> > 
> >  #include <kvm/arm_arch_timer.h>
> >  #include <linux/tracepoint.h>
> > +#include <asm/kvm_arm.h>
> > 
> >  #undef TRACE_SYSTEM
> >  #define TRACE_SYSTEM kvm
> 
> After enabling KVM in the above config (which requires LPAE), I've managed
> to reproduce
> the problem.
> 
> Fix now queued, thanks.
> 

Thanks!

- Jeremy

