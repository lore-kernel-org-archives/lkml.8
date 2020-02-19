Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4D8C34051
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 13:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3D202176D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 13:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="VcOCZBDP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbgBSN4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 08:56:36 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41168 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbgBSN4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 08:56:36 -0500
Received: by mail-lf1-f66.google.com with SMTP id m30so166635lfp.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 05:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XnAwKHZGH6RqM4EvinDza/Bsch2kZO1WSztyXXbxTOQ=;
        b=VcOCZBDP1HYLwyXM84PTmd9Mw6sYWECce4X3TK8uBpKi/1SXj31iNKf4hnl6zgkDWm
         nvPNWPSKEvn2r7UUs7oJsg1yYO6P5JX5GDl0Jh5rBVM/7GKPMEUPjJl6NKsQVmiJrFyr
         EAIiZv7+PyVY9M4foNlbwa3VRmDxR3BmsJQ4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XnAwKHZGH6RqM4EvinDza/Bsch2kZO1WSztyXXbxTOQ=;
        b=JZ3Thwyfj2LkyJin3BaJJWfkQI5qLawnmQqJVcFZiJBTaxsHYQGwXrMmtDXfJbPNSH
         r/S4VSHjn5l91ZuzzHCG6cP/f5veG+HUa5VNfcpEVSHw4oPfYBu56rplLj70dHd7/Y3x
         He4B+hh6gossyrYeu0pGW/yMR/F04+/uUQ05y3nXzJx98fEtA4NL26OpNjLscf8lUGee
         k4MVcMi34KUHm6dtXlUNhhsipcTzY2w0D07fKT+rq310WTVqkb7nSI1tfNIaBf+9iOjl
         apHSV2azWvkPYziWki7rrzJ8CaxCxR1/kvQRGTxb7gMbMr+InsL026L6fWIwBnSfyIjT
         X8Hg==
X-Gm-Message-State: APjAAAVBONpM9hmOCDlFT7GWsTemlkEv4/dffENsEqKtY2mgp0A0fwfD
        ONjsPcdUvsciC0dYWCGi68hNfatfubuslRrY
X-Google-Smtp-Source: APXvYqwePK7hhyPef9srUC/L835T/sNCtC8ExNaX3LTyT8SytphIUTxDpd3XHisHwf7HhonpWE9lXg==
X-Received: by 2002:ac2:4add:: with SMTP id m29mr13587833lfp.190.1582120594313;
        Wed, 19 Feb 2020 05:56:34 -0800 (PST)
Received: from [172.16.11.50] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id k4sm1312814lfo.48.2020.02.19.05.56.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 05:56:33 -0800 (PST)
Subject: Re: [PATCH] vsprintf: sanely handle NULL passed to %pe
To:     Petr Mladek <pmladek@suse.com>
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        "Tobin C . Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <CAHk-=wjEd-gZ1g52kgi_g8gq-QCF2E01TkQd5Hmj4W5aThLw3A@mail.gmail.com>
 <20200219082155.6787-1-linux@rasmusvillemoes.dk>
 <CAOi1vP-4=QCSZ2A89g1po2p=6n_g09SXUCa0_r2SBJm2greRmw@mail.gmail.com>
 <0fef2a1f-9391-43a9-32d5-2788ae96c529@rasmusvillemoes.dk>
 <20200219134826.qqdhy2z67ubsnr2m@pathway.suse.cz>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <5459eb50-48e2-2fd9-3560-0bc921e3678c@rasmusvillemoes.dk>
Date:   Wed, 19 Feb 2020 14:56:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200219134826.qqdhy2z67ubsnr2m@pathway.suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/02/2020 14.48, Petr Mladek wrote:
> On Wed 2020-02-19 12:53:22, Rasmus Villemoes wrote:
>> --- a/lib/vsprintf.c
>> +++ b/lib/vsprintf.c
>> @@ -619,7 +619,7 @@ static char *err_ptr(char *buf, char *end, void *ptr,
>>                      struct printf_spec spec)
>>  {
>>         int err = PTR_ERR(ptr);
>> -       const char *sym = errname(err);
>> +       const char *sym = err ? errname(err) : "NULL";
> 
> I like this more than adding "NULL" errname.

OK.

>>         if (sym)
>>                 return string_nocheck(buf, end, sym, spec);
>>
>> instead of the change(s) in errname.c? And then the test case for
>> '"%pe", NULL' should also be moved outside CONFIG_SYMBOLIC_ERRNAME.
> 
> The test should go into null_pointer() instead of errptr().

Eh, no, the behaviour of %pe is tested by errptr(). I'll keep it that
way. But I should add a #else section that tests how %pe behaves without
CONFIG_SYMBOLIC_ERRNAME - though that's orthogonal to this patch.

> Could you send updated patch, please? ;-)

I'll wait a day or two for more comments. It doesn't seem very urgent.

>> BTW., your original patch for %p lacks corresponding update of
>> test_vsprintf.c. Please add appropriate test cases.
> 
> Good point. The existing test_hashed() is rather weak
> and it did not catch this change.
> 
> It would be nice to make test_hash() more powerful.
> Anyway, the minimal udpate would be:
> 
> diff --git a/lib/test_printf.c b/lib/test_printf.c
> index 2d9f520d2f27..1726a678bccd 100644
> --- a/lib/test_printf.c
> +++ b/lib/test_printf.c
> @@ -333,7 +333,7 @@ test_hashed(const char *fmt, const void *p)
>  static void __init
>  null_pointer(void)
>  {
> -	test_hashed("%p", NULL);
> +	test(ZEROS "00000000", "%p", NULL);

No, it most certainly also needs to check a few "%p", ERR_PTR(-4) cases
(where one of course has to use explicit integers and not E* constants).

Rasmus
