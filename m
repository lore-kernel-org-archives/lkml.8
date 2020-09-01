Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A81C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 20:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CC8F207D3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 20:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IEnvCMEb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgIAUhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 16:37:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59147 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726091AbgIAUhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 16:37:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598992639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=unRPqSfplhG23lqMtqFZh65e87vTYvYCakQ35+qVUdk=;
        b=IEnvCMEb/MDlTmy8E6Q2lSuWJ9onYZXTzQNQDe6NJbi+bNlUyFA7G4tNZT9ZDlFbWiCOIp
        FZnyPZ5ozH5Z77czrSvm3SNWzjFYEGLmh/ValpUFVPez6Ka/RB+kr5eBP1/fdYMVGtMnH7
        1agvxDl8turP4jXqhM+cblLiNcb76rM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-dfrIraDaMFSNsLKo5TPOew-1; Tue, 01 Sep 2020 16:37:15 -0400
X-MC-Unique: dfrIraDaMFSNsLKo5TPOew-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0275E51B7;
        Tue,  1 Sep 2020 20:37:11 +0000 (UTC)
Received: from krava (unknown [10.40.193.186])
        by smtp.corp.redhat.com (Postfix) with SMTP id BD5DD5D9CC;
        Tue,  1 Sep 2020 20:37:07 +0000 (UTC)
Date:   Tue, 1 Sep 2020 22:37:06 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     kajoljain <kjain@linux.ibm.com>
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        pc@us.ibm.com, namhyung@kernel.org, ak@linux.intel.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com,
        john.garry@huawei.com
Subject: Re: [PATCH v6 2/5] perf/jevents: Add new structure to pass json
 fields.
Message-ID: <20200901203706.GB656443@krava>
References: <20200827130958.189146-1-kjain@linux.ibm.com>
 <20200827130958.189146-3-kjain@linux.ibm.com>
 <20200831084357.GC287892@krava>
 <e0cd9e5c-2e9a-5198-108e-14998a757d62@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0cd9e5c-2e9a-5198-108e-14998a757d62@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 11:32:45AM +0530, kajoljain wrote:
> 
> 
> On 8/31/20 2:13 PM, Jiri Olsa wrote:
> > On Thu, Aug 27, 2020 at 06:39:55PM +0530, Kajol Jain wrote:
> > 
> > SNIP
> > 
> >> -	if (!*field)						\
> >> +#define TRY_FIXUP_FIELD(field) do { if (es->field && !je->field) {\
> >> +	je->field = strdup(es->field);				\
> >> +	if (!je->field)						\
> >>  		return -ENOMEM;					\
> >>  } } while (0)
> >>  
> >> @@ -428,11 +440,7 @@ static void free_arch_std_events(void)
> >>  	}
> >>  }
> >>  
> >> -static int save_arch_std_events(void *data, char *name, char *event,
> >> -				char *desc, char *long_desc, char *pmu,
> >> -				char *unit, char *perpkg, char *metric_expr,
> >> -				char *metric_name, char *metric_group,
> >> -				char *deprecated, char *metric_constraint)
> >> +static int save_arch_std_events(void *data, struct json_event *je)
> >>  {
> >>  	struct event_struct *es;
> >>  
> >> @@ -486,17 +494,16 @@ static char *real_event(const char *name, char *event)
> >>  		return NULL;
> >>  
> >>  	for (i = 0; fixed[i].name; i++)
> >> -		if (!strcasecmp(name, fixed[i].name))
> >> -			return (char *)fixed[i].event;
> >> +		if (!strcasecmp(name, fixed[i].name)) {
> >> +			strcpy(event, fixed[i].event);
> > 
> > hum what's this strcpy for in here? we're just replacing separated
> > variables with struct members, why do you need to copy the event in
> > here?
> > 
> 
> Hi Jiri,
>     Actually, initially when events is not part of 'json_event' structure, we are not
> assigning result of function `real_event` to event field. But as we are not passing
> event filed separately in functions like 'save_arch_std_events', freeing event
> memory was giving me issue as we are returning pointer from real_event function in some cases.
> So, that's why I replace it to strcpy to make sure we free je.event memory. Or should I remove
> free(je.event) part?
> 
> -		err = func(data, name, real_event(name, event), desc, long_desc,
> -			   pmu, unit, perpkg, metric_expr, metric_name,
> -			   metric_group, deprecated, metric_constraint);
> +		je.event = real_event(je.name, je.event);
> 
> This is the part, I am referring, here we are assigning result of real_event into je.event field.

hum, I dont't think you can strcpy like that in real_event,

but how about keeping the event variable on stack and freeing
just that one as the original code is doing.. like in change
below, it's diff against your patch

thanks,
jirka


---
diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index b205cd904a4f..6abd2abf62fc 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -494,10 +494,8 @@ static char *real_event(const char *name, char *event)
 		return NULL;
 
 	for (i = 0; fixed[i].name; i++)
-		if (!strcasecmp(name, fixed[i].name)) {
-			strcpy(event, fixed[i].event);
+		if (!strcasecmp(name, fixed[i].name))
 			return event;
-		}
 	return event;
 }
 
@@ -546,6 +544,7 @@ int json_events(const char *fn,
 	EXPECT(tokens->type == JSMN_ARRAY, tokens, "expected top level array");
 	tok = tokens + 1;
 	for (i = 0; i < tokens->size; i++) {
+		char *event = NULL;
 		char *extra_desc = NULL;
 		char *filter = NULL;
 		struct json_event je = {};
@@ -570,7 +569,7 @@ int json_events(const char *fn,
 			       "Expected string value");
 
 			nz = !json_streq(map, val, "0");
-			if (match_field(map, field, nz, &je.event, val)) {
+			if (match_field(map, field, nz, &event, val)) {
 				/* ok */
 			} else if (json_streq(map, field, "EventCode")) {
 				char *code = NULL;
@@ -655,15 +654,15 @@ int json_events(const char *fn,
 						"(Precise event)", NULL);
 		}
 		snprintf(buf, sizeof buf, "event=%#llx", eventcode);
-		addfield(map, &je.event, ",", buf, NULL);
+		addfield(map, &event, ",", buf, NULL);
 		if (je.desc && extra_desc)
 			addfield(map, &je.desc, " ", extra_desc, NULL);
 		if (je.long_desc && extra_desc)
 			addfield(map, &je.long_desc, " ", extra_desc, NULL);
 		if (filter)
-			addfield(map, &je.event, ",", filter, NULL);
+			addfield(map, &event, ",", filter, NULL);
 		if (msr != NULL)
-			addfield(map, &je.event, ",", msr->pname, msrval);
+			addfield(map, &event, ",", msr->pname, msrval);
 		if (je.name)
 			fixname(je.name);
 
@@ -676,10 +675,10 @@ int json_events(const char *fn,
 			if (err)
 				goto free_strings;
 		}
-		je.event = real_event(je.name, je.event);
+		je.event = real_event(je.name, event);
 		err = func(data, &je);
 free_strings:
-		free(je.event);
+		free(event);
 		free(je.desc);
 		free(je.name);
 		free(je.long_desc);

