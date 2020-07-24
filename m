Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5DBC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 18:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 587EA206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 18:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RxUIMfIB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgGXSNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 14:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbgGXSNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 14:13:42 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6237EC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 11:13:42 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f2so9097747wrp.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 11:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1aDU5AXzYgdOnXdn58wgvxjmBcDSQKB8DAmMFSAzX1U=;
        b=RxUIMfIByrxsEmMzG5oOXmUCwzBHDJqPEDFdkSaAMDCpFnYAMwugXgBDr2p0tZ/LTM
         S5Sz0Ls6+G30DfhEB70BuE/OWlkkajVj3JmWz8tdF1AvGEhhcP0IrY99ruL7qQQvYudZ
         Wg/Sq6kWiw+rQmNBDxEjdapcdHX9Rkt2XOeJpJJ4dB1CXVDb3u3vfFI+ccrBqjtekMR8
         4GcClHL0yQLhrr1eMKlYpz7yEhjkgzJ6RXVGkT+O7vb+DKfVpvtQmz57ET5EjJ+EJfDt
         5WNXeKzbqbd/9EkNQ2Pjqxx7GuUorYHBG5r52QA1doxeS5VM7OtuXOyH2EDQQv0Z4xIm
         dbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1aDU5AXzYgdOnXdn58wgvxjmBcDSQKB8DAmMFSAzX1U=;
        b=NjIH7CLnePJU/5PWTvwxDBvJb9oBAofUTWWR+2iEMe8dVVwtiK4Fu9wJjKw0dp6wpm
         vHZ8PcH+jB7WJO5WBgLN/MzU5UPkgBpQul7VvrJLGeyDOSiCEtGCKAAhnY6Dq5ps5Miu
         e0NyiUzFSvZ9g48O3xEwAAwMhTSifTWfgAOwrNGRVnSoK5LuoA1VkRKUajso3PQItPOO
         tYWsFrlGDIjmRvdQEfu9unZoGjiL0aSgQZjUkB+BgBP+rk3tXHJQdB8jQrVaul78H6Bx
         L/9U1EOXgfdt1ZGJcneOgvgsHmcChMwpTH8cT4oPJpM773T3p9Pg4aJZLTj2rXIxfwh2
         r/eg==
X-Gm-Message-State: AOAM532K6F2p2HMEkyWP5CBsfDjpqeeVlmfcuHKxI42ItxRR5CblP4ri
        AeOerWm1atwXIxNLvjy+e9ORoLjkyTcSDlZp6iGiBA==
X-Google-Smtp-Source: ABdhPJxk/WSooyzpjSeDJGa+zv5jUh68iRm70x6YZ62JRDw5Yb8lrUJqjBz7gg2xEon3bSKzXpooCZza/MCoAl9Gpjc=
X-Received: by 2002:adf:fe0c:: with SMTP id n12mr5097208wrr.48.1595614420939;
 Fri, 24 Jul 2020 11:13:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200724071959.3110510-1-irogers@google.com> <20200724144503.GD1180481@tassilo.jf.intel.com>
In-Reply-To: <20200724144503.GD1180481@tassilo.jf.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 24 Jul 2020 11:13:29 -0700
Message-ID: <CAP-5=fW7FZXQ=KQsPCbO1LNnCPH8uvDisdi-kzV=vop3P7=duw@mail.gmail.com>
Subject: Re: [PATCH] perf bench: Add benchmark of find_next_bit
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 7:45 AM Andi Kleen <ak@linux.intel.com> wrote:
>
> On Fri, Jul 24, 2020 at 12:19:59AM -0700, Ian Rogers wrote:
> > for_each_set_bit, or similar functions like for_each_cpu, may be hot
> > within the kernel. If many bits were set then one could imagine on
> > Intel a "bt" instruction with every bit may be faster than the function
> > call and word length find_next_bit logic. Add a benchmark to measure
> > this.
>
> > This benchmark on AMD rome and Intel skylakex shows "bt" is not a good
> > option except for very small bitmaps.
>
> Small bitmaps is a common case in the kernel (e.g. cpu bitmaps)
>
> But the current code isn't that great for small bitmaps. It always looks horrific
> when I look at PT traces or brstackinsn, especially since it was optimized
> purely for code size at some point.
>
> Probably would be better to have different implementations for
> different sizes.

Thanks Andi!

what I was kind of expecting was "bt [mem],reg; jae" to have a fixed
cost and the find_next_bit to be a big win when the majority of bits
in a bitmask were 0 but to lose if the majority of bits in the bitmask
were 1. So the ratio of 1s and 0s was going to matter, not so much the
bitmap size. For bitmaps smaller than 32 this was pretty much the
case:

1000000 operations 1 bits set of 1 bits
  Average for_each_set_bit took: 8368.640 usec (+- 103.009 usec)
  Average test_bit loop took:    4052.360 usec (+- 15.381 usec)
1000000 operations 1 bits set of 2 bits
  Average for_each_set_bit took: 8503.770 usec (+- 4.385 usec)
  Average test_bit loop took:    6103.570 usec (+- 0.514 usec)
1000000 operations 2 bits set of 2 bits
  Average for_each_set_bit took: 12754.485 usec (+- 301.342 usec)
  Average test_bit loop took:    6882.950 usec (+- 55.254 usec)
1000000 operations 1 bits set of 4 bits
  Average for_each_set_bit took: 8517.670 usec (+- 5.712 usec)
  Average test_bit loop took:    10485.580 usec (+- 1.386 usec)
1000000 operations 2 bits set of 4 bits
  Average for_each_set_bit took: 12931.060 usec (+- 312.882 usec)
  Average test_bit loop took:    11093.980 usec (+- 43.149 usec)
1000000 operations 4 bits set of 4 bits
  Average for_each_set_bit took: 19664.760 usec (+- 588.841 usec)
  Average test_bit loop took:    12217.583 usec (+- 96.287 usec)
1000000 operations 1 bits set of 8 bits
  Average for_each_set_bit took: 8501.810 usec (+- 5.250 usec)
  Average test_bit loop took:    18924.550 usec (+- 2.999 usec)
1000000 operations 2 bits set of 8 bits
  Average for_each_set_bit took: 12760.025 usec (+- 301.881 usec)
  Average test_bit loop took:    19726.540 usec (+- 56.878 usec)
1000000 operations 4 bits set of 8 bits
  Average for_each_set_bit took: 19151.163 usec (+- 560.053 usec)
  Average test_bit loop took:    20817.317 usec (+- 96.923 usec)
1000000 operations 8 bits set of 8 bits
  Average for_each_set_bit took: 29770.865 usec (+- 1012.050 usec)
  Average test_bit loop took:    22677.150 usec (+- 176.883 usec)
1000000 operations 1 bits set of 16 bits
  Average for_each_set_bit took: 8534.640 usec (+- 4.920 usec)
  Average test_bit loop took:    36451.930 usec (+- 9.763 usec)
1000000 operations 2 bits set of 16 bits
  Average for_each_set_bit took: 12797.065 usec (+- 302.176 usec)
  Average test_bit loop took:    37178.395 usec (+- 51.756 usec)
1000000 operations 4 bits set of 16 bits
  Average for_each_set_bit took: 18736.880 usec (+- 525.846 usec)
  Average test_bit loop took:    38306.897 usec (+- 98.527 usec)
1000000 operations 8 bits set of 16 bits
  Average for_each_set_bit took: 29257.765 usec (+- 993.813 usec)
  Average test_bit loop took:    40038.798 usec (+- 167.358 usec)
1000000 operations 16 bits set of 16 bits
  Average for_each_set_bit took: 46784.984 usec (+- 1759.075 usec)
  Average test_bit loop took:    43014.266 usec (+- 298.138 usec)

 but for larger bitmaps, for example, 2048 bits where all are set,
even though the bt was a single instruction and find_next_bit was
going to have to do a lot of work to just return true (function call,
bunch of shifts) I got:

1000000 operations 2048 bits set of 2048 bits
  Average for_each_set_bit took: 2218881.255 usec (+- 106485.020 usec)
  Average test_bit loop took:    4934851.515 usec (+- 18463.511 usec)

And so other than say for 4-bit and smaller bitmaps the current
find_next_bit approach works best. I don't see an obvious bug in the
benchmark so I am surprised at how bad bt performs.

Thanks,
Ian

> -Andi
