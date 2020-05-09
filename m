Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C226C28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 07:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2651B24953
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 07:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589010190;
	bh=UHSf6Z47FfGB0qUrhgfd1myGCPpg3PopBhN/Pxob/0E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PLwO6o7mMfS6cWgfSRpNF8I3qeR7Il3IZ6Ytb81pWF1whCA/skUqRcEjmub6oOEqA
	 SYhYxD62q78YtxILkERuy1zIvUBu2QXhxHXhTUAtPeeth69h+V8qsYSEERgXFKllXm
	 gpO7miAm/p6uEPz4rGdidJF6GMSSnCFuucHPkUuA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgEIHnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 03:43:09 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:30489 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgEIHnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 03:43:08 -0400
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 0497glKL009568
        for <linux-kernel@vger.kernel.org>; Sat, 9 May 2020 16:42:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 0497glKL009568
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1589010168;
        bh=cvyOd1WsEVjCH2wf8G/bwMzDjemoQm3XWekZsG7OlCg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tCNhpZxMyGb9KyIL5m5vkSNe+bvedTRJeX/PrYaljbF1zN5Ha95fDOko+86gbTIOk
         OeC8hxe1Tg4Tl17Z4Ym9vAvu1TtUHP74Df1G5/AyY98X8/Jzoc1xXpH7/omPcLziOE
         0BJV1fW7newWr0lRHQfLfX80XRtJAhrSHtcV3/XCHEpRDfnftccJCGN8RHM0aGpt91
         wrtRgfNruSX7c8myupqXi22JbcR62tHBps+7umRLzfwWVUnpmBUJ27RCLPOapOmX7G
         0w7l1BdAlOKetzcjrVcIWNHdXnkaR37auRAhRL0R7uwERsXa2UE0TMElecY4Iz1ViR
         XT0r+Yq5T8Oug==
X-Nifty-SrcIP: [209.85.217.50]
Received: by mail-vs1-f50.google.com with SMTP id s11so2505913vsq.13
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 00:42:47 -0700 (PDT)
X-Gm-Message-State: AGi0PuZElUxy1If/0bNdHbDV8pi2FN/K9RxiglDEh6GN3jq1kilPnwCV
        oA3dg+WFS2qHfMZNOZ4TT40CvXihq5l+fAimEbw=
X-Google-Smtp-Source: APiQypL+sQgafYA4uCgxdY2isPdePEHuXbpy5uiMT5L3bO5owsgJlfUGftxvVUHhablF8VZ4RSiv7l1dv0Zp3A8Wrj8=
X-Received: by 2002:a05:6102:3c7:: with SMTP id n7mr4732676vsq.179.1589010166640;
 Sat, 09 May 2020 00:42:46 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200508110343epcas5p1ae3398e56ee895572487d05b730bd466@epcas5p1.samsung.com>
 <1588935797-7283-1-git-send-email-maninder1.s@samsung.com>
In-Reply-To: <1588935797-7283-1-git-send-email-maninder1.s@samsung.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 9 May 2020 16:42:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS2wJeC_cMy9_3fs4XuoyovQbsfgXD6BP2RCo=MQx=RzQ@mail.gmail.com>
Message-ID: <CAK7LNAS2wJeC_cMy9_3fs4XuoyovQbsfgXD6BP2RCo=MQx=RzQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] scripts/checkstack.pl: don't display $dre as
 different entity
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     "George G. Davis" <george_davis@mentor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        AMIT SAHRAWAT <a.sahrawat@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>, Andi Kleen <ak@linux.intel.com>,
        Vaneet Narang <v.narang@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 8, 2020 at 8:10 PM Maninder Singh <maninder1.s@samsung.com> wrote:
>
> currently script prints stack usage for functions
> in two ways:($re and $dre)
>
> dre breaks sorting mechanism.
> 0xffffa00011f26f88 sunxi_mux_clk_setup.isra.0 [vmlinux]:Dynamic (0x140)
> ..
> 0xffffa00011f27210 sunxi_divs_clk_setup [vmlinux]:      Dynamic (0x1d0)
>
> so we can print it in decimal only.
>
> Also address before function name is changed to function
> start address rather than stack consumption address.
> Because in next patch, arm has two ways to use stack
> which can be clubbed and printed in one function only.
>
> All symbols whose stack by adding(re and dre) is greater than
> 100, will be printed.
>
> 0xffffa00011f2720c0 sunxi_divs_clk_setup [vmlinux]:     464
> ...
> 0xffffa00011f26f840 sunxi_mux_clk_setup.isra.0 [vmlinux]:320
>
> Co-developed-by: Vaneet Narang <v.narang@samsung.com>
> Signed-off-by: Vaneet Narang <v.narang@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> ---


All applied to linux-kbuild. Thanks.



> v1: https://lkml.org/lkml/2020/4/30/530
> v2: review comments by Masahiro Yamada incorporated
>
>  scripts/checkstack.pl | 54 +++++++++++++++++++++++++--------------------------
>  1 file changed, 27 insertions(+), 27 deletions(-)
>
> diff --git a/scripts/checkstack.pl b/scripts/checkstack.pl
> index 371bd17..6957108 100755
> --- a/scripts/checkstack.pl
> +++ b/scripts/checkstack.pl
> @@ -109,11 +109,30 @@ my (@stack, $re, $dre, $x, $xs, $funcre);
>  #
>  # main()
>  #
> -my ($func, $file, $lastslash);
> +my ($func, $file, $lastslash, $total_size, $addr, $intro);
> +
> +$total_size = 0;
>
>  while (my $line = <STDIN>) {
>         if ($line =~ m/$funcre/) {
>                 $func = $1;
> +               next if $line !~ m/^($xs*)/;
> +               if ($total_size > 100) {
> +                       push @stack, "$intro$total_size\n";
> +               }
> +
> +               $addr = $1;
> +               $addr =~ s/ /0/g;
> +               $addr = "0x$addr";
> +
> +               $intro = "$addr $func [$file]:";
> +               my $padlen = 56 - length($intro);
> +               while ($padlen > 0) {
> +                       $intro .= '     ';
> +                       $padlen -= 8;
> +               }
> +
> +               $total_size = 0;
>         }
>         elsif ($line =~ m/(.*):\s*file format/) {
>                 $file = $1;
> @@ -134,37 +153,18 @@ while (my $line = <STDIN>) {
>                 }
>                 next if ($size > 0x10000000);
>
> -               next if $line !~ m/^($xs*)/;
> -               my $addr = $1;
> -               $addr =~ s/ /0/g;
> -               $addr = "0x$addr";
> -
> -               my $intro = "$addr $func [$file]:";
> -               my $padlen = 56 - length($intro);
> -               while ($padlen > 0) {
> -                       $intro .= '     ';
> -                       $padlen -= 8;
> -               }
> -               next if ($size < 100);
> -               push @stack, "$intro$size\n";
> +               $total_size += $size;
>         }
>         elsif (defined $dre && $line =~ m/$dre/) {
> -               my $size = "Dynamic ($1)";
> -
> -               next if $line !~ m/^($xs*)/;
> -               my $addr = $1;
> -               $addr =~ s/ /0/g;
> -               $addr = "0x$addr";
> +               my $size = $1;
>
> -               my $intro = "$addr $func [$file]:";
> -               my $padlen = 56 - length($intro);
> -               while ($padlen > 0) {
> -                       $intro .= '     ';
> -                       $padlen -= 8;
> -               }
> -               push @stack, "$intro$size\n";
> +               $size = hex($size) if ($size =~ /^0x/);
> +               $total_size += $size;
>         }
>  }
> +if ($total_size > 100) {
> +       push @stack, "$intro$total_size\n";
> +}
>
>  # Sort output by size (last field)
>  print sort { ($b =~ /:\t*(\d+)$/)[0] <=> ($a =~ /:\t*(\d+)$/)[0] } @stack;
> --
> 1.9.1
>


-- 
Best Regards
Masahiro Yamada
