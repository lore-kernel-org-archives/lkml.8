Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC940C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0D8B2177B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UHp3j9n0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731559AbgGaQUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 12:20:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21509 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726502AbgGaQUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 12:20:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596212409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4JGruRzvy58TUGMzqZM7NtmLoDhduxdLJhWQsK30czQ=;
        b=UHp3j9n0gt5XThfGzwXgUTFWUI0f/bekhoQGrlKNLbEDDJdwQxgXOOs2eAXN2EIQL7X/Xl
        EYOEGd0PkjQHP96/CWsVkz2mtRJDnRDHV4DNFtyIfsy3Mk9mqgJzHzoBJLMlU4Vlx8YW3h
        ZyubK/rbodYDU1P6d+c6aDxPusWuTiE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-_AxMlTcSNmCOakb8vS8Clw-1; Fri, 31 Jul 2020 12:20:05 -0400
X-MC-Unique: _AxMlTcSNmCOakb8vS8Clw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62574109EB53;
        Fri, 31 Jul 2020 16:19:42 +0000 (UTC)
Received: from krava (unknown [10.40.192.26])
        by smtp.corp.redhat.com (Postfix) with SMTP id CDDC374AA1;
        Fri, 31 Jul 2020 16:19:38 +0000 (UTC)
Date:   Fri, 31 Jul 2020 18:19:37 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        David Ahern <dsahern@gmail.com>,
        =?iso-8859-1?Q?Genevi=E8ve?= Bastien <gbastien@versatic.net>,
        Wang Nan <wangnan0@huawei.com>,
        Jeremie Galarneau <jgalar@efficios.com>
Subject: Re: [PATCH 1/6] perf tools: Add clockid_name function
Message-ID: <20200731161937.GC4296@krava>
References: <20200730213950.1503773-1-jolsa@kernel.org>
 <20200730213950.1503773-2-jolsa@kernel.org>
 <20200731153337.GB1299820@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731153337.GB1299820@tassilo.jf.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 08:33:37AM -0700, Andi Kleen wrote:
> > diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
> > index f486fdd3a538..126dad238ee3 100644
> > --- a/tools/perf/util/util.h
> > +++ b/tools/perf/util/util.h
> > @@ -62,4 +62,6 @@ char *perf_exe(char *buf, int len);
> >  #endif
> >  #endif
> >  
> > +const char *clockid_name(clockid_t clk_id);
> 
> If it's a generic "util" it probably shouldn't live in builtin-record.c

true, but it's where all the clockid data is,
I'd need to move parse_clockid as well, I'll check

thanks,
jirka

