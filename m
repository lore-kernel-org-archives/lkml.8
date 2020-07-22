Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20FAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 11:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5A40206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 11:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eozjfHKC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbgGVLIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 07:08:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47574 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726599AbgGVLIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 07:08:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595416100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I+s91G7/3YaWvofNQl3jYEEEmAS3FwXQUuV6BeKXMpI=;
        b=eozjfHKCkgpCE0w4M0xtlspbCrYTxr2hJKBuMX4uMGGmHKJxQ1jcAViL9rRIrbs46nf4NP
        dbIhYhb69ucrzMQ2lvTDxmF4hJZ0qvzKiNFSX0AUVR8f0eNIE1oOP/zDhjTS0hNCcxv6Mz
        KkXOTc++WByrS1qT6AUNlAOrGt8vSxg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-GuygH6u4PZ-IUkhxS8mhpw-1; Wed, 22 Jul 2020 07:08:16 -0400
X-MC-Unique: GuygH6u4PZ-IUkhxS8mhpw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F4A9800C64;
        Wed, 22 Jul 2020 11:08:14 +0000 (UTC)
Received: from krava (unknown [10.40.194.40])
        by smtp.corp.redhat.com (Postfix) with SMTP id C7F556931A;
        Wed, 22 Jul 2020 11:08:11 +0000 (UTC)
Date:   Wed, 22 Jul 2020 13:08:10 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com, irogers@google.com,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2] perf evsel: Don't set
 sample_regs_intr/sample_regs_user for dummy event
Message-ID: <20200722110810.GD981884@krava>
References: <20200720010013.18238-1-yao.jin@linux.intel.com>
 <20200720091748.GH760733@krava>
 <af1da971-5c60-4c17-e5d9-01430c928592@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af1da971-5c60-4c17-e5d9-01430c928592@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 01:00:03PM +0800, Jin, Yao wrote:

SNIP

> > > 
> > > If we use -IXMM0, the attr>sample_regs_intr will be set with
> > > PERF_REG_EXTENDED_MASK bit.
> > > 
> > > It doesn't make sense to set attr->sample_regs_intr for a
> > > software dummy event.
> > > 
> > > This patch adds dummy event checking before setting
> > > attr->sample_regs_intr and attr->sample_regs_user.
> > > 
> > > After:
> > >    # ./perf record -e cycles:p -IXMM0 -a -- sleep 1
> > >    [ perf record: Woken up 1 times to write data ]
> > >    [ perf record: Captured and wrote 0.413 MB perf.data (45 samples) ]
> > > 
> > >   v2:
> > >   ---
> > >   Rebase to perf/core
> > > 
> > > Fixes: 0a892c1c9472 ("perf record: Add dummy event during system wide synthesis")
> > > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> > > ---
> > >   tools/perf/util/evsel.c | 6 ++++--
> > >   1 file changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > > index 9aa51a65593d..11794d3b7879 100644
> > > --- a/tools/perf/util/evsel.c
> > > +++ b/tools/perf/util/evsel.c
> > > @@ -1014,12 +1014,14 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
> > >   	if (callchain && callchain->enabled && !evsel->no_aux_samples)
> > >   		evsel__config_callchain(evsel, opts, callchain);
> > > -	if (opts->sample_intr_regs && !evsel->no_aux_samples) {
> > > +	if (opts->sample_intr_regs && !evsel->no_aux_samples &&
> > > +	    !evsel__is_dummy_event(evsel)) {
> > 
> > hum, I thought it'd look something like this:
> > 
> >    if (opts->sample_intr_regs && (!evsel->no_aux_samples || !evsel__is_dummy_event(evsel))
> > 
> > but I'm not sure how no_aux_samples flag works exactly.. so it might be
> > correct.. just making sure ;-)
> > 
> > cc-ing Adrian
> > 
> > jirka
> > 
> > 
> 
> no_aux_samples is set to false by default and it's only set to true by pt, right?
> 
> So most of the time, !evsel->no_aux_samples is always true.
> 
> if (opts->sample_intr_regs && (!evsel->no_aux_samples || !evsel__is_dummy_event(evsel)) {
> 	attr->sample_regs_intr = opts->sample_intr_regs;
> 	evsel__set_sample_bit(evsel, REGS_INTR);
> }
> 
> So even if the evsel is dummy event, the condition check is true. :(
> 
> Or maybe I misunderstand anything?

I was just curious, because I did not follow the no_aux_samples
usage in detail.. so how about a case where:

   evsel->no_aux_samples == true and evsel__is_dummy_event(evsel) = false

then the original condition will be false for non dummy event

  (opts->sample_intr_regs && !evsel->no_aux_samples && !evsel__is_dummy_event(evsel))

is that ok?

jirka

