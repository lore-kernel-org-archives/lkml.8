Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D405EC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 14:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A48ED21655
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 14:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sitAIa6q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgCIO7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 10:59:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45498 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgCIO7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 10:59:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=+RbY562ZlHYwkdPKappIm3cW8cBre3bUqcDMjctvcSU=; b=sitAIa6qb1pheuvQV1LusSjSQZ
        1tHDTms/4mth+g3nW1TAeMrIuDeXghdRtiLSY5GncNSWLrph03RWjdrKdAvDy6Gr0MGzKTRdwyXkQ
        fWkUuAwVzFSlijJk8Ya8h2KS5JP8EWddyx4rJDy0Ma6XsApu9xV2oIuD11a7+gPRH/M3TFkkDSjgN
        vx/4/s9/a37jtCo5I8MoGz87SmroAKoeX/ngam0PZLfrruls24ju3Xzd+GlX/AsKXhm4WTikPEVH5
        LVPGRjGUSCj+HIvdOhTtJglej4kpzh++gB8r7ppdqVnSojEYxHjfYrB9Ekw4FflqFPh/aYMMxgwTK
        0pIKSz0Q==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jBJso-0002OX-JD; Mon, 09 Mar 2020 14:59:54 +0000
Subject: Re: [PATCH] ktest: Fix typos in ktest.pl
To:     Masanari Iida <standby24x7@gmail.com>,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org
References: <20200309115430.57540-1-standby24x7@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <097cdf11-33b5-45be-6a41-0e5354276bad@infradead.org>
Date:   Mon, 9 Mar 2020 07:59:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200309115430.57540-1-standby24x7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/20 4:54 AM, Masanari Iida wrote:
> This patch fixes multipe spelling typo found in ktest.pl.
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>

Looks good.  Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  tools/testing/ktest/ktest.pl | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
> index 6a605ba75dd6..dab03d80c902 100755
> --- a/tools/testing/ktest/ktest.pl
> +++ b/tools/testing/ktest/ktest.pl
> @@ -1030,7 +1030,7 @@ sub __read_config {
>  	    }
>  
>  	    if (!$skip && $rest !~ /^\s*$/) {
> -		die "$name: $.: Gargbage found after $type\n$_";
> +		die "$name: $.: Garbage found after $type\n$_";
>  	    }
>  
>  	    if ($skip && $type eq "TEST_START") {
> @@ -1063,7 +1063,7 @@ sub __read_config {
>  	    }
>  
>  	    if ($rest !~ /^\s*$/) {
> -		die "$name: $.: Gargbage found after DEFAULTS\n$_";
> +		die "$name: $.: Garbage found after DEFAULTS\n$_";
>  	    }
>  
>  	} elsif (/^\s*INCLUDE\s+(\S+)/) {
> @@ -1154,7 +1154,7 @@ sub __read_config {
>  	    # on of these sections that have SKIP defined.
>  	    # The save variable can be
>  	    # defined multiple times and the new one simply overrides
> -	    # the prevous one.
> +	    # the previous one.
>  	    set_variable($lvalue, $rvalue);
>  
>  	} else {
> @@ -1234,7 +1234,7 @@ sub read_config {
>  	foreach my $option (keys %not_used) {
>  	    print "$option\n";
>  	}
> -	print "Set IGRNORE_UNUSED = 1 to have ktest ignore unused variables\n";
> +	print "Set IGNORE_UNUSED = 1 to have ktest ignore unused variables\n";
>  	if (!read_yn "Do you want to continue?") {
>  	    exit -1;
>  	}
> @@ -1345,7 +1345,7 @@ sub eval_option {
>  	# Check for recursive evaluations.
>  	# 100 deep should be more than enough.
>  	if ($r++ > 100) {
> -	    die "Over 100 evaluations accurred with $option\n" .
> +	    die "Over 100 evaluations occurred with $option\n" .
>  		"Check for recursive variables\n";
>  	}
>  	$prev = $option;
> @@ -1461,7 +1461,7 @@ sub get_test_name() {
>  
>  sub dodie {
>  
> -    # avoid recusion
> +    # avoid recursion
>      return if ($in_die);
>      $in_die = 1;
>  
> 


-- 
~Randy
