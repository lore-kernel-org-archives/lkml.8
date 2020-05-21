Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3230AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E73282078B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590067917;
	bh=lpxdayHtvYneN1YSTMROFmeSSiJxNNfvsF88kqWCtBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=F9P9XAik2lnlhH6WrZ1Zkn+pmgRDrI+uCZzjvsn0Oj9xfCjf6v/bzTDUGjrqNoQcP
	 YWbMSVEOYn/QqAPMFQPLMTpkbCg7IoZ6NDEciHUhd8kC7IsxVJcNWLBMxI8dlirfxo
	 wqMYUxzAq/92c5WaZn2TMMBEs0Av87AX9CiiX1jQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbgEUNb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 09:31:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:36958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728208AbgEUNbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 09:31:55 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EBBB206BE;
        Thu, 21 May 2020 13:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590067915;
        bh=lpxdayHtvYneN1YSTMROFmeSSiJxNNfvsF88kqWCtBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GtKd6MpiF6glcez2p9Eo6nTIjuyPP8qa/EMw/muxh1tSs5/Dt+H70148YolQC+BE8
         dVfGJHTs41MNmPJq5g8gqJIePW/L8tViUXU4WH8LMa0wEFPjxNg/6gnBTWl6RiK0IM
         LKfoNIJzesF95aBv6gjwY3rVcgaUW8ixVF1rCDqs=
Date:   Thu, 21 May 2020 14:31:50 +0100
From:   Will Deacon <will@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     paulmck@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, clang-built-linux@googlegroups.com,
        bp@alien8.de
Subject: Re: [PATCH -tip v2 09/11] data_race: Avoid nested statement
 expression
Message-ID: <20200521133150.GB6608@willie-the-truck>
References: <20200521110854.114437-1-elver@google.com>
 <20200521110854.114437-10-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521110854.114437-10-elver@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 01:08:52PM +0200, Marco Elver wrote:
> It appears that compilers have trouble with nested statements
> expressions, as such make the data_race() macro be only a single
> statement expression. This will help us avoid potential problems in
> future as its usage increases.
> 
> Link: https://lkml.kernel.org/r/20200520221712.GA21166@zn.tnic
> Signed-off-by: Marco Elver <elver@google.com>
> ---
> v2:
> * Add patch to series in response to above linked discussion.
> ---
>  include/linux/compiler.h | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 7444f026eead..1f9bd9f35368 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -211,12 +211,11 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>   */
>  #define data_race(expr)							\
>  ({									\
> +	__unqual_scalar_typeof(({ expr; })) __v;			\
>  	__kcsan_disable_current();					\
> -	({								\
> -		__unqual_scalar_typeof(({ expr; })) __v = ({ expr; });	\
> -		__kcsan_enable_current();				\
> -		__v;							\
> -	});								\
> +	__v = ({ expr; });						\
> +	__kcsan_enable_current();					\
> +	__v;								\

Hopefully it doesn't matter, but this will run into issues with 'const'
non-scalar expressions.

Will
