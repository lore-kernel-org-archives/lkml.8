Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8CFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A0F42075B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IVRMdF5J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgFDIe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 04:34:26 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44115 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726802AbgFDIe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 04:34:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591259664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MY7gosntZyRVCAkzfX2AHr3cS9sWbmmToluAIV7gnzA=;
        b=IVRMdF5JTU1oj/U1CEmZXs7HaIQsU6RJBsy1u5T1xAj1+lECA8tVqiTnPqlICeqEiD0Kp7
        NSdamYuVmeLPt+2zAOcXKoDeNXxMfxE+WFEtWTKHvJMlGyHmZgzCxjCwB92MEmP+SIfahu
        s1nySAnSEqwXjNJ2G9TAN7Frq4wccx0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-JVyp_s-RPnCG6EDEN2Hufw-1; Thu, 04 Jun 2020 04:34:22 -0400
X-MC-Unique: JVyp_s-RPnCG6EDEN2Hufw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F29A464;
        Thu,  4 Jun 2020 08:34:21 +0000 (UTC)
Received: from krava (unknown [10.40.192.62])
        by smtp.corp.redhat.com (Postfix) with SMTP id AA0C06111F;
        Thu,  4 Jun 2020 08:34:17 +0000 (UTC)
Date:   Thu, 4 Jun 2020 10:34:16 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH 1/2] perf tools: check libasan and libubsan in
 Makefile.config
Message-ID: <20200604083416.GA1283757@krava>
References: <1591071304-19338-1-git-send-email-yangtiezhu@loongson.cn>
 <20200602141551.GC1169993@krava>
 <35e55bec-1f8a-0e8f-798b-bab51ad30797@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35e55bec-1f8a-0e8f-798b-bab51ad30797@loongson.cn>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 10:01:27AM +0800, Tiezhu Yang wrote:

SNIP

> > > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > > index 12a8204..b699d21 100644
> > > --- a/tools/perf/Makefile.config
> > > +++ b/tools/perf/Makefile.config
> > > @@ -387,6 +387,12 @@ else
> > >         NO_LIBBPF := 1
> > >         NO_JVMTI := 1
> > >       else
> > > +      ifneq ($(shell ldconfig -p | grep libasan >/dev/null 2>&1; echo $$?), 0)
> > > +        msg := $(error No libasan found, please install libasan);
> > > +      endif
> > > +      ifneq ($(shell ldconfig -p | grep libubsan >/dev/null 2>&1; echo $$?), 0)
> > > +        msg := $(error No libubsan found, please install libubsan);
> > > +      endif
> > hum, would it be better to have check for this in tools/build/features?
> 
> Hi Jiri,
> 
> Thanks for your suggestion.
> 
> Do you mean that it is better to add this check at the end of file
> tools/build/Makefile.feature?

we usualy detect installed libraries via tools/build/features framework,
this looks like it could fit in there

jirka

> 
> > 
> > jirka
> > 
> > >         ifneq ($(filter s% -static%,$(LDFLAGS),),)
> > >           msg := $(error No static glibc found, please install glibc-static);
> > >         else
> > > -- 
> > > 2.1.0
> > > 
> 

