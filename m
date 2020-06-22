Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9ADAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 21:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D6B720732
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 21:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730642AbgFVVYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 17:24:50 -0400
Received: from smtprelay0192.hostedemail.com ([216.40.44.192]:51818 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728555AbgFVVYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 17:24:50 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id EB19718029134;
        Mon, 22 Jun 2020 21:24:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sink53_2c02d6f26e36
X-Filterd-Recvd-Size: 3649
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Mon, 22 Jun 2020 21:24:47 +0000 (UTC)
Message-ID: <8a218fa14cc2e1690df32d278c82587c7507a820.camel@perches.com>
Subject: Re: [PATCH] checkpatch: fix CONST_STRUCT when
 const_structs.checkpatch is missing
From:   Joe Perches <joe@perches.com>
To:     Quentin Monnet <quentin@isovalent.com>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Mon, 22 Jun 2020 14:24:47 -0700
In-Reply-To: <20200622204844.21030-1-quentin@isovalent.com>
References: <20200622204844.21030-1-quentin@isovalent.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-06-22 at 21:48 +0100, Quentin Monnet wrote:
> Checkpatch reports warnings when some specific structs are not declared
> as const in the code. The list of structs to consider was initially
> defined in the checkpatch.pl script itself, but it was later moved to an
> external file (scripts/const_structs.checkpatch). This introduced two
> minor issues:
> 
> - When file scripts/const_structs.checkpatch is not present (for
>   example, if checkpatch is run outside of the kernel directory with the
>   "--no-tree" option), a warning is printed to stderr to tell the user
>   that "No structs that should be const will be found". This is fair,
>   but the warning is printed unconditionally, even if the option
>   "--ignore CONST_STRUCT" is passed. In the latter case, we explicitly
>   ask checkpatch to skip this check, so no warning should be printed.
> 
> - When scripts/const_structs.checkpatch is missing, or even when trying
>   to silence the warning by adding an empty file, $const_structs is set
>   to "", and the regex used for finding structs that should be const,
>   "$line =~ /\bstruct\s+($const_structs)\b(?!\s*\{)/)", matches all
>   structs found in the code, thus reporting a number of false positives.
> 
> Let's fix the first item by skipping scripts/const_structs.checkpatch
> processing if "CONST_STRUCT" checks are ignored, and the second one by
> skipping the test if $const_structs is an empty string.
> 
> Fixes: bf1fa1dae68e ("checkpatch: externalize the structs that should be const")

Probably not worthy of a Fixes: line, as that's
generally used for backporting, but OK by me.

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -781,8 +781,10 @@ sub read_words {
>  }
>  
>  my $const_structs = "";

This might be a tiny bit faster/less cpu using:

my $const_structs;

> -read_words(\$const_structs, $conststructsfile)
> -    or warn "No structs that should be const will be found - file '$conststructsfile': $!\n";
> +if (show_type("CONST_STRUCT")) {
> +	read_words(\$const_structs, $conststructsfile)
> +	    or warn "No structs that should be const will be found - file '$conststructsfile': $!\n";
> +}
>  
>  my $typeOtherTypedefs = "";
>  if (length($typedefsfile)) {
> @@ -6660,7 +6662,8 @@ sub process {
>  
>  # check for various structs that are normally const (ops, kgdb, device_tree)
>  # and avoid what seem like struct definitions 'struct foo {'
> -		if ($line !~ /\bconst\b/ &&
> +		if ($const_structs ne "" &&

instead testing

		if (defined($const_structs) &&

> +		    $line !~ /\bconst\b/ &&
>  		    $line =~ /\bstruct\s+($const_structs)\b(?!\s*\{)/) {
>  			WARN("CONST_STRUCT",
>  			     "struct $1 should normally be const\n" . $herecurr);

