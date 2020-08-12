Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DD3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 21:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 561C420658
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 21:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OmjqwHnL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgHLVPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 17:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgHLVPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 17:15:47 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917EFC061383
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 14:15:46 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id v6so4508340iow.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 14:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ATFnAwg2Qd0ShiTikqRcosJRn11gItg3MuBgdXg3xrE=;
        b=OmjqwHnLTGaU3gISWHh6IbuFCbNeRwPwl7DN2n7vFlD2T4z7FIJ2+ojZG92zhUkEYP
         9VDJPV8sk4DTFa4Y4woLuKtanStU3X7AN6INks5i4MeR8q837H6F8hJz0uVDBJ5DUcRF
         4cpFDYirAaa+aJ+2S5CaTs9tNiHa9IpMzjw/CQwPV26/JEriMVrtbmU8FqDLdqqbhfFh
         pMSpmuRfSAQ7P14NJiGMQ21bI7THJsZnvrG7PWDLgRKycREOsAWROjnKpmj05+mx23hJ
         QATfhTQqkiKBVglbGeFo8j9xBAiUQ/rnHHeMZM5Ee4QTvpXVYXSF62kBJ+eR5bFCpN3v
         qC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ATFnAwg2Qd0ShiTikqRcosJRn11gItg3MuBgdXg3xrE=;
        b=a93amHPK6HFI6OSuJsjvzV6YSHEUDv6qvRhzzWRBXtY8P13efP+dRp237hM3giuLja
         jid+ttjkh+6cg32MrS/h2c1vX6xLt/a6qYqX0+iWXkxaWsyngRU4h6swBBS/stEqjvxJ
         mGs29QQJ3bwa282ovGTCO1Aw6rY5cr4YFfwUcoDe+BRVM+UICcLafNwJTIAXWE/PAQAy
         BYoOGOYBd/t+2CjkupcDzrIfpdU06P6sWr3AAVXxJWfz6RtPM3dgaLx1FQcmGkug9i8X
         vdyHFy207b1ToiqQEgl5hHcoUUE1KkE/l4786Yx4mM0+bjQ7zAdSSVKtvFWP0WLjIJnZ
         892Q==
X-Gm-Message-State: AOAM531TP018KqfXvlpahNIJE0EGTUBEnZAnGMfuE+P5VesoHsYdy1tJ
        dF+7+Dp0sDz89Uj3Ki0g3pN1K6V1Y1OKtPZ6NfO7ZQ==
X-Google-Smtp-Source: ABdhPJzXCwEfMKfiLbS1llHeqVdhn7VQbQfg9jl+NulOWs5WcUDmBqauEhiEdqI7kCEDhQ/dTgUkXNG9h6j3Xq6/3qc=
X-Received: by 2002:a05:6602:599:: with SMTP id v25mr1699787iox.19.1597266945637;
 Wed, 12 Aug 2020 14:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200812192758.25587-1-sean.j.christopherson@intel.com>
In-Reply-To: <20200812192758.25587-1-sean.j.christopherson@intel.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Wed, 12 Aug 2020 14:15:34 -0700
Message-ID: <CANgfPd8vsgdduEfWLaQSyJkAD1zMgDmGJM+wbCyAXM2zq=rtSg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] KVM: x86/mmu: Zap orphaned kids for nested TDP MMU
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Shier <pshier@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 12:28 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> As promised, albeit a few days late.
>
> Ben, I kept your performance numbers even though it this version has
> non-trivial differences relative to what you tested.  I assume we'll need
> a v3 anyways if this doesn't provide the advertised performance benefits.
>
> Ben Gardon (1):
>   KVM: x86/MMU: Recursively zap nested TDP SPs when zapping last/only
>     parent
>
> Sean Christopherson (1):
>   KVM: x86/mmu: Move flush logic from mmu_page_zap_pte() to
>     FNAME(invlpg)
>
>  arch/x86/kvm/mmu/mmu.c         | 38 ++++++++++++++++++++++------------
>  arch/x86/kvm/mmu/paging_tmpl.h |  7 +++++--
>  2 files changed, 30 insertions(+), 15 deletions(-)
>

Thanks for sending this revised series Sean. This all looks good to me.
I think the main performance difference between this series and the
original patch I sent is only zapping nested TDP shadow pages, but I
expect it to behave more or less the same since the number of direct
TDP pages is pretty bounded.

>
> --
> 2.28.0
>
