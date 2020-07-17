Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48779C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C4F02083E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kgc1xswM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgGQIxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 04:53:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28824 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725864AbgGQIxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 04:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594975992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R2m5yzd2gp9fALP7gnJ+6pZIx19O89rB+rCrvzCd/mU=;
        b=Kgc1xswMOccevsak3pv32MwU7s48Crc+IEm7PHYCMfrthTQlPHsCM6MmSwRKZr1KbPoMck
        819sWB5GI7oxDOIHJrjwa98iSZcOOpxP2PaW2BjIqVU6DfF8a2d0x69BC4XKoPoMdiSSnj
        Tvb2ftq23b8nZCoF09nYra1XQ/un+E4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-D7PoZUfJNUiFr6InOjcSuA-1; Fri, 17 Jul 2020 04:53:10 -0400
X-MC-Unique: D7PoZUfJNUiFr6InOjcSuA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CDEC102C849;
        Fri, 17 Jul 2020 08:53:07 +0000 (UTC)
Received: from krava (unknown [10.40.192.81])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5C33672AF8;
        Fri, 17 Jul 2020 08:53:02 +0000 (UTC)
Date:   Fri, 17 Jul 2020 10:53:01 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        pc@us.ibm.com, namhyung@kernel.org, ak@linux.intel.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com,
        anju@linux.vnet.ibm.com, kan.liang@linux.intel.com,
        nasastry@in.ibm.com
Subject: Re: [PATCH v3 1/5] perf/pmu-events/jevents: Add enum to store
 aggregation like PerPkg
Message-ID: <20200717085301.GB528602@krava>
References: <20200716094216.1418659-1-kjain@linux.ibm.com>
 <20200716094216.1418659-2-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716094216.1418659-2-kjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 03:12:12PM +0530, Kajol Jain wrote:
> Initially, every time we want to add new terms like chip, core thread etc,
> we need to create corrsponding fields in pmu_events and event struct.
> This patch adds an enum called 'aggr_mode_class' which store all these
> aggregation like perpkg/percore. It also adds new field 'aggr_mode'
> to capture these terms.
> Now, if user wants to add any new term, they just need to add it in
> the enum defined.
> 
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> ---
>  tools/perf/pmu-events/jevents.c    | 39 +++++++++++++++++++-----------
>  tools/perf/pmu-events/jevents.h    |  2 +-
>  tools/perf/pmu-events/pmu-events.h |  6 ++++-
>  tools/perf/tests/pmu-events.c      |  8 +++---
>  tools/perf/util/pmu.c              |  6 ++---
>  5 files changed, 38 insertions(+), 23 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> index fa86c5f997cc..b2f59f0af63d 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -53,6 +53,17 @@
>  int verbose;
>  char *prog;
>  
> +enum aggr_mode_class {
> +	PerPkg = 1
> +};
> +
> +enum aggr_mode_class convert(const char *aggr_mode)
> +{
> +	if (!strcmp(aggr_mode, "PerPkg"))
> +		return PerPkg;
> +	return -1;
> +}

I just noticed you define aggr_mode_class twice,
I think we should keep it just in pmu-events.h
like in change below (compiles for me)

thanks,
jirka


---
diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index e1c43f739083..2f48b783a64d 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -49,16 +49,11 @@
 #include "jsmn.h"
 #include "json.h"
 #include "jevents.h"
+#include "pmu-events.h"
 
 int verbose;
 char *prog;
 
-enum aggr_mode_class {
-	PerPkg = 1,
-	PerChip,
-	PerCore
-};
-
 enum aggr_mode_class convert(const char *aggr_mode)
 {
 	if (!strcmp(aggr_mode, "PerPkg"))

