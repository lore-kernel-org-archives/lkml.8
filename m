Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBC3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 18:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8783720739
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 18:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fStVqY29"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbgGPSwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 14:52:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34942 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726986AbgGPSwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 14:52:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594925531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hv8DvK0upvVoTIHsLS9sWiIB7kS2ZyTYYRmQ0XHnu9w=;
        b=fStVqY298RuNUQOi5SzDK+qmX212wV0/dEObX7WDl2GYZ2eGiOKvj+guFsNtK0FMo96d9P
        REI2BtW4lLYvI9HZgkNIzVxbMz9UC9GBtcFsnPktC1Mu6fxeX4zce8eMhOgkFrV9PZtKkg
        M2db2H2CvIvtRAU09XXN0sjB7NVm7u4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-YQgUMFfeNDO1DN3_NOnLzg-1; Thu, 16 Jul 2020 14:52:04 -0400
X-MC-Unique: YQgUMFfeNDO1DN3_NOnLzg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26718800469;
        Thu, 16 Jul 2020 18:52:02 +0000 (UTC)
Received: from krava (unknown [10.40.192.81])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4AE0217D04;
        Thu, 16 Jul 2020 18:51:59 +0000 (UTC)
Date:   Thu, 16 Jul 2020 20:51:58 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 03/18] perf metric: Add expr__add_id function
Message-ID: <20200716185158.GA426898@krava>
References: <20200712132634.138901-1-jolsa@kernel.org>
 <20200712132634.138901-4-jolsa@kernel.org>
 <20200716152906.GC374956@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716152906.GC374956@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 12:29:06PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sun, Jul 12, 2020 at 03:26:19PM +0200, Jiri Olsa escreveu:
> > Adding expr__add_id function to data for ID
> > with zero value, which is used when scanning
> > the expression for IDs.
> > 
> > Acked-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/util/expr.c | 29 +++++++++++++++++++++++------
> >  tools/perf/util/expr.h |  1 +
> >  tools/perf/util/expr.y |  2 +-
> >  3 files changed, 25 insertions(+), 7 deletions(-)
> > 
> > diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> > index 5d05f9765ed8..4b8953605aed 100644
> > --- a/tools/perf/util/expr.c
> > +++ b/tools/perf/util/expr.c
> > @@ -32,6 +32,24 @@ static bool key_equal(const void *key1, const void *key2,
> >  	return !strcmp((const char *)key1, (const char *)key2);
> >  }
> >  
> > +/* Caller must make sure id is allocated */
> > +int expr__add_id(struct expr_parse_ctx *ctx, const char *id)
> > +{
> > +	struct expr_id_data *data_ptr = NULL, *old_data = NULL;
> > +	char *old_key = NULL;
> > +	int ret;
> > +
> > +	data_ptr = malloc(sizeof(*data_ptr));
> > +	if (!data_ptr)
> > +		return -ENOMEM;
> > +
> > +	ret = hashmap__set(&ctx->ids, id, data_ptr,
> > +			   (const void **)&old_key, (void **)&old_data);
> > +	free(old_key);
> > +	free(old_data);
> 
> Hey, if hashmap__set() fails then we leak data_ptr?

right, good catch, will fix

thanks,
jirka

