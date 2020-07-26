Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83CFC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 14:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE31F2070B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 14:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgGZOu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 10:50:58 -0400
Received: from smtprelay0156.hostedemail.com ([216.40.44.156]:58764 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725964AbgGZOu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 10:50:58 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 94DF52438E;
        Sun, 26 Jul 2020 14:50:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: ray83_5a078e226f59
X-Filterd-Recvd-Size: 2920
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Sun, 26 Jul 2020 14:50:55 +0000 (UTC)
Message-ID: <dae471a789ee6e0bda5e641eb8e376fd03667415.camel@perches.com>
Subject: Re: Re: Re: Re: checkpatch: support deprecated terms checking
From:   Joe Perches <joe@perches.com>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     =?UTF-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        SeongJae Park <sjpark@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, apw@canonical.com,
        colin.king@canonical.com, jslaby@suse.cz, pavel@ucw.cz,
        SeongJae Park <sjpark@amazon.de>
Date:   Sun, 26 Jul 2020 07:50:54 -0700
In-Reply-To: <20200726074511.26189-1-sj38.park@gmail.com>
References: <20200726074511.26189-1-sj38.park@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-07-26 at 09:45 +0200, SeongJae Park wrote:
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -721,6 +721,7 @@ sub read_word_corrections {
>  my %deprecated_terms_fix;
>  read_word_corrections($deprecated_terms_file, \%deprecated_terms_fix);
>  my $deprecated_terms = join("|", sort keys %deprecated_terms_fix) if keys %deprecated_terms_fix;
> +my %deprecated_terms_reported = map { $_ => 1 }

overly verbose naming and this doesn't need initialization here.

> @@ -2975,13 +2976,16 @@ sub process {
>  		    ($in_commit_log || $line =~ /^(?:\+|Subject:)/i)) {
>  			while ($rawline =~ /(?:^|[^a-z@])($deprecated_terms)(?:\b|$|[^a-z@])/gi) { 
>  				my $deprecated_term = $1;
> +				last if (exists($deprecated_terms_reported{$deprecated_term}));

next if (...) to check if multiple terms exists on the same line

> +				$deprecated_terms_reported{$deprecated_term} = 1;
> +

But this does need to be reset to empty when checking the next file

>  				my $suggested = $deprecated_terms_fix{lc($deprecated_term)};
>  				$suggested = ucfirst($suggested) if ($deprecated_term=~ /^[A-Z]/);
>  				$suggested = uc($suggested) if ($deprecated_term =~ /^[A-Z]+$/);
>  				my $msg_level = \&WARN;
>  				$msg_level = \&CHK if ($file);
>  				if (&{$msg_level}("DEPRECATED_TERM",
> -						  "Use of '$deprecated_term' is deprecated, please '$suggested', instead.\n" . $herecurr) &&
> +						  "Use of '$deprecated_term' is controversial - if not required by specification, perhaps '$suggested' instead.  See: scripts/deprecated_terms.txt\n" . $herecurr) &&
>  				    $fix) {
>  					$fixed[$fixlinenr] =~ s/(^|[^A-Za-z@])($deprecated_term)($|[^A-Za-z@])/$1$suggested$3/;

I think it simpler to avoid emitting this on existing files.

I do not want to encourage relatively inexperienced people
to run checkpatch and submit inappropriate patches.


