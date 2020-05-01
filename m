Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B64EC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 11:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 803C62076D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 11:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgEALlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 07:41:49 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:34891 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728575AbgEALls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 07:41:48 -0400
Received: from mail-qk1-f175.google.com ([209.85.222.175]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MRTIx-1jpkSM1PjJ-00NVYP for <linux-kernel@vger.kernel.org>; Fri, 01 May
 2020 13:41:47 +0200
Received: by mail-qk1-f175.google.com with SMTP id s9so6220675qkm.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 04:41:47 -0700 (PDT)
X-Gm-Message-State: AGi0PubGFxvwmXv5KsF0hz2GNAFmeHXuYnShGUV1y4L0exff1DuW4qgy
        rYmvI4EMCDU/TBhPeVVr5Lr3RJMKPLKqPykHPFQ=
X-Google-Smtp-Source: APiQypLK/dE9moXgV24esZc0948r5LgLv8YUW89yF3hyBwSbsXxkQYCx0P8f3M5fP642Ias6u41P6Qy4yMIpptz4ad4=
X-Received: by 2002:a37:b543:: with SMTP id e64mr1311261qkf.394.1588333306215;
 Fri, 01 May 2020 04:41:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2qLJkokMGt48JRky=WUeAbJRuNmoD1oqfWdrGSC6y1LA@mail.gmail.com>
 <CAK8P3a2Gzj9SVZSGo+PxWR0cMJb1sFwv+ii9J6jEGE-Z41Fr+A@mail.gmail.com> <20200501002858.4wuiqqv5o32jcvxf@treble>
In-Reply-To: <20200501002858.4wuiqqv5o32jcvxf@treble>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 1 May 2020 13:41:30 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3_aC9rJDXta+6D2Oq5RSJgfXaT5-wFU_tM-6x7unbuPg@mail.gmail.com>
Message-ID: <CAK8P3a3_aC9rJDXta+6D2Oq5RSJgfXaT5-wFU_tM-6x7unbuPg@mail.gmail.com>
Subject: Re: Remaining randconfig objtool warnings, linux-next-20200428
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:nIXbnFdy6pxDJjmIZ9+0AMOkUpINZRtqDzk76riV4axWidMWdTg
 sXpKohSqD11see+SSemt7Ud9+bP5d6UvqhsJQDzYHgT0k7nEmvrrfTcZ3mPB3e4AHhJ8fbN
 9I6cN7lOhsch9XFz8Md1kKwqKCRe/5zsDN/8F+dui6Eq1W8aWYV4nkATsvE6Hr5Q4fWYaAV
 672CLlcSyQxHqPa9lIOPQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hoGpYvtVoao=:SzwjEyDJz9hhk7ZhHTuDpV
 LMZlWzV+yhvriYpHm3d93SJVTHaw2oSyYOrGNpkY2jQ7GoXBIH3Fz8vSYFEYxQLoH6UznlcJl
 kf8KCf12fLcy/W5WoT0DZ+585NTRdqrTs2JVv1FHHlX4smyvEiFN/4qa4YhvEWwGMFvxExtF+
 sGZKkl6mFi9IYSO0+MRaHUycs3u94jsbX9ysRgiTeOa7LisAV5SYsi1kVImeGxNbUg8X9kvIU
 m1NDSxFsy7ziS7QUqR3hrDFViPxxmF9mN8QwowASGsmMrA/pdSP7WgcOlKiEPVCqv5Bv5cSts
 yq59Dk4jXbChgRX0geJxi0pNCzdXgw0pcVGA2rNf+I5TX/F1FQf2KOD6Z56NQfMBmNuxINdz+
 EMjtQjRLlZzj5Vvc//tlgotlIOKrThDeBfF+WxzvUyKamU7Rwdz0Tk8nmPKOEr6v8+Bwk+3gb
 twxZVg/v1o7buwxyfjuaNbNvZkA6RhoKmGJ5/GBYczSXO+gr1C6if07FHXPumVEO/R5fuJrkg
 D7ByKs6mul327q5/EuRg5RrfoLb48NW6/jA9rpj+5VkSRGShRwouUt2WEg4JonE9FjRoK1REK
 yzNzBZObPIXd4R9OzdYcpPxSZ6Bch1RCu/XhASKbi/fl0iNiNuaxaUTC+K/GRqU51+wX5o3x9
 Vqw4LEQz7DuRTQzoE7Y0wzcttRx3vzXp+YqqMD3Te6kXtjPhG9D/OvbtfZ6ZNq+DNSXbl5cdS
 H6ufo5nIWe+gxVehLrX9gZrUQszmi7Cf+yF7SFkn2DlghxdBlSjMopl3qfJR/kR8KziMduI7I
 /T6SHerKR8NFuhAbUnzCrD8IEVDkLqfSJK+1r0xJzN6uWjAQTM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 1, 2020 at 2:29 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Thu, Apr 30, 2020 at 04:05:07PM +0200, Arnd Bergmann wrote:
> > lib/locking-selftest.o: warning: objtool: locking_selftest()+0x117f: PUSHF stack exhausted
> > lib/locking-selftest.o: warning: objtool: ww_tests()+0x1083: PUSHF stack exhausted
>
> Peter,
>
> These functions have a bunch of irqs_disabled() checks, which means a
> bunch of PUSHFs with no POPFs.
>
> Am I reading it correctly that objtool assumes PUSHF is always paired
> with POPF?  irqs_disabled() doesn't do that.

I played around with this one a little more, it seems that the warning
is related to
the number of dotest() calls getting inlined into the functions. If I
comment out
a few of them (any five or more, occording to my non-scientific
tests), the warning
disappears, and it also goes away if I disable inlining that function:

--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -1134,7 +1134,7 @@ static int testcase_successes;
 static int expected_testcase_failures;
 static int unexpected_testcase_failures;

-static void dotest(void (*testcase_fn)(void), int expected, int lockclass_mask)
+static noinline void dotest(void (*testcase_fn)(void), int expected,
int lockclass_mask)
 {
        unsigned long saved_preempt_count = preempt_count();

    Arnd
