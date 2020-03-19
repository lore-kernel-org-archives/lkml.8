Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B93C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA76020658
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584626410;
	bh=OjX+IqWWfZWx2EO3wvzJ6oDbIWxstKfef8bV54kaB8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=a6BiIxn2dNWSQDaQ1AXajSoTavrYfQDyOANs9FoRbV029ZTixptidqd4HY6hBbWpp
	 o5nwJ0V6cm/igaHXCJMC3WY7nmFIn7VfejIEQMkvzCmF0IosqYWJxPXpTPDRwE+lWB
	 J8CBWQ/bCqDPNOEuZFDk9lMxheGokmDCWFzyeh4g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbgCSOAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 10:00:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55077 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbgCSOAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:00:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id f130so1319332wmf.4;
        Thu, 19 Mar 2020 07:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lrNFdW7aRepYu9YxVvAYTTisKC3Jlwrr96kxm4jQjeE=;
        b=mHC8O6dmLwNLJlkYiYsypQBDe8PgT50ZY0zTcQ0oCZGbJRvw2ycQcFFDPltOHkRx3W
         98JENb57Bnw9babZBamAwin5n2W9tYSaCx/lvghhxkCcwy+MU1YJZkAXgkYKllO6aBac
         MhXruf9MKfLE6eCdCIDob6P5Y6+ZUa6t2u63k+qB4xUIpl1A3c+SE0nJHO8/Nv2YfD3u
         Zb3RWaC4LzQ17OQuHYyQpK6PwT++ytqiOLU44AAGvMbtlbaJ9z8F9Hv/wzr37EfYJ2hP
         K6VtDmYk53KZ1PEGEA1caF7K1wKfZDcVXFo5ipNBpsAZmE+iMvOYRb6ug5IEJEqfzWue
         Uymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=lrNFdW7aRepYu9YxVvAYTTisKC3Jlwrr96kxm4jQjeE=;
        b=WNe6z+wws0ccVtP+NRclfwuXdz2DdSqYghdXVBV++vQFTkGgrz/oJLgw0RmP95WjQl
         KxUQYf7YeiqlOuSHqZgWaM5a8IAZR6SgvGZxx/qesfTW1NwNmGHpT1YPmUW9gHMALPQo
         bZ+sFOhSAKf2OW6M3EEHUmlEuD6AYZTgwqagpLRDwr53LFlj++DgZdCUgJy+NLG0cCoO
         KpgB2lugwzkj8RVbuOYSoksyf2d3qcVwtFWwU0JawB/UPx0wiAAxMbJMBVxjfYcmy1Om
         mdmBmWW9bghVoc8Ttw+cMx0xRlYhsAkJaoylNI0tzH+fq3NoDlJdSezqew44XCoWl6pC
         0NBw==
X-Gm-Message-State: ANhLgQ3tEYdXVyA8Q5EHpbBlfDq4wVC5+l7jemlT5JCdabVlDW8LK24p
        9wXZ5cOaELbwxHydkNzf/2Y=
X-Google-Smtp-Source: ADFU+vtq/ZHLp1pCT0PS3qmqU1fhxWibqR53UWr/MYQTBeqrSvmrD4AHYcW5OA3NSXBKBCgBDWwZLg==
X-Received: by 2002:a1c:1f0c:: with SMTP id f12mr3893362wmf.179.1584626406886;
        Thu, 19 Mar 2020 07:00:06 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id x17sm3250153wmi.28.2020.03.19.07.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 07:00:05 -0700 (PDT)
Date:   Thu, 19 Mar 2020 15:00:03 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexandre Ghiti <alex@ghiti.fr>,
        disconnect3d <dominik.b.czarnota@gmail.com>,
        He Zhe <zhe.he@windriver.com>, Ian Rogers <irogers@google.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf/urgent fixes
Message-ID: <20200319140003.GA52834@gmail.com>
References: <20200309185323.22583-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309185323.22583-1-acme@kernel.org>
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
> The following changes since commit 441b62acd9c809e87bab45ad1d82b1b3b77cb4f0:
> 
>   tools: Fix off-by 1 relative directory includes (2020-03-06 08:36:46 -0300)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-5.6-20200309
> 
> for you to fetch changes up to 1efde2754275dbd9d11c6e0132a4f09facf297ab:
> 
>   perf probe: Do not depend on dwfl_module_addrsym() (2020-03-09 10:43:53 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> perf probe:
> 
>   Masami Hiramatsu:
> 
>   - Fix deletion of multiple probe events.
> 
>   - Fix userspace libraries handling by not depending on dwfl_module_addrsym().
> 
> Event parsing:
> 
>   Ian Rogers:
> 
>   - Fix reading of invalid memory in event parsing.
> 
> python binding:
> 
>   Ilie Halip:
> 
>   - Fix clang detection when using CC=clang-version.
> 
> build:
> 
>   Masami Hiramatsu:
> 
>   - Fix O= use with relative paths.
> 
> Android:
> 
>   Dominik b. Czarnota:
> 
>   - Fix off by one in strncpy() size argument when handling Android
>     libraries.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Ian Rogers (1):
>       perf parse-events: Fix reading of invalid memory in event parsing
> 
> Ilie Halip (1):
>       perf python: Fix clang detection when using CC=clang-version
> 
> Masami Hiramatsu (3):
>       tools: Let O= makes handle a relative path with -C option
>       perf probe: Fix to delete multiple probe event
>       perf probe: Do not depend on dwfl_module_addrsym()
> 
> disconnect3d (1):
>       perf map: Fix off by one in strncpy() size argument
> 
>  tools/perf/Makefile            |  2 +-
>  tools/perf/util/map.c          |  2 +-
>  tools/perf/util/parse-events.c | 46 +++++++++++++++++++++---------------------
>  tools/perf/util/probe-file.c   |  3 +++
>  tools/perf/util/probe-finder.c | 11 +++++++---
>  tools/perf/util/setup.py       | 10 +++++----
>  tools/scripts/Makefile.include |  4 ++--
>  7 files changed, 44 insertions(+), 34 deletions(-)

Pulled into tip:perf/urgent, thanks Arnaldo!

	Ingo
