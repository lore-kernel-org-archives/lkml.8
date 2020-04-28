Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4931CC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFCF620730
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o2z8EurV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgD1Vjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726256AbgD1Vjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 17:39:44 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941BBC03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 14:39:44 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id f3so25055693ioj.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 14:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ul4JdnqYIuUZ+XRuxCZf3WpJHQHQUt+RKURin2OvTJE=;
        b=o2z8EurVpT/nTBtFhpV3btr1ad2aGZqWHCjoLb+NSKVxUolYCI2pV/P7JsCPKcFWer
         cA/JKLDr1YnNYBkindhrydkNLhaLmnVkdmXlvcopD8PYFkfBWOBN6FhqXTjQwvZ8TvUD
         cLlXiGnb0VlxyQPqDpU0VyaCjV9zyYBEOZTRrjwGXw65UalAr3fn4OBD04jObMVnbxMH
         ndppohSLJ9Iln0cDOKrtTY24X9LTp7/CyG0YP/fhRFXj24PhpDCn2PcUpsUD+SdVinjT
         tzAJbACUxDWlH/CZIPjCd4f7pNUeeHvv4xd6UGBMLvAlBkzyhHCp6PaS5LLW4pI6mEHj
         3u1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ul4JdnqYIuUZ+XRuxCZf3WpJHQHQUt+RKURin2OvTJE=;
        b=VtuarTLxvpS047ivh3z+V6Lah32iMGNGyjxyJU/vy90xu55LwgSwCSsVMLqDPs7NeH
         IsDHU8xHTiy3N5JH1bqSY34X9AumwIOkJ7DfpT7xKcPkCqUgwJkJ5njRHAPa3q3NzG5c
         puTIdZKSaPWghzHvDZlzOOB8crW4v75Egsq6/Daog6KpIAmAyzI9xk0dEUmoNjj7DVYC
         sR/c64qa9HTLNOHgN6ddNVJyZLx18eTTkBLszUWisOG3vjxvnyA6MuLoF9Cl4mhBOqca
         BcApOMAjpY7+AibN2uVsdDM4jFUb/JK1jpBYXMw697vdiJwtWuDeCxZqjMcR4UvvQYss
         c8ow==
X-Gm-Message-State: AGi0PuYjrSP3qkt6dYGzba6VNHkHFVNIhSwaTlPSM7D6tmASl76ewtWO
        DhlIP5v35DtBAtHsHZPR90cpm9e3p27OUABSo6ghtw==
X-Google-Smtp-Source: APiQypJL8jn5sxcb7rjtcHlX2CtaRnYDq2q/Zfa8onXyOd2w3CHlsb24FCCAaPa1UV1HR2IQxmlqXF7TDuggkkxkXT0=
X-Received: by 2002:a6b:c910:: with SMTP id z16mr27919357iof.164.1588109983668;
 Tue, 28 Apr 2020 14:39:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200423022550.15113-1-sean.j.christopherson@intel.com> <20200423022550.15113-3-sean.j.christopherson@intel.com>
In-Reply-To: <20200423022550.15113-3-sean.j.christopherson@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 28 Apr 2020 14:39:32 -0700
Message-ID: <CALMp9eTnOs=MMVThBf032XVydj1F40P0Kui7VFAn9F=idLAFPw@mail.gmail.com>
Subject: Re: [PATCH 02/13] KVM: nVMX: Open a window for pending nested VMX
 preemption timer
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oliver Upton <oupton@google.com>,
        Peter Shier <pshier@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 7:26 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Add a kvm_x86_ops hook to detect a nested pending "hypervisor timer" and
> use it to effectively open a window for servicing the expired timer.
> Like pending SMIs on VMX, opening a window simply means requesting an
> immediate exit.
>
> This fixes a bug where an expired VMX preemption timer (for L2) will be
> delayed and/or lost if a pending exception is injected into L2.  The
> pending exception is rightly prioritized by vmx_check_nested_events()
> and injected into L2, with the preemption timer left pending.  Because
> no window opened, L2 is free to run uninterrupted.
>
> Fixes: f4124500c2c13 ("KVM: nVMX: Fully emulate preemption timer")
> Reported-by: Jim Mattson <jmattson@google.com>
> Cc: Oliver Upton <oupton@google.com>
> Cc: Peter Shier <pshier@google.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
