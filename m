Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01171C55199
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C740F2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hgpwnDjB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgD0IQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 04:16:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34268 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726349AbgD0IQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 04:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587975397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CrUCqEccXog6ceJqozxwcXd9+SC0GQqpdsx1sfvo64g=;
        b=hgpwnDjB0BnJk5lfDybpgKDC6Jqzuqrv6RGO3kVcpq4u1rrj7irszFi+o4pohIRPgw/VHg
        067Y2MOf4/j196adQ7DOhrEzbLontP+7W11ciRzvkvkOPuiWohTl7khnq/pUO6IUuyo+5d
        2Wb2uwYezA1zoN2IYCMTWoAA0FIUNpM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-96OCTOndNQy3OiO-jA86qg-1; Mon, 27 Apr 2020 04:16:32 -0400
X-MC-Unique: 96OCTOndNQy3OiO-jA86qg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 647908015CE;
        Mon, 27 Apr 2020 08:16:30 +0000 (UTC)
Received: from krava (unknown [10.40.195.65])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E219D5D9DA;
        Mon, 27 Apr 2020 08:16:26 +0000 (UTC)
Date:   Mon, 27 Apr 2020 10:16:24 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, will@kernel.org, ak@linux.intel.com,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        qiangqing.zhang@nxp.com, irogers@google.com, robin.murphy@arm.com,
        zhangshaokun@hisilicon.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v2 01/13] perf parse-events: Fix comparison of evsel
 and leader pmu name
Message-ID: <20200427081624.GA1431639@krava>
References: <1587120084-18990-1-git-send-email-john.garry@huawei.com>
 <1587120084-18990-2-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587120084-18990-2-git-send-email-john.garry@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 06:41:12PM +0800, John Garry wrote:
> Since we now strdup() the pmu name for the event selector, use strcmp()
> instead of pointer equality for comparison.
> 
> Fixes: d4953f7ef1a2 ("perf parse-events: Fix 3 use after frees found with clang ASANutil/parse-events.c")
> Signed-off-by: John Garry <john.garry@huawei.com>

I don't ee this change in your branch:
  private-topic-perf-5.6-sys-pmu-events-v2-upstream

do you have some updated tree?

thanks,
jirka

> ---
> 
> I am not 100% sure that this is the right fix....
> 
>  tools/perf/util/parse-events.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 10107747b361..90ddade1ba23 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1629,7 +1629,7 @@ parse_events__set_leader_for_uncore_aliase(char *name, struct list_head *list,
>  		 * event. That can be used to distinguish the leader from
>  		 * other members, even they have the same event name.
>  		 */
> -		if ((leader != evsel) && (leader->pmu_name == evsel->pmu_name)) {
> +		if ((leader != evsel) && !strcmp(leader->pmu_name, evsel->pmu_name)) {
>  			is_leader = false;
>  			continue;
>  		}
> -- 
> 2.16.4
> 

