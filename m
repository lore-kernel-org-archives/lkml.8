Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12609C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAA702070B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nHFMyDoX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbgFJRLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728642AbgFJRLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 13:11:53 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6C8C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 10:11:52 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id t9so3056268ioj.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 10:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SbsE0+B0P8frLwxQJdTPZKfsaWPnfG0PYAG3BHter6I=;
        b=nHFMyDoX1ZRneSZnzjWlUSdmZCxhP8i2hwnyouel/90ri5jqN6XXyPfjtdeokytvZo
         FG7EOchl6gbjtmYsQDyxVG3SV1uVo9MHQtIoJADI3/aaBJByFTanhFJXFBWr7PIafOCu
         V1Kl/FEUatLNd+J6d+Sdm2KAg/h+Ud4nXqTiUhq9TdwgAtDfP8IK+m9Y/Hvtm2iVCjdQ
         6iRQr1DHqBml/HeJkQZPwogYzby/SthO1fN2Go7zKjsblnSkieqhUYuknRPHqwoDTMBG
         B/LF0+Rt4DXknqkAU2c4GnwH9JSR0txzTcJaFg3CmwtuCe9re6xV+tqy/IsXMaH7Lu8D
         PREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SbsE0+B0P8frLwxQJdTPZKfsaWPnfG0PYAG3BHter6I=;
        b=BUsIsRbE8x0St175cXSw230jddoymvw9CwjezDRFbHRMNlQ+Yl78uxYH8EM9X0aJ8i
         V8LH9om0JG8CmQmtv6hPBeDRz6NFKT8m6HT3AKkWFZ9Qb5Ky4iAnc7/LBtkY1CihoD+Z
         2ZQtpoXRTON61hy9J7WIvguNB10rZLwzCYguK6cInY8KIaX9oGx+9SqODExhWYkYKZz/
         sW1pioSXBw/FyfZJzjMy5WRWVSSe46YX4uRRBFwsJcjJdF9zTbe8WBKJhOhR7FlPOdAX
         rMc3pR2Vhqev1ZLEtx2kHMFN0KXhJ9G8zy1TqLWbOmgAhyyAnQql+SDcbUGpi5zCJ3Ka
         JIiQ==
X-Gm-Message-State: AOAM5323245whbTNICCA4ePrC4I13O1vYLCql2iG5K6dGhPzJ+o+RQkO
        wYalQUubrF1HDPDR2ZrfKTLJ2vMb12KjYo4gqcrdSw==
X-Google-Smtp-Source: ABdhPJzay3APGt06fR9CIbahbDWXLVT+dG8MV0BfB+m73PiOwK29ACp9wDlNtEBpmgVkosGrs1ejTIdn9AMF70xCpsQ=
X-Received: by 2002:a02:ce56:: with SMTP id y22mr4098658jar.18.1591809110794;
 Wed, 10 Jun 2020 10:11:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200610164116.770811-1-vkuznets@redhat.com>
In-Reply-To: <20200610164116.770811-1-vkuznets@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 10 Jun 2020 10:11:38 -0700
Message-ID: <CALMp9eRzMC=6hFUeDP9V_CnJ29EbrC6KzWNXzbAsq7Uqqr=f6g@mail.gmail.com>
Subject: Re: [PATCH] KVM: selftests: fix sync_with_host() in smm_test
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Marcelo Bandeira Condotta <mcondotta@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 9:41 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> It was reported that older GCCs compile smm_test in a way that breaks
> it completely:
>
>   kvm_exit:             reason EXIT_CPUID rip 0x4014db info 0 0
>   func 7ffffffd idx 830 rax 0 rbx 0 rcx 0 rdx 0, cpuid entry not found
>   ...
>   kvm_exit:             reason EXIT_MSR rip 0x40abd9 info 0 0
>   kvm_msr:              msr_read 487 = 0x0 (#GP)
>   ...
>
> Note, '7ffffffd' was supposed to be '80000001' as we're checking for
> SVM. Dropping '-O2' from compiler flags help. Turns out, asm block in
> sync_with_host() is wrong. We us 'in 0xe, %%al' instruction to sync
> with the host and in 'AL' register we actually pass the parameter
> (stage) but after sync 'AL' gets written to but GCC thinks the value
> is still there and uses it to compute 'EAX' for 'cpuid'.

That smells like VMware's hypercall madness!

> smm_test can't fully use standard ucall() framework as we need to
> write a very simple SMI handler there. Fix the immediate issue by
> making RAX input/output operand. While on it, make sync_with_host()
> static inline.
>
> Reported-by: Marcelo Bandeira Condotta <mcondotta@redhat.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
