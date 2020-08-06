Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44892C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4498206B2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h7MloIJO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730640AbgHFRgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730443AbgHFRg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:36:29 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C01C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 10:36:29 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id k12so19983628otr.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 10:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xWs6Ffw3WpIeedVEGxgmLg1+uarFaPgN9gTHSd3ibmg=;
        b=h7MloIJOtgd8oNMv9KiDhQ69SKAd0MGHCzbPV18/Axq05hG/Lf4Yd/8WmCguybwVfi
         w8eh5OFkmAX/tvplpoaVXn0OvcNNxw7LSnRNnxTdygO42DapwzcYU3bZbGEFdC3I+dHx
         TVE/M/hePiLA9rUDysYU8NV20KFE4WIEDoDTcvTKeVTGbeiGTDR41qT4yPCW4/q9P+ck
         NPaGnP70XjfFAWXhUjBGWQpOuR/+4FxscdbYWYMwd9Vd41KBJYDjapTuGIV5pJYHxyyB
         iCblLMlfT3wipepuRTpqpNBWg7y/0JuovsT4+iR4DqK4NslMxW24i9PNdEWkjES+E9mf
         qrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xWs6Ffw3WpIeedVEGxgmLg1+uarFaPgN9gTHSd3ibmg=;
        b=nLu+VyGGIoTiEzH0+vb0uW0RMBcLvlNupsf9dvXJrS1IGLr9l55ElKNiogHURDjeEh
         WwbfNB4oGLGb+dXsztrn5SRZRv5S7Va0+spT/y2Y+SPdSZXY48oWLUYslzvb+6BOuH8M
         lMdt17OFRX2IIzGe0ZFXdVNEfdJRLo3kFjOwXx1z9D67tOWtXu72kP4rIjjz/ZanpdJ5
         9qI6UpDQ2FRP9kU4NHIDAPcotlo1BcsAQMh0TU/FIztsCRA9WjiLrMFld0FqRyepXygJ
         fV9/4I01NqpkU/ijhmR9Tv5MtbYFHAO2TRFawNfzYN+21QFAWa900koC/t7gmq6Bp06J
         PLkw==
X-Gm-Message-State: AOAM533vvPtiwQ8yoxrfUF2cIGz+gDDG3GTBVLNf2It6sqmRn2zmHGUI
        tDWYSNCTgQK2MbJxKEbGEOzdXSIu6l49+ZeF7RTRyg==
X-Google-Smtp-Source: ABdhPJw5W+NsuSxoqJYZWbtd8UCN7aRv3GVPEARZjYQheJcs+k9kdmtCeRNsSS+ueHAwpQKOvpXtfbmCdpiamXMXNZw=
X-Received: by 2002:a9d:22ca:: with SMTP id y68mr8043964ota.56.1596735388579;
 Thu, 06 Aug 2020 10:36:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200728143741.2718593-1-vkuznets@redhat.com> <20200728143741.2718593-3-vkuznets@redhat.com>
 <CALMp9eSWsvufDXMuTUR3Fmh91O7tHUaqpDbAoavSMc=prpcDzg@mail.gmail.com> <20200805201702-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200805201702-mutt-send-email-mst@kernel.org>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 6 Aug 2020 10:36:16 -0700
Message-ID: <CALMp9eRonv7Ds2fw_fByqpQcyQBuq3fEXNnzi6ZmEHd2nHYO+w@mail.gmail.com>
Subject: Re: [PATCH 2/3] KVM: x86: introduce KVM_MEM_PCI_HOLE memory
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Peter Xu <peterx@redhat.com>,
        Julia Suvorova <jsuvorov@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 5, 2020 at 5:18 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Aug 05, 2020 at 10:05:40AM -0700, Jim Mattson wrote:
> > On Tue, Jul 28, 2020 at 7:38 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> > >
> > > PCIe config space can (depending on the configuration) be quite big but
> > > usually is sparsely populated. Guest may scan it by accessing individual
> > > device's page which, when device is missing, is supposed to have 'pci
> > > hole' semantics: reads return '0xff' and writes get discarded. Compared
> > > to the already existing KVM_MEM_READONLY, VMM doesn't need to allocate
> > > real memory and stuff it with '0xff'.
> >
> > Note that the bus error semantics described should apply to *any*
> > unbacked guest physical addresses, not just addresses in the PCI hole.
> > (Typically, this also applies to the standard local APIC page
> > (0xfee00xxx) when the local APIC is either disabled or in x2APIC mode,
> > which is an area that kvm has had trouble with in the past.)
>
> Well ATM from KVM's POV unbacked -> exit to userspace, right?
> Not sure what you are suggesting here ...

Sometimes, maybe. That's not the way the emulation of most VMX
instructions works, should they access unbacked memory. Perhaps that's
just a whole slew of bugs to be fixed. :-)
