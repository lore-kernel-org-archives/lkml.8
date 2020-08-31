Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DF5C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 13:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C4EA208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 13:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TOQdblEl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgHaN4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 09:56:24 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41908 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727066AbgHaN4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 09:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598882176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xBjZRrtnn2DymOUf25LFqlHNqeGn8G4I2kGQPVNxJtk=;
        b=TOQdblElVmSZs1exXJkedbWPH2bboHuygHes0IwBT58wYyF4w4gzA/ldlODZe+trA2glWf
        sivE7TUFTNFuGxdWucdmby78mBBErQupyShzi/IDAxvE6LAkSHCPyBCfBFUpYsuzIVRgu2
        qmX+G5fH6jT257yEdCvaq+7Ea+LOMAo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-DLJnIK9QPMSrShr4w4i1Uw-1; Mon, 31 Aug 2020 09:56:14 -0400
X-MC-Unique: DLJnIK9QPMSrShr4w4i1Uw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5A81802B60;
        Mon, 31 Aug 2020 13:56:12 +0000 (UTC)
Received: from krava (unknown [10.40.192.186])
        by smtp.corp.redhat.com (Postfix) with SMTP id 575111002391;
        Mon, 31 Aug 2020 13:56:10 +0000 (UTC)
Date:   Mon, 31 Aug 2020 15:56:09 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v4 1/7] perf util: Create streams
Message-ID: <20200831135609.GE406859@krava>
References: <20200824233513.16930-1-yao.jin@linux.intel.com>
 <20200824233513.16930-2-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824233513.16930-2-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 07:35:07AM +0800, Jin Yao wrote:

SNIP

> +						  int nr_streams_max,
> +						  enum stream_type type)
> +{
> +	struct evsel_streams *es;
> +	int nr_evsel = evlist->core.nr_entries, ret = -1;
> +
> +	es = create_evsel_streams(nr_evsel, nr_streams_max);
> +	if (!es)
> +		return NULL;
> +
> +	if (type == STREAM_CALLCHAIN)
> +		ret = evlist_init_callchain_streams(evlist, es, nr_evsel);
> +
> +	if (ret) {
> +		free_evsel_streams(es, nr_evsel);
> +		return NULL;
> +	}
> +
> +	return es;
> +}
> diff --git a/tools/perf/util/stream.h b/tools/perf/util/stream.h
> new file mode 100644
> index 000000000000..a8a0172b4d13
> --- /dev/null
> +++ b/tools/perf/util/stream.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __PERF_STREAM_H
> +#define __PERF_STREAM_H
> +
> +#include "callchain.h"
> +
> +enum stream_type {
> +	STREAM_NONE = 0,
> +	STREAM_CALLCHAIN

do you plan to add more types?

jirka

