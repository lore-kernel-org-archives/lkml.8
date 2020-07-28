Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB9BC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C5BC206D8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595937988;
	bh=VjlZKWySxSm5VN8yvVvYTwfkkPxhewC1SM+Xxm1RqDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lYXgdalJLbVOKSrOIcDv+rYxIC9laMN0PxXB0QtQCIgzvRyMb21jkWRiYFRci3TZf
	 Th4kqjeQ8VEZUxCfNxGgwqSCe5VT+eu1dzeknaJT8ZxTzY4cUj0Z1aeBIgEhK21lTJ
	 P619Nl+pI7VrLWvG2q5s4i+nSyYwc1PAZGCUes8Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbgG1MG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:06:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:33770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728560AbgG1MG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:06:26 -0400
Received: from quaco.ghostprotocols.net (179.176.1.55.dynamic.adsl.gvt.net.br [179.176.1.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B9992065E;
        Tue, 28 Jul 2020 12:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595937985;
        bh=VjlZKWySxSm5VN8yvVvYTwfkkPxhewC1SM+Xxm1RqDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mBYXh1fJmvzaHI49+06lNNIiZ8bvwg3ABOM+2yR6BJhDAbvmTVy9xIXtDwb+I85mJ
         kCo++lAGfBsj7OiFrSRZc+fbhq5kKSafZQQwgYVdblwnQJcCexZQwmryK9090yrpOg
         sVDDRHra8aGRZXrFkJNEMWoBF5tij+FPsDkvPxNQ=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 67190404B1; Tue, 28 Jul 2020 09:06:23 -0300 (-03)
Date:   Tue, 28 Jul 2020 09:06:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Wei Li <liwei391@huawei.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Clark <james.clark@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>, zhangshaokun@hisilicon.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, guohanjun@huawei.com
Subject: Re: [PATCH 0/4] Add support for ARMv8.3-SPE
Message-ID: <20200728120623.GB40195@kernel.org>
References: <20200724091607.41903-1-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724091607.41903-1-liwei391@huawei.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jul 24, 2020 at 05:16:03PM +0800, Wei Li escreveu:
> The ARMv8.3-SPE adds an Alignment Flag in the Events packet and filtering
> on this event using PMSEVFR_EL1, together with support for the profiling
> of Scalable Vector Extension operations.

Leo, Matthieu, have you had the time to review this? I can take the
tools/ part, the kernel bits should go via the ARM tree or via PeterZ,

- Arnaldo
 
> Patch 1: Update the kernel driver, mainly for PMSEVFR_EL1.
> 
> Patch 2: Update the decode process of Events packet and Operation Type
>   packet in perf tool.
> 
> Patch 3-4: Synthesize unaligned address access events and partial/empty
>   predicated SVE events, also add two itrace options for filtering.
> 
> Wei Li (4):
>   drivers/perf: Add support for ARMv8.3-SPE
>   perf: arm-spe: Add support for ARMv8.3-SPE
>   perf auxtrace: Add new itrace options for ARMv8.3-SPE
>   perf: arm-spe: Synthesize new events for ARMv8.3-SPE
> 
>  arch/arm64/include/asm/sysreg.h               |  4 +-
>  drivers/perf/arm_spe_pmu.c                    | 18 +++--
>  tools/perf/Documentation/itrace.txt           |  2 +
>  .../util/arm-spe-decoder/arm-spe-decoder.c    | 11 +++
>  .../util/arm-spe-decoder/arm-spe-decoder.h    |  3 +
>  .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 69 ++++++++++++++++++-
>  tools/perf/util/arm-spe.c                     | 61 ++++++++++++++++
>  tools/perf/util/auxtrace.c                    |  8 +++
>  tools/perf/util/auxtrace.h                    |  4 ++
>  9 files changed, 173 insertions(+), 7 deletions(-)
> 
> -- 
> 2.17.1
> 

-- 

- Arnaldo
