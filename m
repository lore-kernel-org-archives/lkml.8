Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971ABC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 18:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7491B20720
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 18:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AULQJavu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731081AbgEKSlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 14:41:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25864 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729768AbgEKSlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 14:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589222511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XWo1dhUmPcxI5RGaFhx3UMrLMTx+OfBASGTN8Q1Mv3g=;
        b=AULQJavuqARgzrg41+xex0RyCge8s2uiofyuGjQCTVZKRSJRgS9oQtrbXGF4CEujgrJ73x
        oypOdwPWM6++F9MTKQYMM7nTOqBGP6mG3NDk9fIGhJ0d/E1hvOMGNjLoYqmu8jFR4aW9nT
        yvwoG2GWGdBIQQJ0ORROW4RKY9GTpOg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-8SlbbwLQOwudMFP9HfDsIA-1; Mon, 11 May 2020 14:41:48 -0400
X-MC-Unique: 8SlbbwLQOwudMFP9HfDsIA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC7D51005510;
        Mon, 11 May 2020 18:41:47 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 73487784AF;
        Mon, 11 May 2020 18:41:44 +0000 (UTC)
Date:   Mon, 11 May 2020 14:41:43 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     agk@redhat.com, dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        song@kernel.org, breeves@redhat.com, mpatocka@redhat.com,
        khazhy@google.com, kernel@collabora.com
Subject: Re: [PATCH v4 0/2] Historical Service Time Path Selector
Message-ID: <20200511184143.GA8274@redhat.com>
References: <20200511163910.3778467-1-krisman@collabora.com>
 <20200511170235.GA7719@redhat.com>
 <85ftc6l7lb.fsf@collabora.com>
 <20200511173155.GA7892@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511173155.GA7892@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11 2020 at  1:31pm -0400,
Mike Snitzer <snitzer@redhat.com> wrote:

> On Mon, May 11 2020 at  1:11pm -0400,
> Gabriel Krisman Bertazi <krisman@collabora.com> wrote:
> 
> > Mike Snitzer <snitzer@redhat.com> writes:
> > 
> > > On Mon, May 11 2020 at 12:39pm -0400,
> > > Gabriel Krisman Bertazi <krisman@collabora.com> wrote:
> > >
> > >> Hi,
> > >> 
> > >> This fourth version of HST applies the suggestion from Mikulas Patocka
> > >> to do the ktime_get_ns inside the mpath map_bio instead of generic
> > >> device-mapper code. This means that struct dm_mpath_io gained another
> > >> 64bit field.  For the request-based case, we continue to use the block
> > >> layer start time information.
> > >> 
> > >> With this modification, I was able obtain similar performance on  BIO
> > >> to request-based multipath with HST on the benchmarks shared in v1.
> > >> 
> > >> v3: https://www.redhat.com/archives/dm-devel/2020-April/msg00308.html
> > >> v2: https://www.redhat.com/archives/dm-devel/2020-April/msg00270.html
> > >> v1: https://www.redhat.com/archives/dm-devel/2020-April/msg00176.html
> > >
> > > I already staged your v3 in linux-next.  Please provide an incremental
> > > patch that layers on this git branch:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=dm-5.8
> > >
> > > I was hopeful for a flag to be set (e.g. in 'struct path_selector') to
> > > reflect whether the path selector expects highres start_time.  Makes
> > > little sense to incur that extra cost of providing the time if the path
> > > selector doesn't even use it.
> > >
> > > Alternatively, could split out the setting of the time needed by .end_io
> > > to a new path_selector_type method (e.g. .set_start_time).  And then
> > > only use ktime_get_ns() for bio-based if .set_start_time is defined.
> > > Would get a little fiddly needing to make sure a stale start_time isn't
> > > used... also, makes more sense to conditionally call this
> > > .set_start_time just after .start_io is.
> > 
> > Oh, my apologies, I hadn't noticed it was merged.  I will make the time fetch
> > conditional and submit a new patch based on that branch.
> 
> I don't want to waste your time so please don't run with that idea just yet.
> 
> There is a possibility we really _do_ need higher resolution time.
> 
> I'm about to have a concall to discuss some disk IO stat issues with DM
> disk stats vs NVMe disk stats (provided by block core).
> 
> I'll let you know the outcome and we can discuss further.

OK, that concall's issue had nothing to do with needing higher
resolution time (was about IOPs realized with requested-based vs
bio-based).

Reality is, DM won't need anything higher resolution than jiffies until
block core's interfaces require something other than jiffies
(e.g. generic_end_io_acct).

So feel free to proceed with the conditional time fetch solution you
were going to run with (prior to my previous mail asking you to hold
off).

Sorry for the noise.  Thanks,
Mike

