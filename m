Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6CAC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 22:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6226220757
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 22:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="So0J2207"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgF1WSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 18:18:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49980 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726104AbgF1WSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 18:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593382680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b03SREaTe9QCT+KgkDJM853mt5KM538Vl06aiF/oOIE=;
        b=So0J2207Sps49gExQY8OTBtA7RnRPnghG+6eCWH2ERgtJufv2E9o4sBjd/VQpjc+SZpjmn
        zV0qEG0I+MVPR3tMMdIGNv4hGr1D7BN2xDDMGwOG7jlWvP7F72rnmJiLxZWTRhYi/dqnM5
        iO4KFt+CmIQ1Vl1CIDWVcu8K/ExzTAU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-EPzhx4CSNp6F1Sb0FdLAfw-1; Sun, 28 Jun 2020 18:17:56 -0400
X-MC-Unique: EPzhx4CSNp6F1Sb0FdLAfw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D03D4107ACCA;
        Sun, 28 Jun 2020 22:17:54 +0000 (UTC)
Received: from krava (unknown [10.40.192.56])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8BE49121B6A;
        Sun, 28 Jun 2020 22:17:51 +0000 (UTC)
Date:   Mon, 29 Jun 2020 00:17:50 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>, Ian Rogers <irogers@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [RFC 00/10] perf tools: Add support to reuse metric
Message-ID: <20200628221750.GT2988321@krava>
References: <20200626194720.2915044-1-jolsa@kernel.org>
 <20200626212522.GF818054@tassilo.jf.intel.com>
 <CAP-5=fVMs4Ok3=gYmzheNTzbBUGGHbCr0cpJSm9TV45aeZb4Ng@mail.gmail.com>
 <20200626215759.GG818054@tassilo.jf.intel.com>
 <20200627124821.GF29008@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200627124821.GF29008@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 27, 2020 at 09:48:21AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Jun 26, 2020 at 02:57:59PM -0700, Andi Kleen escreveu:
> > > The name could be a metric or an event, the logic for each is quite
> > 
> > I would say collisions are unlikely. Event names follow quite structured
> > patterns.
> 
> And when introducing a new metric the build process can detect that
> clash and fail.
>  
> > > different. You could look up an event and when it fails assume it was
> > > a metric, but I like the simplicity of this approach.
>  
> > I don't think it's simpler for the user.
> 
> Agreed.
>  
> > > Maybe this
> > > change could be adopted more widely with something like "perf stat -e
> > > metric:IPC -a -I 1000" rather than the current "perf stat -M IPC -a -I
> > > 1000".
> > 
> > I thought about just adding metrics to -e, without metric: of course.
> 
> Ditto.
> 
> - Arnaldo
> 

I guess I wanted to clearly separate other metrics from the expression,
also running through the whole lists of metrics for each id did not
seem good.. but it's actualy not that bad (compared to other things we
do ;-), and if you guys prefer not using a prefix I think it's ok

thanks,
jirka

