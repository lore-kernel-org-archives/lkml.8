Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D25CC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 20:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5475C20757
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 20:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588711220;
	bh=KsXgkPIepQrTxi3STz1MeJ2XqM4eEMfu8mg3G7P86hg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=c1ru1eiCQFOS2cTM963XcQ39yUF/U5CjAIunOkrIH5PbaXP84huyeucD+z5G7EG58
	 6JcIRii0IVcGF3k+8T0WJfl95Nru4Eh04ZX8MmQeLGEtMShKl5Ycj7WuP3Xuyhh3/T
	 t7pO9dkMDA3vik3mYfywSmzIQwUxwWADPnikDsAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgEEUkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 16:40:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbgEEUkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 16:40:18 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF5C920752;
        Tue,  5 May 2020 20:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588711218;
        bh=KsXgkPIepQrTxi3STz1MeJ2XqM4eEMfu8mg3G7P86hg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kd3Y8n8K/YRIFOhhPweSLC+9q2w1NgM7FntiyXkAgNbpx7g1GG0YO06RDixKqu8Lw
         eyR0UNKZwiWq1KgKk+h5ul4zS1tOgSxz/zHqJQiwHwlyiWygtZMZw3t2JP4yv6BBN1
         2I7nQyVgfTGNc64wiaqTTIEuV69tpWbPHfqpccwI=
Received: by pali.im (Postfix)
        id C6C5E6F1; Tue,  5 May 2020 22:40:15 +0200 (CEST)
Date:   Tue, 5 May 2020 22:40:15 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Whitcroft <apw@canonical.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, users@linux.kernel.org
Subject: Re: [kernel.org users] [PATCH v2] checkpatch: use patch subject when
 reading from stdin
Message-ID: <20200505204015.44ibvg4bapnalrct@pali>
References: <20200505132613.17452-1-geert+renesas@glider.be>
 <1b0b4e6562cbbf4621e71042e511ae3cd0b542f6.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b0b4e6562cbbf4621e71042e511ae3cd0b542f6.camel@perches.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tuesday 05 May 2020 12:57:37 Joe Perches wrote:
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index eac40f0abd56a9f4..3355358697d9e790 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -1057,6 +1057,10 @@ for my $filename (@ARGV) {
> >  	}
> >  	while (<$FILE>) {
> >  		chomp;
> > +		if ($vname eq 'Your patch') {
> > +			my ($subject) = $_ =~ /^Subject:\s*(.*)/;
> > +			$vname = '"' . $subject . '"' if $subject;
> > +		}
> >  		push(@rawlines, $_);
> >  	}
> >  	close($FILE);
> 
> There's a less cpu intensive way to do this,
> for small patches, on my little laptop it's a
> few dozen milliseconds faster, and for very
> large patches multiple seconds faster to use
> the following patch:
> 
> Substitute Geert's patch with the below but:
> 
> Acked-by: Joe Perches <joe@perches.com>
> 
> ---
> 
>  scripts/checkpatch.pl | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index f0092104ff7b..29786a097862 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1062,6 +1062,7 @@ for my $filename (@ARGV) {
>  	while (<$FILE>) {
>  		chomp;
>  		push(@rawlines, $_);
> +		$vname = "\"$1\"" if ($filename eq '-' && $_ =~ /^Subject:\s*(.*)/);

Hint: You can use qq operator to make code more readable (no need to
escape quote character). And maybe you should match Subject as
case-insensitive and expects at least one space after colon.
As a Perl developer I would write above code as:

+		$vname = qq("$1") if $filename eq '-' && $_ =~ m/^Subject:\s+(.+)/i;

Anyway, what would happen if subject line contains quotes?

>  	}
>  	close($FILE);
>  
> 
