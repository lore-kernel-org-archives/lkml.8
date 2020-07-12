Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71E2C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 18:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD8D7206F0
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 18:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fymeA/xz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbgGLS47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 14:56:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50703 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729210AbgGLSzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 14:55:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594580135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f/HFyDvl3nBOP/x8iGrEonXHy4qeta+b9wCOuC0pUxY=;
        b=fymeA/xzdKmAMbWjfNfFjbCwnw+nIEyp7J4ASIuRqMwjFJvHbVAH04ESiSaYvlwqKmIoGL
        rkjfBl53Amfa5u9Ka36z9s3tJFuULqIhqy7Qk2KJJhZNA/FH5aRyPsObAExHBrmUz+sefF
        s+P2mYiYVTCbvRQa9Nmo7n8uJSU7oko=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-OpOHEaUJPgS6EGJrfoYLew-1; Sun, 12 Jul 2020 14:55:31 -0400
X-MC-Unique: OpOHEaUJPgS6EGJrfoYLew-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3A68800FF1;
        Sun, 12 Jul 2020 18:55:28 +0000 (UTC)
Received: from krava (unknown [10.40.192.24])
        by smtp.corp.redhat.com (Postfix) with SMTP id 824F85BAD5;
        Sun, 12 Jul 2020 18:55:24 +0000 (UTC)
Date:   Sun, 12 Jul 2020 20:55:23 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        pc@us.ibm.com, namhyung@kernel.org, ak@linux.intel.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com,
        anju@linux.vnet.ibm.com, kan.liang@linux.intel.com,
        nasastry@in.ibm.com
Subject: Re: [RFC v2 3/5] perf jevents: Add support for parsing
 perchip/percore events
Message-ID: <20200712185523.GA147742@krava>
References: <20200707122314.624400-1-kjain@linux.ibm.com>
 <20200707122314.624400-4-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707122314.624400-4-kjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 05:53:12PM +0530, Kajol Jain wrote:
> Added the "PerChip" field  in enum so that perf knows they are
> per chip events.
> 
> Added the "PerCore" field in enum so that perf knows they are
> per core events and add these fields to pmu_event structure.
> 
> Similar to the way we had "PerPkg field
> to specify perpkg events.
> 
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> ---
>  tools/perf/pmu-events/jevents.c    | 8 +++++++-
>  tools/perf/pmu-events/pmu-events.h | 4 +++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> index b2f59f0af63d..1f65047db000 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -54,13 +54,19 @@ int verbose;
>  char *prog;
>  
>  enum aggr_mode_class {
> -	PerPkg = 1
> +	PerChip = 0,

is there a reason for the values? just wonder if it's wise to have PerChip == 0,
and why you would not continue with forward when PerPkg is 1

jirka

> +	PerPkg = 1,
> +	PerCore = 2
>  };
>  

SNIP

