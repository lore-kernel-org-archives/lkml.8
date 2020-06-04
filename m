Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8501CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 06:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E5662072E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 06:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i7alFgL2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgFDG4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 02:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgFDG4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 02:56:09 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57904C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 23:56:08 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id d13so2403838ybk.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 23:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GTUywvJZD39+wLpr9bEMjka+iyj3T288ULC6aA9Vr/Y=;
        b=i7alFgL2o2VQy7tyyv1Wq8V+G6tBJOD9RttmPMSFsFM6+Nm9okQNgtTUs1RvLIe/Vq
         PHOzi+OnvNvocITV9/LA8ztwh6liY374Hi2Y5E5u7XIYE2OSJXcOwoNrkLDansW67KDW
         63goK7k3fiS1RcCKrxrwCmwCZf6RZF+dAQO+ImG6PLW16unsRjhiGJAeRWXfMLcXX2rR
         j3mkOs4qFYzY21QtqBmspUv1ePCrcScd+vbJQyVyFsvViMshTHGzQBiAs/piEwXvjeS1
         DO6i6QvYHAaz/Hq42dY6+XArZlylkxtUe2fuTi1z3ce13F7c6FWKIV+zPlbvUdA1IR5o
         5JRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GTUywvJZD39+wLpr9bEMjka+iyj3T288ULC6aA9Vr/Y=;
        b=hyBfLNBvECqT3bVH+UPIgsi1cBlQ9gxfc3kTSLgGtkqBSKV5+lV42OFKOk4IaiQnQ+
         ZaliHbumiMGgDldwUEN9aOMUxHbdgEct6hYozubrZaZtCbbc/h5sJBIQ4eCKoAjzwED6
         oaz3MMroBdbMf1E2W8imsy1x5Ki2SEIOgWCESQYZQytF/TxmlacMA+fSeq82ijW2KWZk
         8kz5hsDN9qP0DInjpCexgI1VFMfZtIsrcp98ykNRcjeXbllmLbnthZmiN46kK1wFrwAb
         ZJLmgILoq0H9HFzNAXqn/bYZle0qMpd2ElqpdSgecBZXIUBGC7kaGd4zhyfTZpcOBnM4
         MInQ==
X-Gm-Message-State: AOAM533iUHPZ2/HLW0fD1IhoFO/jQ9kUhPuAaw2ObCAM0Ud0vLcPuLx0
        p2bFeibnlpeybqPdu8ZXTM36vsb5v6kM5yufO8qkQauN0uA=
X-Google-Smtp-Source: ABdhPJx2foYUu54Jt4VJulmGPBFgDjDa6uueZS//Klwtxkcbv/O1lCXiW0eYTuKp1uzGJqzcu7YMQIOSPKRsa8/P8fA=
X-Received: by 2002:a25:4f08:: with SMTP id d8mr6108469ybb.125.1591253766611;
 Wed, 03 Jun 2020 23:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <202006031618.DA25142@keescook> <a3c22bbd360d2148bf097d3c55a89ea13e07b719.camel@perches.com>
In-Reply-To: <a3c22bbd360d2148bf097d3c55a89ea13e07b719.camel@perches.com>
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
Date:   Thu, 4 Jun 2020 09:55:55 +0300
Message-ID: <CAD8XO3bezWoM7Pc0VoiFgoDWTLMN6VwV1vEFL7PR=_iohV82Ag@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: Avoid missing typo suggestions
To:     Joe Perches <joe@perches.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Whitcroft <apw@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jun 2020 at 03:39, Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2020-06-03 at 16:19 -0700, Kees Cook wrote:
> > My codespell dictionary has a lot of capitalized words. For example:
> >
> > MSDOS->MS-DOS
> >
> > Since checkpatch uses case-insensitive matching, I get an undefined
> > variable warning and then empty suggestions for things like this:
> >
> > Use of uninitialized value $typo_fix in concatenation (.) or string at ./scripts/checkpatch.pl line 2958.
> >
> > WARNING: 'msdos' may be misspelled - perhaps ''?
> > +       struct msdos_dir_entry *de;
> >
> > This fixes the matcher to avoid the warning, but it's still a rather
> > silly suggestion:
> >
> > WARNING: 'msdos' may be misspelled - perhaps 'MS-DOS'?
> > +       struct msdos_dir_entry *de;
> >
> > So I'm not really sure what to do with this ... filter out bad
> > suggestions instead?
>
> Hey Kees.
>
> Maybe this?
>
> btw: My codespell dictionary file moved to
> /usr/lib/python3/dist-packages/codespell_lib/data/dictionary.txt
>
> and I had to use --codespell --codespellfile=(above) so
> maybe there should be multiple lookups for this file
> like the array below.
>
> Are there other standard codespell dictionary locations?

It might be better to support standard and non standard locations. I
think it's better to request from codespell where his dictionary is.
I created ticket for this:
https://github.com/codespell-project/codespell/issues/1540

However this patch is good as a temporary solution.

Regards,
Maxim.

> ---
>  scripts/checkpatch.pl | 31 ++++++++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 5 deletions(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 5f00df2c3f59..52aa0dd53d80 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -59,7 +59,7 @@ my $minimum_perl_version = 5.10.0;
>  my $min_conf_desc_length = 4;
>  my $spelling_file = "$D/spelling.txt";
>  my $codespell = 0;
> -my $codespellfile = "/usr/share/codespell/dictionary.txt";
> +my $codespellfile;
>  my $conststructsfile = "$D/const_structs.checkpatch";
>  my $typedefsfile = "";
>  my $color = "auto";
> @@ -716,7 +716,20 @@ if (open(my $spelling, '<', $spelling_file)) {
>  }
>
>  if ($codespell) {
> -       if (open(my $spelling, '<', $codespellfile)) {
> +       if (!defined($codespellfile)) {
> +               my @csfiles = ("/usr/share/codespell/dictionary.txt",
> +                              "/usr/lib/python3/dist-packages/codespell_lib/data/dictionary.txt");
> +               foreach my $csfile (@csfiles) {
> +                       if (-f $csfile) {
> +                               $codespellfile = $csfile;
> +                               last;
> +                       }
> +               }
> +       }
> +
> +       if (!defined($codespellfile)) {
> +               warn "No codespell typos will be found - codespell dictionary not found\n";
> +       } elsif (open(my $spelling, '<', $codespellfile)) {
>                 while (<$spelling>) {
>                         my $line = $_;
>
> @@ -2963,13 +2976,21 @@ sub process {
>                         while ($rawline =~ /(?:^|[^a-z@])($misspellings)(?:\b|$|[^a-z@])/gi) {
>                                 my $typo = $1;
>                                 my $typo_fix = $spelling_fix{lc($typo)};
> -                               $typo_fix = ucfirst($typo_fix) if ($typo =~ /^[A-Z]/);
> -                               $typo_fix = uc($typo_fix) if ($typo =~ /^[A-Z]+$/);
> +                               $typo_fix = $spelling_fix{$typo} if (!defined($typo_fix));
> +                               $typo_fix = $spelling_fix{uc($typo)} if (!defined($typo_fix));
> +                               $typo_fix = 'unknown typo fix' if (!defined($typo_fix));
> +                               if ($typo =~ /^[A-Z]+$/) {
> +                                       $typo_fix = uc($typo_fix);
> +                               } elsif ($typo =~ /^[A-Z]/) {
> +                                       $typo_fix = ucfirst($typo_fix);
> +                               }
> +
>                                 my $msg_level = \&WARN;
>                                 $msg_level = \&CHK if ($file);
>                                 if (&{$msg_level}("TYPO_SPELLING",
>                                                   "'$typo' may be misspelled - perhaps '$typo_fix'?\n" . $herecurr) &&
> -                                   $fix) {
> +                                   $fix &&
> +                                   $typo_fix ne 'unknown typo fix') {
>                                         $fixed[$fixlinenr] =~ s/(^|[^A-Za-z@])($typo)($|[^A-Za-z@])/$1$typo_fix$3/;
>                                 }
>                         }
>
