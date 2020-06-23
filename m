Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5984C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A10B320723
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cDgi7qo2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732902AbgFWOyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 10:54:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29292 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732821AbgFWOyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 10:54:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592924075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r4WyJrfnr1+Z90d/MDctL9zYqmch/HvJOz6hkV6nDGU=;
        b=cDgi7qo21s8EY5FgT7LHGbn9ROEKPAYF8XklJPZ1rXkyaVWQDNiAenxQVLo/nItEPJlqCA
        DwMLdNQ1BSt8VHLqHvmZp5C4Luwp9+I+UN9vC9Bw/IUyqw69hLbyh/HZt4oF3/UPXpipw5
        zFdv+aNZPb5Tk22c1NACAjyHrQ90VeA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-sUS_S_IXNZ-Hgti_ZZEhWw-1; Tue, 23 Jun 2020 10:54:31 -0400
X-MC-Unique: sUS_S_IXNZ-Hgti_ZZEhWw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A3DB1005513;
        Tue, 23 Jun 2020 14:54:30 +0000 (UTC)
Received: from krava (unknown [10.40.192.77])
        by smtp.corp.redhat.com (Postfix) with SMTP id CC6DD60CD3;
        Tue, 23 Jun 2020 14:54:27 +0000 (UTC)
Date:   Tue, 23 Jun 2020 16:54:26 +0200
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
Message-ID: <20200623145426.GC2619137@krava>
References: <20200608160758.GD1558310@krava>
 <bde9bcc3-9ec0-6e37-26f6-139b038ad3de@linux.intel.com>
 <20200615123048.GB2088119@krava>
 <8b29e324-eb8d-2266-562b-ca46aec76a3e@linux.intel.com>
 <20200615165802.GD2088119@krava>
 <8351b3ee-d345-a394-d687-443f2d2f7ec4@linux.intel.com>
 <20200622102142.GA2583819@krava>
 <cad3d9a6-da28-c627-de73-17169a7c36a1@linux.intel.com>
 <20200622121120.GA2584593@krava>
 <99674766-0cb6-7790-3ef6-90cfaf377822@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99674766-0cb6-7790-3ef6-90cfaf377822@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 05:04:21PM +0300, Alexey Budankov wrote:

SNIP

> >>>>> there might be some loose ends (interface change), but
> >>>>> I think this would solve our problems with fdarray
> >>>>
> >>>> Your first patch accomodated in v8 actually avoids fds typing
> >>>> and solves pos (=fdarray__add()) staleness issue with fdarray.
> >>>
> >>> yea, it was a change meant for discussion (which never happened),
> >>> and I considered it to be more a hack than a solution
> >>>
> >>> I suppose we can live with that for a while, but I'd like to
> >>> have clean solution for polling as well
> >>
> >> I wouldn't treat it as a hack but more as a fix because returned
> >> pos is now a part of interface that can be safely used in callers.
> >> Can we go with this fix for the patch set?
> > 
> > apart from this one I still have a problem with that stat factoring
> > having 1 complicated function deal with both fork and no fork processing,
> > which I already commented on, but you ignored ;-)
> 
> Not an issue at all, lets split that func, dispatch_events() I suppose,
> as you see it.

ok,I checked it one more time and perhaps the function naming
was confusing for me.. but maybe we can give it another try,
I'm sending some comments

thanks,
jirka

