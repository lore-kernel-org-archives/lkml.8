Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79F2C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 03:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B8C20747
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 03:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585797176;
	bh=zEpvyKptftJKXh1AIgzZTTQbfr1+ZiT4xwZd3QwDFE0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=ZYSV9nE8SPZtKNlknjnCECPekUJIfn4ojFJweDFpiycblwL/K1A6j9+qTyial72ei
	 CaFf/6LbUQ0yaDZ/rEKlaQ32YqSjbrDdyw9b1YhT9Mzs2neCPL5c8+PtMidTpbjfY3
	 t6V01zeO/+4JC1PkZ6NLS5/R7fulxP060HwVUzbs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733255AbgDBDMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 23:12:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:52128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732560AbgDBDMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 23:12:55 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95FA0206D3;
        Thu,  2 Apr 2020 03:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585797174;
        bh=zEpvyKptftJKXh1AIgzZTTQbfr1+ZiT4xwZd3QwDFE0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=S5Z4kCN3HO1uezCMtf3mBXTQ9ZfFpqJDXFfHk3xoUKz/vkF8g/E7DXVlCW5B9y/2V
         BPqLeqiJk5Bnc4rKSTFuD4oyCkI7QIjKxX7PYVjSFKnvB/7Dzae4cpAen7wKTF12eV
         fHkeNxYhOwiUNEF74029DbBQnvv5HesaEtyRYAD4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 68B94352282A; Wed,  1 Apr 2020 20:12:54 -0700 (PDT)
Date:   Wed, 1 Apr 2020 20:12:54 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>, dvyukov@google.com,
        glider@google.com, andreyknvl@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        apw@canonical.com, Will Deacon <will@kernel.org>
Subject: Re: [PATCH] checkpatch: Look for c99 comments in ctx_locate_comment
Message-ID: <20200402031254.GO19865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200401101714.44781-1-elver@google.com>
 <9de4fb8fa1223fc61d6d8d8c41066eea3963c12e.camel@perches.com>
 <20200401153824.GX19865@paulmck-ThinkPad-P72>
 <65cb075435d2f385a53c77571b491b2b09faaf8e.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65cb075435d2f385a53c77571b491b2b09faaf8e.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 07:20:30PM -0700, Joe Perches wrote:
> Some checks look for comments around a specific function like
> read_barrier_depends.
> 
> Extend the check to support both c89 and c90 comment styles.
> 
> 	c89 /* comment */
> or
> 	c99 // comment
> 
> For c99 comments, only look a 3 single lines, the line being scanned,
> the line above and the line below the line being scanned rather than
> the patch diff context.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Tested-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  scripts/checkpatch.pl | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index d64c67..0f4db4 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1674,8 +1674,16 @@ sub ctx_statement_level {
>  sub ctx_locate_comment {
>  	my ($first_line, $end_line) = @_;
>  
> +	# If c99 comment on the current line, or the line before or after
> +	my ($current_comment) = ($rawlines[$end_line - 1] =~ m@^\+.*(//.*$)@);
> +	return $current_comment if (defined $current_comment);
> +	($current_comment) = ($rawlines[$end_line - 2] =~ m@^[\+ ].*(//.*$)@);
> +	return $current_comment if (defined $current_comment);
> +	($current_comment) = ($rawlines[$end_line] =~ m@^[\+ ].*(//.*$)@);
> +	return $current_comment if (defined $current_comment);
> +
>  	# Catch a comment on the end of the line itself.
> -	my ($current_comment) = ($rawlines[$end_line - 1] =~ m@.*(/\*.*\*/)\s*(?:\\\s*)?$@);
> +	($current_comment) = ($rawlines[$end_line - 1] =~ m@.*(/\*.*\*/)\s*(?:\\\s*)?$@);
>  	return $current_comment if (defined $current_comment);
>  
>  	# Look through the context and try and figure out if there is a
> 
> 
