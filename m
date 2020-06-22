Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C94C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 10:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC81A20706
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 10:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vlog8wtK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgFVKVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 06:21:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60700 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726841AbgFVKVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 06:21:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592821308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7joIPwEiAilajqHGw842bd9Lt4ifvDQJJQVf6KXFIi0=;
        b=Vlog8wtKKPM7gcaKP+uec60BCzCVpmXRNVxXGMABib6jQs88iVbWNksMlelEo9A32hNw7a
        k1/25yw8oSf15qj4vM/A0/XNkdV0FSvb8neN8esj21KgER/llsiPRvkjiz3GCT8Uv1GGPJ
        3842iCf+KkdeRPw7ePF55kb/wwAH20U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-jzngVRJGPxGHYALO6apD1w-1; Mon, 22 Jun 2020 06:21:46 -0400
X-MC-Unique: jzngVRJGPxGHYALO6apD1w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 162708018D9;
        Mon, 22 Jun 2020 10:21:45 +0000 (UTC)
Received: from krava (unknown [10.40.193.171])
        by smtp.corp.redhat.com (Postfix) with SMTP id 263117167B;
        Mon, 22 Jun 2020 10:21:42 +0000 (UTC)
Date:   Mon, 22 Jun 2020 12:21:42 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 01/13] tools/libperf: introduce notion of static
 polled file descriptors
Message-ID: <20200622102142.GA2583819@krava>
References: <be40edeb-0cb9-5e11-2a22-8392316cdced@linux.intel.com>
 <49eca46e-4d0e-2ae5-d7d9-e37a4d680270@linux.intel.com>
 <20200608084344.GA1520715@krava>
 <2d80a43a-54cf-3d12-92fd-066217c95d76@linux.intel.com>
 <20200608160758.GD1558310@krava>
 <bde9bcc3-9ec0-6e37-26f6-139b038ad3de@linux.intel.com>
 <20200615123048.GB2088119@krava>
 <8b29e324-eb8d-2266-562b-ca46aec76a3e@linux.intel.com>
 <20200615165802.GD2088119@krava>
 <8351b3ee-d345-a394-d687-443f2d2f7ec4@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8351b3ee-d345-a394-d687-443f2d2f7ec4@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 12:47:19PM +0300, Alexey Budankov wrote:

SNIP

> >>>>>> fdarray__del(array, fdkey);
> >>>>>
> >>>>> I think there's solution without having filterable type,
> >>>>> I'm not sure why you think this is needed
> >>>>>
> >>>>> I'm busy with other things this week, but I think I can
> >>>>> come up with some patch early next week if needed
> >>>>
> >>>> Friendly reminder.
> >>>
> >>> hm? I believe we discussed this in here:
> >>>   https://lore.kernel.org/lkml/20200609145611.GI1558310@krava/
> >>
> >> Do you want it to be implemented like in the patch posted by the link?
> > 
> > no idea.. looking for good solution ;-)
> > 
> > how about switching completely to epoll? I tried and it
> > does not look that bad
> 
> Well, epoll() is perhaps possible but why does it want switching to epoll()?
> What are the benefits and/or specific task being solved by this switch? 

epoll change fixes the same issues as the patch you took in v8

on top of it it's not a hack and wil make polling more user
friendly because of the clear interface

> 
> > 
> > there might be some loose ends (interface change), but
> > I think this would solve our problems with fdarray
> 
> Your first patch accomodated in v8 actually avoids fds typing
> and solves pos (=fdarray__add()) staleness issue with fdarray.

yea, it was a change meant for discussion (which never happened),
and I considered it to be more a hack than a solution

I suppose we can live with that for a while, but I'd like to
have clean solution for polling as well

jirka

