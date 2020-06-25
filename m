Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193BCC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 17:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD4AC20707
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 17:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KWcTws98"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404191AbgFYRNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 13:13:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35257 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404083AbgFYRNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 13:13:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593105188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m2oVqTZOMAgLQ+rHg3irgZQTKVNYsSFJIr0KW24bVfI=;
        b=KWcTws98jgRqYQ8QlemgiC6VA3x7OcQkjGj1/EMldkWxh7bIGhpDHrog1VDa+BUVLOtz7S
        2D2ff4uB00i3oybO3Zzt7ygKfMZeM6PIEEe+sOmR4pQhfgxQUg2PNmhf0noZtRO39vPF+j
        SeT7iuE2qrKgR8rLHFwpRS8LgqT3xmE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-ZRLiX5l5OHuQM2vE6-Du3w-1; Thu, 25 Jun 2020 13:13:04 -0400
X-MC-Unique: ZRLiX5l5OHuQM2vE6-Du3w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0700800597;
        Thu, 25 Jun 2020 17:13:02 +0000 (UTC)
Received: from krava (unknown [10.40.192.78])
        by smtp.corp.redhat.com (Postfix) with SMTP id 380C760C1D;
        Thu, 25 Jun 2020 17:13:01 +0000 (UTC)
Date:   Thu, 25 Jun 2020 19:13:00 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 04/13] perf stat: factor out body of event handling
 loop for system wide
Message-ID: <20200625171300.GK2719003@krava>
References: <0781a077-aa82-5b4a-273e-c17372a72b93@linux.intel.com>
 <eeeff629-925a-530b-9803-f274337ae473@linux.intel.com>
 <20200623145630.GK2619137@krava>
 <51d5511a-e9a7-2865-c81b-57488e820f8d@linux.intel.com>
 <20200625121719.GI2719003@krava>
 <fdaba173-a046-beae-f8f2-07840c879475@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdaba173-a046-beae-f8f2-07840c879475@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 07:01:08PM +0300, Alexey Budankov wrote:

SNIP

> >>
> >> Well, ok.
> >>
> >> I will rename process_interval() to __process_interval() and
> >> then print_interval() to process_interval().
> >>
> >> Regarding timeout let's have it like this:
> >>
> >> static bool process_timeout(int timeout)
> >> {
> >> 	return timeout ? true : false;
> >> }
> > 
> > can't this just stay as value check after finished poll?
> > 
> > 	if (timeout)
> > 		break;
> > 
> > and then separate call to process_interval(interval, times)?
> 
> Like this? Still makes sense to have it in a single function.
> 
> static bool process_timing_settings(int timeout, unsigned int interval, int *times)
> {
> 	bool res = timeout ? true : false;
>         if (!res)
>  		res = process_interval(interval, times);
>  	return res;
> }

I don't see the connection between timeout and interval
IMO this just complicates things, is there a problem to
keep it separated as it is now?

jirka

> 
> ~Alexey
> 

