Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160CEC2D0EC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 13:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E087E20733
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 13:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKWIYBDl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbgC3NLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 09:11:34 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:42217 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730209AbgC3NLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 09:11:33 -0400
Received: by mail-qv1-f65.google.com with SMTP id ca9so8820600qvb.9;
        Mon, 30 Mar 2020 06:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CXXurTUII8VpB0EcDM75dl6fLEYv6VVhn5KbPydNUXc=;
        b=LKWIYBDltwZUlJG6CutAT4jIkX3wXfKAakiTDQHE8Gycgme/ttLbZBrPdxVt1br5iW
         BYOUb7zO9A6X/e2olDbr3LssTnVNrFarh1bKEhiTM+9bKZ1UOE2D8VFBHy0ypca2T/9m
         apEGb1sDjTyXthtU46eEy2Z7si6xbk1wgs0uUjiTmAhQFOZyDf9sRAL5jfdYE0iBeL+t
         YrQmyH112vCrp/G9bGyBGSlsfunLhFSIhP5SjT2jkVaNxdSAXAU15AyttacA40V8Ybb7
         OyxX4K7PHO/dXWW/KmRira7TzZ6fWIVB5X0XSsHzY/lsSL31Hl1h9j1KqGeScGDVi/9P
         yrzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CXXurTUII8VpB0EcDM75dl6fLEYv6VVhn5KbPydNUXc=;
        b=AS3VNEaENUqfsRAln8Ctw2o48Fea3+tmUZX6ThM2H0IzvW00s/zd/GAoUr4RpDlQAc
         mrJAAzVWTjikemR4sraAsA8yjuFT0ioBG6ZlLpYfR8V+Q4HINwu5nVVz8AoQeRlMoznx
         YjLYudqoBaaKvJHsRm3vfOgLMvQTq+tWqJCPp7xW5y5qi4JURCFPR91cxNWuDgYxEpRn
         9MBU8lPERlh0eOGVTfhZbEpb75KjUMxqOPEZcvXX42XLmihWdwiSyOyT1kIXdw1o0vQB
         WmftxGdL9y4pgbCipar7dpSu0T9oN3sLYaYbHSNFVgR3pKOCprQyJFgCiJBF+cJoE6NV
         GOHQ==
X-Gm-Message-State: ANhLgQ2AyPA6johfF+Q+Z6Qp1WKvVyez875suX0T19nIK4gZOGQ58qwv
        Cw3qTEkO84DRimfsruy9YT4=
X-Google-Smtp-Source: ADFU+vuyODo7GtN0g7PIPraF7IzDWDNCoduQtbSJwyrA275BZnVxNAS0W6EnmzFI4zkeE5XW6cHcUQ==
X-Received: by 2002:ad4:4564:: with SMTP id o4mr11225914qvu.190.1585573892199;
        Mon, 30 Mar 2020 06:11:32 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id k15sm11437005qta.74.2020.03.30.06.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 06:11:31 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 780CF409A3; Mon, 30 Mar 2020 10:11:29 -0300 (-03)
Date:   Mon, 30 Mar 2020 10:11:29 -0300
To:     Kemeng Shi <shikemeng@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, ndesaulniers@google.com, irogers@google.com,
        tmricht@linux.ibm.com, hushiyuan@huawei.com, hewenliang4@huawei.com
Subject: Re: [PATCH] perf report: Fix arm64 gap between kernel start and
 module end
Message-ID: <20200330131129.GB31702@kernel.org>
References: <33fd24c4-0d5a-9d93-9b62-dffa97c992ca@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33fd24c4-0d5a-9d93-9b62-dffa97c992ca@huawei.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 30, 2020 at 03:41:11PM +0800, Kemeng Shi escreveu:
> diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
> index 393b9895c..37cbfa5e9 100644
> --- a/tools/perf/arch/arm64/util/Build
> +++ b/tools/perf/arch/arm64/util/Build
> @@ -2,6 +2,7 @@ libperf-y += header.o
>  libperf-y += tsc.o
>  libperf-y += sym-handling.o
>  libperf-y += kvm-stat.o
> +libperf-y += machine.o

You made the patch against an old perf codebase, right? This libperf-y
above was changed to perf-y here:

commit 5ff328836dfde0cef9f28c8b8791a90a36d7a183
Author: Jiri Olsa <jolsa@kernel.org>
Date:   Wed Feb 13 13:32:39 2019 +0100

    perf tools: Rename build libperf to perf

----

I'm fixing this up, please check my perf/core branch later to see that
all is working as intended.

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/core

Thanks,

- Arnaldo
