Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECF7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 11:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE45020663
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 11:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E5KpWpyj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731434AbgEZLwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 07:52:05 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23632 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728151AbgEZLwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 07:52:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590493923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kGqfEvhWTPSqXGM9TjyWjjJ/kDweyaDjV3KoggQJ9Zs=;
        b=E5KpWpyj5WPW2GHDezOs2oYspiXmW9kfbe43TjSoEokB9iFskNH6HFdQicuwUm3dOgoYYo
        ZDFgukfp+1hitJsOxwXBZdpeXu8jlFhhgMalzRyb0ZbWGL0DKUH6fYla/uObxNK0cCf1mQ
        NJJSTOv3KIkfi4BRy2qSwhWbOROJmDY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-tg8DbXsVM9ah9suJmQKElw-1; Tue, 26 May 2020 07:52:00 -0400
X-MC-Unique: tg8DbXsVM9ah9suJmQKElw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A12E1005510;
        Tue, 26 May 2020 11:51:58 +0000 (UTC)
Received: from krava (unknown [10.40.195.156])
        by smtp.corp.redhat.com (Postfix) with SMTP id 426355C1BB;
        Tue, 26 May 2020 11:51:56 +0000 (UTC)
Date:   Tue, 26 May 2020 13:51:55 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 1/2] perf evlist: Ensure grouped events with same cpu
 map
Message-ID: <20200526115155.GE333164@krava>
References: <20200525065559.6422-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525065559.6422-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 02:55:58PM +0800, Jin Yao wrote:

SNIP

> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 2a9de6491700..1161cffc0688 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -1704,3 +1704,52 @@ struct evsel *perf_evlist__reset_weak_group(struct evlist *evsel_list,
>  	}
>  	return leader;
>  }
> +
> +static bool cpus_map_matched(struct evsel *prev, struct evsel *evsel)
> +{
> +	if (evsel->core.cpus->nr != prev->core.cpus->nr)
> +		return false;
> +
> +	for (int i = 0; i < evsel->core.cpus->nr; i++) {
> +		if (evsel->core.cpus->map[i] != prev->core.cpus->map[i])
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
> +bool evlist__cpus_map_matched(struct evlist *evlist)
> +{
> +	struct evsel *prev = evlist__first(evlist), *evsel = prev;
> +	int nr_members = prev->core.nr_members;
> +
> +	evlist__for_each_entry_continue(evlist, evsel) {
> +		if (nr_members <= 1) {
> +			prev = evsel;
> +			nr_members = evsel->core.nr_members;
> +			continue;
> +		}
> +
> +		nr_members--;
> +
> +		if (!cpus_map_matched(prev, evsel))
> +			return false;
> +
> +		prev = evsel;
> +	}
> +
> +	return true;
> +}
> +
> +void evlist__force_disable_group(struct evlist *evlist)
> +{
> +	struct evsel *evsel;
> +
> +	pr_warning("WARNING: event cpu maps are not fully matched, "
> +		   "stop event grouping\n");
> +
> +	evlist__for_each_entry(evlist, evsel) {
> +		evsel->leader = evsel;
> +		evsel->core.nr_members = 0;
> +	}
> +}

I think this is too much, we need to disable only groups with not
matching cpus, not all of them, how about something like this


        struct evsel *pos;

        evlist__for_each_entry(evlist, evsel) {
                if (evsel->leader == evsel)
                        continue;
                if (!cpus_map_matched(evsel->leader, evsel))
                        continue;
                        
                pr_warn("Disabling group...

                for_each_group_member(pos, evsel->leader) {
                        pos->leader = pos;
                        evsel->core.nr_members = 0;
                }
        }

jirka

