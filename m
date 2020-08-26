Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0025CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 21:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4EC9207CD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 21:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gZumU8Hf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgHZVNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 17:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgHZVNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 17:13:34 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1872EC061756
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 14:13:33 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id e6so2808671oii.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 14:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=skezCpaXkHnWJG3CYg/3DX/Ca64HjeAEqxv8Bp8O8C0=;
        b=gZumU8HfjznAZ9VGfZGR8gUgrWjeHO7wzGRJ2olDYjfRKsLVf++gquOlQ41F3/toDN
         sb5aOBE9wjtkaLPVLbrREX31Ym3BN4FdRlPe0sVgZkCH3UWvhvWxolXNGOnPfbbGEIEP
         8NdzhgxgJAccCcNZX5VJegwgYg8gKz7FXms+SAdzLMfOSIJk+D5kdD4ueOCYcYiMO7nR
         P4ZE1Rt+WiUEmg9LrAfPio1yk2f5LOy0HMm+/Oxn1BYqsdMiN7FfAj8boJaBdrnRawVa
         qCaK65UMX+DR+pBBmcdGvt1670MiJV/WonkKMM3rWvf7QtbjeLbp5dRcv5zDXzy7Ilq3
         Xl6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=skezCpaXkHnWJG3CYg/3DX/Ca64HjeAEqxv8Bp8O8C0=;
        b=r6zCUhTfOqyTsnzvgSnJ4SfW87Qab9A2juBiaagDBC/812bwoMTfFff05ztpW/56nh
         +YPX3+I3I/k1bWSV9/tBwMjhDBn8BvM4XWX6bBTHtap01I8i3TZI/9KbefqtkQJWW+A6
         /YwvU6tHbIFKCZ1sN0ZgIhBl7yCT62sLlzbAubw9F3GGhyY39mZWaA0Mn9Oh25lVZqOs
         MN+ejr2ynX7UlP+gvfIdz08+oig/ZKJ6YHilOEQqDaC4CGbn2514i8QkvPrU5P5/vF4m
         hk6sWK/XJubWPmqXlWjOWs2a1Hy7dcpyuUlPM79B0r5L+IDyrIXFl+1QHoKksE5SKvFG
         fDHw==
X-Gm-Message-State: AOAM532BzCFOi7yEpfdbyin4fZoq0d5wrmHo26Xrw4a34P28WhmMYCxa
        CYsMevSMlkqdCEvPVXUx/IZPAUfjt2v1/gV3eZdZ7g==
X-Google-Smtp-Source: ABdhPJyARu2aDZC+/haxJfZWBmSdVjgOkmXFEjDi6jlFy69OpJWLptw0eNQPByZSemLS8XgQEGK2JDAWB7ISnH/R7T8=
X-Received: by 2002:aca:670b:: with SMTP id z11mr4739617oix.6.1598476410107;
 Wed, 26 Aug 2020 14:13:30 -0700 (PDT)
MIME-Version: 1.0
References: <159846887637.18873.14677728679411578606.stgit@bmoger-ubuntu> <159846930119.18873.955266273208700176.stgit@bmoger-ubuntu>
In-Reply-To: <159846930119.18873.955266273208700176.stgit@bmoger-ubuntu>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 26 Aug 2020 14:13:18 -0700
Message-ID: <CALMp9eRj1ez29L-V1xOeEvrihH-XBa05ou=nrDbc_wJfrHfmWQ@mail.gmail.com>
Subject: Re: [PATCH v5 10/12] KVM: X86: Rename and move the function
 vmx_handle_memory_failure to x86.c
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

On Wed, Aug 26, 2020 at 12:15 PM Babu Moger <babu.moger@amd.com> wrote:
>
> Handling of kvm_read/write_guest_virt*() errors can be moved to common
> code. The same code can be used by both VMX and SVM.
>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
