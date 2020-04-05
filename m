Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8D7C2D0F4
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 14:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C02020672
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 14:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceoJ45Kn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgDEOhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 10:37:08 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:33701 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgDEOhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 10:37:06 -0400
Received: by mail-yb1-f195.google.com with SMTP id e17so7299431ybq.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 07:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iq7bhlEuP87tC6Doi+ny260jw1k9nQHO7+JOk7S3IkY=;
        b=ceoJ45Knn9Zl8eU0DnsRGTYDGS/rlw59aWGmmu4eKd7i+po8bbRfvj35jP480FpTik
         +dv7MMJyUBYx9tvSzv4Ur+3QXjnxBxvee3eCTh/znJDHI/At3sWu1GFiGsLAsO7RXS8t
         uVSULXAHxbwXrttJxRz60IX+IVJ6OxEO9Ynjab00ggtC09tELS2JFRWXSkzsRHRDBBXd
         oANpCMHo4In+LXHYG1uwnaTVbHKuE+wB4S15wFRhVp6lUQWhGd5uwWeWu6Xoi33UpWXr
         cODrBQJzQC0EsFwp6o4npxr+cARk7fzU6Usf7v9uAt9+NEOfKp1fpfEVKBBFTdOT/q4K
         RnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iq7bhlEuP87tC6Doi+ny260jw1k9nQHO7+JOk7S3IkY=;
        b=nmRj58tO5LVhRfuJ1mCKqYsdrVIoBCnCVBUlj/TTgZJWZj295zTrAW9ib22kN1gYz9
         kHjcXGjPcbwntQV2VQVx6u3s0Bmy4le6dLIwktHjGT0034FGqhKqHLFCOTvDZfQVy5wv
         FYcJ3H2F4TYB5CyWwLHuGn7+5KpKrFGSJhtEcHzAKF49jG8cLMjc9RCFlhbQNEWft/Re
         MMkv2Dovf3NnAY83l8HjVO2rULnKxsphhGehKIGFGvanGvz51mD6gwweMrbJdBXQrsVK
         FsT9QGGDj8/6xE40NmRIxhtJq1FS/6l6cRcvJTJL3eVB/dUi2yf1WjjKWM31ipoX5qOt
         Fsdw==
X-Gm-Message-State: AGi0PubiqS4spWik/vxmmoOroct4Dwe0kewzdEXBoc6c7KHL6uNvMrEe
        olObS1etIvPHcl+rYJjVKtMyC2QbeFhOdayiYQw=
X-Google-Smtp-Source: APiQypLYFc4hPKnBc3SI599uWHHdT62VKldY45eeM+yxx81Vkxo1ZqqvUh4Ibry1DdjGmKA319R54ohKQmegiUiein8=
X-Received: by 2002:a05:6902:686:: with SMTP id i6mr25980689ybt.56.1586097425185;
 Sun, 05 Apr 2020 07:37:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200318011144.91532-1-atish.patra@wdc.com> <20200318011144.91532-3-atish.patra@wdc.com>
In-Reply-To: <20200318011144.91532-3-atish.patra@wdc.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Sun, 5 Apr 2020 22:36:53 +0800
Message-ID: <CAEUhbmXH0GP_=r-jUHNCB9wPkSoh6_BNWtUG1SN57QPgLCtDNg@mail.gmail.com>
Subject: Re: [PATCH v11 02/11] RISC-V: Add basic support for SBI v0.2
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Gary Guo <gary@garyguo.net>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mao Han <han_mao@c-sky.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <vincent.chen@sifive.com>,
        Zong Li <zong.li@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 9:11 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> The SBI v0.2 introduces a base extension which is backward compatible
> with v0.1. Implement all helper functions and minimum required SBI
> calls from v0.2 for now. All other base extension function will be
> added later as per need.
> As v0.2 calling convention is backward compatible with v0.1, remove
> the v0.1 helper functions and just use v0.2 calling convention.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> ---
>  arch/riscv/include/asm/sbi.h | 139 ++++++++++----------
>  arch/riscv/kernel/sbi.c      | 243 ++++++++++++++++++++++++++++++++++-
>  arch/riscv/kernel/setup.c    |   5 +
>  3 files changed, 314 insertions(+), 73 deletions(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
