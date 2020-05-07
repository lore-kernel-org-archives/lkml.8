Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36E7C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 10:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A68AC208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 10:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588847805;
	bh=KfmV+2Xl+ChjbcxB/grK2lKVDmYOfQCngH4EwLeGR1M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ABxx5ZoD5xWjWZaYmRjnDM44hMXM/XD1knWTl6MwoT8eBy/nD6ZnAQBAafWe4C0VT
	 aWtO4Kldpjmy8sBcsOt5y7AMAtNPgFG7rBQVlY06qInp6O3pXRgqbkSoc5y1vzf9kE
	 k2knLvCOvkKd2q1EuAQoHyQGZjHouTqMNzu/RkVE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgEGKgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 06:36:44 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:47791 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgEGKgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 06:36:44 -0400
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 047Aa5qY014965
        for <linux-kernel@vger.kernel.org>; Thu, 7 May 2020 19:36:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 047Aa5qY014965
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1588847767;
        bh=B7EfioEe1RRKN3M74HtxQvobPG5NMUGMFYHo0+IEkRQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qfhb4KAsmhFIhm+sylcShPBeUPhL1sjIWR97L7jZhN8YBOLtO1C8IC63cgwkMoicR
         /lNiCDXIYi6qPJ/akRXz2WPYscWYLkmp3XQf1exth4lsB2iqJiFRgBy239WJWFXmpM
         4QskmOcUNjevLXrzlwPrpTz+nxUp+GDMArkc1DXOuMSrfjIRof3ymfKI9/xN6gL6/T
         gd/Ff9PfAv+Qyq3zzPk/x8gvPFocp1+WZMrqZYDjgMTsQDMnlnwGKzoj6pooydJ1zo
         SaWvDsmfDqQvRJnuv29kTIHbQm8eIoJLdWSoM/EtgHkq84CqdIvdsVX7bpSSgbzt55
         c5/BjQJVcTQdQ==
X-Nifty-SrcIP: [209.85.217.44]
Received: by mail-vs1-f44.google.com with SMTP id m24so3024641vsq.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 03:36:06 -0700 (PDT)
X-Gm-Message-State: AGi0PuammPZDgLkIbxSrrRUQjyioseckbACKl9MESp5C7T8PrI2Wi+TM
        jx2bNz7E0b9B8Br78yN6L2pNcKOIk7BZaDNhB4o=
X-Google-Smtp-Source: APiQypIwgU3Ey8732cDkL7DoJbdMF7RKIUy0//fJu29fwQ1PVgNjOufpgKXz15BLMh+CeAAXNiLotUsTSDcyd33NRG8=
X-Received: by 2002:a05:6102:3c7:: with SMTP id n7mr11095677vsq.179.1588847765172;
 Thu, 07 May 2020 03:36:05 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200430124958epcas5p15ecc8e744ed0f78837a6d58274a5baf0@epcas5p1.samsung.com>
 <1588250972-8507-1-git-send-email-maninder1.s@samsung.com> <1588250972-8507-3-git-send-email-maninder1.s@samsung.com>
In-Reply-To: <1588250972-8507-3-git-send-email-maninder1.s@samsung.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 7 May 2020 19:35:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQxOtjsrS6b8pF93=0yqnTJT6b7V2hDOWsYGH-njNcZdw@mail.gmail.com>
Message-ID: <CAK7LNAQxOtjsrS6b8pF93=0yqnTJT6b7V2hDOWsYGH-njNcZdw@mail.gmail.com>
Subject: Re: [PATCH 3/4] scripts/checkstack.pl: add arm push handling for
 stack usage
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     "George G. Davis" <george_davis@mentor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        a.sahrawat@samsung.com, Vaneet Narang <v.narang@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>, Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+CC Andi Kleen, and more mentor)


On Thu, Apr 30, 2020 at 9:50 PM Maninder Singh <maninder1.s@samsung.com> wrote:
>
> To count stack usage of push {*, fp, ip, lr, pc} instruction in ARM,
> if FRAME POINTER is enabled.
> e.g. c01f0d48: e92ddff0 push {r4, r5, r6, r7, r8, r9, sl, fp, ip, lr, pc}
>
> c01f0d50 <Y>:
> c01f0d44:       e1a0c00d        mov     ip, sp
> c01f0d48:       e92ddff0        push    {r4, r5, r6, r7, r8, r9, sl, fp, ip, lr, pc}
> c01f0d4c:       e24cb004        sub     fp, ip, #4
> c01f0d50:       e24dd094        sub     sp, sp, #448    ; 0x1C0
>
> $ cat dump | scripts/checkstack.pl arm
> 0xc01f0d50 Y []:                                        448
>
> added subroutine frame work for this.
> After change:
> 0xc01f0d500 Y []:                                       492
>
> Signed-off-by: Vaneet Narang <v.narang@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>



I do not mean to block this patch, but
some people still invest efforts to improve this script.
So, please let me ask this question.

Do you know CONFIG_FRAME_WARN?

Commit 35bb5b1e0e84cfa1a8906f7e6a77f391ff315791
mentioned -Wframe-larger-than should obsolete
make checkstack.

Now, -Wframe-larger-than is supported by
both minimal version of GCC and Clang.

I know checkstack.pl dumps the stack size
of functions, which is different from what
-Wframe-larger-than does, but the goal is
quite similar, I think.

I just wondered if we need both.




> ---
>  scripts/checkstack.pl | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/checkstack.pl b/scripts/checkstack.pl
> index 8e5ef98..b292ef4 100755
> --- a/scripts/checkstack.pl
> +++ b/scripts/checkstack.pl
> @@ -34,8 +34,10 @@ use strict;
>  # $& (whole re) matches the complete objdump line with the stack growth
>  # $1 (first bracket) matches the dynamic amount of the stack growth
>  #
> +# $sub: subroutine for special handling to check stack usage.
> +#
>  # use anything else and feel the pain ;)
> -my (@stack, $re, $dre, $x, $xs, $funcre, $min_stack);
> +my (@stack, $re, $dre, $sub, $x, $xs, $funcre, $min_stack);
>  {
>         my $arch = shift;
>         if ($arch eq "") {
> @@ -59,6 +61,7 @@ my (@stack, $re, $dre, $x, $xs, $funcre, $min_stack);
>         } elsif ($arch eq 'arm') {
>                 #c0008ffc:      e24dd064        sub     sp, sp, #100    ; 0x64
>                 $re = qr/.*sub.*sp, sp, #(([0-9]{2}|[3-9])[0-9]{2})/o;
> +               $sub = \&arm_push_handling;
>         } elsif ($arch =~ /^x86(_64)?$/ || $arch =~ /^i[3456]86$/) {
>                 #c0105234:       81 ec ac 05 00 00       sub    $0x5ac,%esp
>                 # or
> @@ -112,6 +115,24 @@ my (@stack, $re, $dre, $x, $xs, $funcre, $min_stack);
>  }
>
>  #
> +# To count stack usage of push {*, fp, ip, lr, pc} instruction in ARM,
> +# if FRAME POINTER is enabled.
> +# e.g. c01f0d48: e92ddff0 push {r4, r5, r6, r7, r8, r9, sl, fp, ip, lr, pc}
> +#
> +sub arm_push_handling {
> +       my $regex = qr/.*push.*fp, ip, lr, pc}/o;
> +       my $size = 0;
> +       my $line_arg = shift;
> +
> +       if ($line_arg =~ m/$regex/) {
> +               $size = $line_arg =~ tr/,//;
> +               $size = ($size + 1) * 4;
> +       }
> +
> +       return $size;
> +}
> +
> +#
>  # main()
>  #
>  my ($func, $file, $lastslash, $total_size, $addr, $intro);
> @@ -163,6 +184,10 @@ while (my $line = <STDIN>) {
>                 $size = hex($size) if ($size =~ /^0x/);
>                 $total_size = $total_size + $size
>         }
> +       elsif (defined $sub) {
> +               my $size = &$sub($line);
> +               $total_size = $total_size + $size;


                  $total_size += $size;

           Or

                  $total_size += &$sub($line);

                   then, delete $size.



> +       }
>  }
>  if ($total_size > $min_stack) {
>         push @stack, "$intro$total_size\n";
> --
> 1.9.1
>


-- 
Best Regards
Masahiro Yamada
