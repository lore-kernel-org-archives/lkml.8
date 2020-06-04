Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31813C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 22:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 035AA206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 22:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QDI73MuY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgFDWI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 18:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgFDWIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 18:08:25 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B9BC08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 15:08:25 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id n23so4102810pgb.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 15:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JE/WXA47qMtVomaH/lSH+D4gHq2pXNeqc/VuXi2s6u8=;
        b=QDI73MuYIYJ7TL+rCsdLcj4oR2mQVUVAsZxvG44SEKEJ3vvvYzRENZSTT7MYxxsETD
         lwE+BHbhr0pNr3i1fMOK6zS1j9zXiFYLbEMP6aRHzvyqWo5k9PR0/j7gC9MEiUC31b0X
         YyERRJvOKfMPlOxp/pEubFa4XkWzp++ZLfFA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JE/WXA47qMtVomaH/lSH+D4gHq2pXNeqc/VuXi2s6u8=;
        b=Fl2coOF5+AHc082D0AM6ryhU9Co6ZXd1Y7IcYhopQLICV/PkXVT95tMxDHlX+mAJvU
         sGqtLSmbLGwc76RMuVdE5YBdfFYur3RRmvlajcZV0uKesc2lzJxrzCL1oMeJSO1yy3s5
         aAuM+DWmmPEKFG7EZSoCKKjAs20bFnH34TOE2EKRcVJlfNN/QDvCGJRT0BYzUfXC4cVR
         DzByhMwSwdZdBIcvMwdC6p0WZ+GswvCt71OFMT2YmkWqmZaF+HF2qCG5ZpkVS9Vap5WO
         YH83zLZybXdQijoHA8rYNajw3/jxpeiduumkayqjqraLzsBQL4Ov1zcYtRWcIKbNdhqZ
         FuYQ==
X-Gm-Message-State: AOAM5308XyDow+sFMfk0ksAcW7iAp1QTvfomEvohwZDifj3X3c78ei3q
        PIIi87PSSaIHVSTpPGTdIUvAB/6Bc1wfQg==
X-Google-Smtp-Source: ABdhPJztQOAJAMh2loVloBicuB/Rg4iFaj6Va9E09bNhiXsvvmk2dWjauaFQbu8XhGpYaXYuioXLxA==
X-Received: by 2002:a63:4b0a:: with SMTP id y10mr6464552pga.57.1591308504905;
        Thu, 04 Jun 2020 15:08:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z18sm4981975pgi.68.2020.06.04.15.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 15:08:24 -0700 (PDT)
Date:   Thu, 4 Jun 2020 15:08:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: Re: [PATCH] checkpatch: Avoid missing typo suggestions
Message-ID: <202006041503.C9BFD40255@keescook>
References: <202006031618.DA25142@keescook>
 <a3c22bbd360d2148bf097d3c55a89ea13e07b719.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3c22bbd360d2148bf097d3c55a89ea13e07b719.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 05:39:47PM -0700, Joe Perches wrote:
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

Yeah, mine too. I think I may have added a symlink to my filesystem to
work around this.

> and I had to use --codespell --codespellfile=(above) so
> maybe there should be multiple lookups for this file
> like the array below.

That seems like a good idea.

> 
> Are there other standard codespell dictionary locations?
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
> -	if (open(my $spelling, '<', $codespellfile)) {
> +	if (!defined($codespellfile)) {
> +		my @csfiles = ("/usr/share/codespell/dictionary.txt",
> +			       "/usr/lib/python3/dist-packages/codespell_lib/data/dictionary.txt");
> +		foreach my $csfile (@csfiles) {
> +			if (-f $csfile) {
> +				$codespellfile = $csfile;
> +				last;
> +			}
> +		}
> +	}
> +
> +	if (!defined($codespellfile)) {
> +		warn "No codespell typos will be found - codespell dictionary not found\n";
> +	} elsif (open(my $spelling, '<', $codespellfile)) {
>  		while (<$spelling>) {
>  			my $line = $_;
>  
> @@ -2963,13 +2976,21 @@ sub process {
>  			while ($rawline =~ /(?:^|[^a-z@])($misspellings)(?:\b|$|[^a-z@])/gi) {
>  				my $typo = $1;
>  				my $typo_fix = $spelling_fix{lc($typo)};
> -				$typo_fix = ucfirst($typo_fix) if ($typo =~ /^[A-Z]/);
> -				$typo_fix = uc($typo_fix) if ($typo =~ /^[A-Z]+$/);
> +				$typo_fix = $spelling_fix{$typo} if (!defined($typo_fix));
> +				$typo_fix = $spelling_fix{uc($typo)} if (!defined($typo_fix));

This won't catch stuff like:

Cambrige->Cambridge

because neither "cambrige" nor "CAMBRIGE" is in %spelling_fix. And the
original text is lost due to the //i. :( I'm really not sure what to do
with these things in codespell. Lower case everything? Throw away
anything not all lower case?

-- 
Kees Cook
