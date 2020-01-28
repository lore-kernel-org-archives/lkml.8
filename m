Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4C1C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 10:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A8924687
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 10:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aQ3O6RJ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgA1KDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 05:03:04 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28765 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725922AbgA1KDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 05:03:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580205782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j1ApVnFKF54H0Bn6j53a2xKBCh+sUc/hn1ubA2FVy+o=;
        b=aQ3O6RJ6SPoV2InEitXyYiJXeVEbkl/FEYv17j1Bg1Yut/aed/0Jh7v1t5K4EzqHW1p+7o
        ZvAsrlkZQmhZ2Gyy0Zl6A2JkUzYZr10JINu2OzjMgt1DCVCkJ8PW/TfB1wemYWz+TK5wQD
        yTgIBOviiqWPysYWKio2LsX0Dx/O+XU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-DebLEWeKNLC0nyIisusGmg-1; Tue, 28 Jan 2020 05:02:58 -0500
X-MC-Unique: DebLEWeKNLC0nyIisusGmg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7454B13E4;
        Tue, 28 Jan 2020 10:02:57 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A710100EBA9;
        Tue, 28 Jan 2020 10:02:56 +0000 (UTC)
Date:   Tue, 28 Jan 2020 11:02:54 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] perf tools: Add machine pointer to struct hists
Message-ID: <20200128100254.GD1209308@krava>
References: <20200127143443.89060-1-namhyung@kernel.org>
 <20200128004213.106098-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128004213.106098-1-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 09:42:13AM +0900, Namhyung Kim wrote:

SNIP

> +struct perf_session;
>  
>  static inline struct perf_cpu_map *evsel__cpus(struct evsel *evsel)
>  {
> @@ -145,32 +146,43 @@ void perf_evsel__compute_deltas(struct evsel *evsel, int cpu, int thread,
>  				struct perf_counts_values *count);
>  
>  int perf_evsel__object_config(size_t object_size,
> -			      int (*init)(struct evsel *evsel),
> -			      void (*fini)(struct evsel *evsel));
> +			      int (*init)(struct evsel *evsel,
> +					  struct perf_session *session),
> +			      void (*fini)(struct evsel *evsel,
> +					   struct perf_session *session));
>  
> -struct evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx);
> +struct evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx,
> +				  struct perf_session *session);
>  
>  static inline struct evsel *evsel__new(struct perf_event_attr *attr)
>  {
> -	return perf_evsel__new_idx(attr, 0);
> +	return perf_evsel__new_idx(attr, 0, NULL);
>  }
>  
> -struct evsel *perf_evsel__newtp_idx(const char *sys, const char *name, int idx);
> +static inline struct evsel *evsel__new2(struct perf_event_attr *attr,
> +					struct perf_session *session)
> +{
> +	return perf_evsel__new_idx(attr, 0, session);
> +}

I'm not sure about perf_session as an argument to get machine,
it seems ok but not for the case in perf_event__process_attr
where you call evsel__new and have no way to get perf_sesion
I think... and I think you need to set it up in there for
the pipe workflow to work with your new sort fields

maybe we could be find with just perf_env pointer there?
but perf_session makes more sense to me.. maybe we could
change event_attr_op to pass it as an argument..

jirka

