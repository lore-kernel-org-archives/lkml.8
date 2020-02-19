Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B808C34050
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 11:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E38020658
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 11:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="WydRZKXY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgBSLxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 06:53:30 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40506 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgBSLx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 06:53:29 -0500
Received: by mail-lj1-f195.google.com with SMTP id n18so44582ljo.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 03:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=71fpEu9gj4xQyGwVvrbfmB+uFD/Qs603qpfWf+rF/cI=;
        b=WydRZKXY9aoo5/x9r7meASA5yIZERSvCqFjexbUYomQCBLBEMl8ai9Rdp78ufDUjEO
         jDpzgAurjWlj6uqcwYa/MbVhrLIe44j2GlJRQvJCVc293/5erLflQh+iQfVWV7gir5F4
         RHZkO/3p6owHHQCYafZVPzY+y0IoY0Bh7pYY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=71fpEu9gj4xQyGwVvrbfmB+uFD/Qs603qpfWf+rF/cI=;
        b=GLVz1xffP802RZTHYWfa7AvGTCceN0lqTeAca7UlVtPVia/31N45mG3jewK547MKEF
         pv2aKXlVbIXiW3JMN2NpIZsGu1PGdx3P61i1mrp1U7E5Gfa38SjWLF9lfFzASVAqHk5Y
         o3kbcF0uzT2N6UkB+vnBkkOdhe3X4zUs/ytmJWBk8poO/6V/9Kz41WZc+/EYHs1pY221
         PqPDBWKj+1GurmrJMt/cTU1mmuCpuh3loJkNqK+CUIo21ZztMkv2abHxfJ84LxrrhG+h
         W+LFFyNWIw9tpqhFxiWjAkdO/NjVTz0Y4f1rMF8lRJ2AzBBewthfqqKnLEiYIWyXXqSV
         L6PA==
X-Gm-Message-State: APjAAAUmBfDAmwEsjY+qY184qgnM5V1GoTqgwz0DTwCaeltxdwJFahZj
        Ecs6zBM9MFm0cf60AUjqzOeETNjDNWJHHF2P
X-Google-Smtp-Source: APXvYqwriRVyrAscp4UctZ1kCxokgDNdH+bpOZqirl4aV2eKSeSZNiDE+6GiSUXaE4BVrSQYu3s1Dg==
X-Received: by 2002:a2e:556:: with SMTP id 83mr15644254ljf.127.1582113204971;
        Wed, 19 Feb 2020 03:53:24 -0800 (PST)
Received: from [172.16.11.50] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id o69sm1150496lff.14.2020.02.19.03.53.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 03:53:24 -0800 (PST)
Subject: Re: [PATCH] vsprintf: sanely handle NULL passed to %pe
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
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
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <0fef2a1f-9391-43a9-32d5-2788ae96c529@rasmusvillemoes.dk>
Date:   Wed, 19 Feb 2020 12:53:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAOi1vP-4=QCSZ2A89g1po2p=6n_g09SXUCa0_r2SBJm2greRmw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/02/2020 12.20, Ilya Dryomov wrote:
> On Wed, Feb 19, 2020 at 9:21 AM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
>> Extend %pe to pretty-print NULL in addition to ERR_PTRs,
>> i.e. everything IS_ERR_OR_NULL().
>>
>> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> ---
>> Something like this? The actual code change is +2,-1 with another +1
>> for a test case.
>>
>>  Documentation/core-api/printk-formats.rst | 9 +++++----
>>  lib/errname.c                             | 4 ++++
>>  lib/test_printf.c                         | 1 +
>>  lib/vsprintf.c                            | 4 ++--
>>  4 files changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
>> index 8ebe46b1af39..964b55291445 100644
>> --- a/Documentation/core-api/printk-formats.rst
>> +++ b/Documentation/core-api/printk-formats.rst
>> @@ -86,10 +86,11 @@ Error Pointers
>>
>>         %pe     -ENOSPC
>>
>> -For printing error pointers (i.e. a pointer for which IS_ERR() is true)
>> -as a symbolic error name. Error values for which no symbolic name is
>> -known are printed in decimal, while a non-ERR_PTR passed as the
>> -argument to %pe gets treated as ordinary %p.
>> +For printing error pointers (i.e. a pointer for which IS_ERR() is
>> +true) as a symbolic error name. Error values for which no symbolic
>> +name is known are printed in decimal. A NULL pointer is printed as
>> +NULL. All other pointer values (i.e. anything !IS_ERR_OR_NULL()) get
>> +treated as ordinary %p.
>>
>>  Symbols/Function Pointers
>>  -------------------------
>> diff --git a/lib/errname.c b/lib/errname.c
>> index 0c4d3e66170e..7757bc00f564 100644
>> --- a/lib/errname.c
>> +++ b/lib/errname.c
>> @@ -11,9 +11,13 @@
>>   * allocated errnos (with EHWPOISON = 257 on parisc, and EDQUOT = 1133
>>   * on mips), so this wastes a bit of space on those - though we
>>   * special case the EDQUOT case.
>> + *
>> + * For the benefit of %pe being able to print any ERR_OR_NULL pointer
>> + * symbolically, 0 is also treated specially.
>>   */
>>  #define E(err) [err + BUILD_BUG_ON_ZERO(err <= 0 || err > 300)] = "-" #err
>>  static const char *names_0[] = {
>> +       [0] = "NULL",
>>         E(E2BIG),
>>         E(EACCES),
>>         E(EADDRINUSE),
>> diff --git a/lib/test_printf.c b/lib/test_printf.c
>> index 2d9f520d2f27..3a37d0e9e735 100644
>> --- a/lib/test_printf.c
>> +++ b/lib/test_printf.c
>> @@ -641,6 +641,7 @@ errptr(void)
>>         test("[-EIO    ]", "[%-8pe]", ERR_PTR(-EIO));
>>         test("[    -EIO]", "[%8pe]", ERR_PTR(-EIO));
>>         test("-EPROBE_DEFER", "%pe", ERR_PTR(-EPROBE_DEFER));
>> +       test("[NULL]", "[%pe]", NULL);
>>  #endif
>>  }
>>
>> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
>> index 7c488a1ce318..b7118d78eb20 100644
>> --- a/lib/vsprintf.c
>> +++ b/lib/vsprintf.c
>> @@ -2247,8 +2247,8 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
>>         case 'x':
>>                 return pointer_string(buf, end, ptr, spec);
>>         case 'e':
>> -               /* %pe with a non-ERR_PTR gets treated as plain %p */
>> -               if (!IS_ERR(ptr))
>> +               /* %pe with a non-ERR_OR_NULL ptr gets treated as plain %p */
>> +               if (!IS_ERR_OR_NULL(ptr))
>>                         break;
> 
> FWIW I was about to post a patch that just special cases NULL here.
> 
> I think changing errname() to return "NULL" for 0 is overkill.
> People will sooner or later discover that function and start using it
> in contexts that don't have anything to do with pointers.  Returning
> _some_ string for 0 (instead of NULL) makes it very close to standard
> strerror(), and "NULL" for 0 (i.e. success) seems rather odd.

I see what you mean, but I don't share your assumption that errname()
will ever grow callers other than the one in vsprintf.c. But I don't
have any strong opinion either way. Perhaps this on top of my patch

--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -619,7 +619,7 @@ static char *err_ptr(char *buf, char *end, void *ptr,
                     struct printf_spec spec)
 {
        int err = PTR_ERR(ptr);
-       const char *sym = errname(err);
+       const char *sym = err ? errname(err) : "NULL";

        if (sym)
                return string_nocheck(buf, end, sym, spec);

instead of the change(s) in errname.c? And then the test case for
'"%pe", NULL' should also be moved outside CONFIG_SYMBOLIC_ERRNAME.

BTW., your original patch for %p lacks corresponding update of
test_vsprintf.c. Please add appropriate test cases.

Rasmus
