Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54881C54FCF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D71F2051A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gRoKlRBy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgCWTbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 15:31:11 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36160 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbgCWTbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 15:31:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id i13so8011908pfe.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 12:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DSiiinnDsM5Ld5HkYiOfO11ZFTG2X1EpUiB46MpxJGU=;
        b=gRoKlRByEmrdJ+1XGErh+VIj4YLl+vePxDE3A6fdOgcivVHRUViqrAbPzcxgGwhnhi
         bDM7UdOSCZI2AanpF39P+26KWSMv64vH6zbFjifBY035FpxkJyg50JoPEEElYgex9cgN
         9CAjArYhHoB9Bu7JPxm1FkN70XxmMi8JbGjY0HLVPqLM46MNUvvozDj/u3qI/T+/Wx0U
         6tOdvkDE034k26A2alpGO62lAKoInSYVqNIcj2zQDg6PjnCM+ogcxVMG0HOnjjdFGu4U
         VPaM+4pMJDSqWW2pTxo/G/ZVIKnoNkFhib1S/AB2zBUIsDRq+u839k1sy+GLdQV/ma50
         3sIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DSiiinnDsM5Ld5HkYiOfO11ZFTG2X1EpUiB46MpxJGU=;
        b=KQYYFqzp7Q278Ewfu3x+zjwnLKRbigbo9k2DkcKpjoi+uvhG/hEbcCUTkiTWadGzgH
         WYgjsx8oC/OaZwi8f9mKn3j7ivROJKS9ZkZTH3gdXVZ+ij9VMBfkkNdRy+3zYYCKmgfD
         mtQpZBfvPTWCHIVkFfu0jn76Xvo5/NCOXhePn1ynZUFF4O6+l2qcFd5zcSAfSRlZ5FHG
         /umJ4+eZw9niY7WZFlEAZMJ2bQYG5gz/W7NTXRShT9ygPwF+uFvhYdsc3YHRKiha3kia
         6gKd12AMGTrNXUN20AhSwB1y0MiyDPYzdVUIu0nbew44qA6mhsrU2SV7+qnTuvarAQQK
         SAXA==
X-Gm-Message-State: ANhLgQ1gsKgKosaH8ffj3QoNCmzOQ3rqnGHDoHSsQFbj1h5zHSfKDXza
        dZG9sBsDe4K0lKVcNTDlXMHYWZ/E6Y/n3mPZNQYhSQ==
X-Google-Smtp-Source: ADFU+vsavI6XpX8ossNfyDu1sAijYZq6RsWyzwYZRP5AJ7Y7H4zN+16IYO5VuHGNC2r0BwSOYyTQn7XcqA+DOnYQJi8=
X-Received: by 2002:aa7:8b54:: with SMTP id i20mr25380850pfd.39.1584991867491;
 Mon, 23 Mar 2020 12:31:07 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000277a0405a16bd5c9@google.com> <CACT4Y+b1WFT87pWQaXD3CWjyjoQaP1jcycHdHF+rtxoR5xW1ww@mail.gmail.com>
 <5058aabe-f32d-b8ef-57ed-f9c0206304c5@redhat.com> <CAG_fn=WYtSoyi63ACaz-ya=Dbi+BFU-_mADDpL6gQvDimQscmw@mail.gmail.com>
 <20200323163925.GP28711@linux.intel.com> <CAKwvOdkE8OAu=Gj4MKWwpctka6==6EtrbF3e1tvF=jS2hBB3Ow@mail.gmail.com>
 <CAKwvOdkXi1MN2Yqqoa6ghw14tQ25WYgyJkSv35-+1KRb=cmhZw@mail.gmail.com>
 <CAG_fn=WE0BmuHSxUoBJWQ9dnZ4X5ZpBqcT9rQaDE_6HAfTYKQA@mail.gmail.com>
 <CAG_fn=Uf2dDo4K9X==wE=eL8HQMc1an8m8H18tvWd9Mkyhpskg@mail.gmail.com>
 <CAKwvOdntYiM8afOA2nX6dtLp9FWk-1E3Mc+oVRJ_Y8X-9kr81Q@mail.gmail.com> <CAKwvOdn10Ts_AU6i+7toj7NkMwK-+0yr5wTrN0XEDudBWS0sPQ@mail.gmail.com>
In-Reply-To: <CAKwvOdn10Ts_AU6i+7toj7NkMwK-+0yr5wTrN0XEDudBWS0sPQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 23 Mar 2020 12:30:53 -0700
Message-ID: <CAKwvOdnwhoHe8ouao2VBo1meRd8H4EOC7Nr8hnFkbXBACWRm9w@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in handle_external_interrupt_irqoff
To:     Alexander Potapenko <glider@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        syzbot <syzbot+3f29ca2efb056a761e38@syzkaller.appspotmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 11:49 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> So maybe we can find why
> commit 76b043848fd2 ("x86/retpoline: Add initial retpoline support")
> added THUNK_TARGET with and without "m" constraint, and either:
> - remove "m" from THUNK_TARGET. (Maybe this doesn't compile somewhere)
> or
> - use my above recommendation locally avoiding THUNK_TARGET.  We can
> use "r" rather than "a" (what Clang would have picked) or "b (what GCC
> would have picked) to give the compilers maximal flexibility.

So I've sent a patch for the latter; my reason for not pursuing the former is:
1. I assume that the thunk target could be spilled, or a pointer, and
we'd like to keep flexibility for the general case of inline asm that
doesn't modify the stack pointer.
2. `entry` is local to `handle_external_interrupt_irqoff`; it's not
being passed in via pointer as a function parameter.
3. register pressure is irrelevant if the resulting code is incorrect.
-- 
Thanks,
~Nick Desaulniers
