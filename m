Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F09C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F24712145D
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eHtit0kB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbgIJKBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:01:24 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21775 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730257AbgIJKBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 06:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599732074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SAWVsQ1VutHeIxcMMMfasmStNBpMRCAzjajMGXTXbd0=;
        b=eHtit0kB4Q4gqxCFnvs2sI/d1zB45cvF+vS4fBVctNtQB7dyum3wgsgdHAVCkPqmajfyTV
        rK7w4uQVbZNby42gkseiqeFWLxHhIJQAaxPmg/ytNX3fzdBnNrGmLcV5j2FqP0Ql76DS7E
        DrRVbJBNULeZhT/RYaFKC4XS6Hxgjf8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-2ul8F2GxPr6_nDXiBcdcfQ-1; Thu, 10 Sep 2020 06:01:11 -0400
X-MC-Unique: 2ul8F2GxPr6_nDXiBcdcfQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35E8C801FDF;
        Thu, 10 Sep 2020 10:01:08 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.124])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 32A011002D5E;
        Thu, 10 Sep 2020 10:01:04 +0000 (UTC)
Date:   Thu, 10 Sep 2020 12:01:01 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Peter Maydell <peter.maydell@linaro.org>
Cc:     Peter Maydell <Peter.Maydell@arm.com>,
        Juan Quintela <quintela@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Price <steven.price@arm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v2 2/2] arm64: kvm: Introduce MTE VCPU feature
Message-ID: <20200910100101.4c47ww4xniza7owi@kamzik.brq.redhat.com>
References: <20200904160018.29481-1-steven.price@arm.com>
 <20200904160018.29481-3-steven.price@arm.com>
 <20200909154804.mide6szbzgdy7jju@kamzik.brq.redhat.com>
 <CAFEAcA_1YnBg3HVmtrSMP8u7GqHY8mtDAJwVcZuNUhwA+q9q=w@mail.gmail.com>
 <20200910063854.vwhtn3lc5tei72fh@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910063854.vwhtn3lc5tei72fh@kamzik.brq.redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 08:38:54AM +0200, Andrew Jones wrote:
> On Wed, Sep 09, 2020 at 04:53:02PM +0100, Peter Maydell wrote:
> > On Wed, 9 Sep 2020 at 16:48, Andrew Jones <drjones@redhat.com> wrote:
> > > We either need a KVM cap or a new CPU feature probing interface to avoid
> > > making userspace try features one at a time. It's too bad that VCPU_INIT
> > > doesn't clear all offending features from the feature set when returning
> > > EINVAL, because then userspace could create a scratch VCPU with everything
> > > it supports in order to see what KVM also supports in one go.
> > 
> > You could add one if you wanted -- add a new feature bit
> > TELL_ME_WHAT_YOU_HAVE. If the kernel sees that then on filure
> > it clears out feature bits it doesn't support and also clears
> > TELL_ME_WHAT_YOU_HAVE. If QEMU sees EINVAL and TELL_ME_WHAT_YOU_HAVE
> > is still set, then it knows it's dealing with an old kernel
> > and has to do one-at-a-time probing. If it sees EINVAL but not
> > TELL_ME_WHAT_YOU_HAVE then it knows it has a new kernel and
> > has just got all the info.
> >
> 
> That's a great proposal. I'll try to find time to send the patches.
>

We also have KVM_ARM_PREFERRED_TARGET, which is documented as

"""
...
The ioctl returns struct kvm_vcpu_init instance containing information
about preferred CPU target type and recommended features for it.  The
kvm_vcpu_init->features bitmap returned will have feature bits set if
the preferred target recommends setting these features, but this is
not mandatory.
...
"""

But, it says "recommended" features, not "all supported" features,
and the current implementation of KVM_ARM_PREFERRED_TARGET only
zeros out features. So, I think we should just leave
KVM_ARM_PREFERRED_TARGET as is and stick to the plan of extending
VCPU_INIT.

Thanks,
drew

