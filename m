Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8534C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B23042075E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uk/NsdQD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbgHZK7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 06:59:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39456 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728605AbgHZK5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 06:57:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598439423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rzzC9oLg1V0ye9lbLu/Jhy5o2JSvq8on5DQ8qNbNSwY=;
        b=Uk/NsdQDz+epJyewGKCb5pUNIQPv9pfWRT0DFwofL4JEEIVmogzPlG5FVN8wLlLhhIpt+G
        ROq5MzokBUHV5qApHZJpIgR4KPo9kih6wYMIkWfEXKCHhyWulxzWsWcWjljPWsvl8mS+mf
        WS9yJ4MdkeR79Dx3+audu1h69lwcRvg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-8UOgWM5xOj249_QNCdqz_g-1; Wed, 26 Aug 2020 06:57:01 -0400
X-MC-Unique: 8UOgWM5xOj249_QNCdqz_g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 601F010051AF;
        Wed, 26 Aug 2020 10:57:00 +0000 (UTC)
Received: from krava (unknown [10.40.194.188])
        by smtp.corp.redhat.com (Postfix) with SMTP id CEEF47C682;
        Wed, 26 Aug 2020 10:56:57 +0000 (UTC)
Date:   Wed, 26 Aug 2020 12:56:56 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     acme@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, maddy@linux.ibm.com,
        ravi.bangoria@linux.ibm.com
Subject: Re: [RFC] perf/jevents: Add new structure to pass json fields.
Message-ID: <20200826105656.GC703542@krava>
References: <20200825074041.378520-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825074041.378520-1-kjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 01:10:41PM +0530, Kajol Jain wrote:

SNIP

>  {
>  	/* try to find matching event from arch standard values */
>  	struct event_struct *es;
> @@ -498,8 +486,7 @@ try_fixup(const char *fn, char *arch_std, char **event, char **desc,
>  		if (!strcmp(arch_std, es->name)) {
>  			if (!eventcode && es->event) {
>  				/* allow EventCode to be overridden */
> -				free(*event);
> -				*event = NULL;
> +				je->event = NULL;
>  			}
>  			FOR_ALL_EVENT_STRUCT_FIELDS(TRY_FIXUP_FIELD);
>  			return 0;
> @@ -513,13 +500,8 @@ try_fixup(const char *fn, char *arch_std, char **event, char **desc,
>  
>  /* Call func with each event in the json file */
>  int json_events(const char *fn,
> -	  int (*func)(void *data, char *name, char *event, char *desc,
> -		      char *long_desc,
> -		      char *pmu, char *unit, char *perpkg,
> -		      char *metric_expr,
> -		      char *metric_name, char *metric_group,
> -		      char *deprecated, char *metric_constraint),
> -	  void *data)
> +		int (*func)(void *data, struct json_event *je),
> +			void *data)
>  {
>  	int err;
>  	size_t size;
> @@ -537,24 +519,16 @@ int json_events(const char *fn,
>  	EXPECT(tokens->type == JSMN_ARRAY, tokens, "expected top level array");
>  	tok = tokens + 1;
>  	for (i = 0; i < tokens->size; i++) {
> -		char *event = NULL, *desc = NULL, *name = NULL;
> -		char *long_desc = NULL;
>  		char *extra_desc = NULL;
> -		char *pmu = NULL;
>  		char *filter = NULL;
> -		char *perpkg = NULL;
> -		char *unit = NULL;
> -		char *metric_expr = NULL;
> -		char *metric_name = NULL;
> -		char *metric_group = NULL;
> -		char *deprecated = NULL;
> -		char *metric_constraint = NULL;
> +		struct json_event *je;
>  		char *arch_std = NULL;
>  		unsigned long long eventcode = 0;
>  		struct msrmap *msr = NULL;
>  		jsmntok_t *msrval = NULL;
>  		jsmntok_t *precise = NULL;
>  		jsmntok_t *obj = tok++;
> +		je = (struct json_event *)calloc(1, sizeof(struct json_event));

hum, you don't check je pointer in here.. but does it need to be allocated?
looks like you could just have je on stack as well..

thanks,
jirka

