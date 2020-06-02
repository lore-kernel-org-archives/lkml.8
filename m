Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88381C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 20:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A5B8206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 20:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591130903;
	bh=CdMKjWZXehyY4K7bRGCQXjkB0K8fL+v9jQ3qjY5zkYs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Qm4kzCgU+4fyhQMn0o68SNZcT+zb4uoOwx0KvzNda20nn6VKGGjZr8AMEMbdu3nAa
	 VdsMJDv6OJ/zrHU2r+chMH58rxkRWNXS92nLRyhEiCSGF7WOk0Bxu4PzfOvfdB1QZ2
	 +neTh7DlAo8daVx1D7CWM9cr5PSB6y1slhIrl3TQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgFBUsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 16:48:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:55372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgFBUsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 16:48:22 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8794D20674;
        Tue,  2 Jun 2020 20:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591130901;
        bh=CdMKjWZXehyY4K7bRGCQXjkB0K8fL+v9jQ3qjY5zkYs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Ah7vSqvm+xeoRajRYcKV6V6ne3nEgYVQGxwEECvLL2CLbgIvuxrJMVi4ZECDn4ALP
         UIcmVx8l92wOM6Eg8vcSWlwlflzFMb1032LApF+moh80ZENTYczhcZimKF02yuDnjR
         Ia2Edig6Qs2LfQJ2+2ItFdPZ8CBz+cFUkPfejAx8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6968E3522C92; Tue,  2 Jun 2020 13:48:21 -0700 (PDT)
Date:   Tue, 2 Jun 2020 13:48:21 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] kcsan: Prefer '__no_kcsan inline' in test
Message-ID: <20200602204821.GI29598@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200602143633.104439-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602143633.104439-1-elver@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 04:36:33PM +0200, Marco Elver wrote:
> Instead of __no_kcsan_or_inline, prefer '__no_kcsan inline' in test --
> this is in case we decide to remove __no_kcsan_or_inline.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
> 
> Hi Paul,
> 
> This is to prepare eventual removal of __no_kcsan_or_inline, and avoid a
> series that doesn't apply to anything other than -next (because some
> bits are in -tip and the test only in -rcu; although this problem might
> be solved in 2 weeks). This patch is to make sure in case the
> __kcsan_or_inline series is based on -tip, integration in -next doesn't
> cause problems.
> 
> This came up in
> https://lkml.kernel.org/r/20200529185923.GO706495@hirez.programming.kicks-ass.net

Applied and pushed, thank you!

Please note that unless you would like this pushed into the current
merge window, it will not be visible in -next until v5.8-rc1 comes out.
Which sounds like you are aware of already, just want to be sure.  ;-)

							Thanx, Paul

> Thanks,
> -- Marco
> 
> ---
>  kernel/kcsan/kcsan-test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/kcsan/kcsan-test.c b/kernel/kcsan/kcsan-test.c
> index a8c11506dd2a..3af420ad6ee7 100644
> --- a/kernel/kcsan/kcsan-test.c
> +++ b/kernel/kcsan/kcsan-test.c
> @@ -43,7 +43,7 @@ static struct {
>  };
>  
>  /* Setup test checking loop. */
> -static __no_kcsan_or_inline void
> +static __no_kcsan inline void
>  begin_test_checks(void (*func1)(void), void (*func2)(void))
>  {
>  	kcsan_disable_current();
> @@ -60,7 +60,7 @@ begin_test_checks(void (*func1)(void), void (*func2)(void))
>  }
>  
>  /* End test checking loop. */
> -static __no_kcsan_or_inline bool
> +static __no_kcsan inline bool
>  end_test_checks(bool stop)
>  {
>  	if (!stop && time_before(jiffies, end_time)) {
> -- 
> 2.27.0.rc2.251.g90737beb825-goog
> 
