Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF791C2BB85
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BDDA208E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jDEpO4Og"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411603AbgDOR6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2411585AbgDOR6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:58:37 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BBEC061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 10:58:35 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b11so990825wrs.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 10:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eFD9x/dSIEUfzCFoJjNZCqEIi04lcE4fTMcXRLYjFdQ=;
        b=jDEpO4Og/WRkRTpK1nmwq1px2vFNMlBEtptiPkL96YTLJ050YqOkFOPf9usax5ANAh
         xV6KeqcFaQNlqslIEYoTxVae8J0WndPH2ei++qxgBOp4kQ8ToTUfu0uJl4CnPUkWYr6V
         zAKaiuJjM/9pHxrWdtsaRMYUTQJp+VrXTedMgIjG6Vc8OEZH9LOm3UAitO9HK6d1BaKb
         gmtVZ6oyd2SH10s3IPcBygZDd21frfRvOL0g0CS4Y1tuoGQsWRB8Vm6OfM1vk1pSpPni
         VQbWex0Hj/oiGB1J+/LLGJaGmIWYBL+n1zRL1DcwbjIgfARa52/tnDZSkMmu6nhYX8vr
         RtuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eFD9x/dSIEUfzCFoJjNZCqEIi04lcE4fTMcXRLYjFdQ=;
        b=M7d8eemzOWDWks7ftMnXy80WICLvAj2nLLHnfLlwEh/ZJWbeY5TIVEdbUAItPN38H/
         VlIEm/Ev7xJmzwGKjh0W9iGgeJRMXl1XGv6CyCQ7XJh6qXznpM2F6tu8ruz0Uk8VUx+o
         3XNIVaMBlhWrbzSyd/Uolw5NZ3q1NbC7XGJvU7KJh6Ep5p+SnA+Ji13NcZmtqvzUfE6i
         EbB1owN7CGehcvMVyEEIPFRjGVCHKU61ONkSaBT4M4mLkFwkxKyKQWqwqQXuDE4DOXST
         96nEi7Acvd9wDaVnDf+TqbdcagrIPb5Xyxv8+/WRYyuBoMxejA2e5pHPOBDUQ7LTFCS/
         uqGg==
X-Gm-Message-State: AGi0PuYo44cIoTKrdVOJ6vekv0+bW/fcwanedzyt8gNl9diqeTUyhhxc
        Fg+1ox2a6HxVutiM2XQYtHCZHg==
X-Google-Smtp-Source: APiQypJRVMbsZUt1VUZjyJjcdO/01wBJZiCKW205scfSnwvwm9kAMmQF1elImRzaPco/pydl8EAUQw==
X-Received: by 2002:adf:fa03:: with SMTP id m3mr18227322wrr.68.1586973514021;
        Wed, 15 Apr 2020 10:58:34 -0700 (PDT)
Received: from google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id v16sm354492wml.30.2020.04.15.10.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 10:58:32 -0700 (PDT)
Date:   Wed, 15 Apr 2020 19:58:25 +0200
From:   Marco Elver <elver@google.com>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     brendanhiggins@google.com, frowand.list@gmail.com,
        gregkh@linuxfoundation.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 kunit-next 1/4] kunit: add debugfs
 /sys/kernel/debug/kunit/<suite>/results display
Message-ID: <20200415175825.GA79987@google.com>
References: <1585232710-322-1-git-send-email-alan.maguire@oracle.com>
 <1585232710-322-2-git-send-email-alan.maguire@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585232710-322-2-git-send-email-alan.maguire@oracle.com>
User-Agent: Mutt/1.13.2 (2019-12-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, 26 Mar 2020, Alan Maguire wrote:

> add debugfs support for displaying kunit test suite results; this is
> especially useful for module-loaded tests to allow disentangling of
> test result display from other dmesg events.  debugfs support is
> provided if CONFIG_KUNIT_DEBUGFS=y.
> 
> As well as printk()ing messages, we append them to a per-test log.
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Frank Rowand <frank.rowand@sony.com>
> ---
>  include/kunit/test.h   |  54 +++++++++++++++---
>  lib/kunit/Kconfig      |   8 +++
>  lib/kunit/Makefile     |   4 ++
>  lib/kunit/debugfs.c    | 116 ++++++++++++++++++++++++++++++++++++++
>  lib/kunit/debugfs.h    |  30 ++++++++++
>  lib/kunit/kunit-test.c |   4 +-
>  lib/kunit/test.c       | 147 ++++++++++++++++++++++++++++++++++++++-----------
>  7 files changed, 322 insertions(+), 41 deletions(-)
>  create mode 100644 lib/kunit/debugfs.c
>  create mode 100644 lib/kunit/debugfs.h
> 
[...]
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 9242f93..a3fa21f 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
[...]
> -static void kunit_print_ok_not_ok(bool should_indent,
> +static void kunit_print_ok_not_ok(void *test_or_suite,
> +				  bool is_test,
>  				  bool is_ok,
>  				  size_t test_number,
>  				  const char *description)
>  {
> -	const char *indent, *ok_not_ok;
> -
> -	if (should_indent)
> -		indent = "\t";
> -	else
> -		indent = "";
> +	struct kunit_suite *suite = is_test ? NULL : test_or_suite;
> +	struct kunit *test = is_test ? test_or_suite : NULL;
>  
> -	if (is_ok)
> -		ok_not_ok = "ok";
> +	/*
> +	 * We do not log the test suite results as doing so would
> +	 * mean debugfs display would consist of the test suite
> +	 * description and status prior to individual test results.
> +	 * Hence directly printk the suite status, and we will
> +	 * separately seq_printf() the suite status for the debugfs
> +	 * representation.
> +	 */
> +	if (suite)
> +		pr_info("%s %zd - %s",

I think this is missing '\n' -- is this intentional?

With v5.7-rc1, when I run a test via module, the final "ok" is only
printed once another message is printed to the kernel log (which can
take a while).

Thanks,
-- Marco

> +			kunit_status_to_string(is_ok),
> +			test_number, description);
>  	else
> -		ok_not_ok = "not ok";
> -
> -	pr_info("%s%s %zd - %s\n", indent, ok_not_ok, test_number, description);
> +		kunit_log(KERN_INFO, test, "\t%s %zd - %s",
> +			  kunit_status_to_string(is_ok),
> +			  test_number, description);
>  }
[...]
