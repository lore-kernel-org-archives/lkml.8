Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F6BC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 08:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C1F32075E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 08:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588839206;
	bh=rNQJq7nKT8w1XwqQbSgRgvN27JbP7tFUwgsmi5ku2r0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2PjzZkFe6pf13bqj093L1ZPWs1RepHr8L1iAJ+KZQVw7RgatPisEKYXzyJ+cO+XEc
	 PzWe0jeGwjE4rRRXmmkcEnyX5tIdSfHimj+5bI1xWgs5gz5DcI6aOqVOjY6YYzt3dX
	 J8S30+UjhZgrV06n+L3gj1AVz/t5iB9nOTGypqcY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgEGINZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 04:13:25 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:22926 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgEGINY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 04:13:24 -0400
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 0478DAeu016703
        for <linux-kernel@vger.kernel.org>; Thu, 7 May 2020 17:13:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 0478DAeu016703
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1588839191;
        bh=yqnhy/Loh7LKN1m1cEYiEkGwQiIvaHjvYq0yDYsuUQM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mavmXqpGw8R7lJuk1GuibNupIMvz/hETcCJZM75fdgmvOVMDV9lXbFheD+WOgRBxw
         E4K6whEgqlDL9YSM3WuNUA9kPWHJStbSFyXjhJE+a5ikkPqle1jivhRhwr98DGJtSj
         FsguWWucHfp2zQLatV/XrSV4Y/yjP2tVr4XRJG3m/gQdAPSW7YAP7wD+6PHiIkQ0GR
         pbi6GrEeo5NFI36chlWBvmKwfHd5GAXrai+EGs2VGm07Jv8PtVlg3GTO8FbwVZvP01
         P+pSA4paEoNGPSjQcMA8JxAX+upxIk6pGU0+URrcphHyQ2MYGnC2r4cc/Ost08EHBJ
         7DrV5n1l2FTAw==
X-Nifty-SrcIP: [209.85.217.49]
Received: by mail-vs1-f49.google.com with SMTP id e10so2821285vsp.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 01:13:10 -0700 (PDT)
X-Gm-Message-State: AGi0PuYqgWrlkZz1itof/rXLXB/UHhU4QrXfUq+QoWKAB0HPhWV3DSKC
        QqmC73OQA0Ny8yQB7inNoux09Xo5413x98WtO7Y=
X-Google-Smtp-Source: APiQypLFCNkcA++Yq32fn+1tRnbuNBqswthhAAMORjcPgW28CvggTAxPw6oxWG/vOVhQOWfDmHr4E0khGPt96S+oq9Q=
X-Received: by 2002:a67:e94d:: with SMTP id p13mr10873449vso.215.1588839189847;
 Thu, 07 May 2020 01:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200430124952epcas5p28cd53b0aa452f43eed48ed9d58b4005b@epcas5p2.samsung.com>
 <1588250972-8507-1-git-send-email-maninder1.s@samsung.com>
In-Reply-To: <1588250972-8507-1-git-send-email-maninder1.s@samsung.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 7 May 2020 17:12:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQuT6-sRrdwT183RYEBgHNpiKAzN=RiubHrXZeb2ifqjw@mail.gmail.com>
Message-ID: <CAK7LNAQuT6-sRrdwT183RYEBgHNpiKAzN=RiubHrXZeb2ifqjw@mail.gmail.com>
Subject: Re: [PATCH 1/4] scripts/checkstack.pl: don't display $dre as
 different entity
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     "George G. Davis" <george_davis@mentor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        a.sahrawat@samsung.com, Vaneet Narang <v.narang@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 9:50 PM Maninder Singh <maninder1.s@samsung.com> wrote:
>
> currnetly script prints stack usage for functions
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
> Signed-off-by: Vaneet Narang <v.narang@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> ---
>  scripts/checkstack.pl | 52 +++++++++++++++++++++++++--------------------------
>  1 file changed, 25 insertions(+), 27 deletions(-)
>
> diff --git a/scripts/checkstack.pl b/scripts/checkstack.pl
> index 371bd17..412c459 100755
> --- a/scripts/checkstack.pl
> +++ b/scripts/checkstack.pl
> @@ -109,11 +109,28 @@ my (@stack, $re, $dre, $x, $xs, $funcre);
>  #
>  # main()
>  #
> -my ($func, $file, $lastslash);
> +my ($func, $file, $lastslash, $total_size, $addr, $intro);


$total_size is undefined for the first function.
I think 0 is implied, but is it clearer to initialize it here?

$total_size = 0;



>  while (my $line = <STDIN>) {
>         if ($line =~ m/$funcre/) {
> +               if ($total_size > 100) {
> +                       push @stack, "$intro$total_size\n";
> +               }
> +
>                 $func = $1;
> +               next if $line !~ m/^($xs*)/;

Hmm, I think this 'next' is unlikely to happen.
But, it happened, the same line would be pushed twice.

Maybe, is it better to move 'next it' above
the 'if ($total_size > 100)' check?




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
> @@ -134,37 +151,18 @@ while (my $line = <STDIN>) {
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
> +               $total_size = $total_size + $size


For consistency, I personally prefer adding ';'
to every statement even for the last one in the block...


Is this simpler ?

                  $total_size += $size;






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
> +               $total_size = $total_size + $size



Ditto. How about this?

                  $total_size += $size;


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
