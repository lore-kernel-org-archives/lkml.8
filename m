Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF0FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AB7620678
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="iJyFyog3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731491AbgFASjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728973AbgFASjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:39:15 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C26C008630
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 11:39:15 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id r15so529607wmh.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 11:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DxSxb4qJ2PqYBDzQWgigjbwPlUa5UGLq42V80vRyc3I=;
        b=iJyFyog3o3AHmohKhPz332v36/Qyh0qrg3OZFBu48aDgBLACJW+ckIyF4yBGM+HpQi
         zD+FX6hrwmvP5eMczRZ5Uk6xutCdSeIZjgOy/6+Ms+iN4KvG0tY1+EhLW2bPJHrtGYCu
         ErdUmh2LXxdejN7Bof0/e/MeJjlLxk4jgpxvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DxSxb4qJ2PqYBDzQWgigjbwPlUa5UGLq42V80vRyc3I=;
        b=V4l+uQoUukjhvM7DCtuf+N/PoAxjQTcWp77tgTBwz5yr+4CYSCWq9nAu9KCaukx5xk
         ynMuAWEpHRdStGp8J+yLsl7faHai3GjucreYVHRDaUY+En4P1BB5AgOS8aHaCZAoXD1j
         39rWWNoMqw6vGDoqBNRTkQWvjj/sBUO/9ZsATy8bClpaOuABf+ipDeWoEIER5BuwGrqm
         eCQva7ciHDqWoM78mkrE7BBGv259LnxOSZ91p/T+XrmEV7J7olUDtR3tzmSAziUw0rBq
         6ny0sNxfJ/Vqf4/uedjSUzoiV2mT8kHiypuTnPh9TcGBtaHTbsEgrCODFxizFZ+O1GJw
         /1oQ==
X-Gm-Message-State: AOAM532w1LlP/iMfezeYUDeol+avwvfm9FKfnAUj8wSi8a0nVKoOQ7kp
        t1b+An8jfYMH6PAQkWneY/DvkJBfUNDWa2bztDqe
X-Google-Smtp-Source: ABdhPJwAD8zGThyfWXoJiI+rafDHc+O4vEm2xlxQg4Z/EpXFQAHDx/Gpl90tcbfPP+vrQbnuJhlQEyxbIADBdZ0LHig=
X-Received: by 2002:a7b:c622:: with SMTP id p2mr562073wmk.55.1591036754065;
 Mon, 01 Jun 2020 11:39:14 -0700 (PDT)
MIME-Version: 1.0
References: <29cb3d8c72db7fe36507f487a71224b812805197.1590994864.git.zong.li@sifive.com>
In-Reply-To: <29cb3d8c72db7fe36507f487a71224b812805197.1590994864.git.zong.li@sifive.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 1 Jun 2020 11:39:03 -0700
Message-ID: <CAOnJCUKKvSvH5ZcsHE95goE4UpfrpJeJbVzgBvhMC3xhSF_08Q@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: fix build warning of missing prototypes
To:     Zong Li <zong.li@sifive.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 12:11 AM Zong Li <zong.li@sifive.com> wrote:
>
> Add the missing header in file, it was lost in original implementation.
>
> The warning message as follows:
>  - no previous prototype for 'patch_text_nosync' [-Wmissing-prototypes]
>  - no previous prototype for 'patch_text' [-Wmissing-prototypes]
>
> Changed in v2:
>  - Correct the typo of commit message.
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> ---
>  arch/riscv/kernel/patch.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> index 5805791cd5b5..d4a64dfed342 100644
> --- a/arch/riscv/kernel/patch.c
> +++ b/arch/riscv/kernel/patch.c
> @@ -11,6 +11,7 @@
>  #include <asm/kprobes.h>
>  #include <asm/cacheflush.h>
>  #include <asm/fixmap.h>
> +#include <asm/patch.h>
>
>  struct patch_insn {
>         void *addr;
> --
> 2.26.2
>
>

Reviewed-by: Atish Patra <atish.patra@wdc.com>

-- 
Regards,
Atish
