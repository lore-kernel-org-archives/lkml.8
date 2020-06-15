Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E6DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 12:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD64220739
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 12:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R2JQ+ovt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729936AbgFOMa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 08:30:57 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53004 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728285AbgFOMaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 08:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592224254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R86wgNjo/pUDkredCPnF7v+QqcZWb2dsCbc+4OBYt1s=;
        b=R2JQ+ovtEli3Hvtc0Vsx7uAzuA4rXd59nL7s2zHxvhfl9VdoE+Ly7wvX5vI/O8CTkvkDZl
        YN3JrmfjX/vof3zrtt4K36nGLhWG0I4C6eL/x81oIkYDk71HPmLhOi1gweVyYET9gfcIMx
        z7CdxgcwzzQeWsl5YEr8dBSvEk3mAXo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-kPdSEbhUPzGpHFB6K8YPdw-1; Mon, 15 Jun 2020 08:30:52 -0400
X-MC-Unique: kPdSEbhUPzGpHFB6K8YPdw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3860A108BD1D;
        Mon, 15 Jun 2020 12:30:51 +0000 (UTC)
Received: from krava (unknown [10.40.192.59])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6CD307CAA9;
        Mon, 15 Jun 2020 12:30:49 +0000 (UTC)
Date:   Mon, 15 Jun 2020 14:30:48 +0200
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
Message-ID: <20200615123048.GB2088119@krava>
References: <5de4b954-24f0-1e8d-5a0d-7b12783b8218@linux.intel.com>
 <3c92a0ad-d7d3-4e78-f0b8-1d3a7122c69e@linux.intel.com>
 <20200605105051.GA1404794@krava>
 <20200605113834.GC1404794@krava>
 <be40edeb-0cb9-5e11-2a22-8392316cdced@linux.intel.com>
 <49eca46e-4d0e-2ae5-d7d9-e37a4d680270@linux.intel.com>
 <20200608084344.GA1520715@krava>
 <2d80a43a-54cf-3d12-92fd-066217c95d76@linux.intel.com>
 <20200608160758.GD1558310@krava>
 <bde9bcc3-9ec0-6e37-26f6-139b038ad3de@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bde9bcc3-9ec0-6e37-26f6-139b038ad3de@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 08:20:38AM +0300, Alexey Budankov wrote:
> 
> On 08.06.2020 19:07, Jiri Olsa wrote:
> > On Mon, Jun 08, 2020 at 12:54:31PM +0300, Alexey Budankov wrote:
> >>
> >> On 08.06.2020 11:43, Jiri Olsa wrote:
> >>> On Mon, Jun 08, 2020 at 11:08:56AM +0300, Alexey Budankov wrote:
> >>>>
> >>>> On 05.06.2020 19:15, Alexey Budankov wrote:
> >>>>>
> >>>>> On 05.06.2020 14:38, Jiri Olsa wrote:
> <SNIP>
> >>>>> revents = fdarray_fixed_revents(array, pos);
> >>>>> fdarray__del(array, pos);
> >>>>
> >>>> So how is it about just adding _revents() and _del() for fixed fds with
> >>>> correction of retval to bool for fdarray__add()?
> >>>
> >>> I don't like the separation for fixed and non-fixed fds,
> >>> why can't we make generic?
> >>
> >> Usage models are different but they want still to be parts of the same class
> >> for atomic poll(). The distinction is filterable vs. not filterable.
> >> The distinction should be somehow provided in API. Options are:
> >> 1. expose separate API calls like __add_nonfilterable(), __del_nonfilterable();
> >>    use nonfilterable quality in __filter() and __poll() and, perhaps, other internals;
> >> 2. extend fdarray__add(, nonfilterable) with the nonfilterable quality
> >>    use the type in __filter() and __poll() and, perhaps, other internals;
> >>    expose less API calls in comparison with option 1
> >>
> >> Exposure of pos for filterable fds should be converted to bool since currently
> >> the returned pos can become stale and there is no way in API to check its state.
> >> So it could look like this:
> >>
> >> fdkey = fdarray__add(array, fd, events, type)
> >> type: filterable, nonfilterable, somthing else
> >> revents = fdarray__get_revents(fdkey);
> >> fdarray__del(array, fdkey);
> > 
> > I think there's solution without having filterable type,
> > I'm not sure why you think this is needed
> > 
> > I'm busy with other things this week, but I think I can
> > come up with some patch early next week if needed
> 
> Friendly reminder.

hm? I believe we discussed this in here:
  https://lore.kernel.org/lkml/20200609145611.GI1558310@krava/

jirka

