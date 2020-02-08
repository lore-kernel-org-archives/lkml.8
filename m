Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E01C35242
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 17:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99E620733
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 17:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I61HMxdl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbgBHRMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 12:12:35 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39671 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbgBHRMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 12:12:35 -0500
Received: by mail-pg1-f193.google.com with SMTP id j15so1508023pgm.6
        for <linux-kernel@vger.kernel.org>; Sat, 08 Feb 2020 09:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YD1lho2uBiFfgje3vY86cE2s7Be2NhAx8ao7Z4azKF8=;
        b=I61HMxdlwT05pwtKmeeU8+SUq4o970AFpSI9vYmhWG7LNFzWwqMvdBvdUQJXerJ/75
         718WtHd61dh3svU3LDow31w9U0Q3GpxBRn+Vp2al4NiNWcVBJgYsz59+irONFUX/gVus
         0bdnafXobtYBKgT800FQVwpC/KI+SuxuAnwFTApwZl9+Lfm4M4EKbZagJgN+poZvAj+v
         i1bCAtVcfEa2Bkb0VUzkV+Q06vQLZqZhVWhkOZWtgduSqRhenzTHqxtKfZEScyQKsrlu
         T7t6QmXR8mJKossLEOSUmxpe37cP6OhZy2BcvHjIS+XUvilGxEswnc9gbKbVbAqoIr/i
         u+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YD1lho2uBiFfgje3vY86cE2s7Be2NhAx8ao7Z4azKF8=;
        b=QJbmS3OGyjgvD2jOlt/wZ3yme47HKPYnh6gq+UUeumNYWsFJxJmIdpzfMZ2nYnWcSH
         5kj+PA+98dSqKnL/3HpsXh110Laqz/hfRwOeRYMR4fqkApVuAuUgyUp6MeSrj/cBgGFP
         /lsFpyTJe0NKa0knY6a+Fw8rpWG72WhrOxXs2rWoo4Q4n0chOM+RbfW5l6+n8Niv79UJ
         gqiSMHJwW8zQ4Evvh7CbxKliXi2pNfPC2sjPU9/IFcU3MN0zIFDZpqOg/bQ7xtbMfWBw
         SQ4kNIctSyg7J1Tlm5TuJ//0WNU6YQZWh2ZALGb6nxroQLz08NLp/QRVBAV/XQTUnquW
         hfSw==
X-Gm-Message-State: APjAAAW4TXfJiDbtNWOj3lNI93QRX2BRTI8P3Gi22A1EBTx74I6H1MDY
        Yf53pOAkBPuVRyEp+88ncu5WM7EdAxjtnv0f7LbaGQ==
X-Google-Smtp-Source: APXvYqwVLXqww5kkGenL05sF5jY8E+GKYeAHOD4+sLeQVPd37F3uYOa3F7dMC1/nX9oIiw0Is76yHtNB3ucZMKxVkDs=
X-Received: by 2002:aa7:8618:: with SMTP id p24mr5122092pfn.3.1581181954133;
 Sat, 08 Feb 2020 09:12:34 -0800 (PST)
MIME-Version: 1.0
References: <20200208141052.48476-1-natechancellor@gmail.com>
In-Reply-To: <20200208141052.48476-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Sat, 8 Feb 2020 17:12:21 +0000
Message-ID: <CAKwvOdm8-nL=BnTaCort+tAm27bkBzygmipZ7L3eBD4zvmyb8g@mail.gmail.com>
Subject: Re: [PATCH] s390/kaslr: Fix casts in get_random
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 8, 2020 at 3:11 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> ../arch/s390/boot/kaslr.c:78:25: warning: passing 'char *' to parameter
> of type 'const u8 *' (aka 'const unsigned char *') converts between
> pointers to integer
> types with different sign [-Wpointer-sign]
>                                   (char *) entropy, (char *) entropy,
>                                                     ^~~~~~~~~~~~~~~~
> ../arch/s390/include/asm/cpacf.h:280:28: note: passing argument to
> parameter 'src' here
>                             u8 *dest, const u8 *src, long src_len)
>                                                 ^
> 2 warnings generated.
>
> Fix the cast to match what else is done in this function.
>
> Fixes: b2d24b97b2a9 ("s390/kernel: add support for kernel address space layout randomization (KASLR)")
> Link: https://github.com/ClangBuiltLinux/linux/issues/862
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  arch/s390/boot/kaslr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/s390/boot/kaslr.c b/arch/s390/boot/kaslr.c
> index 5d12352545c5..5591243d673e 100644
> --- a/arch/s390/boot/kaslr.c
> +++ b/arch/s390/boot/kaslr.c
> @@ -75,7 +75,7 @@ static unsigned long get_random(unsigned long limit)
>                 *(unsigned long *) prng.parm_block ^= seed;
>                 for (i = 0; i < 16; i++) {
>                         cpacf_kmc(CPACF_KMC_PRNG, prng.parm_block,
> -                                 (char *) entropy, (char *) entropy,
> +                                 (u8 *) entropy, (u8 *) entropy,
>                                   sizeof(entropy));
>                         memcpy(prng.parm_block, entropy, sizeof(entropy));
>                 }
> --
> 2.25.0
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200208141052.48476-1-natechancellor%40gmail.com.



-- 
Thanks,
~Nick Desaulniers
