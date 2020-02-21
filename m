Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0290EC35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD91C20656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cf1KWWcs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbgBUOpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 09:45:42 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58018 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728668AbgBUOpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 09:45:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582296341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oiG5ghUrte7wKAhNiGRVflPJ7PSvc7lLJT9TU9t3N88=;
        b=cf1KWWcs9tGdqoul9OpML1BS2kXreZ3HZerR06aJGenqi9n8yxpBOUmnN2LSuxAMqJyjJL
        6WgEDwC+lvZTN1d6vSGSVT2rxSfaKv+EpOm7wpeUgC5xYpJ0jgsZUjgokcdbf5yxeyXGj3
        n45fgKWlp81HNfQ46qQv0Bvv5Er5AUE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-j9QjZeQ1PkKFH4ATDOGnlQ-1; Fri, 21 Feb 2020 09:45:37 -0500
X-MC-Unique: j9QjZeQ1PkKFH4ATDOGnlQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E48FC107ACC9;
        Fri, 21 Feb 2020 14:45:35 +0000 (UTC)
Received: from krava (unknown [10.43.17.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D7F2A6E3EE;
        Fri, 21 Feb 2020 14:45:33 +0000 (UTC)
Date:   Fri, 21 Feb 2020 15:45:31 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 2/2] perf annotate: Support interactive annotation of
 code without symbols
Message-ID: <20200221144531.GA657629@krava>
References: <20200221024608.1847-1-yao.jin@linux.intel.com>
 <20200221024608.1847-3-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221024608.1847-3-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 10:46:08AM +0800, Jin Yao wrote:

SNIP

> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/ui/browsers/hists.c | 51 +++++++++++++++++++++++++++++-----
>  tools/perf/util/annotate.h     |  2 ++
>  2 files changed, 46 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
> index f36dee499320..5144528b2931 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -2465,13 +2465,47 @@ do_annotate(struct hist_browser *browser, struct popup_action *act)
>  	return 0;
>  }
>  
> +static struct symbol *new_annotate_sym(u64 addr, struct map *map,
> +				       struct annotation_options *opts)
> +{
> +	struct symbol *sym;
> +	struct annotated_source *src;
> +	char name[64];
> +
> +	snprintf(name, sizeof(name), "%-#.*lx", BITS_PER_LONG / 4, addr);
> +
> +	sym = symbol__new(addr,
> +			  opts->annotate_dummy_len ?
> +			  opts->annotate_dummy_len : ANNOTATION_DUMMY_LEN,

I can't see annotate_dummy_len being set anywhere..

jirka

