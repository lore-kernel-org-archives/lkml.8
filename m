Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FDCC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75E602074C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="loQUqh5A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbgCMXXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 19:23:36 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38487 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgCMXXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:23:36 -0400
Received: by mail-pl1-f193.google.com with SMTP id w3so5037447plz.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 16:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GKwNKNSaR4hvuCVxFKB7fh6wTciBS/jI2gaQ81bOrQY=;
        b=loQUqh5AkruK8wmiArpp5SyVDAXdURVGlb/UQBkOw8Cu55iPTM9WltLIlnKxQKubWT
         vawaH6q8RDehoTn1ImkPU5Icpk00M/Fzd7YT7vc2/BpgOvhTLDwv3cT7pLNIel9AW5T+
         EGljfjCDYHJQedYvWmqnzNO9TKp2x43PogoRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GKwNKNSaR4hvuCVxFKB7fh6wTciBS/jI2gaQ81bOrQY=;
        b=shjnaKbHITSsIDrW6mi4b08w0VOB+jMjHBOxmYLZv0GCq4WNIjAvsmQY+agv5SoNx7
         hicWQbil+bUWWg2FFcRz1SzZcAsMVyIqReiIwJh6lboSYOGGMNY2nKM79nDFQFTs2j+y
         btqZEMNvwnDhKW3mXhmTZ1WfXKuMRqvU26gWZqcQgh839yp14miwTJyAZZf+to/BDntH
         iw3yUvs7l05W33VoTwER4g9r5aIacREJf6yQn0K854evlUEpNKZo/d/eAKMvoc/HPfGP
         834DNNdeKzPxyowt48k4JnUqXc4IvHd6Wrm9fQ8LWrOr6VNfHS4H+uAxZkkM5N7EQKW1
         wJjA==
X-Gm-Message-State: ANhLgQ2HABIiStAMuGiX8KZdwva469tdIh0/LakEyR56F346xs4wywgf
        FYDTM5HqClRkjCyg/gWXAAHCFg==
X-Google-Smtp-Source: ADFU+vs3t7r4j9rAlz3llCK/UznTSQMLNctwd5wIUO4qjLU1zpyU8eGzcHROLsHdNclrqEix6JDJcg==
X-Received: by 2002:a17:90a:d101:: with SMTP id l1mr12607028pju.130.1584141813722;
        Fri, 13 Mar 2020 16:23:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w11sm58858042pfn.4.2020.03.13.16.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 16:23:32 -0700 (PDT)
Date:   Fri, 13 Mar 2020 16:23:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     shuah@kernel.org, luto@amacapital.net, wad@chromium.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/5] kselftest: create fixture objects
Message-ID: <202003131623.947F308F2@keescook>
References: <20200313031752.2332565-1-kuba@kernel.org>
 <20200313031752.2332565-3-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313031752.2332565-3-kuba@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 08:17:49PM -0700, Jakub Kicinski wrote:
> Grouping tests by fixture will allow us to parametrize
> test runs. Create full objects for fixtures.
> 
> Add a "global" fixture for tests without a fixture.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

I like this!

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  tools/testing/selftests/kselftest_harness.h | 57 +++++++++++++++++----
>  1 file changed, 46 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index 5336b26506ab..a396afe4a579 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -169,8 +169,10 @@
>  #define __TEST_IMPL(test_name, _signal) \
>  	static void test_name(struct __test_metadata *_metadata); \
>  	static struct __test_metadata _##test_name##_object = \
> -		{ .name = "global." #test_name, \
> -		  .fn = &test_name, .termsig = _signal, \
> +		{ .name = #test_name, \
> +		  .fn = &test_name, \
> +		  .fixture = &_fixture_global, \
> +		  .termsig = _signal, \
>  		  .timeout = TEST_TIMEOUT_DEFAULT, }; \
>  	static void __attribute__((constructor)) _register_##test_name(void) \
>  	{ \
> @@ -212,10 +214,12 @@
>   * populated and cleaned up using FIXTURE_SETUP() and FIXTURE_TEARDOWN().
>   */
>  #define FIXTURE(fixture_name) \
> +	static struct __fixture_metadata _##fixture_name##_fixture_object = \
> +		{ .name =  #fixture_name, }; \
>  	static void __attribute__((constructor)) \
>  	_register_##fixture_name##_data(void) \
>  	{ \
> -		__fixture_count++; \
> +		__register_fixture(&_##fixture_name##_fixture_object); \
>  	} \
>  	FIXTURE_DATA(fixture_name)
>  
> @@ -309,8 +313,9 @@
>  	} \
>  	static struct __test_metadata \
>  		      _##fixture_name##_##test_name##_object = { \
> -		.name = #fixture_name "." #test_name, \
> +		.name = #test_name, \
>  		.fn = &wrapper_##fixture_name##_##test_name, \
> +		.fixture = &_##fixture_name##_fixture_object, \
>  		.termsig = signal, \
>  		.timeout = tmout, \
>  	 }; \
> @@ -631,10 +636,44 @@
>  	} \
>  } while (0); OPTIONAL_HANDLER(_assert)
>  
> +/* Contains all the information about a fixture */
> +struct __fixture_metadata {
> +	const char *name;
> +	struct __fixture_metadata *prev, *next;
> +} _fixture_global __attribute__((unused)) = {
> +	.name = "global",
> +	.prev = &_fixture_global,
> +};
> +
> +static struct __fixture_metadata *__fixture_list = &_fixture_global;
> +static unsigned int __fixture_count;
> +static int __constructor_order;
> +
> +#define _CONSTRUCTOR_ORDER_FORWARD   1
> +#define _CONSTRUCTOR_ORDER_BACKWARD -1
> +
> +static inline void __register_fixture(struct __fixture_metadata *f)
> +{
> +	__fixture_count++;
> +	/* Circular linked list where only prev is circular. */
> +	if (__constructor_order == _CONSTRUCTOR_ORDER_FORWARD) {
> +		f->next = NULL;
> +		f->prev = __fixture_list->prev;
> +		f->prev->next = f;
> +		__fixture_list->prev = f;
> +	} else {
> +		f->next = __fixture_list;
> +		f->next->prev = f;
> +		f->prev = f;
> +		__fixture_list = f;
> +	}
> +}
> +
>  /* Contains all the information for test execution and status checking. */
>  struct __test_metadata {
>  	const char *name;
>  	void (*fn)(struct __test_metadata *);
> +	struct __fixture_metadata *fixture;
>  	int termsig;
>  	int passed;
>  	int trigger; /* extra handler after the evaluation */
> @@ -647,11 +686,6 @@ struct __test_metadata {
>  /* Storage for the (global) tests to be run. */
>  static struct __test_metadata *__test_list;
>  static unsigned int __test_count;
> -static unsigned int __fixture_count;
> -static int __constructor_order;
> -
> -#define _CONSTRUCTOR_ORDER_FORWARD   1
> -#define _CONSTRUCTOR_ORDER_BACKWARD -1
>  
>  /*
>   * Since constructors are called in reverse order, reverse the test
> @@ -702,7 +736,7 @@ void __run_test(struct __test_metadata *t)
>  
>  	t->passed = 1;
>  	t->trigger = 0;
> -	printf("[ RUN      ] %s\n", t->name);
> +	printf("[ RUN      ] %s.%s\n", t->fixture->name, t->name);
>  	alarm(t->timeout);
>  	child_pid = fork();
>  	if (child_pid < 0) {
> @@ -751,7 +785,8 @@ void __run_test(struct __test_metadata *t)
>  				status);
>  		}
>  	}
> -	printf("[     %4s ] %s\n", (t->passed ? "OK" : "FAIL"), t->name);
> +	printf("[     %4s ] %s.%s\n", (t->passed ? "OK" : "FAIL"),
> +	       t->fixture->name, t->name);
>  	alarm(0);
>  }
>  
> -- 
> 2.24.1
> 

-- 
Kees Cook
