Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D22C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 792F620678
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578678658;
	bh=7TCQHbB0mjCO+0QqSnDmXsUhmItYFw4Q1QzlkaGBSG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AT68bh3XtWepPfp9A4f+Ss5uYEZimFH/whlr8nk2yTuXUKJhN7UI53InSogahkNGu
	 7R17JQTyr2AMt5muPyfg0FA/WdPg18YBMfyWRpZxRijNuvI7vhBHtZDObBULqFK11G
	 SReSVRbqKcYBQ0+j4+gwFkbOhHqA8Qa99j5rv7eE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbgAJRu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:50:57 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55673 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbgAJRu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:50:57 -0500
Received: by mail-wm1-f66.google.com with SMTP id q9so2916726wmj.5;
        Fri, 10 Jan 2020 09:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uj6Jte21QmtwcGSvAGBsxCZTazgIKLD+rTsqTg7aZ5Q=;
        b=Z75W3n0p9QGCfBlqKyunBVoXuwqI2SOgE9m3NDc+DM7qKlnIlDz8ewr6UOXkXowdi7
         AFkInyxK2sxN3ZeR0wOcvi2/rNIsNLHFBTGvK8iOBJ1BsL/ZYLR9bS5xCCry0MOINdRg
         LURLUHYAyFlWVHki22fmhKXkdAItiWSqzLdkyfJ6NHt9VFcuwIcDItz2j/PoVvsu6wzl
         86uuuLf4pTizL53YglxwTcbDzQ3i3A0H96tsF1t725Veo+o96hRRa0xzyXjpPk9hI1RG
         t8wIx7Okzms4T+r0RMqACbx/QmmrPFBDh1D34dEovJKNXIjjp9L19NlcBODvOWej665X
         xK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=uj6Jte21QmtwcGSvAGBsxCZTazgIKLD+rTsqTg7aZ5Q=;
        b=nO5u5wDrDu10sI89+FFQEeMAOH9FCOrdYeG9Hcj96cjdrfSiG+tuGvdJSpDqQ56cJh
         mAm4gPkSy/cIwa5hCJoUKUhFZGxTTDp72aWUk3B1VaCCpt+cPhuuW6ejqpFX9SV4GTc+
         qe11USTp+AHK70yj21DrmFUE+qR4C+MWnC35r/J3u+0ko+Uye91aYMRoMHS3jhTmYAYQ
         h1fTREDZp6qNbPvtu6VXdNcAIcT5IQbGmnG7tULb5ZYbYl3Id8TinwYOoOKaE0g/2R99
         PC/9pzl0m8d4WzotzPCJKQSHk9X8TFsB+gnKTNWRgmMFOzYOsG4+Wa7HSiQ9xueTqp0m
         OuTw==
X-Gm-Message-State: APjAAAVZZBYpe0FvmK43AXsO/BzOphEh597rj0gWxP+OEz9I22FuwTut
        hAkjsJ96+w2uXU5h2J74UBY=
X-Google-Smtp-Source: APXvYqw7OXhGlWG4+FGPSXoDL7rbT6MJnRpQroqE6Xi93z+QEbNgUN1Nia8qtpf5/c+Gi755DRNPuw==
X-Received: by 2002:a1c:49c2:: with SMTP id w185mr5417340wma.138.1578678654618;
        Fri, 10 Jan 2020 09:50:54 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id f17sm3069477wmc.8.2020.01.10.09.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 09:50:53 -0800 (PST)
Date:   Fri, 10 Jan 2020 18:50:51 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        David Ahern <dsahern@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vitaly Chikunov <vt@altlinux.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf/core improvements and fixes
Message-ID: <20200110175051.GA83292@gmail.com>
References: <20200106160705.10899-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106160705.10899-1-acme@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo/Thomas,
> 
> 	Please consider pulling,
> 
> Best regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit b9fb2de0115bbacab36da31fd10483ea66d9cfab:
> 
>   Merge tag 'perf-urgent-for-mingo-5.5-20191223' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2019-12-23 22:27:44 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.6-20200106
> 
> for you to fetch changes up to 6c4798d3f08b81c2c52936b10e0fa872590c96ae:
> 
>   tools lib: Fix builds when glibc contains strlcpy() (2020-01-06 11:46:10 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes.
> 
> perf record:
> 
>   Alexey Budankov:
> 
>   - Adapt affinity for machines with #CPUs > 1K to overcome current 1024 CPUs
>     mask size limitation of cpu_set_t type.
> 
> perf report/top TUI:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Make ENTER consistently present the pop up menu with and without call
>     chains, to eliminate confusion. The menu continues available at all times
>     use 'm' and '+' can be used to toggle just one call chain level, 'e' for all
>     the call chains for a top level histogram entry and 'E' to expand all call
>     chains in all top level entries. Extra info about these options was added to
>     the pop up menu entries. Pressing 'k' serves as special hotkey to go straight
>     to the main vmlinux entries, to avoid having to press enter and then select
>     "Zoom into the kernel DSO".
> 
> perf sched timehist:
> 
>   David Ahern:
> 
>   - Add support for filtering on CPU.
> 
> perf tests:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Show expected versus obtained values in bp_signal test.
> 
> libperf:
> 
>   Jiri Olsa:
> 
>   - Move to tools/lib/perf.
> 
>   - Add man pages.
> 
> libapi:
> 
>   Andrey Zhizhikin:
> 
>   - Fix gcc9 stringop-truncation compilation error.
> 
> tools lib:
> 
>   Vitaly Chikunov:
> 
>   - Fix builds when glibc contains strlcpy(), which is the case for ALT Linux.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Alexey Budankov (3):
>       tools bitmap: Implement bitmap_equal() operation at bitmap API
>       perf mmap: Declare type for cpu mask of arbitrary length
>       perf record: Adapt affinity to machines with #CPUs > 1K
> 
> Andrey Zhizhikin (1):
>       tools lib api fs: Fix gcc9 stringop-truncation compilation error
> 
> Arnaldo Carvalho de Melo (12):
>       perf tests bp_signal: Show expected versus obtained values
>       perf hists browser: Restore ESC as "Zoom out" of DSO/thread/etc
>       perf report/top: Make ENTER consistently bring up menu
>       perf report/top: Add menu entry for toggling callchain expansion
>       perf report/top: Improve toggle callchain menu option
>       perf hists browser: Generalize the do_zoom_dso() function
>       perf report/top: Add 'k' hotkey to zoom directly into the kernel map
>       perf hists browser: Allow passing an initial hotkey
>       tools ui popup: Allow returning hotkeys
>       perf report/top: Allow pressing hotkeys in the options popup menu
>       perf report/top: Do not offer annotation for symbols without samples
>       perf report/top: Make 'e' visible in the help and make it toggle showing callchains
> 
> David Ahern (1):
>       perf sched timehist: Add support for filtering on CPU
> 
> Jiri Olsa (2):
>       libperf: Move to tools/lib/perf
>       libperf: Add man pages
> 
> Vitaly Chikunov (1):
>       tools lib: Fix builds when glibc contains strlcpy()

>  70 files changed, 1565 insertions(+), 352 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
