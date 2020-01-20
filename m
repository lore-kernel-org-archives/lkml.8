Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0FDC33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 09:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80FE8207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 09:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GX7MwzAa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgATJrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 04:47:43 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40265 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726039AbgATJrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 04:47:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579513659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6kBzDi7SFKdEvqr6Y4JWqyNRLKTU/UBLtrUhTeIHOSw=;
        b=GX7MwzAakGgm35D2Vs/HfuFxG8kCzJ/FpLf+3Zn9ve/tFE3iSYtRJdrkoSRkVISIGs1mfP
        /q4rK+3v5jvRehojgo5f1d/qG3DnenUvcDAXkni7q8GFVEZgzodjIPyoFijgBCqI+JaZZA
        kDoyGhkam7WDGuRCKMg3Vq/QnhCuEtM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-4FCYWnCjOGWqsi5Gj1D98w-1; Mon, 20 Jan 2020 04:47:36 -0500
X-MC-Unique: 4FCYWnCjOGWqsi5Gj1D98w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6FE1B8017CC;
        Mon, 20 Jan 2020 09:47:34 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 580C35D9D6;
        Mon, 20 Jan 2020 09:47:32 +0000 (UTC)
Date:   Mon, 20 Jan 2020 10:47:29 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v4 3/4] perf util: Flexible to set block info output
 formats
Message-ID: <20200120094729.GE608405@krava>
References: <20200115192904.16798-1-yao.jin@linux.intel.com>
 <20200115192904.16798-3-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115192904.16798-3-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 03:29:03AM +0800, Jin Yao wrote:

SNIP

>  }
>  
> +void block_info__free_report(struct block_report *reps, int nr_reps)
> +{
> +	for (int i = 0; i < nr_reps; i++)
> +		hists__delete_entries(&reps[i].hist.block_hists);
> +
> +	free(reps);
> +}
> +
>  int report__browse_block_hists(struct block_hist *bh, float min_percent,
>  			       struct evsel *evsel, struct perf_env *env,
> -			       struct annotation_options *annotation_opts)
> +			       struct annotation_options *annotation_opts,
> +			       bool release)
>  {
>  	int ret;
>  
> @@ -451,13 +473,17 @@ int report__browse_block_hists(struct block_hist *bh, float min_percent,
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

I don't understand this change.. why do you relase it in here?
there's release call in block_info__free_report you just added...

jirka

