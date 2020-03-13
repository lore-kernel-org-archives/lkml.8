Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C64C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 11:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8D620749
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 11:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgCMLxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 07:53:04 -0400
Received: from foss.arm.com ([217.140.110.172]:53476 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbgCMLxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 07:53:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9724D30E;
        Fri, 13 Mar 2020 04:53:03 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6E923F534;
        Fri, 13 Mar 2020 04:53:02 -0700 (PDT)
Date:   Fri, 13 Mar 2020 11:53:00 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     James Clark <james.clark@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nd@arm.com
Subject: Re: [PATCH v6 0/3] perf tools: Add support for some spe events
Message-ID: <20200313115300.GE42546@lakrids.cambridge.arm.com>
References: <20200228160126.GI36089@lakrids.cambridge.arm.com>
 <20200306152520.28233-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306152520.28233-1-james.clark@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 03:25:17PM +0000, James Clark wrote:
> Hi Mark,
> 
> Yes I think this is something I can look into. For now I have removed
> that last patch because the current patch set already works very similarly anyway
> and allows people to use SPE in perf:
> 
>     ./perf record -e arm_spe_0/branch_filter=1/
> vs
>     ./perf record -e arm_spe/branch-misses/pp

Thanks, FWIW that looks fine to me.

> Also I don't have access to any big.LITTLE hardware with SPE so wouldn't be able
> to test collating all the SPE PMUs.

Likewise, I just want to make sure we don't back ourselves into a
corner.

Otherwise, I have no comments on these patches, so feel free to take
that as:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> 
> Thanks
> James
> 
> Tan Xiaojun (3):
>   perf tools: Move arm-spe-pkt-decoder.h/c to the new dir
>   perf tools: Add support for "report" for some spe events
>   perf report: Add SPE options to --itrace argument
> 
>  tools/perf/Documentation/itrace.txt           |   5 +-
>  tools/perf/util/Build                         |   2 +-
>  tools/perf/util/arm-spe-decoder/Build         |   1 +
>  .../util/arm-spe-decoder/arm-spe-decoder.c    | 225 ++++++
>  .../util/arm-spe-decoder/arm-spe-decoder.h    |  66 ++
>  .../arm-spe-pkt-decoder.c                     |   0
>  .../arm-spe-pkt-decoder.h                     |   2 +
>  tools/perf/util/arm-spe.c                     | 747 +++++++++++++++++-
>  tools/perf/util/auxtrace.c                    |  13 +
>  tools/perf/util/auxtrace.h                    |  13 +-
>  10 files changed, 1032 insertions(+), 42 deletions(-)
>  create mode 100644 tools/perf/util/arm-spe-decoder/Build
>  create mode 100644 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
>  create mode 100644 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
>  rename tools/perf/util/{ => arm-spe-decoder}/arm-spe-pkt-decoder.c (100%)
>  rename tools/perf/util/{ => arm-spe-decoder}/arm-spe-pkt-decoder.h (96%)
> 
> -- 
> 2.17.1
> 
