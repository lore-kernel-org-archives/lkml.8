Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424E5C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 08:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1073020753
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 08:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588839254;
	bh=IHVOyrSAKuw04bOmG6ITxstY/X3NC8ccL3LvYmC9lpY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lYjOBz43yKZFuADudoF86J/y532JCZxoFgmHa2mm2ugUmcOkhPWkNwl68Y/66yDH2
	 1N4auyOO6GLAKuKG5NlUjB9/UzpTMNZObJr5LYgtogHU7n2omWAlNAvl00ANKkx6F1
	 7ZCeCFyze4VyWltbFAUCJkIojgAnFixsj8rWliWs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgEGION (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 04:14:13 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:34939 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgEGIOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 04:14:12 -0400
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 0478Dc5P008707
        for <linux-kernel@vger.kernel.org>; Thu, 7 May 2020 17:13:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 0478Dc5P008707
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1588839219;
        bh=oO23HSsWhRBDhOTb98SBCWFO49siOAirG9x+sRE0UoY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BaWCx5RzNwzhamAV77FD4rs3gnmwdJ+Zaa7bSJn/GYFhICn6TmXOG5IrDP6D8N6HL
         qI3VUS6MizO/GSE1vbgx4SeNnrR8SydfXto0y6Qpqh6coGUpx7fAMuqLfH/KT+42oj
         ZdOqwUky5jZgMtMOlHU68zbmcUMNzFLuBHsSSlDb3DDQSj7pQGt/tPzEiYmQUaPJXY
         udPvY4id8t86ZxdtTMg4hsefqh1EvsFpOMUlEPOl7/6+dX1oCN4q4AJNgb54/97X0Y
         xe+G85Aewmzmk26Lw7npmqwDhl8NDdtdy/UuTWf9Q7+3SVtwuHrMX3RWCD8ep3sdTJ
         tP6TX/5sv9Aow==
X-Nifty-SrcIP: [209.85.217.49]
Received: by mail-vs1-f49.google.com with SMTP id s11so2826120vsm.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 01:13:39 -0700 (PDT)
X-Gm-Message-State: AGi0PuazvZ5o0+z+M/SAc4U6bKX9gGbPpg5BIeImQw38mROEJ3JH997F
        aTp5PNFx3gAcb4mtK18nwNlEKhGupVAXtherKzo=
X-Google-Smtp-Source: APiQypLwM3BW7DMJPZFbKzpJjXsVIV8g3d+kRwYnRHMEncLQXUcHDXQGM178jYukr80/uu+tzH/cbAwxQL8aPJDRvlY=
X-Received: by 2002:a67:6e07:: with SMTP id j7mr11040549vsc.181.1588839218008;
 Thu, 07 May 2020 01:13:38 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200430124955epcas5p4b5c1dd7393a7b798d80206d071264df3@epcas5p4.samsung.com>
 <1588250972-8507-1-git-send-email-maninder1.s@samsung.com> <1588250972-8507-2-git-send-email-maninder1.s@samsung.com>
In-Reply-To: <1588250972-8507-2-git-send-email-maninder1.s@samsung.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 7 May 2020 17:13:02 +0900
X-Gmail-Original-Message-ID: <CAK7LNARQNmrCYofk5yG6diwrZnaqgUs0ASBo23k25SnOKM3viQ@mail.gmail.com>
Message-ID: <CAK7LNARQNmrCYofk5yG6diwrZnaqgUs0ASBo23k25SnOKM3viQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] scripts/checkstack.pl: Add argument to print stacks
 greather than value.
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
> Add arguments support to print stacks which are greater than
> argument value only.
>
> Signed-off-by: Vaneet Narang <v.narang@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> ---
>  scripts/checkstack.pl | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/checkstack.pl b/scripts/checkstack.pl
> index 412c459..8e5ef98 100755
> --- a/scripts/checkstack.pl
> +++ b/scripts/checkstack.pl
> @@ -35,7 +35,7 @@ use strict;
>  # $1 (first bracket) matches the dynamic amount of the stack growth
>  #
>  # use anything else and feel the pain ;)
> -my (@stack, $re, $dre, $x, $xs, $funcre);
> +my (@stack, $re, $dre, $x, $xs, $funcre, $min_stack);
>  {
>         my $arch = shift;
>         if ($arch eq "") {
> @@ -43,6 +43,11 @@ my (@stack, $re, $dre, $x, $xs, $funcre);
>                 chomp($arch);
>         }
>
> +       $min_stack = shift;
> +       if ($min_stack eq "" || $min_stack !~ /^\d+$/) {
> +               $min_stack = 100;
> +       }
> +
>         $x      = "[0-9a-f]";   # hex character
>         $xs     = "[0-9a-f ]";  # hex character or space
>         $funcre = qr/^$x* <(.*)>:$/;
> @@ -113,7 +118,7 @@ my ($func, $file, $lastslash, $total_size, $addr, $intro);
>
>  while (my $line = <STDIN>) {
>         if ($line =~ m/$funcre/) {
> -               if ($total_size > 100) {
> +               if ($total_size > $min_stack) {
>                         push @stack, "$intro$total_size\n";
>                 }
>
> @@ -150,7 +155,6 @@ while (my $line = <STDIN>) {
>                         $size += 0x80000000;
>                 }
>                 next if ($size > 0x10000000);
> -


This is a noise change.

You can do this in 1/4 if you want to.



>                 $total_size = $total_size + $size
>         }
>         elsif (defined $dre && $line =~ m/$dre/) {
> @@ -160,7 +164,7 @@ while (my $line = <STDIN>) {
>                 $total_size = $total_size + $size
>         }
>  }
> -if ($total_size > 100) {
> +if ($total_size > $min_stack) {
>         push @stack, "$intro$total_size\n";
>  }
>
> --
> 1.9.1
>


--
Best Regards

Masahiro Yamada
