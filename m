Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D594DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 18:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B819C2087C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 18:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yjq8DqIP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgH0SZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 14:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgH0SZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 14:25:38 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3473AC061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 11:25:37 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id 2so5435457ois.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 11:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gs0r/qLqNENIPIXNSy2JKQmS4bv6DjmNng0VSEeWxcY=;
        b=Yjq8DqIPvwRF1E9Tr12e/y+mTnyhCpVETyEZh1fq/yZGhcgQPT6Tyy05F2WWlmnUC6
         dfRnq6kYRM1bJlsf7G8zIQjSa1l+/9dq1QUzy+rRrArCwjrFRzFGXdXNT1s4RqnZrvBG
         fCp8l1Zt4JFqK7OSoQc0KL29gj3eafs0XRL+2MYhejL2Qzf0tHo6kyFGelGZste+olQA
         aeMQ+XYFNXBGgdnJTMWjA7l02SiGVMUXUUWdiUIhH+078YbZD42rlFX34bwocJASQLVn
         Tns2Mc1c1xJ1+cux3uB1404kK/KDAdlN7SdWoJWh3bTIDlSqFLxs7CrzletDnTvusf+5
         l53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gs0r/qLqNENIPIXNSy2JKQmS4bv6DjmNng0VSEeWxcY=;
        b=OhesYdwwcsyIEuqqnWGCVj/MChi9XGsdhLhicPntxavzSKxF2DGTbpYFnLVUh6ABpx
         jAXdOgr2jr/HYBR7xY677mYyIAgQN2gv5vA28QOpt9vmYdyO0wXhDH+SxvyKVFhMbyYg
         ubkZ10drIzrNPnJLcrix3fwBK3fh5KF+25vtjxLoPFAz1l3c60MdiQ0R6tNk80YcyaYQ
         398p9OYyiX9bzxiOLAPP6GxO13oxUz7PGj22pOHeQHtKvtetyiuX1NzbszeSAM8IQI+c
         r7aWDjbGf1MRInty2VsrMNqY0bLSsIMhat4TTCect7JI/MrSq+BZCXtLBejv4beWKlP7
         W2TQ==
X-Gm-Message-State: AOAM532wciYdhJjSI5Z0fPizNWzQrAXwoyqpkMdUCXuc/WFfuooZj8Ny
        wfXiFJ/QsDcj5388ju8oY8ILz+vFSrI7C7nEh/54cA==
X-Google-Smtp-Source: ABdhPJyki3MAfYcG3wS6NQGrmmLx/zt7ChQXHSU1crErA4qk+WA5f7w/hTN++agIsMk2QIir4G0Mgl+njaE7EkxXApY=
X-Received: by 2002:aca:670b:: with SMTP id z11mr130883oix.6.1598552736210;
 Thu, 27 Aug 2020 11:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200713162206.1930767-1-vkuznets@redhat.com> <CALMp9eR+DYVH0UZvbNKUNArzPdf1mvAoxakzj++szaVCD0Fcpw@mail.gmail.com>
In-Reply-To: <CALMp9eR+DYVH0UZvbNKUNArzPdf1mvAoxakzj++szaVCD0Fcpw@mail.gmail.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 27 Aug 2020 11:25:25 -0700
Message-ID: <CALMp9eRGStwpYbeHbxo79zF9EyQ=35wwhNt03rjMHMDD9a5G0A@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: nVMX: fix the layout of struct kvm_vmx_nested_state_hdr
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Peter Shier <pshier@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 11:23 AM Jim Mattson <jmattson@google.com> wrote:
>
> On Mon, Jul 13, 2020 at 9:22 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> >
> > Before commit 850448f35aaf ("KVM: nVMX: Fix VMX preemption timer
> > migration") struct kvm_vmx_nested_state_hdr looked like:
> >
> > struct kvm_vmx_nested_state_hdr {
> >         __u64 vmxon_pa;
> >         __u64 vmcs12_pa;
> >         struct {
> >                 __u16 flags;
> >         } smm;
> > }
> >
> > The ABI got broken by the above mentioned commit and an attempt
> > to fix that was made in commit 83d31e5271ac ("KVM: nVMX: fixes for
> > preemption timer migration") which made the structure look like:
> >
> > struct kvm_vmx_nested_state_hdr {
> >         __u64 vmxon_pa;
> >         __u64 vmcs12_pa;
> >         struct {
> >                 __u16 flags;
> >         } smm;
> >         __u32 flags;
> >         __u64 preemption_timer_deadline;
> > };
> >
> > The problem with this layout is that before both changes compilers were
> > allocating 24 bytes for this and although smm.flags is padded to 8 bytes,
> > it is initialized as a 2 byte value. Chances are that legacy userspaces
> > using old layout will be passing uninitialized bytes which will slip into
> > what is now known as 'flags'.
> >
> > Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
> > Fixes: 850448f35aaf ("KVM: nVMX: Fix VMX preemption timer migration")
> > Fixes: 83d31e5271ac ("KVM: nVMX: fixes for preemption timer migration")
> > Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>
> Oops!
>
> Reviewed-by: Jim Mattson <jmattson@google.com>

Whatever happened to this?
