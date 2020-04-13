Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33CFC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 18:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A48820735
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 18:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586801639;
	bh=/PoTNeVrc6MwSon4BjbQ9ftFoRVce1YIXW9yX1m6Vlg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qAiCtgiG3+ZCh8S2PJW7MopzrqsIomnlzFm/tDqumz58QtNe65nxV4jTNo4JRvM/V
	 0O/cRcDzejkUa3OBo53o1x3D3HeK/DCmbGTzi8wTbBPXZSYkE/hOmiAFuOVrqMc12c
	 /yElgLmDYLGARlw5ngHqDlDWZXNyxIj/xSqlGOJU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387676AbgDMSN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 14:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387623AbgDMSN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 14:13:56 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC99C0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 11:13:56 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id m19so7237864lfq.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 11:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yqrn/lvg8MKN3ZJAgVGn2Djp8dSZuTuTN4gwks6EVe4=;
        b=AK0WRb2rySLprGYr7CAPSgeXCNnAUatM1AU+74gdeAF/7P8aEG6EI+bM0vz5uFAzJu
         hPw6AOOr5NT3Bua/PoMqEoSGeDomSpnxfzm7gSGhETxUHe9jqJ/zM1HZfiFYg59ogWc4
         ErzmFA3qU6zs7+PocOTTBiQoM7v3RvoMcLuNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yqrn/lvg8MKN3ZJAgVGn2Djp8dSZuTuTN4gwks6EVe4=;
        b=sB02OdPXX43+1pt0NLjcXmMaU1slvxfBNvGY7eK+DJbO/kLClCK008JLtSmeJp5Eaf
         E9bezwkjAARa0xAbtWqyxJ2CspL+sTeng3JEYqgTlx4b+x1Ei+EIkiAPHg09M/0zf7Sx
         xi9vz8U/6VJn0xH5qIszvbVJxPTHpJyJ/XZGZmKThuHkSmtRXA9fPVJooKb0fs58UJ5y
         iMbVQPUvra0l+5XIe0pJ3rvx6dVF4zN6oh1e3oK2h2KSLw/qpJ8EAG6Ys1iVjEPoxyvc
         5VgrD3pqLQwrseUoFVL4CcfwUv9zN3HF6uWqkChJrtD9B+x/Bq+eZZX/yo5JfmgZjFWQ
         t6TQ==
X-Gm-Message-State: AGi0Pub9NrgiKIQqCfHPVhetAWkSGkpJ6FMcK8PvtMpeV2qOwKfI0oFe
        wrSpxsRzFT40wVxwL788Gx6WbRYRPGM=
X-Google-Smtp-Source: APiQypIq2ba2wm09YiCAQVLHm3KNZAFWccl+W27CkRixmFouf50aRd5aEDzn3djWBJt6M1wShfJGSQ==
X-Received: by 2002:a05:6512:6c8:: with SMTP id u8mr9161338lff.23.1586801634076;
        Mon, 13 Apr 2020 11:13:54 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id w24sm7565872ljh.57.2020.04.13.11.13.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2020 11:13:52 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 198so7280513lfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 11:13:51 -0700 (PDT)
X-Received: by 2002:a19:240a:: with SMTP id k10mr11275697lfk.30.1586801631427;
 Mon, 13 Apr 2020 11:13:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200413063317.7164-1-penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20200413063317.7164-1-penguin-kernel@I-love.SAKURA.ne.jp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 13 Apr 2020 11:13:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgbMi2+VBN0SCEw9GeoiWgui034AOBwbt_dW9tdCa3Nig@mail.gmail.com>
Message-ID: <CAHk-=wgbMi2+VBN0SCEw9GeoiWgui034AOBwbt_dW9tdCa3Nig@mail.gmail.com>
Subject: Re: [PATCH v3] Add kernel config option for tweaking kernel behavior.
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Garrett <mjg59@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jslaby@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 12, 2020 at 11:34 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Existing kernel config options are defined based on "whether you want to
> enable this module/feature or not". And such granularity is sometimes
> too rough-grained for fuzzing tools which try to find bugs inside each
> module/feature.

I still detest making this a hardcoded build-time config option.

A kernel parameter that sets a flag seems much simpler. More
importantly, having it be something sanely named, and something you
can set independently some other way, would allow a regular kernel to
then run a fuzzer as root.

Some kind of "not even root" flag, which might be per-process and not
possible to clear once set (so that your _normal_ system binaries
could still do the root-only stuff, but then you could start a fuzzing
process with that flag set, knowing that the fuzzing process - and
it's children - are not able to do things).

Honestly, in a perfect world, it has nothing at all to do with
fuzzing, and people could even have some local rules like "anybody who
came in through ssh from the network will also have this flag set".

                 Linus
