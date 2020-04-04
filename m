Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1F5C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 01:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC2EB2064A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 01:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585963779;
	bh=aeWvhZUdVfTp0O61TTqBL76FSwlp8n1vPFEO7AvJCKU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Co/WUhgrjYRbR0kbdaE6TwFzfIrNHUUr1owQKETSpPM/QovJYuciuOUKvhXVd69Gf
	 Z5O+ceX/G3ExkKWoHgjIba3hIpglRrvQbQRvKOthNVppoWZgM3Dve5MFKYyIUF7qXb
	 3/e8Mcn2xbNMmqAGTGfqLmbDLfLFTc+/vRX6hOn0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgDDB3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 21:29:38 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35600 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgDDB3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 21:29:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id i19so9729082wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 18:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VRwOcI1+h35fHJSbSWxbypPvdZDgUSqWGPr4ShkMhi0=;
        b=b63nZy6oknlHTQAORbiyZBvkxv9xQNJsW0hSX8S3s6v6FakUGt3HvvAEYinGBHsunB
         V8iDhCGB0jOMEW1GR+TVq2NqOCYUSXN0bwrhadvoR9pwDyLapDkxm2YwB3izaicQBCkm
         zIAS32LHabLFK8OZzckNEQBs1uEL6mBa4bIDUnQAM39XytXNmaZUpmOtTGU+xTp5pMU8
         iwHPzWyKi7dLQDewNu7nsWTuMmQf2OydcLfUzJ9wqw93mNTMhH0MyWKrOI00m7xhBbfV
         FaPawiQsVa0xE2yxHEmphSoE4kIP8QR8Qk3Q2rkQYqtxTuAy5t4xxxl6ojwLbCIfDsaN
         bW8w==
X-Gm-Message-State: AGi0PuZ6MXP/seUYP9nigS38XkjLwGxj0n+sKg/MHLuII09EOmku/RMW
        5cW9BhOrK92Qqf9XWl3r7AFwba6v69S/UZ0smEw=
X-Google-Smtp-Source: APiQypKW+iQvXq14tWLpIG/DKw3YUnGjZqziD1HmFlVhDwJEBHktD9t0Bh9GPjRCC94/qvwipD5AGqT0BpEV5awcnEk=
X-Received: by 2002:a7b:c842:: with SMTP id c2mr11954058wml.154.1585963775062;
 Fri, 03 Apr 2020 18:29:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200325124536.2800725-1-namhyung@kernel.org> <20200325124536.2800725-5-namhyung@kernel.org>
 <20200403123606.GC23243@kernel.org>
In-Reply-To: <20200403123606.GC23243@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 4 Apr 2020 10:29:24 +0900
Message-ID: <CAM9d7cjxwTFDqMmqzM5Mwg4OZnBxN8tdnd7bHfZG9fDTtAs28A@mail.gmail.com>
Subject: Re: [PATCH 4/9] perf tools: Maintain cgroup hierarchy
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Fri, Apr 3, 2020 at 9:36 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Wed, Mar 25, 2020 at 09:45:31PM +0900, Namhyung Kim escreveu:
> > Each cgroup is kept in the perf_env's cgroup_tree sorted by the cgroup
> > id.  Hist entries have cgroup id can compare it directly and later it
> > can be used to find a group name using this tree.
>
> This one breaks the 'perf test python' test, I fixed it adding this
> patch before your series:

Thanks a lot for fixing this and taking care of the whole thing!
Namhyung


> From ea3c4ab73cb2ea2960bba6894560b1ef91e69737 Mon Sep 17 00:00:00 2001
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date: Fri, 3 Apr 2020 09:29:52 -0300
> Subject: [PATCH 1/1] perf python: Include rwsem.c in the pythong biding
>
> We'll need it for the cgroup patches, and its better to have it in a
> separate patch in case we need to later revert the cgroup patches.
>
> I.e. without this we have:
>
>   [root@five ~]# perf test -v python
>   19: 'import perf' in python                               :
>   --- start ---
>   test child forked, pid 148447
>   Traceback (most recent call last):
>     File "<stdin>", line 1, in <module>
>   ImportError: /tmp/build/perf/python/perf.cpython-37m-x86_64-linux-gnu.so: undefined symbol: down_write
>   test child finished with -1
>   ---- end ----
>   'import perf' in python: FAILED!
>   [root@five ~]#
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/python-ext-sources | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/perf/util/python-ext-sources b/tools/perf/util/python-ext-sources
> index e7279ea6043a..a9d9c142eb7c 100644
> --- a/tools/perf/util/python-ext-sources
> +++ b/tools/perf/util/python-ext-sources
> @@ -34,3 +34,4 @@ util/string.c
>  util/symbol_fprintf.c
>  util/units.c
>  util/affinity.c
> +util/rwsem.c
> --
> 2.25.1
>
