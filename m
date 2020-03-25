Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32889C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 13:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 077A220663
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 13:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OVhCj5N1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbgCYNyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 09:54:04 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:49964 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727400AbgCYNyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 09:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585144442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/4VxL/3n2wwkAxdAocEhluwFbDPieQfQMLt4GawbFZU=;
        b=OVhCj5N1LmmiamujauveY2jOo0WyFjwhllEhZ0pzz2lHu7e9zPAV+HIHiWxGxZU/GArQ3z
        igaKjYOHSIeX/Gr2xjWDoM/hnbwJydlRunVyIDyPoLRQ4HU0w8PJ6UBhFx/amtgIU9/Ujx
        K6Pzf12Wq6oC6wmIot0o2ojCd8Rk2Ko=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-2iMpxqAnM-Wn4LSdBltDVA-1; Wed, 25 Mar 2020 09:53:58 -0400
X-MC-Unique: 2iMpxqAnM-Wn4LSdBltDVA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EEFA149C0;
        Wed, 25 Mar 2020 13:53:57 +0000 (UTC)
Received: from krava (unknown [10.40.192.119])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B98810027B6;
        Wed, 25 Mar 2020 13:53:55 +0000 (UTC)
Date:   Wed, 25 Mar 2020 14:53:50 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Add missing Intel CPU events to parser
Message-ID: <20200325135350.GA1888042@krava>
References: <20200324150443.28832-1-adrian.hunter@intel.com>
 <20200325103345.GA1856035@krava>
 <20200325131549.GB14102@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325131549.GB14102@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 10:15:49AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Mar 25, 2020 at 11:33:45AM +0100, Jiri Olsa escreveu:
> > On Tue, Mar 24, 2020 at 05:04:43PM +0200, Adrian Hunter wrote:
> > > perf list expects CPU events to be parseable by name, e.g.
> 
> > >     # perf list | grep el-capacity-read
> > >       el-capacity-read OR cpu/el-capacity-read/          [Kernel PMU event]
> 
> > > But the event parser does not recognize them that way, e.g.
> 
> > >     # perf test -v "Parse event"
> > >     <SNIP>
> > >     running test 54 'cycles//u'
> > >     running test 55 'cycles:k'
> > >     running test 0 'cpu/config=10,config1,config2=3,period=1000/u'
> > >     running test 1 'cpu/config=1,name=krava/u,cpu/config=2/u'
> > >     running test 2 'cpu/config=1,call-graph=fp,time,period=100000/,cpu/config=2,call-graph=no,time=0,period=2000/'
> > >     running test 3 'cpu/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks',period=0x1,event=0x2/ukp'
> > >     -> cpu/event=0,umask=0x11/
> > >     -> cpu/event=0,umask=0x13/
> > >     -> cpu/event=0x54,umask=0x1/
> > >     failed to parse event 'el-capacity-read:u,cpu/event=el-capacity-read/u', err 1, str 'parser error'
> > >     event syntax error: 'el-capacity-read:u,cpu/event=el-capacity-read/u'
> > >                            \___ parser error test child finished with 1
> > >     ---- end ----
> > >     Parse event definition strings: FAILED!
> 
> > > Fix by adding missing Intel CPU events to the event parser.
> > > Missing events were found by using:
> 
> > >     grep -r EVENT_ATTR_STR arch/x86/events/intel/core.c
> > > 
> > > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > 
> > Acked-by: Jiri Olsa <jolsa@redhat.com>
> 
> So, I'm not being able to reproduce this, what an I missing?

I think you need to be on some really recent intel
which defines events which we did not covered yet
like el-capacity-write in icelake

jirka

