Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35971C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 057F22071E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wv28GJcK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbgHZMAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 08:00:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40075 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729362AbgHZMAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 08:00:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598443204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vxOMv7aIE5VKOI8Z8uOxqjwFJ74Uuc9uROH2S5YI5WA=;
        b=Wv28GJcKi2HF7ZDlmFlOxdTpW/O4g+uoJcS+qURpT+cRtow3boBrvDmQdPL9GJ2k+yJ9K0
        WMpD6iXvVOlSZfePY3s7C6hB63GZkNjaycXyM6MHGGWpi5CW2eOFXdY++RelPzpZOHFHSg
        loNGaRzht4w0CCAN4ndoJgi9KIQkJPM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-688zvG8OMhCFXbTeDPUExA-1; Wed, 26 Aug 2020 08:00:00 -0400
X-MC-Unique: 688zvG8OMhCFXbTeDPUExA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C72681CAF9;
        Wed, 26 Aug 2020 11:59:58 +0000 (UTC)
Received: from krava (unknown [10.40.194.188])
        by smtp.corp.redhat.com (Postfix) with SMTP id 15D1C77DD1;
        Wed, 26 Aug 2020 11:59:55 +0000 (UTC)
Date:   Wed, 26 Aug 2020 13:59:54 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     kajoljain <kjain@linux.ibm.com>
Cc:     acme@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, maddy@linux.ibm.com,
        ravi.bangoria@linux.ibm.com
Subject: Re: [RFC] perf/jevents: Add new structure to pass json fields.
Message-ID: <20200826115954.GA766216@krava>
References: <20200825074041.378520-1-kjain@linux.ibm.com>
 <20200826105656.GC703542@krava>
 <6a4e977e-4f77-6a2a-252c-cfdda26db3e2@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a4e977e-4f77-6a2a-252c-cfdda26db3e2@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 05:02:04PM +0530, kajoljain wrote:
> 
> 
> On 8/26/20 4:26 PM, Jiri Olsa wrote:
> > On Tue, Aug 25, 2020 at 01:10:41PM +0530, Kajol Jain wrote:
> > 
> > SNIP
> > 
> >>  {
> >>  	/* try to find matching event from arch standard values */
> >>  	struct event_struct *es;
> >> @@ -498,8 +486,7 @@ try_fixup(const char *fn, char *arch_std, char **event, char **desc,
> >>  		if (!strcmp(arch_std, es->name)) {
> >>  			if (!eventcode && es->event) {
> >>  				/* allow EventCode to be overridden */
> >> -				free(*event);
> >> -				*event = NULL;
> >> +				je->event = NULL;
> >>  			}
> >>  			FOR_ALL_EVENT_STRUCT_FIELDS(TRY_FIXUP_FIELD);
> >>  			return 0;
> >> @@ -513,13 +500,8 @@ try_fixup(const char *fn, char *arch_std, char **event, char **desc,
> >>  
> >>  /* Call func with each event in the json file */
> >>  int json_events(const char *fn,
> >> -	  int (*func)(void *data, char *name, char *event, char *desc,
> >> -		      char *long_desc,
> >> -		      char *pmu, char *unit, char *perpkg,
> >> -		      char *metric_expr,
> >> -		      char *metric_name, char *metric_group,
> >> -		      char *deprecated, char *metric_constraint),
> >> -	  void *data)
> >> +		int (*func)(void *data, struct json_event *je),
> >> +			void *data)
> >>  {
> >>  	int err;
> >>  	size_t size;
> >> @@ -537,24 +519,16 @@ int json_events(const char *fn,
> >>  	EXPECT(tokens->type == JSMN_ARRAY, tokens, "expected top level array");
> >>  	tok = tokens + 1;
> >>  	for (i = 0; i < tokens->size; i++) {
> >> -		char *event = NULL, *desc = NULL, *name = NULL;
> >> -		char *long_desc = NULL;
> >>  		char *extra_desc = NULL;
> >> -		char *pmu = NULL;
> >>  		char *filter = NULL;
> >> -		char *perpkg = NULL;
> >> -		char *unit = NULL;
> >> -		char *metric_expr = NULL;
> >> -		char *metric_name = NULL;
> >> -		char *metric_group = NULL;
> >> -		char *deprecated = NULL;
> >> -		char *metric_constraint = NULL;
> >> +		struct json_event *je;
> >>  		char *arch_std = NULL;
> >>  		unsigned long long eventcode = 0;
> >>  		struct msrmap *msr = NULL;
> >>  		jsmntok_t *msrval = NULL;
> >>  		jsmntok_t *precise = NULL;
> >>  		jsmntok_t *obj = tok++;
> >> +		je = (struct json_event *)calloc(1, sizeof(struct json_event));
> > 
> > hum, you don't check je pointer in here.. but does it need to be allocated?
> > looks like you could just have je on stack as well..
> 
> Hi Jiri,
>    Yes I will add check for je pointer here.The reason for allocating memory to 'je' is,
> later we are actually referring one by one to its field and in case if won't allocate memory
> we will get segmentaion fault as otherwise je will be NULL. Please let me know if I am
> getting correct.

I don't see reason why not to use automatic variable in here,
I tried and it seems to work.. below is diff to your changes,
feel free to squash it with your changes

jirka

---
diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 606805af69fe..eaac5c126a52 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -521,14 +521,13 @@ int json_events(const char *fn,
 	for (i = 0; i < tokens->size; i++) {
 		char *extra_desc = NULL;
 		char *filter = NULL;
-		struct json_event *je;
+		struct json_event je = {};
 		char *arch_std = NULL;
 		unsigned long long eventcode = 0;
 		struct msrmap *msr = NULL;
 		jsmntok_t *msrval = NULL;
 		jsmntok_t *precise = NULL;
 		jsmntok_t *obj = tok++;
-		je = (struct json_event *)calloc(1, sizeof(struct json_event));
 
 		EXPECT(obj->type == JSMN_OBJECT, obj, "expected object");
 		for (j = 0; j < obj->size; j += 2) {
@@ -544,7 +543,7 @@ int json_events(const char *fn,
 			       "Expected string value");
 
 			nz = !json_streq(map, val, "0");
-			if (match_field(map, field, nz, &je->event, val)) {
+			if (match_field(map, field, nz, &je.event, val)) {
 				/* ok */
 			} else if (json_streq(map, field, "EventCode")) {
 				char *code = NULL;
@@ -557,14 +556,14 @@ int json_events(const char *fn,
 				eventcode |= strtoul(code, NULL, 0) << 21;
 				free(code);
 			} else if (json_streq(map, field, "EventName")) {
-				addfield(map, &je->name, "", "", val);
+				addfield(map, &je.name, "", "", val);
 			} else if (json_streq(map, field, "BriefDescription")) {
-				addfield(map, &je->desc, "", "", val);
-				fixdesc(je->desc);
+				addfield(map, &je.desc, "", "", val);
+				fixdesc(je.desc);
 			} else if (json_streq(map, field,
 					     "PublicDescription")) {
-				addfield(map, &je->long_desc, "", "", val);
-				fixdesc(je->long_desc);
+				addfield(map, &je.long_desc, "", "", val);
+				fixdesc(je.long_desc);
 			} else if (json_streq(map, field, "PEBS") && nz) {
 				precise = val;
 			} else if (json_streq(map, field, "MSRIndex") && nz) {
@@ -584,34 +583,34 @@ int json_events(const char *fn,
 
 				ppmu = field_to_perf(unit_to_pmu, map, val);
 				if (ppmu) {
-					je->pmu = strdup(ppmu);
+					je.pmu = strdup(ppmu);
 				} else {
-					if (!je->pmu)
-						je->pmu = strdup("uncore_");
-					addfield(map, &je->pmu, "", "", val);
-					for (s = je->pmu; *s; s++)
+					if (!je.pmu)
+						je.pmu = strdup("uncore_");
+					addfield(map, &je.pmu, "", "", val);
+					for (s = je.pmu; *s; s++)
 						*s = tolower(*s);
 				}
-				addfield(map, &je->desc, ". ", "Unit: ", NULL);
-				addfield(map, &je->desc, "", je->pmu, NULL);
-				addfield(map, &je->desc, "", " ", NULL);
+				addfield(map, &je.desc, ". ", "Unit: ", NULL);
+				addfield(map, &je.desc, "", je.pmu, NULL);
+				addfield(map, &je.desc, "", " ", NULL);
 			} else if (json_streq(map, field, "Filter")) {
 				addfield(map, &filter, "", "", val);
 			} else if (json_streq(map, field, "ScaleUnit")) {
-				addfield(map, &je->unit, "", "", val);
+				addfield(map, &je.unit, "", "", val);
 			} else if (json_streq(map, field, "PerPkg")) {
-				addfield(map, &je->perpkg, "", "", val);
+				addfield(map, &je.perpkg, "", "", val);
 			} else if (json_streq(map, field, "Deprecated")) {
-				addfield(map, &je->deprecated, "", "", val);
+				addfield(map, &je.deprecated, "", "", val);
 			} else if (json_streq(map, field, "MetricName")) {
-				addfield(map, &je->metric_name, "", "", val);
+				addfield(map, &je.metric_name, "", "", val);
 			} else if (json_streq(map, field, "MetricGroup")) {
-				addfield(map, &je->metric_group, "", "", val);
+				addfield(map, &je.metric_group, "", "", val);
 			} else if (json_streq(map, field, "MetricConstraint")) {
-				addfield(map, &je->metric_constraint, "", "", val);
+				addfield(map, &je.metric_constraint, "", "", val);
 			} else if (json_streq(map, field, "MetricExpr")) {
-				addfield(map, &je->metric_expr, "", "", val);
-				for (s = je->metric_expr; *s; s++)
+				addfield(map, &je.metric_expr, "", "", val);
+				for (s = je.metric_expr; *s; s++)
 					*s = tolower(*s);
 			} else if (json_streq(map, field, "ArchStdEvent")) {
 				addfield(map, &arch_std, "", "", val);
@@ -620,7 +619,7 @@ int json_events(const char *fn,
 			}
 			/* ignore unknown fields */
 		}
-		if (precise && je->desc && !strstr(je->desc, "(Precise Event)")) {
+		if (precise && je.desc && !strstr(je.desc, "(Precise Event)")) {
 			if (json_streq(map, precise, "2"))
 				addfield(map, &extra_desc, " ",
 						"(Must be precise)", NULL);
@@ -629,34 +628,33 @@ int json_events(const char *fn,
 						"(Precise event)", NULL);
 		}
 		snprintf(buf, sizeof buf, "event=%#llx", eventcode);
-		addfield(map, &je->event, ",", buf, NULL);
-		if (je->desc && extra_desc)
-			addfield(map, &je->desc, " ", extra_desc, NULL);
-		if (je->long_desc && extra_desc)
-			addfield(map, &je->long_desc, " ", extra_desc, NULL);
+		addfield(map, &je.event, ",", buf, NULL);
+		if (je.desc && extra_desc)
+			addfield(map, &je.desc, " ", extra_desc, NULL);
+		if (je.long_desc && extra_desc)
+			addfield(map, &je.long_desc, " ", extra_desc, NULL);
 		if (filter)
-			addfield(map, &je->event, ",", filter, NULL);
+			addfield(map, &je.event, ",", filter, NULL);
 		if (msr != NULL)
-			addfield(map, &je->event, ",", msr->pname, msrval);
-		if (je->name)
-			fixname(je->name);
+			addfield(map, &je.event, ",", msr->pname, msrval);
+		if (je.name)
+			fixname(je.name);
 
 		if (arch_std) {
 			/*
 			 * An arch standard event is referenced, so try to
 			 * fixup any unassigned values.
 			 */
-			err = try_fixup(fn, arch_std, eventcode, je);
+			err = try_fixup(fn, arch_std, eventcode, &je);
 			if (err)
 				goto free_strings;
 		}
-		je->event = real_event(je->name, je->event);
-		err = func(data, je);
+		je.event = real_event(je.name, je.event);
+		err = func(data, &je);
 free_strings:
 		free(extra_desc);
 		free(filter);
 		free(arch_std);
-		free(je);
 
 		if (err)
 			break;

