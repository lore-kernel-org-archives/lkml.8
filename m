Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57126C33C9A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 10:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A0572084D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 10:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ib1umlEe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgAMKKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 05:10:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33701 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726109AbgAMKKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 05:10:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578910246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q1ztglqEyesU+ZKBRLp3ewRaO08AfjJZsrxplPE48f8=;
        b=ib1umlEeJXdflGdxyp4PjDsCftkO0s6CnOpT5GpUhuJQQtTsL6fsOlumPZI6YRMxgm8KyK
        Maw71ML142althUT9O3OEoObXCfF77HJDpfSPJoMgJsZHW8ikQuALcYQ0TZXKRd5ZDX9mg
        Fdr++KXq1qXPzpOv46qDrfi2o8keM80=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-ZvzrmI57M0SbFJ8ZN6RF9g-1; Mon, 13 Jan 2020 05:10:43 -0500
X-MC-Unique: ZvzrmI57M0SbFJ8ZN6RF9g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C344F18B9FD7;
        Mon, 13 Jan 2020 10:10:41 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C229688861;
        Mon, 13 Jan 2020 10:10:39 +0000 (UTC)
Date:   Mon, 13 Jan 2020 11:10:37 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3 3/4] perf util: Flexible to set block info output
 formats
Message-ID: <20200113101037.GF35080@krava>
References: <20200107230354.30132-1-yao.jin@linux.intel.com>
 <20200107230354.30132-3-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107230354.30132-3-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 07:03:53AM +0800, Jin Yao wrote:

SNIP

>  int report__browse_block_hists(struct block_hist *bh, float min_percent,
>  			       struct evsel *evsel, struct perf_env *env,
> -			       struct annotation_options *annotation_opts)
> +			       struct annotation_options *annotation_opts,
> +			       bool release)
>  {
>  	int ret;
>  
> @@ -451,13 +477,17 @@ int report__browse_block_hists(struct block_hist *bh, float min_percent,
>  		symbol_conf.report_individual_block = true;
>  		hists__fprintf(&bh->block_hists, true, 0, 0, min_percent,
>  			       stdout, true);
> -		hists__delete_entries(&bh->block_hists);
> +		if (release)
> +			hists__delete_entries(&bh->block_hists);
> +
>  		return 0;
>  	case 1:
>  		symbol_conf.report_individual_block = true;
>  		ret = block_hists_tui_browse(bh, evsel, min_percent,
>  					     env, annotation_opts);
> -		hists__delete_entries(&bh->block_hists);
> +		if (release)
> +			hists__delete_entries(&bh->block_hists);
> +
>  		return ret;
>  	default:
>  		return -1;
> diff --git a/tools/perf/util/block-info.h b/tools/perf/util/block-info.h
> index bfa22c59195d..0bf01e3a423d 100644
> --- a/tools/perf/util/block-info.h
> +++ b/tools/perf/util/block-info.h
> @@ -44,7 +44,8 @@ enum {
>  struct block_report {
>  	struct block_hist	hist;
>  	u64			cycles;
> -	struct block_fmt	fmts[PERF_HPP_REPORT__BLOCK_MAX_INDEX];
> +	struct block_fmt	*fmts;

hum, couldn't you just keep the array and use it instead of allocating it?
it will never be bigger than PERF_HPP_REPORT__BLOCK_MAX_INDEX, no?

we could get rid of that release code


jirka

