Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E7AC11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D3A424691
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dsz/dd+K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732167AbgB0OnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:43:24 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:41399 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731358AbgB0OnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:43:22 -0500
Received: by mail-vs1-f65.google.com with SMTP id k188so1967131vsc.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 06:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z+isuoKHbYPGILyMICbGR0T5QiMYRy4J1XMZ/c0MyCE=;
        b=dsz/dd+K0I4XD1YrhrhPrHHrR191LtRyLN7aW8hmkbZPgrrvlzPCU2Smg1NEu36eT6
         KHLffuYRjxM41BUOtcI6irVNls7ebDoaPsitXlh9zLNYML4FI9hSwEqIRBSYmpQPdrk6
         +5Jc5auj6M+JJe2bJ1uLklew3o9sgGElGwB3XYKUXjOLArCJ0cpQkL84PKxdozFzjvc+
         KIlGHGfjb2TATOqqIOqDSze6qeAqyF/kaKk98t/jbfQT0r2qx6PrOxDMGQ4f7S6IIwmt
         dbHDeywyho5NjaxRwEKTM+v75sCIpKtLn9ske4II8+0vX697sx2/ui4at3opVGGi2eJP
         BmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z+isuoKHbYPGILyMICbGR0T5QiMYRy4J1XMZ/c0MyCE=;
        b=oWxc/mRnkHrIChnQsbe/eNyxk1tUdx+dtAkgZ3V55551wKs4cLq0koNDkUwcdl3NOZ
         KamK+W1N+xNiE3znEAWo7ASs/Qdz4Aq3VjvhwnmIICBfca7Zwy4suUE/DWHWyQS2KQvy
         VjByaJHw9AHukQMH8+D2gov7h4jtaa8vqdoBFcIzFHqzPi2Wbe7uIKFM63jHUh/wgy4s
         ozmfgBJp40EkZzUUDzO0F+BE6qcgW8olGhKDwf/flLSy1Y3Wvnhfn/u+HNIJ7os2ZFis
         xUoe+J/NCMRFm7xL70n48jYBNguPng7kpDKNrXhc19kWegusg5Ear/e23XkOdqA9+OdJ
         j8cQ==
X-Gm-Message-State: APjAAAVWja1w3DDxgH959E3GeGkGn6TI6I0WKaCybvoMX67VihY8VSl+
        gt3Yg3FPWaBbGCPwgc6L+bQEANdjm6lXBmFNpl6cfw==
X-Google-Smtp-Source: APXvYqwcq58o1fQ/mxg6LapwJjViDpXeZMxMof5dGvU3nXZs+HFFCPF/LbTlE/gRBPnnUHHPHu5q3xLtm8y/xdFNsQ0=
X-Received: by 2002:a67:f318:: with SMTP id p24mr2787324vsf.240.1582814601592;
 Thu, 27 Feb 2020 06:43:21 -0800 (PST)
MIME-Version: 1.0
References: <20200227024301.217042-1-trishalfonso@google.com> <20200227024301.217042-2-trishalfonso@google.com>
In-Reply-To: <20200227024301.217042-2-trishalfonso@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 27 Feb 2020 15:43:10 +0100
Message-ID: <CACT4Y+YFewcbRnY62wLHueVNwyXCSZwO8K7SUR2cg=pxZv8uZA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] KUnit: KASAN Integration
To:     Patricia Alfonso <trishalfonso@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>, vincent.guittot@linaro.org,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 3:44 AM 'Patricia Alfonso' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> Integrate KASAN into KUnit testing framework.
>  - Fail tests when KASAN reports an error that is not expected
>  - Use KUNIT_EXPECT_KASAN_FAIL to expect a KASAN error in KASAN tests
>  - KUnit struct added to current task to keep track of the current test
> from KASAN code
>  - Booleans representing if a KASAN report is expected and if a KASAN
>  report is found added to kunit struct
>  - This prints "line# has passed" or "line# has failed"
>
> Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
> ---
> If anyone has any suggestions on how best to print the failure
> messages, please share!
>
> One issue I have found while testing this is the allocation fails in
> kmalloc_pagealloc_oob_right() sometimes, but not consistently. This
> does cause the test to fail on the KUnit side, as expected, but it
> seems to skip all the tests before this one because the output starts
> with this failure instead of with the first test, kmalloc_oob_right().

I don't follow this... we don't check output in any way, so how does
output affect execution?...


> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -141,7 +141,7 @@ class LinuxSourceTree(object):
>                 return True
>
>         def run_kernel(self, args=[], timeout=None, build_dir=''):
> -               args.extend(['mem=256M'])
> +               args.extend(['mem=256M', 'kasan_multi_shot'])

This is better done somewhere else (different default value if
KASAN_TEST is enabled or something). Or overridden in the KASAN tests.
Not everybody uses tools/testing/kunit/kunit_kernel.py and this seems
to be a mandatory part now. This means people will always hit this, be
confused, figure out they need to flip the value, and only then be
able to run kunit+kasan.


>                 process = self._ops.linux_bin(args, timeout, build_dir)
>                 with open(os.path.join(build_dir, 'test.log'), 'w') as f:
>                         for line in process.stdout:
