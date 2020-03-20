Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3AAC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 09:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C33C520757
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 09:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RHoYhX/9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgCTJaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 05:30:18 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:28059 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726602AbgCTJaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 05:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584696617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KKKwaA4p/ieu7P/98VGPzMcyCQtTlnjqvRi2vO81emU=;
        b=RHoYhX/9E9ejZGjP4BqO4fV9vk+ruud34EB4BOcNSKksmPPDzYG2eDNhjZaNAWEd0mBMlr
        pBSBWf2h/X4roe1mOnS/XRa9kxMeR3Xmz3bfh4ULNapLEs9ScOFHB5z4EX4TM4wVRrykIA
        9Je2qMpAbRu/57cbUS3cOboLkxGXLWw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-NCl0cmQMOKiPrI05Ia7q9Q-1; Fri, 20 Mar 2020 05:30:13 -0400
X-MC-Unique: NCl0cmQMOKiPrI05Ia7q9Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9359D1007272;
        Fri, 20 Mar 2020 09:30:11 +0000 (UTC)
Received: from krava (unknown [10.40.193.244])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C3D0060BF1;
        Fri, 20 Mar 2020 09:30:08 +0000 (UTC)
Date:   Fri, 20 Mar 2020 10:30:06 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        will@kernel.org, ak@linux.intel.com, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org, james.clark@arm.com,
        qiangqing.zhang@nxp.com
Subject: Re: [PATCH v2 7/7] perf test: Test pmu-events aliases
Message-ID: <20200320093006.GA1343171@krava>
References: <1584442939-8911-1-git-send-email-john.garry@huawei.com>
 <1584442939-8911-8-git-send-email-john.garry@huawei.com>
 <20200317162043.GC759708@krava>
 <01dd565b-931c-e853-a721-aa995f87469c@huawei.com>
 <20200317170730.GF759708@krava>
 <20200319183622.GD14841@kernel.org>
 <c00876b9-99bb-9272-6602-98806808cac3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c00876b9-99bb-9272-6602-98806808cac3@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 09:24:19AM +0000, John Garry wrote:
> On 19/03/2020 18:36, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Mar 17, 2020 at 06:07:30PM +0100, Jiri Olsa escreveu:
> > > On Tue, Mar 17, 2020 at 04:41:04PM +0000, John Garry wrote:
> > > > On 17/03/2020 16:20, Jiri Olsa wrote:
> > > > > On Tue, Mar 17, 2020 at 07:02:19PM +0800, John Garry wrote:
> > > > > > @@ -36,6 +51,8 @@ static struct perf_pmu_test_event test_cpu_events[] = {
> > > > > >    			.desc = "Number of segment register loads",
> > > > > >    			.topic = "other",
> > > > > >    		},
> > > > > > +		.alias_str = "umask=0x80,(null)=0x30d40,event=0x6",
> > 
> > > > > ah so we are using other pmus because of the format definitions
> > 
> > > > > why is there the '(null)' in there?
> > 
> > > > Well this is just coming from the generated alias string in the pmu code,
> > > > and it does not seem to be handling "period" argument properly. It needs to
> > > > be checked.
> > > nice, it found first issue already ;-)
> 
> thanks
> 
> > 
> > Applied the series to perf/core, good job! What about the fix for the
> > above (null) problem?
> 
> So I had started to look at that, but then the codepath lead into the lex
> parsing, which I am not familiar with.
> 
> So from when we parse the event terms in parse_events_terms(), we get 3x
> terms:
> config=umask, then newval=umask=0x80
> confg=(null), then newval=umask=0x80,(null)=x030d40
> config=event, then newval=umask=0x80,(null)=x030d40,event=0x6
> 
> I can continue to look. Maybe jirka has an idea on this and what happens in
> the lex parsing.

yep, I plan to check on it

jirka

