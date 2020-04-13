Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E10C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 07:29:30 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 578D020735
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 07:29:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 578D020735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbgDMH33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 03:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbgDMH33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 03:29:29 -0400
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0D9C008651;
        Mon, 13 Apr 2020 00:29:27 -0700 (PDT)
Received: by mail-wm1-f66.google.com with SMTP id o81so2978734wmo.2;
        Mon, 13 Apr 2020 00:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uhk/XHhK+30XdE8fgu1onjLrqtuGjnJe9Gl5IIcetew=;
        b=JGMO1ZQ0zeUbNIKTWcwJqNmegwBB+1SbVA77Rck8A9/d4r6fOV8su3KJZz2+xyLqqo
         YujtFDeIqKgoCkPA+cNsswd9kqrE5UPYP2DwrztvcWCyUsyN5pCqv8uW613c/itRjK9A
         SfBKJLFVD16BI/9AXZF+/9tkdTFmXoUfaO/JFN+TMiODNtrQ3SAgOmezb5RzXHun3rQs
         429+Z3f6B2PYAE6PtjQJ4QJCsNymwcjIL4I6hwyo3gilDymN3OpGf0qCNGEyfXxc+Aqc
         QhnA/bSsZGGk+R3AJqPe151Hznb4llVkqAquA0H2YBC6XAoAGE8taW8IvyJDzSZZmfUN
         lWzw==
X-Gm-Message-State: AGi0PubQ2KK1k2l3EdtDPpsWWQ+kFQ4JvuVMLRVXBp/zPSMgD2K2gGAc
        +ea1YxEdaHwIWlFZ5V9OnKH0bnCH1FQx5BIJNus=
X-Google-Smtp-Source: APiQypIktJCjFxsADA1D8yYdP3dhFDL6jagFc2iH+xGBCKPBUGElOO3yBb0n+vkmF3A3TxFRIP3/HBCz8tZz+TQ4k70=
X-Received: by 2002:a1c:2007:: with SMTP id g7mr17347133wmg.70.1586762965993;
 Mon, 13 Apr 2020 00:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200411064248.247530-1-irogers@google.com>
In-Reply-To: <20200411064248.247530-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 13 Apr 2020 16:29:15 +0900
Message-ID: <CAM9d7cgOO88sWDh8F1x2Mnk2ikSF0FUCp88c1wAheW5zJ9+B0g@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] tools api: add a lightweight buffered reading api
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Petr Mladek <pmladek@suse.com>,
        Andrey Zhizhikin <andrey.z@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Sat, Apr 11, 2020 at 3:42 PM Ian Rogers <irogers@google.com> wrote:
>
> The synthesize benchmark shows the majority of execution time going to
> fgets and sscanf, necessary to parse /proc/pid/maps. Add a new buffered
> reading library that will be used to replace these calls in a follow-up
> CL. Add tests for the library to perf test.
>
> v4 adds the test file missed in v3.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> +/* Read a hexadecimal value with no 0x prefix into the out argument hex. If the
> + * first character isn't hexadecimal returns -2, io->eof returns -1, otherwise
> + * returns the character after the hexadecimal value which may be -1 for eof.

I'm not sure returning -1 is good when it actually reads something and
meets EOF.
Although it would have a valid value, users might consider it an error IMHO.
Why not returning 0 instead? (I'm ok with -1 for the later use of the API).


> + * If the read value is larger than a u64 the high-order bits will be dropped.
> + */
> +static inline int io__get_hex(struct io *io, __u64 *hex)
> +{
> +       bool first_read = true;
> +
> +       *hex = 0;
> +       while (true) {
> +               int ch = io__get_char(io);
> +
> +               if (ch < 0)
> +                       return ch;
> +               if (ch >= '0' && ch <= '9')
> +                       *hex = (*hex << 4) | (ch - '0');
> +               else if (ch >= 'a' && ch <= 'f')
> +                       *hex = (*hex << 4) | (ch - 'a' + 10);
> +               else if (ch >= 'A' && ch <= 'F')
> +                       *hex = (*hex << 4) | (ch - 'A' + 10);
> +               else if (first_read)
> +                       return -2;
> +               else
> +                       return ch;
> +               first_read = false;
> +       }
> +}
> +
> +/* Read a positive decimal value with out argument dec. If the first character
> + * isn't a decimal returns -2, io->eof returns -1, otherwise returns the
> + * character after the decimal value which may be -1 for eof. If the read value
> + * is larger than a u64 the high-order bits will be dropped.

Ditto.

Thanks
Namhyung


> + */
> +static inline int io__get_dec(struct io *io, __u64 *dec)
> +{
> +       bool first_read = true;
> +
> +       *dec = 0;
> +       while (true) {
> +               int ch = io__get_char(io);
> +
> +               if (ch < 0)
> +                       return ch;
> +               if (ch >= '0' && ch <= '9')
> +                       *dec = (*dec * 10) + ch - '0';
> +               else if (first_read)
> +                       return -2;
> +               else
> +                       return ch;
> +               first_read = false;
> +       }
> +}
> +
> +#endif /* __API_IO__ */
