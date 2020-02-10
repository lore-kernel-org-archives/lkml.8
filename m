Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A679C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 743F92082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B2G82Roh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgBJMIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:08:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54372 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727754AbgBJMHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:07:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581336459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e2eRuZqsSaScZZo8kRHflKS/ooXKuAQ41Yq4aCVvwEU=;
        b=B2G82Rohi7mN/kp/9ws49OL7fzkIeLYogtqbkMPS30ueDZ1eKT/k7n6ql6OdrEAB06Ii79
        O70pVv8UaKsGhR+RQDVIT5xCs6LV0rFj90G7vTbTHFacV6n2i2iCQSsmLEfszDQVbioHcg
        kAO/JprQwNPsYdB0Ypp7W8kyucr93ho=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-rRbuwR1zN2iFw2chVyWWEw-1; Mon, 10 Feb 2020 07:07:35 -0500
X-MC-Unique: rRbuwR1zN2iFw2chVyWWEw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E9AC13E6;
        Mon, 10 Feb 2020 12:07:33 +0000 (UTC)
Received: from krava (unknown [10.43.17.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 43FCD60BF1;
        Mon, 10 Feb 2020 12:07:30 +0000 (UTC)
Date:   Mon, 10 Feb 2020 13:07:27 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, will@kernel.org, ak@linux.intel.com,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
        james.clark@arm.com, zhangshaokun@hisilicon.com,
        robin.murphy@arm.com
Subject: Re: [PATCH RFC 1/7] perf jevents: Add support for an extra directory
 level
Message-ID: <20200210120727.GD1907700@krava>
References: <1579876505-113251-1-git-send-email-john.garry@huawei.com>
 <1579876505-113251-2-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579876505-113251-2-git-send-email-john.garry@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 10:34:59PM +0800, John Garry wrote:
> Currently we support upto a level 2 directory, and level 2 would be in the
> form vendor/platform.
> 
> Add support for a further level, to hold specific categories of events for
> when we want to segregate them for matching purposes.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  tools/perf/pmu-events/jevents.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> index 079c77b6a2fd..8af05b94a37d 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -960,15 +960,20 @@ static int process_one_file(const char *fpath, const struct stat *sb,
>  	int level   = ftwbuf->level;
>  	int err = 0;
>  
> -	if (level == 2 && is_dir) {
> +	if (level >= 2 && is_dir) {
> +		int count = 0;
>  		/*
>  		 * For level 2 directory, bname will include parent name,
>  		 * like vendor/platform. So search back from platform dir
>  		 * to find this.
> +		 * Something similar for level 3 directory, but we're a PMU
> +		 * category folder, like vendor/platform/cpu.
>  		 */
>  		bname = (char *) fpath + ftwbuf->base - 2;
>  		for (;;) {
>  			if (*bname == '/')
> +				count++;
> +			if (count == level - 1)
>  				break;
>  			bname--;

I was wondering why we just don't use different filename for that,
but it's true that the code transforms directory chain to the table
name.. so I guess another directory level is justified ;-)

jirka


>  		}
> @@ -981,13 +986,13 @@ static int process_one_file(const char *fpath, const struct stat *sb,
>  		 level, sb->st_size, bname, fpath);
>  
>  	/* base dir or too deep */
> -	if (level == 0 || level > 3)
> +	if (level == 0 || level > 4)
>  		return 0;
>  
>  
>  	/* model directory, reset topic */
>  	if ((level == 1 && is_dir && is_leaf_dir(fpath)) ||
> -	    (level == 2 && is_dir)) {
> +	    (level >= 2 && is_dir && is_leaf_dir(fpath))) {
>  		if (close_table)
>  			print_events_table_suffix(eventsfp);
>  
> -- 
> 2.17.1
> 

