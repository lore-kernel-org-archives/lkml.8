Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C29C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 17:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAA6520829
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 17:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HHUdhxL4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgHMRwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 13:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgHMRwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 13:52:24 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BD8C061383
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 10:52:24 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id q9so5504561oth.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 10:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k8yck4RdxUV1UPISOKBseddHGlGtyaOeMcKpGKtvB5c=;
        b=HHUdhxL4MGJXkKRiv5isZeF1DkyMTSw2yBABrfsO4Xva8T2zhq3GQMK3f5sW7YoGHx
         23D2UVUUIlyJxdJ9o+ngPoLZFL2OGto96L5+Ip2NErBzR3s56SJDTnDE3I25F+BBDKSv
         yse8+HTv56nArcjdoR3nUsOhVt9Y/WtgQ7ysCncj6YtFq3Lv2SR5fCloxjrzlmVxNewQ
         ki1AxnIxj2wq/I6qJUvqVOmFawfFSLrqwta/oi/0Eh6h91Oyhz+5GVyMHarpmpJNGI4q
         A2m9I7im1yC7QJBtfj/4m+diDBkN5enPS2zyUR8cW/jvYpB3sSt3PLx3EsfP8zLBTlTK
         vszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k8yck4RdxUV1UPISOKBseddHGlGtyaOeMcKpGKtvB5c=;
        b=ukSzLqA8oc8VlV0XKrAR6Ci2rbCgeJBFkKbLcm16QkjFZobWpzy3v19m8fSoPLo5ny
         +NZG3sGmZuZGjlOJ0oaycPCAMMpT4eAb9gC90M4Ueh1f0J3DrsDZ0CfyT5OPiyP8y11l
         LmMIgqDbgp+MVlKiNzxbbfSVpMP5RtNuFjn6yrEQvnzCGF3ziQk6udgf4C6qhM1WhXlE
         vKJbKYb/lIRBBUWPRS09VEJRzq9tE9S/UlTth8Z+myIXRmFSdVp/R8aAuYjX/UJdcCwl
         SQzpXtzkzhfZenZiEL0/BG6Eve/1uaPVUkuXQ2JyTjI5iZxo2LfEH229Y08ajeXP7Um5
         iY+Q==
X-Gm-Message-State: AOAM531mgd9pBD8hSQWLX0BuFG+HJZgLuom4CNC2kIG41u855R0OwsnV
        HsagrE7BXjQfgzH6VKpsVoEb190DYu3LXJhg236fLA==
X-Google-Smtp-Source: ABdhPJyEFFAL1NxJEK/txJK2vu6Y2XY3X3D1k5/2k0C7zRHTi5Vb1j4WYuZEzG0GPL9KBEF4kKGfI6p6awvXRFkM4Q8=
X-Received: by 2002:a9d:22ca:: with SMTP id y68mr5263764ota.56.1597341143209;
 Thu, 13 Aug 2020 10:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200807084841.7112-1-chenyi.qiang@intel.com> <20200807084841.7112-8-chenyi.qiang@intel.com>
 <CALMp9eTAo3WO5Vk_LptTDZLzymJ_96=UhRipyzTXXLxWJRGdXg@mail.gmail.com> <1481a482-c20b-5531-736c-de0c5d3d611c@intel.com>
In-Reply-To: <1481a482-c20b-5531-736c-de0c5d3d611c@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 13 Aug 2020 10:52:11 -0700
Message-ID: <CALMp9eQ5HhhXaEVKwnn6N6xxd2QOkNkE7ysiwq+3P=HB-Y1uzg@mail.gmail.com>
Subject: Re: [RFC 7/7] KVM: VMX: Enable PKS for nested VM
To:     Chenyi Qiang <chenyi.qiang@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 9:54 PM Chenyi Qiang <chenyi.qiang@intel.com> wrote:
>
>
>
> On 8/11/2020 8:05 AM, Jim Mattson wrote:
> > On Fri, Aug 7, 2020 at 1:47 AM Chenyi Qiang <chenyi.qiang@intel.com> wrote:
> >>
> >> PKS MSR passes through guest directly. Configure the MSR to match the
> >> L0/L1 settings so that nested VM runs PKS properly.
> >>
> >> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> >> ---

> >> +           (!vmx->nested.nested_run_pending ||
> >> +            !(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_IA32_PKRS)))
> >> +               vmcs_write64(GUEST_IA32_PKRS, vmx->nested.vmcs01_guest_pkrs);
> >
> > This doesn't seem right to me. On the target of a live migration, with
> > L2 active at the time the snapshot was taken (i.e.,
> > vmx->nested.nested_run_pending=0), it looks like we're going to try to
> > overwrite the current L2 PKRS value with L1's PKRS value (except that
> > in this situation, vmx->nested.vmcs01_guest_pkrs should actually be
> > 0). Am I missing something?
> >
>
> We overwrite the L2 PKRS with L1's value when L2 doesn't support PKS.
> Because the L1's VM_ENTRY_LOAD_IA32_PKRS is off, we need to migrate L1's
> PKRS to L2.

I'm thinking of the case where vmx->nested.nested_run_pending is
false, and we are processing a KVM_SET_NESTED_STATE ioctl, yet
VM_ENTRY_LOAD_IA32_PKRS *is* set in the vmcs12.
