Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AA4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 23:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77B2920723
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 23:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594079113;
	bh=5Y1zS7sOzTCIQkIflLi1Pc2LBhHJ510ftzMkErnN0qo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=wlq4EUTM+9fdhkDrda6QwgZ7plBCNo+pzsmcOkOC4tDWZcYAgxGFEiY/YBqhBpyBo
	 nY/4SCoRGCKBuj0M/9Y410NAqfaYEYymm/rn+Ahh+Mn7NLylJEx0+MqCFY29AhUebu
	 4G7QihYftDxh5bcAbjSioAjT4Vd+JeWJvjBYqFoo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgGFXpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 19:45:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:38446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbgGFXpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 19:45:12 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DC34206E9;
        Mon,  6 Jul 2020 23:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594079111;
        bh=5Y1zS7sOzTCIQkIflLi1Pc2LBhHJ510ftzMkErnN0qo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=MSK20KXaatpfMbWRYcv/Av068aBBezFshyGbQ5e1Tfpm29rAAHtYOWvoESiv4zc7H
         Dfbbkc7YUXKmapIPDD9TDjq1UCRZJ3CuHXfoQ5P8BApvWGMWueyfO/duli63tdFTsk
         NR0xvbcMQRqPrHH0wTXU3xX592gvq1eiyVjjm8Zc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 054F93522637; Mon,  6 Jul 2020 16:45:11 -0700 (PDT)
Date:   Mon, 6 Jul 2020 16:45:11 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     dvyukov@google.com, glider@google.com, andreyknvl@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] kcsan: Add atomic builtin test case
Message-ID: <20200706234510.GA20540@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200703134031.3298135-1-elver@google.com>
 <20200703134031.3298135-3-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703134031.3298135-3-elver@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 03:40:31PM +0200, Marco Elver wrote:
> Adds test case to kcsan-test module, to test atomic builtin
> instrumentation works.
> 
> Signed-off-by: Marco Elver <elver@google.com>

Applied all three, thank you!!!

							Thanx, Paul

> ---
>  kernel/kcsan/kcsan-test.c | 63 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
> 
> diff --git a/kernel/kcsan/kcsan-test.c b/kernel/kcsan/kcsan-test.c
> index fed6fcb5768c..721180cbbab1 100644
> --- a/kernel/kcsan/kcsan-test.c
> +++ b/kernel/kcsan/kcsan-test.c
> @@ -390,6 +390,15 @@ static noinline void test_kernel_seqlock_writer(void)
>  	write_sequnlock_irqrestore(&test_seqlock, flags);
>  }
>  
> +static noinline void test_kernel_atomic_builtins(void)
> +{
> +	/*
> +	 * Generate concurrent accesses, expecting no reports, ensuring KCSAN
> +	 * treats builtin atomics as actually atomic.
> +	 */
> +	__atomic_load_n(&test_var, __ATOMIC_RELAXED);
> +}
> +
>  /* ===== Test cases ===== */
>  
>  /* Simple test with normal data race. */
> @@ -852,6 +861,59 @@ static void test_seqlock_noreport(struct kunit *test)
>  	KUNIT_EXPECT_FALSE(test, match_never);
>  }
>  
> +/*
> + * Test atomic builtins work and required instrumentation functions exist. We
> + * also test that KCSAN understands they're atomic by racing with them via
> + * test_kernel_atomic_builtins(), and expect no reports.
> + *
> + * The atomic builtins _SHOULD NOT_ be used in normal kernel code!
> + */
> +static void test_atomic_builtins(struct kunit *test)
> +{
> +	bool match_never = false;
> +
> +	begin_test_checks(test_kernel_atomic_builtins, test_kernel_atomic_builtins);
> +	do {
> +		long tmp;
> +
> +		kcsan_enable_current();
> +
> +		__atomic_store_n(&test_var, 42L, __ATOMIC_RELAXED);
> +		KUNIT_EXPECT_EQ(test, 42L, __atomic_load_n(&test_var, __ATOMIC_RELAXED));
> +
> +		KUNIT_EXPECT_EQ(test, 42L, __atomic_exchange_n(&test_var, 20, __ATOMIC_RELAXED));
> +		KUNIT_EXPECT_EQ(test, 20L, test_var);
> +
> +		tmp = 20L;
> +		KUNIT_EXPECT_TRUE(test, __atomic_compare_exchange_n(&test_var, &tmp, 30L,
> +								    0, __ATOMIC_RELAXED,
> +								    __ATOMIC_RELAXED));
> +		KUNIT_EXPECT_EQ(test, tmp, 20L);
> +		KUNIT_EXPECT_EQ(test, test_var, 30L);
> +		KUNIT_EXPECT_FALSE(test, __atomic_compare_exchange_n(&test_var, &tmp, 40L,
> +								     1, __ATOMIC_RELAXED,
> +								     __ATOMIC_RELAXED));
> +		KUNIT_EXPECT_EQ(test, tmp, 30L);
> +		KUNIT_EXPECT_EQ(test, test_var, 30L);
> +
> +		KUNIT_EXPECT_EQ(test, 30L, __atomic_fetch_add(&test_var, 1, __ATOMIC_RELAXED));
> +		KUNIT_EXPECT_EQ(test, 31L, __atomic_fetch_sub(&test_var, 1, __ATOMIC_RELAXED));
> +		KUNIT_EXPECT_EQ(test, 30L, __atomic_fetch_and(&test_var, 0xf, __ATOMIC_RELAXED));
> +		KUNIT_EXPECT_EQ(test, 14L, __atomic_fetch_xor(&test_var, 0xf, __ATOMIC_RELAXED));
> +		KUNIT_EXPECT_EQ(test, 1L, __atomic_fetch_or(&test_var, 0xf0, __ATOMIC_RELAXED));
> +		KUNIT_EXPECT_EQ(test, 241L, __atomic_fetch_nand(&test_var, 0xf, __ATOMIC_RELAXED));
> +		KUNIT_EXPECT_EQ(test, -2L, test_var);
> +
> +		__atomic_thread_fence(__ATOMIC_SEQ_CST);
> +		__atomic_signal_fence(__ATOMIC_SEQ_CST);
> +
> +		kcsan_disable_current();
> +
> +		match_never = report_available();
> +	} while (!end_test_checks(match_never));
> +	KUNIT_EXPECT_FALSE(test, match_never);
> +}
> +
>  /*
>   * Each test case is run with different numbers of threads. Until KUnit supports
>   * passing arguments for each test case, we encode #threads in the test case
> @@ -891,6 +953,7 @@ static struct kunit_case kcsan_test_cases[] = {
>  	KCSAN_KUNIT_CASE(test_assert_exclusive_access_scoped),
>  	KCSAN_KUNIT_CASE(test_jiffies_noreport),
>  	KCSAN_KUNIT_CASE(test_seqlock_noreport),
> +	KCSAN_KUNIT_CASE(test_atomic_builtins),
>  	{},
>  };
>  
> -- 
> 2.27.0.212.ge8ba1cc988-goog
> 
