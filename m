Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947ABC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 11:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D5E206E6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 11:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Be7bt+IK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgCCLO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 06:14:57 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35265 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgCCLO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 06:14:56 -0500
Received: by mail-lf1-f68.google.com with SMTP id z9so2403907lfa.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 03:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Te4008Ygv+e8EkEPtUyyDzC/wCjlEHdJ0l3bocHmqjA=;
        b=Be7bt+IK2zL1T2KP/cT3VO2yjXTjN4qZ800HUUWTCahQrK+eJpKkufhazj0oheUpjx
         8n7pVLjtg6if6PVgo85MJs+rn9or//vEc1HcyJcV8Xg2SlCmB8+QuDhkjHgzy16mH5JT
         1B+EyvjJjEdr4U7bJFpuISU+1k14rmUU5/Uig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Te4008Ygv+e8EkEPtUyyDzC/wCjlEHdJ0l3bocHmqjA=;
        b=FTTHsPGKLyh9WhJukHQ0iq3tCFrFwn2YrdnhIbVPm7Y2EUsDFr+lCdzYnmWYxyrgpC
         r+AUXlGzlkfID9jgVwiHa1Vn/0cqMOYZMXwoBVT/slaEaxpHFWvyILrg6umMBgVYrmGN
         U/TmTHiU5q/I7q0XWZ6Ax0e4oMhprB9qOzH3Qy0ds25V+8J65EdmH0urYgoLunU2J894
         Su1A3odJw9JUuh6BoPTxhI8MDFohCbtZeARNxqGG4/NIxMxa9tdDC3svKUwBtT78bWKM
         /6ksP8A731Oc52/onYB828KLeShqxitX9WoR7EdNP31PRGahGk3Fpux6Bfh/c3lv3gCb
         /4NQ==
X-Gm-Message-State: ANhLgQ28myYdm4Kpt5JlbJGJe3lCCEHKo+cOPl8/OZ4Vuqyh43AK/tEr
        YLO5a3gnon//bWj1OWI/krjHHQ==
X-Google-Smtp-Source: ADFU+vuxuV8YM7v6YvJjbG2Pn0ROlTAakmGinS7M35+/eN6Zpxei1OaOU2gqgvW/qo5zjH/WpumddA==
X-Received: by 2002:ac2:568a:: with SMTP id 10mr2341306lfr.123.1583234093729;
        Tue, 03 Mar 2020 03:14:53 -0800 (PST)
Received: from [172.16.11.50] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id q8sm13913484lfn.90.2020.03.03.03.14.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 03:14:53 -0800 (PST)
Subject: Re: [PATCH 1/3] lib/test_printf: Clean up test of hashed pointers
To:     Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Tobin C . Harding" <me@tobin.cc>
References: <20200227130123.32442-1-pmladek@suse.com>
 <20200227130123.32442-2-pmladek@suse.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <2572b127-fd57-3de6-2a49-23886129d781@rasmusvillemoes.dk>
Date:   Tue, 3 Mar 2020 12:14:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200227130123.32442-2-pmladek@suse.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/2020 14.01, Petr Mladek wrote:
> The commit ad67b74d2469d9b82a ("printk: hash addresses printed with %p")
> helps to prevent leaking kernel addresses.
> 
> The testing of this functionality is a bit problematic because the output
> depends on a random key that is generated during boot. Though, it is
> still possible to check some aspects:
> 
>   + output string length
>   + hash differs from the original pointer value
>   + top half bits are zeroed on 64-bit systems
> 
> This is currently done by a maze of functions:
> 
>   + It is hard to follow.
>   + Some code is duplicated, e.g. the check for initialized crng.
>   + The zeroed top half bits are tested only with one hardcoded PTR.
>   + plain() increments "failed_tests" but not "total_tests".
>   + The generic test_hashed() does not touch number of tests at all.
> 
> Move all the checks into test_hashed() so that they are done for
> any given pointer that should get hashed. Also handle test counters
> and internal errors the same way as the existing test() function.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  lib/test_printf.c | 130 ++++++++++++++++++------------------------------------
>  1 file changed, 42 insertions(+), 88 deletions(-)
> 
> diff --git a/lib/test_printf.c b/lib/test_printf.c
> index 2d9f520d2f27..6fa6fb606554 100644
> --- a/lib/test_printf.c
> +++ b/lib/test_printf.c
> @@ -215,29 +215,6 @@ test_string(void)
>  #define PTR_VAL_NO_CRNG "(____ptrval____)"
>  #define ZEROS "00000000"	/* hex 32 zero bits */
>  
> -static int __init
> -plain_format(void)
> -{
> -	char buf[PLAIN_BUF_SIZE];
> -	int nchars;
> -
> -	nchars = snprintf(buf, PLAIN_BUF_SIZE, "%p", PTR);
> -
> -	if (nchars != PTR_WIDTH)
> -		return -1;
> -
> -	if (strncmp(buf, PTR_VAL_NO_CRNG, PTR_WIDTH) == 0) {
> -		pr_warn("crng possibly not yet initialized. plain 'p' buffer contains \"%s\"",
> -			PTR_VAL_NO_CRNG);
> -		return 0;
> -	}
> -
> -	if (strncmp(buf, ZEROS, strlen(ZEROS)) != 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
>  #else
>  
>  #define PTR_WIDTH 8
> @@ -246,88 +223,65 @@ plain_format(void)
>  #define PTR_VAL_NO_CRNG "(ptrval)"
>  #define ZEROS ""
>  
> -static int __init
> -plain_format(void)
> -{
> -	/* Format is implicitly tested for 32 bit machines by plain_hash() */
> -	return 0;
> -}
> -
>  #endif	/* BITS_PER_LONG == 64 */
>  
> -static int __init
> -plain_hash_to_buffer(const void *p, char *buf, size_t len)
> +static void __init
> +test_hashed(const char *fmt, const void *p)
>  {
> +	char real[PLAIN_BUF_SIZE];
> +	char hash[PLAIN_BUF_SIZE];
>  	int nchars;
>  
> -	nchars = snprintf(buf, len, "%p", p);
> -
> -	if (nchars != PTR_WIDTH)
> -		return -1;
> +	total_tests++;
>  
> -	if (strncmp(buf, PTR_VAL_NO_CRNG, PTR_WIDTH) == 0) {
> -		pr_warn("crng possibly not yet initialized. plain 'p' buffer contains \"%s\"",
> -			PTR_VAL_NO_CRNG);
> -		return 0;
> +	nchars = snprintf(real, sizeof(real), "%px", p);
> +	if (nchars != PTR_WIDTH) {
> +		pr_err("error in test suite: vsprintf(\"%%px\", p) returned number of characters %d, expected %d\n",
> +		       nchars, PTR_WIDTH);
> +		goto err;
>  	}
>  
> -	return 0;
> -}
> -
> -static int __init
> -plain_hash(void)
> -{
> -	char buf[PLAIN_BUF_SIZE];
> -	int ret;
> -
> -	ret = plain_hash_to_buffer(PTR, buf, PLAIN_BUF_SIZE);
> -	if (ret)
> -		return ret;
> -
> -	if (strncmp(buf, PTR_STR, PTR_WIDTH) == 0)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -/*
> - * We can't use test() to test %p because we don't know what output to expect
> - * after an address is hashed.
> - */
> -static void __init
> -plain(void)
> -{
> -	int err;
> +	nchars = snprintf(hash, sizeof(hash), fmt, p);

I don't like introducing a use of snprintf in the test suite where the
compiler cannot do the basic type checking. In fact, I think we should
turn on -Werror=format (or whatever the spelling is) for test_printf.c.

So I'd much rather introduce a

int check_hashed(const char *hashed, int ret, void *p)

helper and have the caller do the "%p", p formatting to a local buffer,
pass that buffer and the snprintf return value along with the formatted
pointer p to check_hashed, then do

  failed_tests += check_hashed(...)

in the caller. Then you can use a "return 1" in the places where you now
have a "goto err".

And I think you need a rather early check in check_hashed that there's a
nul byte in the buffer that is being checked (as well as in the buffer
containing the "%px" output) before you use those buffers as %s
arguments in the error messages. do_test() carefully postpones the
comparison to the expected content (and writing of the "expected ...,
got ...") until after we at least know %s won't end up reading beyond
the end of the buffer.

> +	if (nchars != PTR_WIDTH) {
> +		pr_warn("vsprintf(\"%s\", p) returned number of characters %d, expected %d\n",
> +			fmt, nchars, PTR_WIDTH);

No, you did not call vsprintf. You called snprintf() - and vsprintf
isn't even in the call chain of that. Given that there are functions in
vsprintf.c that munge the return value (the s_c_nprintf family), please
be more precise.

> +		goto err;
> +	}
>  
> -	err = plain_hash();
> -	if (err) {
> -		pr_warn("plain 'p' does not appear to be hashed\n");
> -		failed_tests++;
> +	if (strncmp(hash, PTR_VAL_NO_CRNG, PTR_WIDTH) == 0) {
> +		pr_warn_once("crng possibly not yet initialized. vsprinf(\"%s\", p) printed \"%s\"",
> +			     fmt, hash);
> +		total_tests--;
>  		return;
>  	}

Rather than decrementing total_tests, we should have a skipped_tests to
account for the rare case(s) where we had to skip a test for some
reason. Doing pr_warn_once for each such case is fine.

Also, typo (vsprinf), but use the right name anyway.

>  
> -	err = plain_format();
> -	if (err) {
> -		pr_warn("hashing plain 'p' has unexpected format\n");
> -		failed_tests++;
> +	/*
> +	 * There is a small chance of a false negative on 32-bit systems
> +	 * when the hash is the same as the pointer value.
> +	 */
> +	if (strncmp(hash, real, PTR_WIDTH) == 0) {
> +		pr_warn("vsprintf(\"%s\", p) returned %s, expected hashed pointer\n",
> +			fmt, hash);
> +		goto err;
> +	}
> +
> +#if BITS_PER_LONG == 64
> +	if (strncmp(hash, ZEROS, PTR_WIDTH / 2) != 0) {
> +		pr_warn("vsprintf(\"%s\", p) returned %s, expected %s in the top half bits\n",
> +			fmt, hash, ZEROS);
> +		goto err;
>  	}
> +#endif

OK, but should we also have a strspn(, "0123456789abcdef") check that
the formatted string consists of precisely PTR_WIDTH hex decimals?

Rasmus
