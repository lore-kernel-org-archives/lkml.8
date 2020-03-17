Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78278C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB942051A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M038mtHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgCQOSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:18:53 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:33768 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726388AbgCQOSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 10:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584454732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nztugtnIojkJwSB0mVguQ4PbYC04wIaERChUJYf2fk0=;
        b=M038mtHDA1NtctCaRbkQGvn/fSalqL66DXx0NNuRzHr+vHiq9F/4DNA5eaMp6cLgjE5rGD
        zJcjJy7kPF4WZSS+BHDRVd8bOjeDd0GzJI5D+PbvQA6UoXWWSIpcY6W2GNzzFvtLHGeJix
        UnLkv8GHtdVBzd0+glMg8grJgZxFgWY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-d3KVBnn2PjuNEi9rXjM_gQ-1; Tue, 17 Mar 2020 10:18:50 -0400
X-MC-Unique: d3KVBnn2PjuNEi9rXjM_gQ-1
Received: by mail-qv1-f70.google.com with SMTP id ev8so12690621qvb.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 07:18:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nztugtnIojkJwSB0mVguQ4PbYC04wIaERChUJYf2fk0=;
        b=PYP8EIdYAzpjedwgIm/v1WMeL1uKrae27lqS4pn/+DKLz8ecLoJs+P7lEljBki3KHX
         lSZ4Q20kKORIr8L079YyfZ+hpRfl80HjM3bkb/A95CKzjoeIQ7ckYUvoguBR9s9zUYsu
         2g/xVBfe91DxByomh2fR2uClZQxt1hboftfYHWsOYGzLOeZa/2lCS42CRA9yhAoqAFh9
         kNIcpdHz951hFGC1bhDu+1Oo+2pwERYAXfsnwU6SUuGLJ/DA2xeBNfzG6xUa8uEiJDkr
         W/Op0a8mHgqB25/6ZpT5xO+1gu6upe1s4ymAViO5RRLotVSF4lCxto1kOWkVOU9O8/hp
         bD2g==
X-Gm-Message-State: ANhLgQ1rTgblNMxnRLP6lUPgYqtAAbCKiCfXRfkQr9rZ+75+9hDBeVVM
        psmPujNOdu53Wa9ljKJ/wUaEnyOHYMpVCHc6rHsYTbtC2JbNaO0GgOdAqb/rl18o3Q4SMUH5Iob
        ng9twyFt8aYprxQcRbo/zniFa
X-Received: by 2002:ac8:554a:: with SMTP id o10mr5739694qtr.224.1584454729604;
        Tue, 17 Mar 2020 07:18:49 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvrMULxF73NFl450EaKtUxhKQ8RE2wadz6W/eiWeg/s9hhJFyS0fpSjgmsoVMmaOPvBseqjpg==
X-Received: by 2002:ac8:554a:: with SMTP id o10mr5739661qtr.224.1584454729268;
        Tue, 17 Mar 2020 07:18:49 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id q8sm1982327qkm.73.2020.03.17.07.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 07:18:48 -0700 (PDT)
Date:   Tue, 17 Mar 2020 10:18:47 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-mips@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH RFC 0/4] KVM: MIPS: Provide arch-specific
 kvm_flush_remote_tlbs()
Message-ID: <20200317141847.GB199571@xz-x1>
References: <20200207223520.735523-1-peterx@redhat.com>
 <44ba59d6-39a5-4221-1ae6-41e5a305d316@redhat.com>
 <20200311183201.GK479302@xz-x1>
 <2db8490e-e4a0-79d0-5088-a9571b01703d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2db8490e-e4a0-79d0-5088-a9571b01703d@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 02:33:00PM +0100, Paolo Bonzini wrote:
> On 11/03/20 19:32, Peter Xu wrote:
> > On Wed, Feb 12, 2020 at 01:25:30PM +0100, Paolo Bonzini wrote:
> >> On 07/02/20 23:35, Peter Xu wrote:
> >>> [This series is RFC because I don't have MIPS to compile and test]
> >>>
> >>> kvm_flush_remote_tlbs() can be arch-specific, by either:
> >>>
> >>> - Completely replace kvm_flush_remote_tlbs(), like ARM, who is the
> >>>   only user of CONFIG_HAVE_KVM_ARCH_TLB_FLUSH_ALL so far
> >>>
> >>> - Doing something extra before kvm_flush_remote_tlbs(), like MIPS VZ
> >>>   support, however still wants to have the common tlb flush to be part
> >>>   of the process.  Could refer to kvm_vz_flush_shadow_all().  Then in
> >>>   MIPS it's awkward to flush remote TLBs: we'll need to call the mips
> >>>   hooks.
> >>>
> >>> It's awkward to have different ways to specialize this procedure,
> >>> especially MIPS cannot use the genenal interface which is quite a
> >>> pity.  It's good to make it a common interface.
> >>>
> >>> This patch series removes the 2nd MIPS usage above, and let it also
> >>> use the common kvm_flush_remote_tlbs() interface.  It should be
> >>> suggested that we always keep kvm_flush_remote_tlbs() be a common
> >>> entrance for tlb flushing on all archs.
> >>>
> >>> This idea comes from the reading of Sean's patchset on dynamic memslot
> >>> allocation, where a new dirty log specific hook is added for flushing
> >>> TLBs only for the MIPS code [1].  With this patchset, logically the
> >>> new hook in that patch can be dropped so we can directly use
> >>> kvm_flush_remote_tlbs().
> >>>
> >>> TODO: We can even extend another common interface for ranged TLB, but
> >>> let's see how we think about this series first.
> >>>
> >>> Any comment is welcomed, thanks.
> >>>
> >>> Peter Xu (4):
> >>>   KVM: Provide kvm_flush_remote_tlbs_common()
> >>>   KVM: MIPS: Drop flush_shadow_memslot() callback
> >>>   KVM: MIPS: Replace all the kvm_flush_remote_tlbs() references
> >>>   KVM: MIPS: Define arch-specific kvm_flush_remote_tlbs()
> >>>
> >>>  arch/mips/include/asm/kvm_host.h |  7 -------
> >>>  arch/mips/kvm/Kconfig            |  1 +
> >>>  arch/mips/kvm/mips.c             | 22 ++++++++++------------
> >>>  arch/mips/kvm/trap_emul.c        | 15 +--------------
> >>>  arch/mips/kvm/vz.c               | 14 ++------------
> >>>  include/linux/kvm_host.h         |  1 +
> >>>  virt/kvm/kvm_main.c              | 10 ++++++++--
> >>>  7 files changed, 23 insertions(+), 47 deletions(-)
> >>>
> >>
> >> Compile-tested and queued.
> > 
> > Just in case it fells through the crach - Paolo, do you still have
> > plan to queue this again?
> 
> Yes, I wanted to make it compile first though.  I'm undecided between
> queuing your series and killing KVM MIPS honestly.

Understood.  Yep killing that will provide the same thing too as what
the series wanted to do anyways, as we'll remove the only outlier of
kvm_flush_remote_tlbs().  Thanks,

-- 
Peter Xu

