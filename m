Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6926AC33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 09:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F8B2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 09:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fJcSq0n1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgATJrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 04:47:47 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30400 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726421AbgATJrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 04:47:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579513665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fg1U8qlrVdmoJUUQuabXDtMR+N/go4aNFyOp1Y6SRqU=;
        b=fJcSq0n1lf6TmA7M+sRQC8vT7PDW2maCy7LDo8IZ6khZxoeVjFwSgQqpNCU4GFq7lKlNeA
        0542qwKd8ITfDYmdUMe8btK1gUxN9ew13lZrvhXTJvFSYvWxJ4Jsafyxi8p92etYehIaDB
        oyYiMJbTNv+KVOIrMHHq2+YxodvSgVU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-rrGqycZCNUaz9YnfaAqwFg-1; Mon, 20 Jan 2020 04:47:43 -0500
X-MC-Unique: rrGqycZCNUaz9YnfaAqwFg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C59B8017CC;
        Mon, 20 Jan 2020 09:47:42 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 168C3860E4;
        Mon, 20 Jan 2020 09:47:39 +0000 (UTC)
Date:   Mon, 20 Jan 2020 10:47:37 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v4 3/4] perf util: Flexible to set block info output
 formats
Message-ID: <20200120094737.GF608405@krava>
References: <20200115192904.16798-1-yao.jin@linux.intel.com>
 <20200115192904.16798-3-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115192904.16798-3-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 03:29:03AM +0800, Jin Yao wrote:

SNIP

> +			       block_hpps, nr_hpps);
>  
> -	perf_hpp_list__register_sort_field(&bh->block_list,
> -		&block_fmts[PERF_HPP_REPORT__BLOCK_TOTAL_CYCLES_PCT].fmt);
> +	/* Sort by the first fmt */
> +	perf_hpp_list__register_sort_field(&bh->block_list, &block_fmts[0].fmt);
>  }
>  
> -static void process_block_report(struct hists *hists,
> -				 struct block_report *block_report,
> -				 u64 total_cycles)
> +static int process_block_report(struct hists *hists,
> +				struct block_report *block_report,
> +				u64 total_cycles, int *block_hpps,
> +				int nr_hpps)
>  {
>  	struct rb_node *next = rb_first_cached(&hists->entries);
>  	struct block_hist *bh = &block_report->hist;
>  	struct hist_entry *he;
>  
> -	init_block_hist(bh, block_report->fmts);
> +	if (nr_hpps > PERF_HPP_REPORT__BLOCK_MAX_INDEX)

hum, should be '>=' above.. ?

jirka

