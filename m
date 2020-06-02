Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E34C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B687E20734
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H2MutNN6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgFBTIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:08:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40575 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726174AbgFBTIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:08:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591124903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8y6oZjj3V4uWtlMv1o25l7nHDbVFUeee47F/Q2Ad1rQ=;
        b=H2MutNN6Ktm0Jr1tptrKP7g+nL/GBpYug76ujVfE7JNtErQ1YjCzrXuPlxwFTh8Bztu+QT
        VLqdHnYlhTEALmJH8eMwIYOxZmiFW7Cj5Ryg2w8r8AyLEozQr9IV9sq9Iyi9FdjIL+D45v
        3wZkp9n2htnyrUaG8Wi1eOt9t/YwvLg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-JEPnNF33M0OZSWHYSa9PIw-1; Tue, 02 Jun 2020 15:08:21 -0400
X-MC-Unique: JEPnNF33M0OZSWHYSa9PIw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A7ED835B8C;
        Tue,  2 Jun 2020 19:08:19 +0000 (UTC)
Received: from krava (unknown [10.40.192.62])
        by smtp.corp.redhat.com (Postfix) with SMTP id 368312B4CC;
        Tue,  2 Jun 2020 19:08:16 +0000 (UTC)
Date:   Tue, 2 Jun 2020 21:08:15 +0200
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
Subject: Re: [PATCH 04/13] perf tests: Add another metric parsing test
Message-ID: <20200602190815.GH1169993@krava>
References: <20200602115055.1168446-1-jolsa@kernel.org>
 <20200602115055.1168446-5-jolsa@kernel.org>
 <CAP-5=fXjQ0ZgtrsizH6F7y2VRZ6dnsu54BXRxszyM+mMAvP-cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXjQ0ZgtrsizH6F7y2VRZ6dnsu54BXRxszyM+mMAvP-cQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 10:58:32AM -0700, Ian Rogers wrote:

SNIP

> > +static int check_parse_fake(const char *id)
> > +{
> > +       struct parse_events_error error;
> 
> nit: this reads funny as it isn't clear, without looking at
> check_parse_id, that error is zero initialized.

right, how about something like below?

thanks,
jirka


---
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index d3343827eb4d..c745b6e13cbe 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -403,7 +403,6 @@ static int check_parse_id(const char *id, struct parse_events_error *error,
 	evlist = evlist__new();
 	if (!evlist)
 		return -ENOMEM;
-	memset(error, 0, sizeof(*error));
 	ret = parse_events(evlist, id, error, fake_pmu);
 	evlist__delete(evlist);
 	return ret;
@@ -411,7 +410,7 @@ static int check_parse_id(const char *id, struct parse_events_error *error,
 
 static int check_parse_cpu(const char *id, bool same_cpu, struct pmu_event *pe)
 {
-	struct parse_events_error error;
+	struct parse_events_error error = { 0 };
 
 	int ret = check_parse_id(id, &error, false);
 	if (ret && same_cpu) {
@@ -433,7 +432,7 @@ static int check_parse_cpu(const char *id, bool same_cpu, struct pmu_event *pe)
 
 static int check_parse_fake(const char *id)
 {
-	struct parse_events_error error;
+	struct parse_events_error error = { 0 };
 	int ret = check_parse_id(id, &error, true);
 
 	free(error.str);

