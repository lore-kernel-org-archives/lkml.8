Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3BAC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 10:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F287820663
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 10:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ADYpT/no"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbgCRKTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 06:19:33 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:28998 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726786AbgCRKTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 06:19:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584526772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t01fhWNp1IRXO32y9v3L1IxmXyRwLvORUavbkYC8gO4=;
        b=ADYpT/no2EVaCuUjpWuHZNIRY77eX4JqHB8xWXgMsxh47sMb+glK/Qi3xmQ6vxO2zR76QU
        g7DFWBal9yGQE95pLMqMRwWOFAWy0onawcoZFVWQdmxWo3G7VTfEJnx4EUUswJP8zjl2bh
        WPvPggiAXEdq3uc6DI+SWA14UYPbQT4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-BCLxyEjRMZOmdsNyN1yuxA-1; Wed, 18 Mar 2020 06:19:30 -0400
X-MC-Unique: BCLxyEjRMZOmdsNyN1yuxA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F970107ACCC;
        Wed, 18 Mar 2020 10:19:29 +0000 (UTC)
Received: from krava (unknown [10.40.195.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B453B92D0E;
        Wed, 18 Mar 2020 10:19:25 +0000 (UTC)
Date:   Wed, 18 Mar 2020 11:19:15 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 00/14] perf: Stream comparison
Message-ID: <20200318101915.GB821557@krava>
References: <20200313071118.11983-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313071118.11983-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 03:11:04PM +0800, Jin Yao wrote:

SNIP

> 
>  v2:
>  ---
>  Refine the codes for following patches:
>   perf util: Create source line mapping table
>   perf util: Create streams for managing top N hottest callchains
>   perf util: Calculate the sum of all streams hits
>   perf util: Add new block info functions for top N hot blocks comparison 
> 
> Jin Yao (14):
>   perf util: Create source line mapping table
>   perf util: Create streams for managing top N hottest callchains
>   perf util: Return per-event callchain streams
>   perf util: Compare two streams
>   perf util: Calculate the sum of all streams hits
>   perf util: Report hot streams
>   perf diff: Support hot streams comparison
>   perf util: Add new block info functions for top N hot blocks
>     comparison
>   perf util: Add new block info fmts for showing hot blocks comparison
>   perf util: Enable block source line comparison
>   perf diff: support hot blocks comparison
>   perf util: Filter out streams by name of changed functions
>   perf util: Filter out blocks by name of changed functions
>   perf diff: Filter out streams by changed functions

I can't apply this on latest perf/core, do you have it in git tree branch?

thanks,
jirka

> 
>  tools/perf/Documentation/perf-diff.txt |  19 +
>  tools/perf/builtin-diff.c              | 324 ++++++++++++---
>  tools/perf/util/Build                  |   1 +
>  tools/perf/util/block-info.c           | 433 ++++++++++++++++++-
>  tools/perf/util/block-info.h           |  38 +-
>  tools/perf/util/callchain.c            | 517 +++++++++++++++++++++++
>  tools/perf/util/callchain.h            |  34 ++
>  tools/perf/util/srclist.c              | 555 +++++++++++++++++++++++++
>  tools/perf/util/srclist.h              |  74 ++++
>  9 files changed, 1935 insertions(+), 60 deletions(-)
>  create mode 100644 tools/perf/util/srclist.c
>  create mode 100644 tools/perf/util/srclist.h
> 
> -- 
> 2.17.1
> 

