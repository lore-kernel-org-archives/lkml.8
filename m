Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A2EC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 15:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC1F52075E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 15:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dq+RSNrV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgCQPLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 11:11:02 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:55932 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726478AbgCQPLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 11:11:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584457861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W5HQAvbPU4U3uMqTwVbtXlufV8kjT1jXd8mJ+pSamK4=;
        b=dq+RSNrVVfgmdkMj/1djImhaKfO4ZAaNDtbihfWo2vWDt8ZVv4ahmSxxZoXdCdN9nPyVjX
        YXqmi/nrA9GP4Sj3+o8AH/d8YCW6ZbCZxD2DRyFrCnPrJkn6qbEsGatAsLIa++wMEcKTHn
        lrNHMgvJgGH04G85szykRZ+WPhHboY0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-kEnLFVR7PCuI3hiVy5LX1g-1; Tue, 17 Mar 2020 11:11:00 -0400
X-MC-Unique: kEnLFVR7PCuI3hiVy5LX1g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4D28107ACC4;
        Tue, 17 Mar 2020 15:10:56 +0000 (UTC)
Received: from krava (unknown [10.40.195.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BE4073865;
        Tue, 17 Mar 2020 15:10:50 +0000 (UTC)
Date:   Tue, 17 Mar 2020 16:10:47 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     acme@kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        sukadev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, anju@linux.vnet.ibm.com,
        maddy@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com,
        peterz@infradead.org, yao.jin@linux.intel.com, ak@linux.intel.com,
        jolsa@kernel.org, kan.liang@linux.intel.com, jmario@redhat.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com,
        gregkh@linuxfoundation.org, benh@kernel.crashing.org,
        mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com,
        tglx@linutronix.de
Subject: Re: [PATCH v5 09/11] perf/tools: Enhance JSON/metric infrastructure
 to handle "?"
Message-ID: <20200317151047.GF757893@krava>
References: <20200317062333.14555-1-kjain@linux.ibm.com>
 <20200317062333.14555-10-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317062333.14555-10-kjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 11:53:31AM +0530, Kajol Jain wrote:

SBIP

> +static int metricgroup__add_metric_runtime_param(struct strbuf *events,
> +			struct list_head *group_list, struct pmu_event *pe)
> +{
> +	int i, count;
> +	int ret = -EINVAL;
> +
> +	count = arch_get_runtimeparam();
> +
> +	/* This loop is added to create multiple
> +	 * events depend on count value and add
> +	 * those events to group_list.
> +	 */
> +
> +	for (i = 0; i < count; i++) {
> +		const char **ids;
> +		int idnum;
> +		struct egroup *eg;
> +		char value[PATH_MAX];
> +
> +		if (expr__find_other(pe->metric_expr, NULL, &ids, &idnum, i) < 0)
> +			return ret;
> +
> +		if (events->len > 0)
> +			strbuf_addf(events, ",");
> +
> +		if (metricgroup__has_constraint(pe))
> +			metricgroup__add_metric_non_group(events, ids, idnum);
> +		else
> +			metricgroup__add_metric_weak_group(events, ids, idnum);
> +
> +		eg = malloc(sizeof(*eg));
> +		if (!eg) {
> +			ret = -ENOMEM;
> +			return ret;
> +		}
> +
> +		sprintf(value, "%s%c%d", pe->metric_name, '_', i);
> +		eg->ids = ids;
> +		eg->idnum = idnum;
> +		eg->metric_name = strdup(value);
> +		if (!eg->metric_name) {
> +			ret = -ENOMEM;
> +			return ret;
> +		}
> +
> +		eg->metric_expr = pe->metric_expr;
> +		eg->metric_unit = pe->unit;
> +		list_add_tail(&eg->nd, group_list);
> +		ret = 0;
> +
> +		if (ret != 0)
> +			break;

again, this is part of metricgroup__add_metric_param no? why not use it?

jirka

