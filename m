Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593ABC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 11:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A35020899
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 11:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K0vmH1pU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388890AbgEZLP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 07:15:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44610 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388712AbgEZLP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 07:15:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590491726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5bTHoLgIfdIigbECZgfIbpBlTngaTI4kGHd0degjyNM=;
        b=K0vmH1pUziHWjRaXfNS9BTkfUwkC/E1fBdK80BnI0H45rC2ukLAUsfZvKw2B3gF+2RS57j
        XBchVra0pUqTR4gSmxUJac1CNMYPmunAydwGQmnBLN1gnlI5OjAFCEZNh1DOOsEE0qLcWj
        45NGHLK8X1a84xNnTEVo4DFTdz9Y5u0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-kyTJuLFbMk6yo5xLjM8A3A-1; Tue, 26 May 2020 07:15:17 -0400
X-MC-Unique: kyTJuLFbMk6yo5xLjM8A3A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80631800688;
        Tue, 26 May 2020 11:15:15 +0000 (UTC)
Received: from krava (unknown [10.40.195.156])
        by smtp.corp.redhat.com (Postfix) with SMTP id 133456EF91;
        Tue, 26 May 2020 11:15:12 +0000 (UTC)
Date:   Tue, 26 May 2020 13:15:12 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC 00/14] perf tests: Check on subtest for user specified test
Message-ID: <20200526111512.GC333164@krava>
References: <20200524224219.234847-1-jolsa@kernel.org>
 <20200525142300.GK14034@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525142300.GK14034@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 11:23:00AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, May 25, 2020 at 12:42:05AM +0200, Jiri Olsa escreveu:
> > hi,
> > changes for using metric result in another metric seem
> > to change lot of core metric code, so it's better we
> > have some more tests before we do that.
> > 
> > Sending as RFC as it's still alive and you guys might
> > have some other idea of how to do this.
> > 
> > Also available in here:
> >   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> >   perf/fixes
> 
> I applied the first three patches, will wait a bit for Ian and others to
> have some time to look at it, but one thing I thought was that instead
> of having parse_state->fake_pmu as a bool, you could have it as a
> pointer to the fake pmu, this way we would do away with that static
> thing in the middle of the parsing code.
> 
> +static int check_id(const char *id)
> +{
> +	struct parse_events_error error;
> +	struct evlist *evlist;
> +	int ret;
> +
> +	/* Numbers are always valid. */
> +	if (is_number(id))
> +               return 0;
> +
> +	evlist = evlist__new();
> +	if (!evlist)
> +               return -1;
> +
> +	memset(&error, 0, sizeof(error));
> +       ret = parse_events_fake(evlist, id, &error);
> +       if (ret) {
> +               pr_debug("str        : %s\n", error.str);
> +               pr_debug("help       : %s\n", error.help);
> +               pr_debug("first_str  : %s\n", error.first_str);
> +               pr_debug("first_help : %s\n", error.first_help);
> +       }
> +
> +       evlist__delete(evlist);
> +       free(error.str);
> +	free(error.help);
> +       free(error.first_str);
> +       free(error.first_help);
> +	return ret;
> +}
> 
> 
> Would read:
> 
> 	struct perf_pmu fake = { 0, };
> 	.
> 	.
> 	.
> 	ret = parse_events_fake_pmu(evlist, id, &fake, &error);

hi,

ok I'll check, but what I'd like to keep is to have the fake pmu
defined in just one place, I was initialy thinking to put it on
the list of pmus, but then it'd appear in other places we dont want,
like perf list ;-)

> 	.
> 	.
> 	.
> 
> 
> That also renames parse_events_fake() to parse_events_fake_pmu().

ok, thanks,
jirka

