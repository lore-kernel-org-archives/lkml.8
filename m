Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033ACC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 20:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3A0B207BC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 20:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oEpPptmh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgHZUpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 16:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbgHZUpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 16:45:13 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7EBC061756
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 13:45:13 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id v13so2715757oiv.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 13:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QnLfeoLcCvYGQhSXCHvu6ntO3iZypCG03j0v0V/lE60=;
        b=oEpPptmh8R/ckvOynlZJ0jBvRyvSgLg+QaTk85AvfB5WWtFS64+ArAY6dtSzIgW24p
         UzviT/lXocVLE2aWZpLhJA+/l9NktOLBwDMVhswDM/teObIMU1J+8LDfA4qnVFaoBFrC
         b/ucW8ynwOUH2jpcdHHAKtea59hSC+gyN2xU/o0yaIY+s+7jqQaNFGqo3rOR1Omq3mQp
         /g31ng79Q59TbpLRpyYVd/s/Gwj6PiQuxNyXkK6WlSw+oWKm7VHGRU5VUkWSO5vGQO0c
         WWjwA7GB3h0CfFeEjJfxmJJsxgD9PnFMkojRobSrFawZwkOYgCpR094C3Tu4v/aBfWBM
         LwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QnLfeoLcCvYGQhSXCHvu6ntO3iZypCG03j0v0V/lE60=;
        b=guPa5OjV1EqCqkyWzNb34EwAKk6P9ABJQ0jGPTyRBy3Ok9AA49gAWgQDvAtVrpZ6Q9
         mC+gByvRM6e1uyYFhmddxCVEeW0bYxZXROG1TccJA0M9aXrwAR67Qwk9XbCr3awQHsC8
         iaJc2We1ooWiJvQLrqAIU1/BrAmNs5zU2rFnjV9/HuM4K9fNOmvj98kjZLskE4dL1dTf
         ga+zrnLVMbsGUAjRrgv8GV9eFA9DMefp0L1IYR14h7nGUrNClXacqHG2WQjDTOdAha04
         LSlnBKGiBbmLJrVvERiAZOXYFtyZJUAJ6LqJsWw8LEn/drpC2NKkjYZuXHk3Kcnor0Rl
         FyFw==
X-Gm-Message-State: AOAM532cs99JfWwQGy1i4/s0XGtGwzQDrV1PytG3A1Zf3leU8QjqwvQi
        CoYvsQllaiXnp5yKOcQmzgp07nX+PTTXfcFonC/C4w==
X-Google-Smtp-Source: ABdhPJztiKIs+AKmRQMjj8AupE0RfyXrDjWJ/I5FIYrFSEg+06xO6+xJgEtk14F9HUsJ3uBQwaGnAQSaytfPXKIFy8I=
X-Received: by 2002:aca:b942:: with SMTP id j63mr4826397oif.28.1598474712710;
 Wed, 26 Aug 2020 13:45:12 -0700 (PDT)
MIME-Version: 1.0
References: <159846887637.18873.14677728679411578606.stgit@bmoger-ubuntu> <159846924650.18873.2599714820148493539.stgit@bmoger-ubuntu>
In-Reply-To: <159846924650.18873.2599714820148493539.stgit@bmoger-ubuntu>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 26 Aug 2020 13:45:01 -0700
Message-ID: <CALMp9eTo_HMPcobJos-KMKBCjOuT=P+j9=WSh7Cf3JrQb3xftQ@mail.gmail.com>
Subject: Re: [PATCH v5 03/12] KVM: SVM: Change intercept_dr to generic intercepts
To:     Babu Moger <babu.moger@amd.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        kvm list <kvm@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 12:14 PM Babu Moger <babu.moger@amd.com> wrote:
>
> Modify intercept_dr to generic intercepts in vmcb_control_area. Use
> the generic vmcb_set_intercept, vmcb_clr_intercept and vmcb_is_intercept
> to set/clear/test the intercept_dr bits.
>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
