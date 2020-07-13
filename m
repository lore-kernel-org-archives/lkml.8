Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE25C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 16:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11AB52067D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 16:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0g0m2Hs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730340AbgGMQ4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 12:56:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33523 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729751AbgGMQ4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 12:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594659381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zhbk/UAwQj549JRj3+RaAGwYTtXDrPNunb4lWnrp4Q0=;
        b=U0g0m2HsLwO+zwFui71DfTdV5TmTC0FPBYadypmBUarIfAqnILki0moUdyaviAqp8QV/mA
        XRIwNL8OyXdP7lpTDJyPn0r1gCyfAjwTiTTEOkqr4Cvf27CAZPuege+BUFwGtGZrjCU5TO
        pPdFB2ysxw+0ye/JlEki1tZQSX3O7rQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-I4HWmZ48OuiUcwtUuKK2sg-1; Mon, 13 Jul 2020 12:56:17 -0400
X-MC-Unique: I4HWmZ48OuiUcwtUuKK2sg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1082885D980;
        Mon, 13 Jul 2020 16:56:15 +0000 (UTC)
Received: from krava (unknown [10.40.192.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB88B5C1D0;
        Mon, 13 Jul 2020 16:56:11 +0000 (UTC)
Date:   Mon, 13 Jul 2020 18:56:10 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 11/18] perf metric: Add referenced metrics to hash data
Message-ID: <20200713165610.GC183694@krava>
References: <20200712132634.138901-1-jolsa@kernel.org>
 <20200712132634.138901-12-jolsa@kernel.org>
 <c55188aa-d8ff-ea5c-c8ed-a6f36d20c652@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c55188aa-d8ff-ea5c-c8ed-a6f36d20c652@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 05:27:53PM +0100, John Garry wrote:
> On 12/07/2020 14:26, Jiri Olsa wrote:
> > +int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref)
> > +{
> > +	struct expr_id_data *data_ptr = NULL, *old_data = NULL;
> > +	char *old_key = NULL;
> > +	char *name;
> > +	int ret;
> > +
> > +	data_ptr = zalloc(sizeof(*data_ptr));
> > +	if (!data_ptr)
> > +		return -ENOMEM;
> > +
> > +	name = strdup(ref->metric_name);
> > +	if (!name) {
> > +		free(data_ptr);
> > +		return -ENOMEM;
> > +	}
> 
> JFYI, this was not compiling for me:
> 
> util/expr.c: In function ‘expr__add_ref’:
> util/expr.c:84:13: error: implicit declaration of function ‘zalloc’; did you
> mean ‘valloc’? [-Werror=implicit-function-declaration]
>  data_ptr = zalloc(sizeof(*data_ptr));
>  ^~~~~~
>  valloc
> util/expr.c:84:13: error: nested extern declaration of ‘zalloc’
> [-Werror=nested-externs]
> util/expr.c:84:11: error: assignment to ‘struct expr_id_data *’ from ‘int’
> makes pointer from integer without a cast [-Werror=int-conversion]
>  data_ptr = zalloc(sizeof(*data_ptr));
> ^
>  LDutil/arm-spe-decoder/perf-in.o
> cc1: all warnings being treated as errors
> 
> I think the zalloc.h include is missing.

yea, strange it compiles for me.. I'll add it

thanks,
jirka

