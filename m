Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FC4C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 19:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C12B2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 19:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599247995;
	bh=EwWqQCCeyt59RTTQb8UOoKzovguyPsH4Mq6GX6zmhgE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PKxwxRjX10Ka9S8hZXvXYBWv690DMrVVvx39rSbsoRtoDpRdNL6a/ly7DT1gpWLvb
	 VjniJapvfLxDbWHGbsFwzGHnCijd3xiGYy/njHGhwq4dLRjJPcNKABZ3WqnPRXOFo9
	 4lB8bAOrm4EEC5Y5ukleEokl1xs4DpZq064d3Aqo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgIDTdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 15:33:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:52386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbgIDTdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 15:33:12 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCA342083B;
        Fri,  4 Sep 2020 19:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599247992;
        bh=EwWqQCCeyt59RTTQb8UOoKzovguyPsH4Mq6GX6zmhgE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oAFKDW9FXgJ9pwPBOyWGU4pwAGUBLMfyCrWC9AT7td4hEN/jGrNoU6Nlc99D52Bek
         ZzCYBYCNliEs2PerjM4pemO3H16rQxtb8tkiqQHxi6s3LzktxNreOh7ST0J7Pr9NXJ
         aY1PSZIfg5GJlFPFYD+mt4deFJ66LcD2qoie0odE=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id ECB2C40D3D; Fri,  4 Sep 2020 16:33:09 -0300 (-03)
Date:   Fri, 4 Sep 2020 16:33:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Kim Phillips <kim.phillips@amd.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Vijay Thakkar <vijaythakkar@me.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        Borislav Petkov <bp@suse.de>, Jon Grimm <jon.grimm@amd.com>,
        Martin Jambor <mjambor@suse.cz>,
        Michael Petlan <mpetlan@redhat.com>,
        William Cohen <wcohen@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] perf vendor events amd: Enable Family 19h users by
 matching Zen2 events
Message-ID: <20200904193309.GH3753976@kernel.org>
References: <20200901220944.277505-1-kim.phillips@amd.com>
 <20200901220944.277505-4-kim.phillips@amd.com>
 <CAP-5=fXs6WJoJ5HTkkgXVx=TR6=G1VaP6kcZHhf4Zq9Nhxb4Xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXs6WJoJ5HTkkgXVx=TR6=G1VaP6kcZHhf4Zq9Nhxb4Xw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 02, 2020 at 11:20:20PM -0700, Ian Rogers escreveu:
> On Tue, Sep 1, 2020 at 3:10 PM Kim Phillips <kim.phillips@amd.com> wrote:
> >
> > This enables zen3 users by reusing mostly-compatible zen2 events
> > until the official public list of zen3 events is published in a
> > future PPR.
> >
> > Signed-off-by: Kim Phillips <kim.phillips@amd.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied,

- Arnaldo
 
> Thanks!
> Ian
> 
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Jiri Olsa <jolsa@redhat.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Vijay Thakkar <vijaythakkar@me.com>
> > Cc: Andi Kleen <ak@linux.intel.com>
> > Cc: John Garry <john.garry@huawei.com>
> > Cc: Kan Liang <kan.liang@linux.intel.com>
> > Cc: Yunfeng Ye <yeyunfeng@huawei.com>
> > Cc: Jin Yao <yao.jin@linux.intel.com>
> > Cc: "Martin Liška" <mliska@suse.cz>
> > Cc: Borislav Petkov <bp@suse.de>
> > Cc: Jon Grimm <jon.grimm@amd.com>
> > Cc: Martin Jambor <mjambor@suse.cz>
> > Cc: Michael Petlan <mpetlan@redhat.com>
> > Cc: William Cohen <wcohen@redhat.com>
> > Cc: Stephane Eranian <eranian@google.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: linux-perf-users@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  tools/perf/pmu-events/arch/x86/mapfile.csv | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
> > index 25b06cf98747..2f2a209e87e1 100644
> > --- a/tools/perf/pmu-events/arch/x86/mapfile.csv
> > +++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
> > @@ -38,3 +38,4 @@ GenuineIntel-6-7E,v1,icelake,core
> >  GenuineIntel-6-86,v1,tremontx,core
> >  AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
> >  AuthenticAMD-23-[[:xdigit:]]+,v1,amdzen2,core
> > +AuthenticAMD-25-[[:xdigit:]]+,v1,amdzen2,core
> > --
> > 2.27.0
> >

-- 

- Arnaldo
