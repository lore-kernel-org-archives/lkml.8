Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CBDC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E120720716
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hoKCJce5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgCLKwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 06:52:11 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56349 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726044AbgCLKwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 06:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584010330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R+E7IwCKDlOkibK9pQlSg0fG3D+6SSYGlZXYefrXYlo=;
        b=hoKCJce5IQ2vmNnS4FTcx9dou0AcfZGETWc1SIuhNiMrxjJIwJC6+CAuYGnTw6EbDM5ZjB
        0r+vXSQObrrTv1h0ld5bvA/jMpUX3ffs1/yfvAlEyp5xLPXJrHA2Y42WhHQ3eN+PN0XtHh
        aAQWG/7E5AzQz50fu9k8ZhJsvgk+DJw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-N6K3NEdRMl6BFcClDJVGsQ-1; Thu, 12 Mar 2020 06:52:06 -0400
X-MC-Unique: N6K3NEdRMl6BFcClDJVGsQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5CDC800D48;
        Thu, 12 Mar 2020 10:52:02 +0000 (UTC)
Received: from krava (ovpn-204-40.brq.redhat.com [10.40.204.40])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CDC3060BF1;
        Thu, 12 Mar 2020 10:51:55 +0000 (UTC)
Date:   Thu, 12 Mar 2020 11:51:45 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Kajol Jain <kjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
        ravi.bangoria@linux.ibm.com, peterz@infradead.org,
        yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org,
        kan.liang@linux.intel.com, jmario@redhat.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com,
        gregkh@linuxfoundation.org, benh@kernel.crashing.org,
        mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com,
        tglx@linutronix.de
Subject: Re: [PATCH v4 6/8] perf/tools: Enhance JSON/metric infrastructure to
 handle "?"
Message-ID: <20200312105145.GC311223@krava>
References: <20200309062552.29911-1-kjain@linux.ibm.com>
 <20200309062552.29911-7-kjain@linux.ibm.com>
 <20200310183455.GB12036@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310183455.GB12036@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 03:34:55PM -0300, Arnaldo Carvalho de Melo wrote:

SNIP

> > diff --git a/tools/perf/arch/powerpc/util/header.c b/tools/perf/arch/powerpc/util/header.c
> > index 3b4cdfc5efd6..036f6b2ce202 100644
> > --- a/tools/perf/arch/powerpc/util/header.c
> > +++ b/tools/perf/arch/powerpc/util/header.c
> > @@ -7,6 +7,11 @@
> >  #include <string.h>
> >  #include <linux/stringify.h>
> >  #include "header.h"
> > +#include "metricgroup.h"
> > +#include "evlist.h"
> > +#include <dirent.h>
> > +#include "pmu.h"
> > +#include <api/fs/fs.h>
> >  
> >  #define mfspr(rn)       ({unsigned long rval; \
> >  			 asm volatile("mfspr %0," __stringify(rn) \
> > @@ -16,6 +21,8 @@
> >  #define PVR_VER(pvr)    (((pvr) >>  16) & 0xFFFF) /* Version field */
> >  #define PVR_REV(pvr)    (((pvr) >>   0) & 0xFFFF) /* Revison field */
> >  
> > +#define SOCKETS_INFO_FILE_PATH "/devices/hv_24x7/interface/"
> > +
> >  int
> >  get_cpuid(char *buffer, size_t sz)
> >  {
> > @@ -44,3 +51,18 @@ get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
> >  
> >  	return bufp;
> >  }
> > +
> > +int arch_get_runtimeparam(void)
> > +{
> > +	int count;
> > +	char path[PATH_MAX];
> > +	char filename[] = "sockets";
> > +
> > +	snprintf(path, PATH_MAX,
> > +		 SOCKETS_INFO_FILE_PATH "%s", filename);

also, what's the point of using snprintf in here?

jirka

