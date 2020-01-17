Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1C9C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 12:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E5E02082F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 12:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579264768;
	bh=V9JQ89MenhRIDahBTT5r+ufS8fzK17VCIuTKQTYaIfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d9FZ6qsVQoHNZVKSlr7LKsFxHrtRmM4Y8uSzzDbtCmupCbFCTVpiJ9+qYONpGtRPy
	 LvejSimksA0XMDMwXa6Rwok0p4cSZtf9E5M6IP45+sCIYNK7L/ewDd6LWRmTSS4dze
	 tc+F9qP3d1fReMfWepBNqByGr9UeGbY2TwwgqsLU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgAQMj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 07:39:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:53224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbgAQMj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 07:39:27 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6932920730;
        Fri, 17 Jan 2020 12:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579264766;
        bh=V9JQ89MenhRIDahBTT5r+ufS8fzK17VCIuTKQTYaIfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jaJPazZu/SigkBzXTBjsv060d3X9J2JT0m8OVULDMyaPBfiBIOKi1XEvA3mjCawnp
         kmXkK440fgfk1n4ynXs95xCkp3GjF7w5n1MPXW9jXp4xp2xObqbRd2WKLd/IpPvjjs
         12oeBCyURh2btIIidIosTVYk3wETSsoQIJ966RKA=
Date:   Fri, 17 Jan 2020 12:39:21 +0000
From:   Will Deacon <will@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, nd@arm.com,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Al Grant <al.grant@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Return EINVAL when precise_ip perf events are
 requested on Arm
Message-ID: <20200117123920.GB8199@willie-the-truck>
References: <20200115105855.13395-1-james.clark@arm.com>
 <20200115105855.13395-2-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115105855.13395-2-james.clark@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Wed, Jan 15, 2020 at 10:58:55AM +0000, James Clark wrote:
> ARM PMU events can be delivered with arbitrary skid, and there's
> nothing the kernel can do to prevent this. Given that, the PMU
> cannot support precise_ip != 0.
> 
> Also update comment to state that attr.config field is used to
> set the event type rather than event_id which doesn't exist.

"Also..." is usually a good sign that you should split up the patch. In
this case, you're touching a UAPI header with a questionable clarification,
so I'd definitely rather see that handled separately.

> Signed-off-by: James Clark <james.clark@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Tan Xiaojun <tanxiaojun@huawei.com>
> Cc: Al Grant <al.grant@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/perf/arm_pmu.c          | 3 +++
>  include/uapi/linux/perf_event.h | 4 ++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
> index df352b334ea7..4ddbdb93b3b6 100644
> --- a/drivers/perf/arm_pmu.c
> +++ b/drivers/perf/arm_pmu.c
> @@ -102,6 +102,9 @@ armpmu_map_event(struct perf_event *event,
>  	u64 config = event->attr.config;
>  	int type = event->attr.type;
>  
> +	if (event->attr.precise)
> +		return -EINVAL;

You're right that this is a user-visible change, and I'm pretty nervous
about it to be honest with you.

Perhaps a better way would be to expose something under sysfs, a bit like
the caps directory for the SPE PMU, which identifies the fields of the attr
structure that the driver does not ignore. I think doing this as an Arm-PMU
specific thing initially would be fine, but it would be even better to have
something where a driver can tell perf core about the parts it responds to
and have this stuff populated automatically. The current design makes it
inevitable that PMU drivers will have issues like the one you point out in
the cover letter.

Thoughts?

Will
