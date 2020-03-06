Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D906C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 607F7206CC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dNPNTB8t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgCFOKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:10:24 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20937 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726873AbgCFOKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:10:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583503822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TTQGx2tQzO/aOf60DlPPKOJLh+ROpLBlO2kykQtolrk=;
        b=dNPNTB8t/Cd0lc3TV6GAVKvZb4HJ2V2CFoEXYW6+zeiVsinbgpdKwG/lGs6vtb0cUNwTTg
        dqpwvDYMpvxDkIFmFt8gIiqkfwpwlyqmgMl+wRBLJGs09idrrEHzoWosvYqLlsmz4a2W04
        pMeFn5Am9mzkPnlyeWXR7fdxNpeWzAQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-YdgSLRdhOlGkPtr8DUpGaA-1; Fri, 06 Mar 2020 09:10:19 -0500
X-MC-Unique: YdgSLRdhOlGkPtr8DUpGaA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 057728017CC;
        Fri,  6 Mar 2020 14:10:17 +0000 (UTC)
Received: from krava (ovpn-205-205.brq.redhat.com [10.40.205.205])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DB4115D9CD;
        Fri,  6 Mar 2020 14:10:13 +0000 (UTC)
Date:   Fri, 6 Mar 2020 15:10:11 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 06/10] perf report: Add 'cgroup' sort key
Message-ID: <20200306141011.GB290743@krava>
References: <20200224043749.69466-1-namhyung@kernel.org>
 <20200224043749.69466-7-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224043749.69466-7-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 01:37:45PM +0900, Namhyung Kim wrote:

SNIP

> @@ -634,6 +637,39 @@ struct sort_entry sort_cgroup_id = {
>  	.se_width_idx	= HISTC_CGROUP_ID,
>  };
>  
> +/* --sort cgroup */
> +
> +static int64_t
> +sort__cgroup_cmp(struct hist_entry *left, struct hist_entry *right)
> +{
> +	return right->cgroup - left->cgroup;
> +}
> +
> +static int hist_entry__cgroup_snprintf(struct hist_entry *he,
> +				       char *bf, size_t size,
> +				       unsigned int width __maybe_unused)
> +{
> +	const char *cgrp_name = "N/A";
> +
> +	if (he->cgroup) {
> +		struct cgroup *cgrp = cgroup__find(he->ms.maps->machine->env,

eveything is connected :)) great that this one works

jirka

