Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991D4C11D04
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 11:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C2E92071E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 11:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ax4tPD2Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbgBTLfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 06:35:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28916 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726825AbgBTLfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 06:35:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582198540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qLmJc92NAYctHXMZ0dWlfak7zr37dopUurK0FZ6BiyY=;
        b=Ax4tPD2QT9s2/A3w8V7KdXQPH29k/se/hAqpspg24larzfRgzTIII7OTPUetmxCns3yw+B
        TLDSwrg/2nRGUlzOaiwLQoDavPBelEDNy39g8Xip5r8EF2CCpg7AKQbE6B+RMtvVEGt9Mw
        fUd+HIhJGOwL0HboCxflN1RFVIW+4lg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-Z8jsiTzxP1-xQMUA42qMeA-1; Thu, 20 Feb 2020 06:35:36 -0500
X-MC-Unique: Z8jsiTzxP1-xQMUA42qMeA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4699801E6D;
        Thu, 20 Feb 2020 11:35:34 +0000 (UTC)
Received: from krava (unknown [10.43.17.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AD2E35C219;
        Thu, 20 Feb 2020 11:35:32 +0000 (UTC)
Date:   Thu, 20 Feb 2020 12:35:30 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        namhyung@kernel.org, ravi.bangoria@linux.ibm.com,
        yao.jin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH 4/5] perf metricgroup: Support metric constraint
Message-ID: <20200220113530.GA565976@krava>
References: <1582139320-75181-1-git-send-email-kan.liang@linux.intel.com>
 <1582139320-75181-5-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582139320-75181-5-git-send-email-kan.liang@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 11:08:39AM -0800, kan.liang@linux.intel.com wrote:

SNIP

> +static bool violate_nmi_constraint;
> +
> +static bool metricgroup__has_constraint(struct pmu_event *pe)
> +{
> +	if (!pe->metric_constraint)
> +		return false;
> +
> +	if (!strcmp(pe->metric_constraint, "NO_NMI_WATCHDOG") &&
> +	    sysctl__nmi_watchdog_enabled()) {
> +		pr_warning("Splitting metric group %s into standalone metrics.\n",
> +			   pe->metric_name);
> +		violate_nmi_constraint = true;

no static flags plz.. can't you just print that rest of the warning in here?

jirka

> +		return true;
> +	}
> +
> +	return false;
> +}
> +
>  static int metricgroup__add_metric(const char *metric, struct strbuf *events,
>  				   struct list_head *group_list)
>  {
> @@ -460,7 +490,10 @@ static int metricgroup__add_metric(const char *metric, struct strbuf *events,
>  			if (events->len > 0)
>  				strbuf_addf(events, ",");
>  
> -			metricgroup__add_metric_weak_group(events, ids, idnum);
> +			if (metricgroup__has_constraint(pe))
> +				metricgroup__add_metric_non_group(events, ids, idnum);
> +			else
> +				metricgroup__add_metric_weak_group(events, ids, idnum);
>  
>  			eg = malloc(sizeof(struct egroup));
>  			if (!eg) {
> @@ -544,6 +577,13 @@ int metricgroup__parse_groups(const struct option *opt,
>  	strbuf_release(&extra_events);
>  	ret = metricgroup__setup_events(&group_list, perf_evlist,
>  					metric_events);
> +
> +	if (violate_nmi_constraint) {
> +		pr_warning("Try disabling the NMI watchdog to comply NO_NMI_WATCHDOG metric constraint:\n"
> +			   "    echo 0 > /proc/sys/kernel/nmi_watchdog\n"
> +			   "    perf stat ...\n"
> +			   "    echo 1 > /proc/sys/kernel/nmi_watchdog\n");
> +	}
>  out:
>  	metricgroup__free_egroups(&group_list);
>  	return ret;
> -- 
> 2.7.4
> 

