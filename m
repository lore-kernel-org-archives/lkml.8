Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F241C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 14:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DE7D21D80
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 14:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599574165;
	bh=mbfauGX7l3Y8qQxNiJqadv/7s6SZLaKEn9FW9X7d8FI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2ptoDHdFoUO65/UQ0AJXVjNoBLoEo2dQhN52cDddVk7arYaLHZBgIICbo4QWhoNAo
	 jEkDMAQj1WZ+5hZIPAEk8YewdmmmcYUfTZMkDsNcGgISla0zfhuz173oNvAizATiHa
	 H7zFWYmFh16CeuGSnqCBIIe1VKYpgZrgd9TPRcDM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbgIHOFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 10:05:39 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42124 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729622AbgIHN6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 09:58:35 -0400
Received: by mail-lj1-f194.google.com with SMTP id k25so20123765ljg.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 06:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DRy3SRSuusmtp8hsLZEtIL6pPGQ6A3wyEibwbW07K/I=;
        b=eLniuopSwS2QSW49fS4p20Kk/0QbAWns/5Lffj7yf4148IcE7VKwZAsL8lWbkG/KYn
         xb5Db6KN5/yHNKtojo83jNWUtvvGCVL5lkZas++BBMaLNeuZe66Ffq/Y+WpM/CvwUKua
         qIC4zsKUHP906W7H3bV6xFqDKnTlrRx31Y4lVZXQMUlyKm28OHxRDJvq1iVY4YLcwFIL
         iQ0AGgPKR1n3B2kBNR5ffDhfv35y3p6uh6BkYtK2/0NACH02e5STcofaKWhBUXLBe7pq
         CVD5umK3TjS8fmAHQRQids1+uZ23ZqIAlhN3po5ObFd09gaHPqTScNUXOF+KSBEdAAEb
         tH5A==
X-Gm-Message-State: AOAM530CD+71O2KprEJZ375+RoioLM5QHdnGoAtTPsHsGLH350oVzdOe
        B3S0c3PAxofb01uXJoiCVQDkUTFz104+Tcx7Qlb8MXPoaHw=
X-Google-Smtp-Source: ABdhPJyIWW+D5eWfj47c1+pq5A02Y/jUZ0zoKOIBtqsfqrJ+9jCo9ypO3LZcu/nZO+l+BbJvNtjU2PvQjzJKoJjr+aU=
X-Received: by 2002:adf:8b48:: with SMTP id v8mr26923909wra.21.1599572669813;
 Tue, 08 Sep 2020 06:44:29 -0700 (PDT)
MIME-Version: 1.0
References: <1599563792-20711-1-git-send-email-tangzejiang@loongson.cn>
In-Reply-To: <1599563792-20711-1-git-send-email-tangzejiang@loongson.cn>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 8 Sep 2020 22:44:18 +0900
Message-ID: <CAM9d7ch+AvG=NetiEjT6qmewhCy6+QEBS4sr1J7qikYnmQPDZg@mail.gmail.com>
Subject: Re: [PATCH v2] Improve perf option help information in perf.txt
To:     Zejiang Tang <tangzejiang@loongson.cn>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 8, 2020 at 8:16 PM Zejiang Tang <tangzejiang@loongson.cn> wrote:
>
> Perf could use many options, such as:-vv, --exec-path,
> --html-path, -p, --paginate,--no-pager, --debugfs-dir,
> --buildid-dir, --list-cmds, --list-opts. Add these options
> in perf.txt.
>
> Signed-off-by: Zejiang Tang <tangzejiang@loongson.cn>
> ---
>  tools/perf/Documentation/perf.txt | 69 ++++++++++++++++++++++++++-------------
>  1 file changed, 47 insertions(+), 22 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf.txt b/tools/perf/Documentation/perf.txt
> index 3f37ded..5edb854 100644
> --- a/tools/perf/Documentation/perf.txt
> +++ b/tools/perf/Documentation/perf.txt
> @@ -12,32 +12,57 @@ SYNOPSIS
>
>  OPTIONS
>  -------
> ---debug::
> -       Setup debug variable (see list below) in value
> -       range (0, 10). Use like:
> -         --debug verbose   # sets verbose = 1
> -         --debug verbose=2 # sets verbose = 2
> -
> -       List of debug variables allowed to set:
> -         verbose          - general debug messages
> -         ordered-events   - ordered events object debug messages
> -         data-convert     - data convert command debug messages
> -         stderr           - write debug output (option -v) to stderr
> -                            in browser mode
> -         perf-event-open  - Print perf_event_open() arguments and
> -                            return value
> -
> ---buildid-dir::
> -       Setup buildid cache directory. It has higher priority than
> -       buildid.dir config file option.
> +-h::
> +--help::
> +        Run perf help command.
>
>  -v::
>  --version::
> -  Display perf version.
> +        Display perf version.
>
> --h::
> ---help::
> -  Run perf help command.
> +-vv::
> +        Print the compiled-in status of libraries.
> +
> +--exec-path::
> +        Display or set exec path.
> +
> +--html-path::
> +        Display absolute html path.

I doubt if we ever used this html man pages.

> +
> +-p::
> +--paginate::
> +        Set up pager.
> +
> +--no-pager::
> +        Add or change the content of environment variables.

It's too vague and incorrect.  Maybe just "Do not set up pager" ?

Thanks
Namhyung


> +
> +--buildid-dir::
> +        Setup buildid cache directory. It has higher priority
> +        than buildid.dir config file option.
> +
> +--list-cmds::
> +        List the most commonly used perf commands.
> +
> +--list-opts::
> +        List available perf options.
> +
> +--debugfs-dir::
> +        Set debugfs directory or set environment variable PERF_DEBUGFS_DIR.
> +
> +--debug::
> +        Setup debug variable (see list below) in value
> +        range (0, 10). Use like:
> +          --debug verbose   # sets verbose = 1
> +          --debug verbose=2 # sets verbose = 2
> +
> +        List of debug variables allowed to set:
> +          verbose          - general debug messages
> +          ordered-events   - ordered events object debug messages
> +          data-convert     - data convert command debug messages
> +          stderr           - write debug output (option -v) to stderr
> +                             in browser mode
> +          perf-event-open  - Print perf_event_open() arguments and
> +                             return value
>
>  DESCRIPTION
>  -----------
> --
> 2.1.0
>
