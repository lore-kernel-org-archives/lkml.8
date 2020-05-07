Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B28C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 10:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDABF208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 10:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588848000;
	bh=YP541EjI3NoCkfDw9IO4IUFLqhgliUbaju7ZvUnMZFI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mXzth4p6IkZhriGsUg7br+2FJJWk7KejXqXcQMPxWKFy8IBAQ0Rv/v+B8sNg3FESV
	 oCYu97lhayuZq88cJDglZ7zHlwesqAhCFmTHtcpVSfh1duKNj+jDWE/tFvGKyal423
	 wCRbFBUh5wwfpwFYGi0rpDmIzQMH5VqsaRvIGOjA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgEGKkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 06:40:00 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:19592 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgEGKj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 06:39:59 -0400
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 047AdRIF003000
        for <linux-kernel@vger.kernel.org>; Thu, 7 May 2020 19:39:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 047AdRIF003000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1588847968;
        bh=lOxb8f86Kz4Qx/da1Nx9cKkfwC10sWdTZOHVkCSBvsY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FxIPosAPHVFKoVTylyUva1ucqgjg4LPf4iojY6P3QW531JJzC7dH6l109yc916HAL
         ismKMTRrXALTf3m49Ie4wf1R4KUujOUqss+X3wXc7Vz6YrdkvEHegt2+RXoligaGjk
         ru+I0JZGfuBbCRHj3azFfYrzs1PhEpkyTf+hn2kjcu6PeM/MOSflM6gCyjP4ZvtLiN
         Sx1UI67sZsIwLrqQ9Y6eVR7zwHO0lH4AVtCQNUta5fA76WNX/aI9MCm2YP9jIfwYef
         TjdfQ7K/NOaSszySwxhHsSfHxeg6xXhAVZPQ983C50UHh1nWAxsd79SxNrjwG1OdRS
         AM68MnHgyjzBA==
X-Nifty-SrcIP: [209.85.217.49]
Received: by mail-vs1-f49.google.com with SMTP id z1so3038276vsn.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 03:39:28 -0700 (PDT)
X-Gm-Message-State: AGi0PuYG03zqCyH5t+y+RE3ubb0YEJ/B1PL5NxEJI10SvB9pW6xQH6X5
        wwToEBupgKJcV4y0OojFcm2DzzeUt0sCsUXUc3g=
X-Google-Smtp-Source: APiQypLvQgdvpB6JF3Ctp0ZVQgz8+NQtkk0Pl86Zh+WWbuPjqKN4pC2owQPYtXJ/IQp2D5MLksXgq7PN1vXGRLIe0u0=
X-Received: by 2002:a67:e94d:: with SMTP id p13mr11206427vso.215.1588847967057;
 Thu, 07 May 2020 03:39:27 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200430125001epcas5p2a6f02e9888481cef96f32ba14450bc63@epcas5p2.samsung.com>
 <1588250972-8507-1-git-send-email-maninder1.s@samsung.com> <1588250972-8507-4-git-send-email-maninder1.s@samsung.com>
In-Reply-To: <1588250972-8507-4-git-send-email-maninder1.s@samsung.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 7 May 2020 19:38:51 +0900
X-Gmail-Original-Message-ID: <CAK7LNASf687MLf1oWqrUiOHtw=p9Ug02bi1r-KevsxnFtQni2g@mail.gmail.com>
Message-ID: <CAK7LNASf687MLf1oWqrUiOHtw=p9Ug02bi1r-KevsxnFtQni2g@mail.gmail.com>
Subject: Re: [PATCH 4/4] scripts/checkstack.pl: fix arm sp regex
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
> if objdump has below entries;
> c01ed608 <X>:
> c01ed614:       e24ddff7        sub     sp, sp, #120    ; 0x78
>
> c01f0d50 <Y>:
> c01f0d50:       e24dd094        sub     sp, sp, #140    ; 0x8c
>
> scripts fails to read stack usage.
> so making regex $re for ARM similar to aarch64
>
> Signed-off-by: Vaneet Narang <v.narang@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>


This looks good to me, and it is a bug fix.

Just a question about the SOB.


Maninder Singh is the author and also the submitter, right?

What does "Signed-off-by: Vaneet Narang <v.narang@samsung.com>" mean?

Co-developed-by or something else?






> ---
>  scripts/checkstack.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/checkstack.pl b/scripts/checkstack.pl
> index b292ef4..e80de70 100755
> --- a/scripts/checkstack.pl
> +++ b/scripts/checkstack.pl
> @@ -60,7 +60,7 @@ my (@stack, $re, $dre, $sub, $x, $xs, $funcre, $min_stack);
>                 $dre = qr/^.*sub.*sp, sp, #(0x$x{1,8})/o;
>         } elsif ($arch eq 'arm') {
>                 #c0008ffc:      e24dd064        sub     sp, sp, #100    ; 0x64
> -               $re = qr/.*sub.*sp, sp, #(([0-9]{2}|[3-9])[0-9]{2})/o;
> +               $re = qr/.*sub.*sp, sp, #([0-9]{1,4})/o;
>                 $sub = \&arm_push_handling;
>         } elsif ($arch =~ /^x86(_64)?$/ || $arch =~ /^i[3456]86$/) {
>                 #c0105234:       81 ec ac 05 00 00       sub    $0x5ac,%esp
> --
> 1.9.1
>


-- 
Best Regards
Masahiro Yamada
