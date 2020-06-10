Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D957C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 07:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30DBA2081A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 07:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbgFJHNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 03:13:46 -0400
Received: from smtprelay0218.hostedemail.com ([216.40.44.218]:46140 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726276AbgFJHNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 03:13:46 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 76A34181D3762;
        Wed, 10 Jun 2020 07:13:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: brain48_4312e6726dc9
X-Filterd-Recvd-Size: 2457
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Wed, 10 Jun 2020 07:13:44 +0000 (UTC)
Message-ID: <016a2c771e5535a872b9f20d90e4cc5683ea7a55.camel@perches.com>
Subject: Re: [PATCH v3 1/2] checkpatch: support deprecated terms checking
From:   Joe Perches <joe@perches.com>
To:     SeongJae Park <sjpark@amazon.com>, akpm@linux-foundation.org,
        apw@canonical.com
Cc:     colin.king@canonical.com, sj38.park@gmail.com,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Date:   Wed, 10 Jun 2020 00:13:42 -0700
In-Reply-To: <20200610065223.29894-2-sjpark@amazon.com>
References: <20200610065223.29894-1-sjpark@amazon.com>
         <20200610065223.29894-2-sjpark@amazon.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-06-10 at 08:52 +0200, SeongJae Park wrote:
> From: SeongJae Park <sjpark@amazon.de>
> 
> Some terms could be deprecated for various reasons, but it is hard to
> update the entire old usages.  That said, we could at least encourage
> new patches to use the suggested replacements.  This commit adds check
> of deprecated terms in the 'checkpatch.pl' for that.  The script will
> get deprecated terms and suggested replacements of those from
> 'scripts/deprecated_terms.txt' file and warn if the deprecated terms are
> used.  The mechanism and the format of the file are almost the same as
> that of 'spelling.txt'.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> +# Load deprecated terms and build regular expression list.
> +my $deprecated_terms;
> +my %deprecated_terms_fix;
> +
> +if (open(my $deprecates, '<', $deprecated_terms_file)) {
> +	while (<$deprecates>) {
> +		my $line = $_;
> +
> +		$line =~ s/\s*\n?$//g;
> +		$line =~ s/^\s*//g;
> +
> +		next if ($line =~ m/^\s*#/);
> +		next if ($line =~ m/^\s*$/);
> +
> +		my ($suspect, $fix) = split(/\|\|/, $line);
> +
> +		$deprecated_terms_fix{$suspect} = $fix;
> +	}
> +	close($deprecates);
> +} else {
> +	warn "No deprecated term will be found - file '$deprecated_terms_file': $!\n";
> +}
> +
> +$deprecated_terms = join("|", sort keys %deprecated_terms_fix) if keys %deprecated_terms_fix;
> +

This is a direct copy of the spelling dictionary
loading code, so maybe these could be consolidated.


