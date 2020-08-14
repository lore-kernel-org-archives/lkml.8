Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32CCC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D115820838
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gth4o4u+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbgHNRes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728657AbgHNReq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 13:34:46 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354AFC061385
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:34:45 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id p137so2074228oop.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BeRR5BzKObBdnK+fwz2UMgE1kYYlUJPk1LUN7o/xOdo=;
        b=Gth4o4u+BkS4uuzbxWgDAcemzHF6oW0a+jDbxQPWhywWdFUx49bWOeLvc6PLgn90wj
         4E7Bdbqv/daLEB0xpvYOdkpXThby+VgfCQe3UnYzRrFhXDykNwL5mVrk2U+GZKQ54ImZ
         Yf6KRxLhyDeFkhq58rqwAmSDDkIGJQuoNXgDoT3vORVXbTtS8hrsQH7IA5thm0SUbb3A
         c0QPfqvoHjsom0u/nNnIWhGY6GsGhsp7yZ39jLqFBxNDgz2oLrSR9KgAAw3VMoAbdnyF
         ozpOZQOlPvK7YalbqVTpyRJd3qUjMEJGnH/paK0pON6yTCpaGy4m16p0xPch9xhCydrU
         KbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BeRR5BzKObBdnK+fwz2UMgE1kYYlUJPk1LUN7o/xOdo=;
        b=ndzyfVp1xt5fddRi+Vp1DvcyMo3R1+GLzzm2Bqo60qnf2G3lBEWlSKBWiQnd1Nog5Q
         x1nk10aSslTQMZpwzX1Ahl7IVVgf8ekXJgejxJqO8V2xss5eEDoa0tu8QOfSUzU8hEAS
         BXloGq0Ek71aElSsummTxnDsxBsGXCgRE7tMRihYcFTuBzp8q5OlRgrHtR0JA39ZhA63
         3gzwn9Rki5I3IN7e3rLVqA5xMHAJc9gDsRYTNa7j2TDRkxMwgP1crCe+a+6pD5aYEMJy
         FB0UHUMEtoJnOOMkEVnxaUYMFWUhjBD/Jh/5nnhY59MaI/eeltyAWssytjBYzdny8auk
         Gx7Q==
X-Gm-Message-State: AOAM5314/NOTQRC5CHB+mHvt7EgqOAs11g1asgFDJfPObVed51SdqgKd
        MEI6hfF9Z22JU5xorL9oy4nD4Y9Y3UcqB8IxigeXNw==
X-Google-Smtp-Source: ABdhPJyLWTN75DpWp2qFiCaZKdEgDOflg7ol6OkLKr1Zd+Luii22yLm5tIh0B4PTsZxpUYFSv0cqBDfdxqw2lwuqd6E=
X-Received: by 2002:a4a:87c8:: with SMTP id c8mr2455742ooi.81.1597426484278;
 Fri, 14 Aug 2020 10:34:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200807084841.7112-1-chenyi.qiang@intel.com> <20200807084841.7112-8-chenyi.qiang@intel.com>
 <CALMp9eTAo3WO5Vk_LptTDZLzymJ_96=UhRipyzTXXLxWJRGdXg@mail.gmail.com>
 <1481a482-c20b-5531-736c-de0c5d3d611c@intel.com> <CALMp9eQ5HhhXaEVKwnn6N6xxd2QOkNkE7ysiwq+3P=HB-Y1uzg@mail.gmail.com>
 <ae2191a7-a165-3b50-2c8d-e2ddb4505455@intel.com>
In-Reply-To: <ae2191a7-a165-3b50-2c8d-e2ddb4505455@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 14 Aug 2020 10:34:33 -0700
Message-ID: <CALMp9eSXGjVLXBFmvyVn5RLKOMkVxvVLiR5Sy4abyMiHkeNmdA@mail.gmail.com>
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

On Fri, Aug 14, 2020 at 3:09 AM Chenyi Qiang <chenyi.qiang@intel.com> wrote:
>
>
>
> On 8/14/2020 1:52 AM, Jim Mattson wrote:
> > On Wed, Aug 12, 2020 at 9:54 PM Chenyi Qiang <chenyi.qiang@intel.com> wrote:
> >>
> >>
> >>
> >> On 8/11/2020 8:05 AM, Jim Mattson wrote:
> >>> On Fri, Aug 7, 2020 at 1:47 AM Chenyi Qiang <chenyi.qiang@intel.com> wrote:
> >>>>
> >>>> PKS MSR passes through guest directly. Configure the MSR to match the
> >>>> L0/L1 settings so that nested VM runs PKS properly.
> >>>>
> >>>> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> >>>> ---
> >
> >>>> +           (!vmx->nested.nested_run_pending ||
> >>>> +            !(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_IA32_PKRS)))
> >>>> +               vmcs_write64(GUEST_IA32_PKRS, vmx->nested.vmcs01_guest_pkrs);
> >>>
> >>> This doesn't seem right to me. On the target of a live migration, with
> >>> L2 active at the time the snapshot was taken (i.e.,
> >>> vmx->nested.nested_run_pending=0), it looks like we're going to try to
> >>> overwrite the current L2 PKRS value with L1's PKRS value (except that
> >>> in this situation, vmx->nested.vmcs01_guest_pkrs should actually be
> >>> 0). Am I missing something?
> >>>
> >>
> >> We overwrite the L2 PKRS with L1's value when L2 doesn't support PKS.
> >> Because the L1's VM_ENTRY_LOAD_IA32_PKRS is off, we need to migrate L1's
> >> PKRS to L2.
> >
> > I'm thinking of the case where vmx->nested.nested_run_pending is
> > false, and we are processing a KVM_SET_NESTED_STATE ioctl, yet
> > VM_ENTRY_LOAD_IA32_PKRS *is* set in the vmcs12.
> >
>
> Oh, I miss this case. What I'm still confused here is that the
> restoration for GUEST_IA32_DEBUGCTL and GUEST_BNDCFGS have the same
> issue, right? or I miss something.

I take it back. This does work, assuming that userspace calls
KVM_SET_MSRS before calling KVM_SET_NESTED_STATE. Assuming L2 is
active when the checkpoint is taken, the MSR values saved will be the
L2 values. When restoring the MSRs with KVM_SET_MSRS, the L2 MSR
values will be written into vmcs01. They don't belong there, but we're
never going to launch vmcs01 with those MSR values. Instead, when
userspace calls KVM_SET_NESTED_STATE, those values will be transferred
first to the vmcs01_<msr> fields of the vmx->nested struct, and then
to vmcs02.

This is subtle, and I don't think it's documented anywhere that
KVM_SET_NESTED_STATE must be called after KVM_SET_MSRS. In fact, there
are probably a number of dependencies among the various KVM_SET_*
functions that aren't documented anywhere.
