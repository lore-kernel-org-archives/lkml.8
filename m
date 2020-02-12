Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A1EC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF43720661
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgBLIiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 03:38:23 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:35611 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728428AbgBLIiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:38:22 -0500
Received: from mail-qk1-f182.google.com ([209.85.222.182]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MEmIl-1jGJS32slH-00GJ5u for <linux-kernel@vger.kernel.org>; Wed, 12 Feb
 2020 09:38:20 +0100
Received: by mail-qk1-f182.google.com with SMTP id a2so1241151qko.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 00:38:20 -0800 (PST)
X-Gm-Message-State: APjAAAWOKBX2xd7Rs1Ln4N24t3Nh/o/a/jQXU8fBUsqFyLsCk9smDCmd
        yNi3/iy3ZBn59MoY5rEncyKjvhmnAHbCTzrU3T0=
X-Google-Smtp-Source: APXvYqyYk7YcrJsuGQROcM1Q+7Sr79yC/wr0DfRbtSl7Fh7agtFK3thWNqlFOqrqSc684PPKwzGxufZobo2gdBgTBY4=
X-Received: by 2002:a05:620a:1530:: with SMTP id n16mr6477563qkk.394.1581496699586;
 Wed, 12 Feb 2020 00:38:19 -0800 (PST)
MIME-Version: 1.0
References: <fe6868726b897fb7e89058d8e45985141260ed68.1581494174.git.michal.simek@xilinx.com>
In-Reply-To: <fe6868726b897fb7e89058d8e45985141260ed68.1581494174.git.michal.simek@xilinx.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 12 Feb 2020 09:38:03 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1kjK=fqJiPWPOG19pBEX+khAgVyMC-7AqT4BiH8dDn8g@mail.gmail.com>
Message-ID: <CAK8P3a1kjK=fqJiPWPOG19pBEX+khAgVyMC-7AqT4BiH8dDn8g@mail.gmail.com>
Subject: Re: [PATCH] microblaze: Fix unistd_32.h generation format
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git@xilinx.com,
        Firoz Khan <firoz.khan@linaro.org>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Exq0zEcR4E3c2SEm/Nkna68KFy5bEyX4AzqxeBlwWkcTRSVOu3i
 V1rDHe1HBjp+0xrLCImTSSlOZ3DapxX9h0HRc94ilYyx47YCtiIJ/OPol//mMwpYcHBgjxs
 O2NSheR4UZlWn4AUgJrkM0aFv6g42SjY+LxjE4eGXZeY/Aiq6BDqmeJbXc+MGRe41IvuM1d
 0Ycb6XiP/3CdW8gd9v73w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BJGm9oCgk18=:CVySYhE5RvWhSgvCttlRRb
 HE/PZWrFJmvpM8+Sm40s4Zf5sRnMZmig8JNR8EiZQ8YACyoDG8QKTlDjcfQ25IA8IMXeOlBMR
 OW2vvoy/e0PtBLz6XWofMkfVtkCrLoE2PzZ33xg9KdeOHjpi4fvToP6YRg6tpYxMgBvNWBE34
 LBxG3dukLhv0jYSZ+OiZDDQr7WNPKe/RfgCqDQIc/ifCdXwoUT1cXLwvEtK9ZDGHYt23N8QPd
 +b3rQC9WJygb3IMilVsrr8VMoIwvtPj/nr6Eusg6tQaZZ535DQ0QWlWuTWl2M9byXvrQ5iaMu
 gmsVz5SVBfARLppEOkahPWG0v+FnNXZETW3Jqo69Ajel26KUvQw9Vatkrtpf7Gewd1V9AJ0RW
 UEoAuJnzgaSuJSzV3zPB6eLpwYqjIuPBJQOZGz3I3d1Ea9wbzDJ4Vvxl0UycnBq66YzivVs9W
 jbNzmIQ8rkXZc5tDub3BlnhUYwgKDlbs30XXRqt6xsCPT0+AwGssE276lZewxK5MHJ/nDrnJ3
 GwTQbvqyJvb0aib7GHfjOw7QWj8tV056NTdEu/UfwNJd8DzLJKrZaYewInkO0xMdUz38Gdp1W
 4w9DK2lLw7gq2KmIUDEBnzqUO0OrsyDayxNcchnNVpPXAFCL+QZZg/2cWJHbLtzcpT4qtN1qi
 kL+KgrGNlcEmtlEjZEnrI5mUSbIkB0vp71VGCDGiT/LMV2wRVPixsrmNKfAelYQlXNxH3+v38
 MSJnAPViDYDv62oQeBkrPRtZW0IpOLANdUtmwOdqo1HgmEXz4L79e+8MLXLFEShvHAiBfSacg
 V26c6zlGQct+h5awvM1tdlQHm5/yiGR+vAPdYaWdguUh/DkkIM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 8:56 AM Michal Simek <michal.simek@xilinx.com> wrote:
>
> Generated files are also checked by sparse that's why add newline
> to remove sparse (C=1) warning:
> ./arch/microblaze/include/generated/uapi/asm/unistd_32.h:438:45:
> warning: no newline at end of file
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Reviewed-by: Stefan Asserhall <stefan.asserhall@xilinx.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

The patch looks good, but if you don't mind respinning it, could respin
it to do the same thing for all architectures at once? I see that  some
already have it, but most don't.

> ---
>
>  arch/microblaze/kernel/syscalls/syscallhdr.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/microblaze/kernel/syscalls/syscallhdr.sh b/arch/microblaze/kernel/syscalls/syscallhdr.sh
> index 2e9062a926a3..4f4238433644 100644
> --- a/arch/microblaze/kernel/syscalls/syscallhdr.sh
> +++ b/arch/microblaze/kernel/syscalls/syscallhdr.sh
> @@ -33,4 +33,5 @@ grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
>         printf "#endif\n"
>         printf "\n"
>         printf "#endif /* %s */" "${fileguard}"
> +       printf "\n"
>  ) > "$out"
> --
> 2.25.0
>
