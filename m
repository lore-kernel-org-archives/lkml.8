Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4971AC2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 20:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BF8D206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 20:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n0LnCFGD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388264AbgDMUPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 16:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388255AbgDMUPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 16:15:41 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E8DC0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 13:15:41 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id ay1so3816308plb.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 13:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DkHAR+oxww53GwT/kjjvrDpwgjqv7mOYgCamOLTpniI=;
        b=n0LnCFGDBJPaKi4xZcNfGjspPZVo3qwWE/LJARdpoj19RLpTyz2YPO+qxrO66/pqoT
         fixObNg4t8oGzp4L++uEnKgS+IPb02PXa4FNJJpSgKkFStsYY99XOGKUagqFiW6bGSnJ
         2TR/PsB32svMPu4BRKQSjIk3mmi8tsvUuuI0pN0GCu+h+WUj8YX0BUBB0mTCcUpymOvs
         V6r2QYPPR2Y0QIZJAoLQcxqoMv65gtoH+6+jLht9n1ZVxRxdddQjprWOXodIHMctl7tl
         AKm5yipWxQE6fokza9MMBEEMARxALJqu9nrEVIfxrAmp4QK8w+QxhwTUoGAZiRkRCJbw
         e+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DkHAR+oxww53GwT/kjjvrDpwgjqv7mOYgCamOLTpniI=;
        b=b2FOyVZykXTklsJfly51X5DX+wPpi8fwadqGwZegAvjhBlktG6rzSTOaER/crK6mdU
         lCT8q2o/LyC7BHt3iahPuO3OY4nkGHOA4nva3/9p7xymlplThKhmvuK4XXAPmLiQ+MXo
         FqaQKPqZDLhGYF5HvNLINAZ7Fafxi0BixyjeSHL8nsZkhxU12DrPfnV7InoOr8stZu2S
         Us4Xfcm1OnWV672jTFieH6EmFVCbOg4yoMu0Mp4Pw9z5pfDIYIUVqIrmWSVrjni/jTF/
         B1MIOy1ReLGTEYDelE5ZR7WNCOq2p3ZFVIeFZKFAc6A/2uJDjTKByhptBH1JmguVjvD2
         DwMg==
X-Gm-Message-State: AGi0PuZaL00HxewDVx8t/MxZe0fBvEE6HHbv6ELg13n1AzEdbHl732q+
        vJ1b85kXcdlBExA1as37fKS4/usj/743lrHBGvPgljlad68=
X-Google-Smtp-Source: APiQypLDBsROUmBgcpDq9xD2lz2MiGRhKpXw/T4Of6GQ+CDkATvN9ezhlPmN6HE2gQKYZ9Ou59c50LYayBLRd0SSGKw=
X-Received: by 2002:a17:90a:ff06:: with SMTP id ce6mr478682pjb.1.1586808940805;
 Mon, 13 Apr 2020 13:15:40 -0700 (PDT)
MIME-Version: 1.0
References: <17677130b3ca62d79817e6a22546bad39d7e81b4.camel@perches.com>
In-Reply-To: <17677130b3ca62d79817e6a22546bad39d7e81b4.camel@perches.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 13 Apr 2020 23:15:28 +0300
Message-ID: <CAHp75VePn6w6aN=+DW85rC9qSytBQSVaHjUC_QsmEqxaXYoz+A@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: Additional MAINTAINER section entry ordering checks
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@shadowen.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 11:12 PM Joe Perches <joe@perches.com> wrote:
>
> There is a preferred order for the entries in MAINTAINERS sections.
>
> See:
>
> commit 3b50142d8528 ("MAINTAINERS: sort field names for all entries")
> and
> commit 6680125ea5a2 ("MAINTAINERS: list the section entries in the preferred order)
>
> Add checkpatch tests to try to keep that ordering.
>

Good one, thanks!
FWIW,
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  scripts/checkpatch.pl | 45 +++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 37 insertions(+), 8 deletions(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index d64c67..3c44833 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3060,14 +3060,43 @@ sub process {
>                         #print "is_start<$is_start> is_end<$is_end> length<$length>\n";
>                 }
>
> -# check for MAINTAINERS entries that don't have the right form
> -               if ($realfile =~ /^MAINTAINERS$/ &&
> -                   $rawline =~ /^\+[A-Z]:/ &&
> -                   $rawline !~ /^\+[A-Z]:\t\S/) {
> -                       if (WARN("MAINTAINERS_STYLE",
> -                                "MAINTAINERS entries use one tab after TYPE:\n" . $herecurr) &&
> -                           $fix) {
> -                               $fixed[$fixlinenr] =~ s/^(\+[A-Z]):\s*/$1:\t/;
> +# check MAINTAINERS entries
> +               if ($realfile =~ /^MAINTAINERS$/) {
> +# check MAINTAINERS entries for the right form
> +                       if ($rawline =~ /^\+[A-Z]:/ &&
> +                           $rawline !~ /^\+[A-Z]:\t\S/) {
> +                               if (WARN("MAINTAINERS_STYLE",
> +                                        "MAINTAINERS entries use one tab after TYPE:\n" . $herecurr) &&
> +                                   $fix) {
> +                                       $fixed[$fixlinenr] =~ s/^(\+[A-Z]):\s*/$1:\t/;
> +                               }
> +                       }
> +# check MAINTAINERS entries for the right ordering too
> +                       my $preferred_order = 'MRLSWQBCPTFXNK';
> +                       if ($rawline =~ /^\+[A-Z]:/ &&
> +                           $prevrawline =~ /^[\+ ][A-Z]:/) {
> +                               $rawline =~ /^\+([A-Z]):\s*(.*)/;
> +                               my $cur = $1;
> +                               my $curval = $2;
> +                               $prevrawline =~ /^[\+ ]([A-Z]):\s*(.*)/;
> +                               my $prev = $1;
> +                               my $prevval = $2;
> +                               my $curindex = index($preferred_order, $cur);
> +                               my $previndex = index($preferred_order, $prev);
> +                               if ($curindex < 0) {
> +                                       WARN("MAINTAINERS_STYLE",
> +                                            "Unknown MAINTAINERS entry type: '$cur'\n" . $herecurr);
> +                               } else {
> +                                       if ($previndex >= 0 && $curindex < $previndex) {
> +                                               WARN("MAINTAINERS_STYLE",
> +                                                    "Misordered MAINTAINERS entry - list '$cur:' before '$prev:'\n" . $hereprev);
> +                                       } elsif ((($prev eq 'F' && $cur eq 'F') ||
> +                                                 ($prev eq 'X' && $cur eq 'X')) &&
> +                                                ($prevval cmp $curval) > 0) {
> +                                               WARN("MAINTAINERS_STYLE",
> +                                                    "Misordered MAINTAINERS entry - list file patterns in alphabetic order\n" . $hereprev);
> +                                       }
> +                               }
>                         }
>                 }
>
>


-- 
With Best Regards,
Andy Shevchenko
