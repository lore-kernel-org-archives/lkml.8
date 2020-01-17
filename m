Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7919AC33CB3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 03:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 509392083E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 03:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NzsOYh2G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729990AbgAQD6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 22:58:22 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60217 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729852AbgAQD6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 22:58:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579233498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GS6FnA5NNUNJfxm482U+3UbNOpbqVkHtaTFx8YTek68=;
        b=NzsOYh2GjCMHP1Fi0YFgU9pMtjTY+p/hF7SgPlsJ2yJa5OCHvQ4r2oPByOMJqCIewpK42G
        AkZKur+UwYJvZO/Cvt/NsSpN//mxaQit1C0uHs4YljYtVGg4LKjI9EgxprEUFQdJr9YFvC
        zBXuygfEa1Fdp++YIQLVbIdC9JBn5Io=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-_pOoDC-COqSvuzkdxWry3Q-1; Thu, 16 Jan 2020 22:58:16 -0500
X-MC-Unique: _pOoDC-COqSvuzkdxWry3Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 330AA184C71F;
        Fri, 17 Jan 2020 03:58:14 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-166.pek2.redhat.com [10.72.12.166])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 66F9C5C1D8;
        Fri, 17 Jan 2020 03:58:08 +0000 (UTC)
Date:   Fri, 17 Jan 2020 11:58:04 +0800
From:   Dave Young <dyoung@redhat.com>
To:     James Morse <james.morse@arm.com>
Cc:     Chen Zhou <chenzhou10@huawei.com>, tglx@linutronix.de,
        mingo@redhat.com, catalin.marinas@arm.com, will@kernel.org,
        bhsharma@redhat.com, horms@verge.net.au,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        xiexiuqi@huawei.com, kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v7 1/4] x86: kdump: move reserve_crashkernel_low() into
 crash_core.c
Message-ID: <20200117035804.GA16926@dhcp-128-65.nay.redhat.com>
References: <20191223152349.180172-1-chenzhou10@huawei.com>
 <20191223152349.180172-2-chenzhou10@huawei.com>
 <20191227055458.GA14893@dhcp-128-65.nay.redhat.com>
 <09d42854-461b-e85c-ba3f-0e1173dc95b5@huawei.com>
 <20191228093227.GA19720@dhcp-128-65.nay.redhat.com>
 <77c971a4-608f-ee35-40cb-77186a2ddbd1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77c971a4-608f-ee35-40cb-77186a2ddbd1@arm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/16/20 at 03:17pm, James Morse wrote:
> Hi guys,
> 
> On 28/12/2019 09:32, Dave Young wrote:
> > On 12/27/19 at 07:04pm, Chen Zhou wrote:
> >> On 2019/12/27 13:54, Dave Young wrote:
> >>> On 12/23/19 at 11:23pm, Chen Zhou wrote:
> >>>> In preparation for supporting reserve_crashkernel_low in arm64 as
> >>>> x86_64 does, move reserve_crashkernel_low() into kernel/crash_core.c.
> >>>>
> >>>> Note, in arm64, we reserve low memory if and only if crashkernel=X,low
> >>>> is specified. Different with x86_64, don't set low memory automatically.
> >>>
> >>> Do you have any reason for the difference?  I'd expect we have same
> >>> logic if possible and remove some of the ifdefs.
> >>
> >> In x86_64, if we reserve crashkernel above 4G, then we call reserve_crashkernel_low()
> >> to reserve low memory.
> >>
> >> In arm64, to simplify, we call reserve_crashkernel_low() at the beginning of reserve_crashkernel()
> >> and then relax the arm64_dma32_phys_limit if reserve_crashkernel_low() allocated something.
> >> In this case, if reserve crashkernel below 4G there will be 256M low memory set automatically
> >> and this needs extra considerations.
> 
> > Sorry that I did not read the old thread details and thought that is
> > arch dependent.  But rethink about that, it would be better that we can
> > have same semantic about crashkernel parameters across arches.  If we
> > make them different then it causes confusion, especially for
> > distributions.
> 
> Surely distros also want one crashkernel* string they can use on all platforms without
> having to detect the kernel version, platform or changeable memory layout...
> 
> 
> > OTOH, I thought if we reserve high memory then the low memory should be
> > needed.  There might be some exceptions, but I do not know the exact
> > one,
> 
> > can we make the behavior same, and special case those systems which
> > do not need low memory reservation.
> 
> Its tricky to work out which systems are the 'normal' ones.
> 
> We don't have a fixed memory layout for arm64. Some systems have no memory below 4G.
> Others have no memory above 4G.
> 
> Chen Zhou's machine has some memory below 4G, but its too precious to reserve a large
> chunk for kdump. Without any memory below 4G some of the drivers won't work.
> 
> I don't see what distros can set as their default for all platforms if high/low are
> mutually exclusive with the 'crashkernel=' in use today. How did x86 navigate this, ... or
> was it so long ago?

It is very rare for such machine without any low memory in X86, at least
from what I know,  so the current way just works fine.

Since arm64 is quite different, I would agree with current way
proposed in the patch, but a question is, for those arm64 systems how can
admin know if low crashkernel memory is needed or not?  and just skip the
low reservation for machine with high memory installed only?

> 
> No one else has reported a problem with the existing placement logic, hence treating this
> 'low' thing as the 'in addition' special case.
> 
> 
> >> previous discusses:
> >> 	https://lkml.org/lkml/2019/6/5/670
> >> 	https://lkml.org/lkml/2019/6/13/229
> > 
> > Another concern from James:
> > "
> > With both crashk_low_res and crashk_res, we end up with two entries in /proc/iomem called
> > "Crash kernel". Because its sorted by address, and kexec-tools stops searching when it
> > find "Crash kernel", you are always going to get the kernel placed in the lower portion.
> > "
> > 
> > The kexec-tools code is iterating all "Crash kernel" ranges and add them
> > in an array.  In X86 code, it uses the higher range to locate memory.
> 
> Then my hurried reading of what the user-space code does was wrong!
> 
> If kexec-tools places the kernel in the low region, there may not be enough memory left
> for whatever purpose it was reserved for. This was the motivation for giving it a
> different name.

Agreed,  it is still a potential problem though.  Say we have both low
and high reserved.  Kdump kernel boots up, the kernel and drivers,
applications will use memory, I'm not sure if there is a memory
allocation policy to let them all use high mem first..  Anyway that is
beyond the kexec-tools and resource name.

Thanks
Dave

