Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7D8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 13:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28E8F207BC
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 13:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JwKuZ+Qx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgFANV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 09:21:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47682 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725974AbgFANV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 09:21:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591017716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uuL0bQy2sUs5ArY63zfMD5EmO7NflLnDpTF3Q2rxr8o=;
        b=JwKuZ+QxdyRZ4wKIPfvrWawblP9hrTPjtDU7hmr7ykIXf7w2Ok4zHbcoqHqgiEv7oQkkXx
        HteG9wKssrtbM0+g1uVJ1FPBsZXifGC106+iFoBhTCuZxKSjs8MsGh1dtEf8YRPjKrSB0V
        G0AEKccmcBDEydlGVLpWAcspzuUWZUQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-yQhZXB91PiO6lSP6cyg-dA-1; Mon, 01 Jun 2020 09:21:53 -0400
X-MC-Unique: yQhZXB91PiO6lSP6cyg-dA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC8031855A1C;
        Mon,  1 Jun 2020 13:21:50 +0000 (UTC)
Received: from krava (unknown [10.40.192.36])
        by smtp.corp.redhat.com (Postfix) with SMTP id 791407E7CB;
        Mon,  1 Jun 2020 13:21:48 +0000 (UTC)
Date:   Mon, 1 Jun 2020 15:21:47 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 06/14] perf tests: Add another pmu-events tests
Message-ID: <20200601132147.GB1031432@krava>
References: <20200524224219.234847-1-jolsa@kernel.org>
 <20200524224219.234847-7-jolsa@kernel.org>
 <CAP-5=fV5tKwyMCpwt2VFkSFwCCk6qJ3S2_ajNy2P6ZWVxvbC-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fV5tKwyMCpwt2VFkSFwCCk6qJ3S2_ajNy2P6ZWVxvbC-w@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 12:44:15AM -0700, Ian Rogers wrote:

SNIP

> > +       memset(&error, 0, sizeof(error));
> > +       ret = parse_events_fake(evlist, id, &error);
> > +       if (ret) {
> > +               pr_debug("str        : %s\n", error.str);
> > +               pr_debug("help       : %s\n", error.help);
> > +               pr_debug("first_str  : %s\n", error.first_str);
> > +               pr_debug("first_help : %s\n", error.first_help);
> > +       }
> > +
> > +       evlist__delete(evlist);
> > +       free(error.str);
> > +       free(error.help);
> > +       free(error.first_str);
> > +       free(error.first_help);
> > +       return ret;
> > +}
> 
> This is quite similar to check_parse_id, fold them together?

there is the 'same_cpu' logic in check_parse_id,
so I did not want to mess with that

> 
> > +
> > +static int metric_parse_fake(const char *str)
> > +{
> > +       struct expr_parse_ctx ctx;
> > +       struct hashmap_entry *cur;
> > +       double result;
> > +       int ret = -1;
> > +       size_t bkt;
> > +       int i;
> > +
> > +       pr_debug("parsing '%s'\n", str);
> > +
> > +       expr__ctx_init(&ctx);
> > +       if (expr__find_other(str, NULL, &ctx, 0) < 0) {
> > +               pr_err("expr__find_other failed\n");
> > +               return -1;
> > +       }
> > +
> > +       i = 1;
> > +       hashmap__for_each_entry((&ctx.ids), cur, bkt)
> > +               expr__add_id(&ctx, strdup(cur->key), i++);
> 
> It might make sense to share the code here with that in test_parsing.
> This initialization of ids is commented there and it is a bit special.

hum, not sure it's worth to add this complexity to test, I'd like
to keep it simple, it's already not straightforward ;-) I added the
comment you mentioned

jirka

