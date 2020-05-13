Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B815C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 22:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 873D820675
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 22:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kuX/0H7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730472AbgEMWGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 18:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729775AbgEMWGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 18:06:40 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CABC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 15:06:40 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id o16so1214490qto.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 15:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=dFi1xyzNnKBBgiBIj8/xIwUl0ZF4I4xLwJBwXpoPEyM=;
        b=kuX/0H7zx99c6QI4JFt1MEuceinDcrpoOecdzQ6a1Zp4jnpsWgs55YNWbYkGyCiqVc
         9m0p3rUkBxNq9gfGGlAhLI7Iim8ufxXXIDhrXLhisHoWPhcmI7vlnV2kXFpv18XDDjbS
         tVbn5UpGZZJVxWjhrTI5GWwj3bT/PEER6OvcwnWnSrSAqSPasHZqZcCTODdCvxImZPAi
         Ro3PbmioXEBMEzwcFiHT4dvdp6Ntx6atRxuIBcstJ/pl0vIUx2E/jAo8q7Ygi5QjJXj7
         1gULh9voBnZBk6FPF8i5szm0fwUwJNEmFzEJrxKf0Y6c/sHX537hOYdarlXaWjGSGkMR
         eHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=dFi1xyzNnKBBgiBIj8/xIwUl0ZF4I4xLwJBwXpoPEyM=;
        b=NBatCJF61wLcu3ZnTnEaIHlFWbqiKicRzlBqzwVp9dG6ac2o9YY5DMfpCv3sM+aOf6
         hokIiSpCw9a1hJUgQxZT7Fyl9mZGyo+dQ1JFUu7G0TnlaXeCHQPv4WAMwhSmQGnhbOy2
         EWM0cWG9/jYzXwTCJt8n2P+Smz2O5BhpdZ6s5JmuPzyGv0TUOgGA83jyw1BAjMOH8Xei
         WP/LKUc4CjJdx/NYaNXPNcbAPfS+VXqv+Dkxkm48+0A3/MsA6+x1nrv/fdYfibE+0NZv
         8eKjUvaUlW2p0VB713/2VAcxigvXvO3vpg7yALfGMpCVnk1bzgXQRU4/JwcY+wpic40R
         C7fw==
X-Gm-Message-State: AOAM530oyGib/t2eLWQjvPF8st3YnBz1gsdee4TUK69mnhxHrBW6mGUt
        xcwm5JBpHax+rk589rxwcJVz52AqtHIk
X-Google-Smtp-Source: ABdhPJy0W2z1LHvY+7cFAllwsno5HK8FojuwjkxdKqYm5X0QaAyzar74wRCxGz7BoPdW/qyrb4tdL1HWTInT
X-Received: by 2002:a0c:f44a:: with SMTP id h10mr1727568qvm.111.1589407599131;
 Wed, 13 May 2020 15:06:39 -0700 (PDT)
Date:   Wed, 13 May 2020 15:06:35 -0700
Message-Id: <20200513220635.54700-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH v2] perf parse-events: Make add PMU verbose output clearer
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a CPU like skylakex an uncore_iio_0 PMU may alias with
uncore_iio_free_running_0. The latter PMU doesn't support fc_mask
as a parameter and so pmu_config_term fails. Typically
parse_events_add_pmu is called in a loop where if one alias succeeds
errors are ignored, however, if multiple errors occur
parse_events__handle_error will currently give a WARN_ONCE.

This change removes the WARN_ONCE in parse_events__handle_error and
makes it a pr_debug. It adds verbose messages to parse_events_add_pmu
warning that non-fatal errors may occur, while giving details on the pmu
and config terms for useful context. pmu_config_term is altered so the
failing term and pmu are present in the case of the 'unknown term'
error which makes spotting the free_running case more straightforward.

Before:
$ perf --debug verbose=3D3 stat -M llc_misses.pcie_read sleep 1
Using CPUID GenuineIntel-6-55-4
metric expr unc_iio_data_req_of_cpu.mem_read.part0 + unc_iio_data_req_of_cp=
u.mem_read.part1 + unc_iio_data_req_of_cpu.mem_read.part2 + unc_iio_data_re=
q_of_cpu.mem_read.part3 for LLC_MISSES.PCIE_READ
found event unc_iio_data_req_of_cpu.mem_read.part0
found event unc_iio_data_req_of_cpu.mem_read.part1
found event unc_iio_data_req_of_cpu.mem_read.part2
found event unc_iio_data_req_of_cpu.mem_read.part3
metric expr unc_iio_data_req_of_cpu.mem_read.part0 + unc_iio_data_req_of_cp=
u.mem_read.part1 + unc_iio_data_req_of_cpu.mem_read.part2 + unc_iio_data_re=
q_of_cpu.mem_read.part3 for LLC_MISSES.PCIE_READ
found event unc_iio_data_req_of_cpu.mem_read.part0
found event unc_iio_data_req_of_cpu.mem_read.part1
found event unc_iio_data_req_of_cpu.mem_read.part2
found event unc_iio_data_req_of_cpu.mem_read.part3
adding {unc_iio_data_req_of_cpu.mem_read.part0,unc_iio_data_req_of_cpu.mem_=
read.part1,unc_iio_data_req_of_cpu.mem_read.part2,unc_iio_data_req_of_cpu.m=
em_read.part3}:W,{unc_iio_data_req_of_cpu.mem_read.part0,unc_iio_data_req_o=
f_cpu.mem_read.part1,unc_iio_data_req_of_cpu.mem_read.part2,unc_iio_data_re=
q_of_cpu.mem_read.part3}:W
intel_pt default config: tsc,mtc,mtc_period=3D3,psb_period=3D3,pt,branch
WARNING: multiple event parsing errors
...
Invalid event/parameter 'fc_mask'
...

After:
$ perf --debug verbose=3D3 stat -M llc_misses.pcie_read sleep 1
Using CPUID GenuineIntel-6-55-4
metric expr unc_iio_data_req_of_cpu.mem_read.part0 + unc_iio_data_req_of_cp=
u.mem_read.part1 + unc_iio_data_req_of_cpu.mem_read.part2 + unc_iio_data_re=
q_of_cpu.mem_read.part3 for LLC_MISSES.PCIE_READ
found event unc_iio_data_req_of_cpu.mem_read.part0
found event unc_iio_data_req_of_cpu.mem_read.part1
found event unc_iio_data_req_of_cpu.mem_read.part2
found event unc_iio_data_req_of_cpu.mem_read.part3
metric expr unc_iio_data_req_of_cpu.mem_read.part0 + unc_iio_data_req_of_cp=
u.mem_read.part1 + unc_iio_data_req_of_cpu.mem_read.part2 + unc_iio_data_re=
q_of_cpu.mem_read.part3 for LLC_MISSES.PCIE_READ
found event unc_iio_data_req_of_cpu.mem_read.part0
found event unc_iio_data_req_of_cpu.mem_read.part1
found event unc_iio_data_req_of_cpu.mem_read.part2
found event unc_iio_data_req_of_cpu.mem_read.part3
adding {unc_iio_data_req_of_cpu.mem_read.part0,unc_iio_data_req_of_cpu.mem_=
read.part1,unc_iio_data_req_of_cpu.mem_read.part2,unc_iio_data_req_of_cpu.m=
em_read.part3}:W,{unc_iio_data_req_of_cpu.mem_read.part0,unc_iio_data_req_o=
f_cpu.mem_read.part1,unc_iio_data_req_of_cpu.mem_read.part2,unc_iio_data_re=
q_of_cpu.mem_read.part3}:W
intel_pt default config: tsc,mtc,mtc_period=3D3,psb_period=3D3,pt,branch
Attempting to add event pmu 'uncore_iio_free_running_5' with 'unc_iio_data_=
req_of_cpu.mem_read.part0,' that may result in non-fatal errors
After aliases, add event pmu 'uncore_iio_free_running_5' with 'fc_mask,ch_m=
ask,umask,event,' that may result in non-fatal errors
Attempting to add event pmu 'uncore_iio_free_running_3' with 'unc_iio_data_=
req_of_cpu.mem_read.part0,' that may result in non-fatal errors
After aliases, add event pmu 'uncore_iio_free_running_3' with 'fc_mask,ch_m=
ask,umask,event,' that may result in non-fatal errors
Attempting to add event pmu 'uncore_iio_free_running_1' with 'unc_iio_data_=
req_of_cpu.mem_read.part0,' that may result in non-fatal errors
After aliases, add event pmu 'uncore_iio_free_running_1' with 'fc_mask,ch_m=
ask,umask,event,' that may result in non-fatal errors
Multiple errors dropping message: unknown term 'fc_mask' for pmu 'uncore_ii=
o_free_running_3' (valid terms: event,umask,config,config1,config2,name,per=
iod,percore)
...

So before you see a 'WARNING: multiple event parsing errors' and
'Invalid event/parameter'. After you see 'Attempting... that may result
in non-fatal errors' then 'Multiple errors...' with details that
'fc_mask' wasn't known to a free running counter. While not completely
clean, this makes it clearer that an error hasn't really occurred.

v2. addresses review feedback from Jiri Olsa <jolsa@redhat.com>.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/intel-pt.c | 32 +++++++++++++++++-----------
 tools/perf/tests/pmu.c              |  4 ++--
 tools/perf/util/parse-events.c      | 29 ++++++++++++++++++++++++-
 tools/perf/util/pmu.c               | 33 ++++++++++++++++++-----------
 tools/perf/util/pmu.h               |  2 +-
 5 files changed, 72 insertions(+), 28 deletions(-)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util=
/intel-pt.c
index fd9e22d1e366..0fe401ad3347 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -59,7 +59,8 @@ struct intel_pt_recording {
 	size_t				priv_size;
 };
=20
-static int intel_pt_parse_terms_with_default(struct list_head *formats,
+static int intel_pt_parse_terms_with_default(const char *pmu_name,
+					     struct list_head *formats,
 					     const char *str,
 					     u64 *config)
 {
@@ -78,7 +79,8 @@ static int intel_pt_parse_terms_with_default(struct list_=
head *formats,
 		goto out_free;
=20
 	attr.config =3D *config;
-	err =3D perf_pmu__config_terms(formats, &attr, terms, true, NULL);
+	err =3D perf_pmu__config_terms(pmu_name, formats, &attr, terms, true,
+				     NULL);
 	if (err)
 		goto out_free;
=20
@@ -88,11 +90,12 @@ static int intel_pt_parse_terms_with_default(struct lis=
t_head *formats,
 	return err;
 }
=20
-static int intel_pt_parse_terms(struct list_head *formats, const char *str=
,
-				u64 *config)
+static int intel_pt_parse_terms(const char *pmu_name, struct list_head *fo=
rmats,
+				const char *str, u64 *config)
 {
 	*config =3D 0;
-	return intel_pt_parse_terms_with_default(formats, str, config);
+	return intel_pt_parse_terms_with_default(pmu_name, formats, str,
+						 config);
 }
=20
 static u64 intel_pt_masked_bits(u64 mask, u64 bits)
@@ -229,7 +232,8 @@ static u64 intel_pt_default_config(struct perf_pmu *int=
el_pt_pmu)
=20
 	pr_debug2("%s default config: %s\n", intel_pt_pmu->name, buf);
=20
-	intel_pt_parse_terms(&intel_pt_pmu->format, buf, &config);
+	intel_pt_parse_terms(intel_pt_pmu->name, &intel_pt_pmu->format, buf,
+			     &config);
=20
 	return config;
 }
@@ -337,13 +341,16 @@ static int intel_pt_info_fill(struct auxtrace_record =
*itr,
 	if (priv_size !=3D ptr->priv_size)
 		return -EINVAL;
=20
-	intel_pt_parse_terms(&intel_pt_pmu->format, "tsc", &tsc_bit);
-	intel_pt_parse_terms(&intel_pt_pmu->format, "noretcomp",
-			     &noretcomp_bit);
-	intel_pt_parse_terms(&intel_pt_pmu->format, "mtc", &mtc_bit);
+	intel_pt_parse_terms(intel_pt_pmu->name, &intel_pt_pmu->format,
+			     "tsc", &tsc_bit);
+	intel_pt_parse_terms(intel_pt_pmu->name, &intel_pt_pmu->format,
+			     "noretcomp", &noretcomp_bit);
+	intel_pt_parse_terms(intel_pt_pmu->name, &intel_pt_pmu->format,
+			     "mtc", &mtc_bit);
 	mtc_freq_bits =3D perf_pmu__format_bits(&intel_pt_pmu->format,
 					      "mtc_period");
-	intel_pt_parse_terms(&intel_pt_pmu->format, "cyc", &cyc_bit);
+	intel_pt_parse_terms(intel_pt_pmu->name, &intel_pt_pmu->format,
+			     "cyc", &cyc_bit);
=20
 	intel_pt_tsc_ctc_ratio(&tsc_ctc_ratio_n, &tsc_ctc_ratio_d);
=20
@@ -768,7 +775,8 @@ static int intel_pt_recording_options(struct auxtrace_r=
ecord *itr,
 		}
 	}
=20
-	intel_pt_parse_terms(&intel_pt_pmu->format, "tsc", &tsc_bit);
+	intel_pt_parse_terms(intel_pt_pmu->name, &intel_pt_pmu->format,
+			     "tsc", &tsc_bit);
=20
 	if (opts->full_auxtrace && (intel_pt_evsel->core.attr.config & tsc_bit))
 		have_timing_info =3D true;
diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index 74379ff1f7fa..5c11fe2b3040 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -156,8 +156,8 @@ int test__pmu(struct test *test __maybe_unused, int sub=
test __maybe_unused)
 		if (ret)
 			break;
=20
-		ret =3D perf_pmu__config_terms(&formats, &attr, terms,
-					     false, NULL);
+		ret =3D perf_pmu__config_terms("perf-pmu-test", &formats, &attr,
+					     terms, false, NULL);
 		if (ret)
 			break;
=20
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.=
c
index e37a6a3e6217..6434db2e10dd 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -204,7 +204,8 @@ void parse_events__handle_error(struct parse_events_err=
or *err, int idx,
 		err->help =3D help;
 		break;
 	default:
-		WARN_ONCE(1, "WARNING: multiple event parsing errors\n");
+		pr_debug("Multiple errors dropping message: %s (%s)\n",
+			err->str, err->help);
 		free(err->str);
 		err->str =3D str;
 		free(err->help);
@@ -1422,6 +1423,19 @@ int parse_events_add_pmu(struct parse_events_state *=
parse_state,
 	bool use_uncore_alias;
 	LIST_HEAD(config_terms);
=20
+	if (verbose > 1) {
+		fprintf(stderr, "Attempting to add event pmu '%s' with '",
+			name);
+		if (head_config) {
+			struct parse_events_term *term;
+
+			list_for_each_entry(term, head_config, list) {
+				fprintf(stderr, "%s,", term->config);
+			}
+		}
+		fprintf(stderr, "' that may result in non-fatal errors\n");
+	}
+
 	pmu =3D perf_pmu__find(name);
 	if (!pmu) {
 		char *err_str;
@@ -1458,6 +1472,19 @@ int parse_events_add_pmu(struct parse_events_state *=
parse_state,
 	if (perf_pmu__check_alias(pmu, head_config, &info))
 		return -EINVAL;
=20
+	if (verbose > 1) {
+		fprintf(stderr, "After aliases, add event pmu '%s' with '",
+			name);
+		if (head_config) {
+			struct parse_events_term *term;
+
+			list_for_each_entry(term, head_config, list) {
+				fprintf(stderr, "%s,", term->config);
+			}
+		}
+		fprintf(stderr, "' that may result in non-fatal errors\n");
+	}
+
 	/*
 	 * Configure hardcoded terms first, no need to check
 	 * return value when called with fail =3D=3D 0 ;)
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 92bd7fafcce6..93fe72a9dc0b 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1056,7 +1056,8 @@ static char *pmu_formats_string(struct list_head *for=
mats)
  * Setup one of config[12] attr members based on the
  * user input data - term parameter.
  */
-static int pmu_config_term(struct list_head *formats,
+static int pmu_config_term(const char *pmu_name,
+			   struct list_head *formats,
 			   struct perf_event_attr *attr,
 			   struct parse_events_term *term,
 			   struct list_head *head_terms,
@@ -1082,16 +1083,24 @@ static int pmu_config_term(struct list_head *format=
s,
=20
 	format =3D pmu_find_format(formats, term->config);
 	if (!format) {
-		if (verbose > 0)
-			printf("Invalid event/parameter '%s'\n", term->config);
+		char *pmu_term =3D pmu_formats_string(formats);
+		char *unknown_term;
+		char *help_msg;
+
+		if (asprintf(&unknown_term,
+				"unknown term '%s' for pmu '%s'",
+				term->config, pmu_name) < 0)
+			unknown_term =3D NULL;
+		help_msg =3D parse_events_formats_error_string(pmu_term);
 		if (err) {
-			char *pmu_term =3D pmu_formats_string(formats);
-
 			parse_events__handle_error(err, term->err_term,
-				strdup("unknown term"),
-				parse_events_formats_error_string(pmu_term));
-			free(pmu_term);
+						   unknown_term,
+						   help_msg);
+		} else {
+			pr_debug("%s (%s)\n", unknown_term, help_msg);
+			free(unknown_term);
 		}
+		free(pmu_term);
 		return -EINVAL;
 	}
=20
@@ -1168,7 +1177,7 @@ static int pmu_config_term(struct list_head *formats,
 	return 0;
 }
=20
-int perf_pmu__config_terms(struct list_head *formats,
+int perf_pmu__config_terms(const char *pmu_name, struct list_head *formats=
,
 			   struct perf_event_attr *attr,
 			   struct list_head *head_terms,
 			   bool zero, struct parse_events_error *err)
@@ -1176,7 +1185,7 @@ int perf_pmu__config_terms(struct list_head *formats,
 	struct parse_events_term *term;
=20
 	list_for_each_entry(term, head_terms, list) {
-		if (pmu_config_term(formats, attr, term, head_terms,
+		if (pmu_config_term(pmu_name, formats, attr, term, head_terms,
 				    zero, err))
 			return -EINVAL;
 	}
@@ -1196,8 +1205,8 @@ int perf_pmu__config(struct perf_pmu *pmu, struct per=
f_event_attr *attr,
 	bool zero =3D !!pmu->default_config;
=20
 	attr->type =3D pmu->type;
-	return perf_pmu__config_terms(&pmu->format, attr, head_terms,
-				      zero, err);
+	return perf_pmu__config_terms(pmu->name, &pmu->format, attr,
+				      head_terms, zero, err);
 }
=20
 static struct perf_pmu_alias *pmu_find_alias(struct perf_pmu *pmu,
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index e119333e93ba..85e0c7f2515c 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -76,7 +76,7 @@ struct perf_pmu *perf_pmu__find_by_type(unsigned int type=
);
 int perf_pmu__config(struct perf_pmu *pmu, struct perf_event_attr *attr,
 		     struct list_head *head_terms,
 		     struct parse_events_error *error);
-int perf_pmu__config_terms(struct list_head *formats,
+int perf_pmu__config_terms(const char *pmu_name, struct list_head *formats=
,
 			   struct perf_event_attr *attr,
 			   struct list_head *head_terms,
 			   bool zero, struct parse_events_error *error);
--=20
2.26.2.645.ge9eca65c58-goog

