Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B1EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 03:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 257E52078B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 03:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SXMcOFE9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgEVDJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 23:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbgEVDJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 23:09:13 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4DFC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 20:09:12 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id r10so4309413pgv.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 20:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SYThr11VROFvRu+cdpBJm1IFRFr6IJOz9VjNqzlHdcM=;
        b=SXMcOFE97PdF3SHJ+msYl5rNfTNfBGbQ9gJ0PzSswAsKngYg/s9lP0Ol4g10CAyLXs
         /ZmJHQ4FOt55R8Ais99i94r4mlP8Ot3iV1cclZhmKeYIOxOVdwU+gklKqcIoPisXJK+g
         GukHcKybsW14OqI/drckMao2LQE0CJBobNUWYpwMa1tE3GuC3aW8hKFur2GrOJgrbPcN
         ftoZ1gZGbU9CbxZkQMclBMUPBHjXUs5hEW3GmDTzQMsp/fSXpmL/VUQoC9qm9Qoa4+jT
         uwzfHWvSaDcpxsVruBHcBs/1FyNMogHOI7zwbq+YZRE3MoorOJZ/PSTbEV7S2qTp1lA3
         PCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SYThr11VROFvRu+cdpBJm1IFRFr6IJOz9VjNqzlHdcM=;
        b=hFgx97i56JsaEBgvh0YY/CsjRHLsR8T9q90EpAqF+05eJ0ZzDcLrXJ3OfsT2tFX6WM
         HFR+oNVgnqL9qYK/OSYqY44TAS1fyLKmXtxk7xbRgjDPNOPzrLMAZYNMv/lbSMNm4IUu
         gY0dN0jjkSY1QZM4MJJvId6LYbsrwjuGradwrbIaglvczW19uYlSYhobA3uerGoUEtBu
         vw5AxTZ1jSIP4tLSAfN9MYxddpYl/9o67fY31Zt2AXAMMSFJaQfgaXcSC1T/1ibzujUU
         yL6pJDWMxk4i3soBPO4GY7yrCRTDdR9fEeN7qVaD7j/kL3nH6id8kqOVhfUGw4Ax2F7v
         PCPA==
X-Gm-Message-State: AOAM532uTCl2pMNHZkOd89p1JuGBsrDt0mBio15USeO+01Ng7HiuhfA2
        85E00/eX27o8ZDU49o5GK7x40A==
X-Google-Smtp-Source: ABdhPJzME1zTtjy1qck6ek0rBvyojYElvrJ400xhxV9eXHEjIVW3UJyCTtbdTxATHq3NIw4zUj2HIA==
X-Received: by 2002:a63:5fc8:: with SMTP id t191mr11687895pgb.185.1590116951974;
        Thu, 21 May 2020 20:09:11 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id j26sm5448971pfr.215.2020.05.21.20.09.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 May 2020 20:09:11 -0700 (PDT)
Date:   Fri, 22 May 2020 11:09:19 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Al Grant <al.grant@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>
Subject: Re: [PATCH v7 0/3] perf arm-spe: Add support for synthetic events
Message-ID: <20200522030919.GE32389@leoy-ThinkPad-X240s>
References: <20200504115625.12589-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504115625.12589-1-leo.yan@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, May 04, 2020 at 07:56:22PM +0800, Leo Yan wrote:
> This patch set is to support synthetic events with enabling Arm SPE
> decoder.  Since before Xiaojun Tan (Hisilicon) and James Clark (Arm)
> have contributed much for this task, so this patch set is based on their
> privous work and polish for the version 7.
> 
> The main work in this version is to polished the core patch "perf
> arm-spe: Support synthetic events", e.g. rewrite the code to calculate
> ip, packet generation for multiple types (L1 data cache, Last level
> cache, TLB, remote access, etc).  It also heavily refactors code for
> data structure and program flow, which removed unused fields in
> structure and polished the program flow to achieve neat code as
> possible.
> 
> This patch set has been checked with checkpatch.pl, though it leaves
> several warnings, but these warnings are delibarately kept after
> reviewing.  Some warnings ask to add maintainer (so far it's not
> necessary), and some warnings complaint for patch 02 "perf auxtrace:
> Add four itrace options" for the text format, since need to keep the
> consistency with the same code format in the source code, this is why
> this patch doesn't get rid of checkpatch warnings.

Gentle ping ...

It would be appreciate if can get some review for this patch set.

Thanks,
Leo

> Tan Xiaojun (3):
>   perf tools: Move arm-spe-pkt-decoder.h/c to the new dir
>   perf auxtrace: Add four itrace options
>   perf arm-spe: Support synthetic events
> 
>  tools/perf/Documentation/itrace.txt           |   6 +-
>  tools/perf/util/Build                         |   2 +-
>  tools/perf/util/arm-spe-decoder/Build         |   1 +
>  .../util/arm-spe-decoder/arm-spe-decoder.c    | 219 +++++
>  .../util/arm-spe-decoder/arm-spe-decoder.h    |  82 ++
>  .../arm-spe-pkt-decoder.c                     |   0
>  .../arm-spe-pkt-decoder.h                     |  16 +
>  tools/perf/util/arm-spe.c                     | 823 +++++++++++++++++-
>  tools/perf/util/auxtrace.c                    |  17 +
>  tools/perf/util/auxtrace.h                    |  15 +-
>  10 files changed, 1135 insertions(+), 46 deletions(-)
>  create mode 100644 tools/perf/util/arm-spe-decoder/Build
>  create mode 100644 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
>  create mode 100644 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
>  rename tools/perf/util/{ => arm-spe-decoder}/arm-spe-pkt-decoder.c (100%)
>  rename tools/perf/util/{ => arm-spe-decoder}/arm-spe-pkt-decoder.h (64%)
> 
> -- 
> 2.17.1
> 
