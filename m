Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D031DC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 09:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F28220719
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 09:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qwb+qlaP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgCZJ0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 05:26:02 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:50459 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727689AbgCZJ0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 05:26:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585214760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IhVzqliyJ8WaqEL7ERlWxS9vX4381zE4zrDPvL2hS08=;
        b=Qwb+qlaPIwRtKjgKhxzIAoe7Sx4oTnM9BN5y7IrgLah8uIzYhwQOvpRh2ARaQ4LK2AkezJ
        US+A6fZK/hMASJQQPaIERHU+gVg7/M7q4ZQc2FVeOrjJW7AjY13F/f4YNNMpJbRPpQ+dRf
        GryMSt3cz4JPXcSeqQJeVkygDSEw2vs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-q9Qt-RpVNpaw1iI85YrY0g-1; Thu, 26 Mar 2020 05:25:56 -0400
X-MC-Unique: q9Qt-RpVNpaw1iI85YrY0g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACE898017CC;
        Thu, 26 Mar 2020 09:25:55 +0000 (UTC)
Received: from krava (unknown [10.40.192.119])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 695F05D9C5;
        Thu, 26 Mar 2020 09:25:50 +0000 (UTC)
Date:   Thu, 26 Mar 2020 10:25:45 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        linux-kernel@vger.kernel.org, Kan Liang <kan.liang@intel.com>
Subject: Re: [PATCH V2] perf tools: Add missing Intel CPU events to parser
Message-ID: <20200326092545.GE1947699@krava>
References: <20200324150443.28832-1-adrian.hunter@intel.com>
 <20200325103345.GA1856035@krava>
 <20200325131549.GB14102@kernel.org>
 <20200325135350.GA1888042@krava>
 <20200325142214.GD14102@kernel.org>
 <ea516b26-6249-e870-20bf-819ea1a2d2c2@intel.com>
 <20200325152211.GA1908530@krava>
 <fc3c4dee-981e-4c39-566a-4163ee0bcc02@intel.com>
 <20200325174449.GB1934048@krava>
 <90c7ae07-c568-b6d3-f9c4-d0c1528a0610@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90c7ae07-c568-b6d3-f9c4-d0c1528a0610@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 10:01:47AM +0200, Adrian Hunter wrote:
> perf list expects CPU events to be parseable by name, e.g.
> 
>     # perf list | grep el-capacity-read
>       el-capacity-read OR cpu/el-capacity-read/          [Kernel PMU event]
> 
> But the event parser does not recognize them that way, e.g.
> 
>     # perf test -v "Parse event"
>     <SNIP>
>     running test 54 'cycles//u'
>     running test 55 'cycles:k'
>     running test 0 'cpu/config=10,config1,config2=3,period=1000/u'
>     running test 1 'cpu/config=1,name=krava/u,cpu/config=2/u'
>     running test 2 'cpu/config=1,call-graph=fp,time,period=100000/,cpu/config=2,call-graph=no,time=0,period=2000/'
>     running test 3 'cpu/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks',period=0x1,event=0x2/ukp'
>     -> cpu/event=0,umask=0x11/
>     -> cpu/event=0,umask=0x13/
>     -> cpu/event=0x54,umask=0x1/
>     failed to parse event 'el-capacity-read:u,cpu/event=el-capacity-read/u', err 1, str 'parser error'
>     event syntax error: 'el-capacity-read:u,cpu/event=el-capacity-read/u'
>                            \___ parser error test child finished with 1
>     ---- end ----
>     Parse event definition strings: FAILED!
> 
> This happens because the parser splits names by '-' in order to deal
> with cache events. For example 'L1-dcache' is a token in
> parse-events.l which is matched to 'L1-dcache-load-miss' by the
> following rule:
> 
>     PE_NAME_CACHE_TYPE '-' PE_NAME_CACHE_OP_RESULT '-' PE_NAME_CACHE_OP_RESULT opt_event_config
> 
> And so there is special handling for 2-part PMU names i.e.
> 
>     PE_PMU_EVENT_PRE '-' PE_PMU_EVENT_SUF sep_dc
> 
> but no handling for 3-part names, which are instead added as tokens e.g.
> 
>     topdown-[a-z-]+
> 
> While it would be possible to add a rule for 3-part names, that would
> not work if the first parts were also a valid PMU name e.g.
> 'el-capacity-read' would be matched to 'el-capacity' before the parser
> reached the 3rd part.
> 
> The parser would need significant change to rationalize all this, so
> instead fix for now by adding missing Intel CPU events with 3-part names
> to the event parser as tokens.
> 
> Missing events were found by using:
> 
>     grep -r EVENT_ATTR_STR arch/x86/events/intel/core.c
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

