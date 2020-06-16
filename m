Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333B0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C70A208B8
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FrdhN4Xb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730519AbgFPQxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729771AbgFPQxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 12:53:06 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B17C06174E
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 09:53:06 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id t8so3135464ilm.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 09:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=35fJVpimnPIUIwkluAKTPDeW39MIuCPNhgYXzeFLeCI=;
        b=FrdhN4XbBCzcjxgqatMcyw636L7XhrL/fbg/YYPrrAO7BMtJXMQTeIHZqJZRz9REyE
         jNx/O+9nb5urZAYd5dXGI4W2wdlubrf6P2pf3Obm8CYuYngCyOqavnX112jiFHocm8qb
         Z47p7BdD8hWjBkKEpY1rTtoQOYwOpvws8Q/lQ3cLFda/nTem+nAKnskDIONifD6PrYlL
         Y85Fl/Vj05mZigg5G87IV2BIR5S93gtHcjPZveSZw68S9yCXfhpdwL3EtxWThKtKSZl6
         WSGNnOuy8YmwP2rp2pGKCgxttgReEIKZqiBn/f8s/GF4rHCTR0LE3wYA0LU5zj8ljPNs
         NOaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=35fJVpimnPIUIwkluAKTPDeW39MIuCPNhgYXzeFLeCI=;
        b=dSr9RAn49DGnw4Z/YGoksfJCdZi1XLVSU7dJ3YvkenO3I/sD1Bu0UiHGxpWfXPDqpa
         1JegcSctQRxa30aWl8ngo32vbBv0khB0UGMkjQNIXmktdsCZ1Y9h3dbhPAabAp9LWXf0
         x68qZoJGBCSolnFnd7xd/7pGNkNqJ0JZJwCdjcgAsv3jGiWsD7jhTA+BaFXfKwWUMdqP
         XbphQsRGMA8xhxIEy0cCfo1vd/xwemRIJxDXlvhlGceNZDknBwOZ7wHPK1en+sSK8wFN
         sQBUS86dKEcG7H8jJY6PGnzMTzAZ58B+GGlv3fFuJSTWcdHjRhyR7OlvsQS9CJtj09lK
         9LVA==
X-Gm-Message-State: AOAM532ShLLJ1VxVk8y0MZqGH6NDCfrs9R7Evf/4/Y/NQC/u5IYskgXh
        x7peqGgCZgjexJY/EnyA/OOsjThzsb8TEwUv353X0yNbLuM=
X-Google-Smtp-Source: ABdhPJwH3LniTJNmavisyNTcdSi95okyd/Pkfo1xifTdxT8dZZTARF4tN4WcB5PUfmX0LvB95lJY5m/qnwlN8UsUCms=
X-Received: by 2002:a05:6e02:1208:: with SMTP id a8mr4162289ilq.118.1592326385013;
 Tue, 16 Jun 2020 09:53:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200616161427.375651-1-vkuznets@redhat.com> <CALMp9eSWXGQkOOzSrALfZDMj5JHSH=CsK1wKfdj2x2jtV4XJsw@mail.gmail.com>
 <87366vhscx.fsf@vitty.brq.redhat.com>
In-Reply-To: <87366vhscx.fsf@vitty.brq.redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 16 Jun 2020 09:52:54 -0700
Message-ID: <CALMp9eQ1qe4w5FojzgsUHKpD=zXqen_D6bBg4-vfHa03BdomGA@mail.gmail.com>
Subject: Re: [PATCH] KVM: SVM: drop MSR_IA32_PERF_CAPABILITIES from emulated MSRs
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Like Xu <like.xu@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 9:45 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Jim Mattson <jmattson@google.com> writes:
>
> > On Tue, Jun 16, 2020 at 9:14 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> >>
> >> state_test/smm_test selftests are failing on AMD with:
> >> "Unexpected result from KVM_GET_MSRS, r: 51 (failed MSR was 0x345)"
> >>
> >> MSR_IA32_PERF_CAPABILITIES is an emulated MSR indeed but only on Intel,
> >> make svm_has_emulated_msr() skip it so it is not returned by
> >> KVM_GET_MSR_INDEX_LIST.
> >
> > Do we need to support this MSR under SVM for cross-vendor migration?
> > Or, have we given up on that?
>
> To be honest I'm not sure about the status of cross-vendor migration in
> general and PMU implications in particular, hope Paolo/Sean can shed
> some light. In this particular case my shallow understanding is that
> MSR_IA32_PERF_CAPABILITIES has only one known feature bit which unlocks
> an MSR range with additional counters. If the feature bit is not set
> this, I guess, can easily be migrated (basically, let's allow writing
> '0' there on AMD and return '0' on read). But what if the feature was
> enabled? We'll have to support the new MSR range and do something with
> it after migration (run intel_pmu in fully emulated mode?).
>
> Anyway, the immediate issue I'm trying to fix here is: whatever is
> returned by KVM_GET_MSR_INDEX_LIST can be successfully queried with
> KVM_GET_MSRS as some userspaces count on that.

That's a nice property. Is it documented somewhere?

Reviewed-by: Jim Mattson <jmattson@google.com>
