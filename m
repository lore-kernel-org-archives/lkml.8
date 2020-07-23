Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6CCC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A5C620771
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jkkMHttu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgGWPJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 11:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbgGWPJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 11:09:26 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17714C0619E2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 08:09:26 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id o25so1926261uar.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 08:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HBvrm0LkOSK3wKXnjy/eV7+R8Jarv+VxyO8ZHGItrFs=;
        b=jkkMHttuqqzbnQWGBgmOdat5ug/yuxNsx9IQKT0eJPuBQzVCzuMEfKBc9ckmOFpLES
         nYQ/ZVG+bMeNmmcIKXMiAQywOUkWlRhTxFg3xB02Agv4zqMB9reb4XKWCybkCzDHOx+t
         EMMHgXqik/NHwF9PB+uZjS+k017VwXZ0IkH86QVD/Ded9A/KrVNCwfIA7rZtcosRYFik
         X2Fin7ysJSl0cmobmRQ3BzhkR9OWhw25B07crM99E710Bw3QZiUfyBOnkWYChRnrjU1E
         3/O1/NVYizX4/IYGgSlP+8qqrbSz/eOwt07bvoZU3zpNNAVaGSFl7xTN5xcRkh6xd/mF
         oLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HBvrm0LkOSK3wKXnjy/eV7+R8Jarv+VxyO8ZHGItrFs=;
        b=hKKDCvVhqQmk7ULB8+x9siKeOalmtar/zszLzIai4c4nKjXup3/4c0VYdDYOlIlnCs
         +zgvrJwd7PCfJMxNc4EitlWEwmKXwru8NIkQj2dPCxXvHcaJPvMaeLTkVcBRYpYqlfmz
         hf70MUUaKX8cXaXwVaYuJ1AkW72jhZcajRRtJrQsZcFqowfRwpXC2U8lZrzLCX183wDk
         eum6hp9MPMlrWC3D/ZYWH7NJUSP4v3uIJ5ab2QRkWv2BW8hPzUvuKgrSEnR6GQEvadX+
         59y3XCDBO2xkJoHv1up5LJYWAM44/jwB9JskM5098H5vNZyKCjGAZnSeVRkPeIPl/d1J
         vSvQ==
X-Gm-Message-State: AOAM531PL1BYinjGk/ToVE3uPv50nMzdCJYn6WHNqjExmykQUJkMcGhF
        s1EzLTEIPDz3WIooKmVq2qtr9aGI4eU2b9dGpiGT7A==
X-Google-Smtp-Source: ABdhPJx/50vvParRzY8YudAFZ+goS5yVdwhcZiMS5bblMdTtEmiiDPZPaZGwlFO5w1QkZ6pq8df6mHY5PUmQpuYT6XM=
X-Received: by 2002:a9f:236c:: with SMTP id 99mr4703333uae.14.1595516965081;
 Thu, 23 Jul 2020 08:09:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200720191523.845282610@linuxfoundation.org> <CA+G9fYuVJAHyXqPhhqtcdDstKrjb-TLu=d7DZTuQX3YuCsypHA@mail.gmail.com>
 <20200722124953.GE3155653@kroah.com>
In-Reply-To: <20200722124953.GE3155653@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 23 Jul 2020 20:39:12 +0530
Message-ID: <CA+G9fYsNCqKOAt1EdzvgDibpGnWVZum2RPJZe5CU8Ao-eYGyYA@mail.gmail.com>
Subject: Re: [PATCH 5.7 000/243] 5.7.10-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        jolsa@redhat.com, Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Basil Eljuse <Basil.Eljuse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jul 2020 at 18:19, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> >
> > Results from Linaro=E2=80=99s test farm.
> > Regressions detected on arm and arm64 (Juno-r2)
> > We are bisecting this problem and get back to you soon.
> >
> > perf test cases failed
> >   perf:
> >     * Track-with-sched_switch
> >     * perf_record_test
> >     * perf_report_test
> >
> > Bad case:
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.002 MB perf-lava-test.data ]
> >
> > when it was pass it prints number of samples like below,
> > Good case:
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.004 MB perf-lava-test.data (46 samp=
les) ]
> >
> > steps to reproduce:
> > # perf record -e cycles -o perf-lava-test.data ls -a  2>&1 | tee perf-r=
ecord.log
> >
> > Link to full test:
> > https://qa-reports.linaro.org/lkft/linux-stable-rc-5.7-oe/build/v5.7.9-=
244-g7d2e5723ce4a/testrun/2969482/suite/perf/test/perf_record_test/log
> >
> > test case:
> > https://github.com/Linaro/test-definitions/blob/master/automated/linux/=
perf/perf.sh
>
> Any hint by bisection as to what this problem is caused by?

Not yet found the bad commit.
We are working on it.

- Naresh
