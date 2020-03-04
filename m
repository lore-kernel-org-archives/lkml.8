Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DE5C3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 15:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6B38215A4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 15:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmmduGue"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387432AbgCDPp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 10:45:57 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:35784 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbgCDPp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 10:45:56 -0500
Received: by mail-qv1-f68.google.com with SMTP id u10so980538qvi.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 07:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H1aD5rl73gQz3pyK1j23DADA5B3p3KqrJNHXqqRhR64=;
        b=YmmduGueqqp9ySMA98td9oAu34c9SWy8R77kmdKg7UwQzkTeDaN9nfKdY1Z30PgGOg
         3BeNT+3djX76TtX3Wyp7ezNwYVs/KIQpHmKsWQaaInP3iHD5Gb+E9yf9ie51LUybEl9d
         caVXPhhNRwuxCAkIfu/ZY24rJ7jiRlWX2aCOY+zl+nVWDxcADqQPtf6xVhgadBl3uj1h
         lZGxTSgw5l1ANhFc/iWaqVuxvZQdj0bHOo9ZYDU+UPqGEYr9l88fgyWCJVSwn6MlCEeN
         No5Ivnqk+ONpmQETS4etBo1DtvhROZxgBYKjExa/8Ffiy9vvQXTu5bXtqH/1onrg/hwQ
         PPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H1aD5rl73gQz3pyK1j23DADA5B3p3KqrJNHXqqRhR64=;
        b=lqgC/5O+VDr76mBueYQTFrDAGzepNOAnWx94Eq2EiKFVe+w6082FRSrfhRaq+j0vmf
         q5tp1ZyH/SdnxvJJ5vl8FvWuXrpjq4D1OAtE2vEyKRSIWKJnQIooFfjrHoVP4ztItX1V
         +FrlknjIAkAsxrZQ+QFFTcvDwSdrBEP19Z6kSp0Zo86V49Ds+orydW78ANZiw1biXkKF
         V7ueLFVnHLKqFFpQi5W21Ralq2lQyQ9jnIOyswKulPEgm94/kwOrsrEEP3v0Kg9NhpD6
         GR0I2NgzSzLcTl/pp18zFW1Wg5m8kXQmJjX4AYLY3TYLkWcpEIdLe531+tkzccDH9WQC
         Y8sQ==
X-Gm-Message-State: ANhLgQ2rTlJ2BC2on4rYckXuxWx4gnKfUYPbvmqF04SV9TRIjbCvMJMB
        f6JnB0SfJ4mUnIrKh48J5emDd8HihSSToA==
X-Google-Smtp-Source: ADFU+vvsss4/ZBMJp88rkdQf1pi8NgzUZWn3qy0MxLSpNUQ+OpNhX01na0keFXoDmbxPPF20Vf/9UA==
X-Received: by 2002:ad4:4e46:: with SMTP id eb6mr2673196qvb.64.1583336755259;
        Wed, 04 Mar 2020 07:45:55 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id l3sm6479687qkl.100.2020.03.04.07.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 07:45:54 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0E110403AD; Wed,  4 Mar 2020 12:45:52 -0300 (-03)
Date:   Wed, 4 Mar 2020 12:45:52 -0300
To:     kan.liang@linux.intel.com
Cc:     jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        adrian.hunter@intel.com, mathieu.poirier@linaro.org,
        ravi.bangoria@linux.ibm.com, alexey.budankov@linux.intel.com,
        vitaly.slobodskoy@intel.com, pavel.gerasimov@intel.com,
        mpe@ellerman.id.au, eranian@google.com, ak@linux.intel.com
Subject: Re: [PATCH 01/12] perf tools: Add hw_idx in struct branch_stack
Message-ID: <20200304154552.GB2854@kernel.org>
References: <20200228163011.19358-1-kan.liang@linux.intel.com>
 <20200228163011.19358-2-kan.liang@linux.intel.com>
 <20200304134902.GB12612@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304134902.GB12612@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 04, 2020 at 10:49:02AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Feb 28, 2020 at 08:30:00AM -0800, kan.liang@linux.intel.com escreveu:
> > From: Kan Liang <kan.liang@linux.intel.com>
> > The low level index of raw branch records for the most recent branch can
> > be recorded in a sample with PERF_SAMPLE_BRANCH_HW_INDEX
> > branch_sample_type. Extend struct branch_stack to support it.

> > However, if the PERF_SAMPLE_BRANCH_HW_INDEX is not applied, only nr and
> > entries[] will be output by kernel. The pointer of entries[] could be
> > wrong, since the output format is different with new struct branch_stack.
> > Add a variable no_hw_idx in struct perf_sample to indicate whether the
> > hw_idx is output.
> > Add get_branch_entry() to return corresponding pointer of entries[0].
  
> This should be broken up in at least two patches, one that syncs
> tools/include/uapi/linux/perf_event.h with the kernel, and another to do
> what this changeset log message states, I'll do it this time to expedite
> processing of this patchset, please do it that way next time.

So, after doing that split I'm also suggesting/tentatively applying this
patch on top of it, to keep the naming convention we have in tools/perf,
and also the 'static' to that inline, please holler if you disagree,
I'll put the end result in a branch for further visualization/comments.

At some point these functions obtaining stuff from a 'struct perf_sample' to
tools/lib/perf/ (aka libperf), so better go doing proper namespacing,
etc, right Jiri?

- Arnaldo

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index acf3107bbda2..656b347f6dd8 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -735,7 +735,7 @@ static int perf_sample__fprintf_brstack(struct perf_sample *sample,
 					struct perf_event_attr *attr, FILE *fp)
 {
 	struct branch_stack *br = sample->branch_stack;
-	struct branch_entry *entries = get_branch_entry(sample);
+	struct branch_entry *entries = perf_sample__branch_entries(sample);
 	struct addr_location alf, alt;
 	u64 i, from, to;
 	int printed = 0;
@@ -783,7 +783,7 @@ static int perf_sample__fprintf_brstacksym(struct perf_sample *sample,
 					   struct perf_event_attr *attr, FILE *fp)
 {
 	struct branch_stack *br = sample->branch_stack;
-	struct branch_entry *entries = get_branch_entry(sample);
+	struct branch_entry *entries = perf_sample__branch_entries(sample);
 	struct addr_location alf, alt;
 	u64 i, from, to;
 	int printed = 0;
@@ -829,7 +829,7 @@ static int perf_sample__fprintf_brstackoff(struct perf_sample *sample,
 					   struct perf_event_attr *attr, FILE *fp)
 {
 	struct branch_stack *br = sample->branch_stack;
-	struct branch_entry *entries = get_branch_entry(sample);
+	struct branch_entry *entries = perf_sample__branch_entries(sample);
 	struct addr_location alf, alt;
 	u64 i, from, to;
 	int printed = 0;
@@ -1056,7 +1056,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 					    struct machine *machine, FILE *fp)
 {
 	struct branch_stack *br = sample->branch_stack;
-	struct branch_entry *entries = get_branch_entry(sample);
+	struct branch_entry *entries = perf_sample__branch_entries(sample);
 	u64 start, end;
 	int i, insn, len, nr, ilen, printed = 0;
 	struct perf_insn x;
diff --git a/tools/perf/util/branch.h b/tools/perf/util/branch.h
index 014c3cd4cb32..154a05cd03af 100644
--- a/tools/perf/util/branch.h
+++ b/tools/perf/util/branch.h
@@ -54,7 +54,7 @@ struct branch_stack {
  * Check whether the hw_idx is available,
  * and return the corresponding pointer of entries[0].
  */
-inline struct branch_entry *get_branch_entry(struct perf_sample *sample)
+static inline struct branch_entry *perf_sample__branch_entries(struct perf_sample *sample)
 {
 	u64 *entry = (u64 *)sample->branch_stack;
 
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 808ca27bd5cf..e74a5acf66d9 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -2584,7 +2584,7 @@ void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
 			  u64 *total_cycles)
 {
 	struct branch_info *bi;
-	struct branch_entry *entries = get_branch_entry(sample);
+	struct branch_entry *entries = perf_sample__branch_entries(sample);
 
 	/* If we have branch cycles always annotate them. */
 	if (bs && bs->nr && entries[0].flags.cycles) {
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index b0623f99fb9c..fd14f1489802 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2081,7 +2081,7 @@ struct branch_info *sample__resolve_bstack(struct perf_sample *sample,
 {
 	unsigned int i;
 	const struct branch_stack *bs = sample->branch_stack;
-	struct branch_entry *entries = get_branch_entry(sample);
+	struct branch_entry *entries = perf_sample__branch_entries(sample);
 	struct branch_info *bi = calloc(bs->nr, sizeof(struct branch_info));
 
 	if (!bi)
@@ -2186,7 +2186,7 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 	/* LBR only affects the user callchain */
 	if (i != chain_nr) {
 		struct branch_stack *lbr_stack = sample->branch_stack;
-		struct branch_entry *entries = get_branch_entry(sample);
+		struct branch_entry *entries = perf_sample__branch_entries(sample);
 		int lbr_nr = lbr_stack->nr, j, k;
 		bool branch;
 		struct branch_flags *flags;
@@ -2281,7 +2281,7 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 					    int max_stack)
 {
 	struct branch_stack *branch = sample->branch_stack;
-	struct branch_entry *entries = get_branch_entry(sample);
+	struct branch_entry *entries = perf_sample__branch_entries(sample);
 	struct ip_callchain *chain = sample->callchain;
 	int chain_nr = 0;
 	u8 cpumode = PERF_RECORD_MISC_USER;
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 02b6c87c5abe..8c1b27cd8b99 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -464,7 +464,7 @@ static PyObject *python_process_brstack(struct perf_sample *sample,
 					struct thread *thread)
 {
 	struct branch_stack *br = sample->branch_stack;
-	struct branch_entry *entries = get_branch_entry(sample);
+	struct branch_entry *entries = perf_sample__branch_entries(sample);
 	PyObject *pylist;
 	u64 i;
 
@@ -562,7 +562,7 @@ static PyObject *python_process_brstacksym(struct perf_sample *sample,
 					   struct thread *thread)
 {
 	struct branch_stack *br = sample->branch_stack;
-	struct branch_entry *entries = get_branch_entry(sample);
+	struct branch_entry *entries = perf_sample__branch_entries(sample);
 	PyObject *pylist;
 	u64 i;
 	char bf[512];
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index dab985e3f136..055b00abd56d 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1007,7 +1007,7 @@ static void callchain__lbr_callstack_printf(struct perf_sample *sample)
 {
 	struct ip_callchain *callchain = sample->callchain;
 	struct branch_stack *lbr_stack = sample->branch_stack;
-	struct branch_entry *entries = get_branch_entry(sample);
+	struct branch_entry *entries = perf_sample__branch_entries(sample);
 	u64 kernel_callchain_nr = callchain->nr;
 	unsigned int i;
 
@@ -1069,7 +1069,7 @@ static void callchain__printf(struct evsel *evsel,
 
 static void branch_stack__printf(struct perf_sample *sample, bool callstack)
 {
-	struct branch_entry *entries = get_branch_entry(sample);
+	struct branch_entry *entries = perf_sample__branch_entries(sample);
 	uint64_t i;
 
 	printf("%s: nr:%" PRIu64 "\n",
