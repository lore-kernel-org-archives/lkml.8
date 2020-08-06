Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B06C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B07E23119
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="stM9mBca"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbgHFQs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729103AbgHFQmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:42:46 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24554C0A893B
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 09:41:24 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id v6so25882088ota.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 09:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=vZCQg8+eOt4xV3JIQtSzWjGSCEAJBUaAw1bfGf3lBko=;
        b=stM9mBcaLLBoAVOGyLKRqBDV5bdXIlOzBVmFTAKYX50Mr5IQvi9vQ7AvJM0L4/5m2R
         9codphlIh6NL4Pt3LU5mseL3yk8JTQm+BR8N4MYqDjO9mHJ8x6FOPMmjHNWkJbtr+2o6
         +BzRU2mzFug8SMV4TeecXCGHUMQO0R83U9nQ0alj4hZQ9v64s/6H8sKcErGhz6qAWWcP
         5cE0Qp9uaWTwsKWkCuUvwCe7ykJ3HslBcRjmn9wZaGw93/xGXswfiNLNMQURTHFjCkIK
         yBLhUJaqL8Xy/pBfMli9d7cYEDhUei8+y6rLgEeLpZ5u7q2zacbJN9TlUTh4SpSjFzoR
         L8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=vZCQg8+eOt4xV3JIQtSzWjGSCEAJBUaAw1bfGf3lBko=;
        b=TvJ60nzJXoQC6/WTWejzsgBtNgDT9ULOSvNhSdbfDDfMDo4llk8m+YZeeDSQHlYKWm
         wtvDv0Ia0PXX45Mn/niSpFVDFNLLf0x3nd2RPTTE+QxIp6f1K9wIx0sEt8JbXWmVvYvC
         gT67P43cQmVUkzgnLJ3U6Ra6v4RUQPf8+qNQsh+oSQNnF4g6mUVoAOj2FTSGDA8gqvfs
         DIyF7RCvtYy57IpeVO3Rd7KbvdoZSqAckKoeVI7Eqs/xAhpj85e4nmWF1PA0k9oWnTOJ
         95JoyBNgNLI/9Q7WTMPWSGLu2jCeRRBlnbqBSvnC/p06BvUCb2JYfto/w1IG2s/CbX0u
         ZfxA==
X-Gm-Message-State: AOAM532MPHocjhC3bgvgtnyylNmdbAh9uYwTdPFYzfzWhvug5EkhAydJ
        rWCgrU5+4TW88yN02sEWEmTDAA==
X-Google-Smtp-Source: ABdhPJz602trHpkpOhs26Phasf2ch9/0QyldoGfsTVMlNz3IbhPyWBm6fFiVU4sXegQNDrqI9OAT4w==
X-Received: by 2002:a9d:69cd:: with SMTP id v13mr7842427oto.64.1596732082316;
        Thu, 06 Aug 2020 09:41:22 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id z4sm1095537ota.52.2020.08.06.09.41.20
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 06 Aug 2020 09:41:21 -0700 (PDT)
Date:   Thu, 6 Aug 2020 09:41:05 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Roman Gushchin <guro@fb.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: vmstat: fix /proc/sys/vm/stat_refresh generating
 false warnings
In-Reply-To: <20200806035140.GA1162560@carbon.dhcp.thefacebook.com>
Message-ID: <alpine.LSU.2.11.2008060824380.9630@eggly.anvils>
References: <20200714173920.3319063-1-guro@fb.com> <alpine.LSU.2.11.2007291902340.6363@eggly.anvils> <20200730162348.GA679955@carbon.dhcp.thefacebook.com> <alpine.LSU.2.11.2007302018350.2410@eggly.anvils> <20200801011821.GA859734@carbon.dhcp.thefacebook.com>
 <alpine.LSU.2.11.2007311915130.9716@eggly.anvils> <20200804004012.GA1049259@carbon.dhcp.thefacebook.com> <alpine.LSU.2.11.2008051913580.8184@eggly.anvils> <20200806035140.GA1162560@carbon.dhcp.thefacebook.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Aug 2020, Roman Gushchin wrote:
> On Wed, Aug 05, 2020 at 08:01:33PM -0700, Hugh Dickins wrote:
> > 
> > I shall certainly want to reintroduce those stats to checking for
> > negatives, even if it's in a patch that never earns your approval,
> > and just ends up kept internal for debugging.  But equally certainly,
> > I must not suddenly reintroduce that checking without gaining some
> > experience of it (and perhaps getting as irritated as you by more
> > transient negatives).
> > 
> > I said earlier that I'd prefer you to rip out all that checking for
> > negatives, rather than retaining it with the uselessly over-generous
> > 125 * nr_cpus leeway.  Please, Roman, would you send Andrew a patch
> > doing that, to replace the patch in this thread?  Or if you prefer,
> > I can do so.
> 
> Sure, I can do it. But can you, please, explain why you want them to be
> eliminated? Is this because they will never fire, you think?

Yes, I've never seen a machine on which vm/stat_refresh reported -16000
or less, or anything approaching that (true, this laptop does not have
128 cpus, but...).  Maybe they get reinstalled or otherwise rebooted
before reaching numbers of that magnitude.  Maybe having the warnings
shown at much lower magnitudes has helped to root-cause and eliminate
some of them.

Waiting until the heat-death-of-the-universe theoretical worst case is
so unhelpful as to defeat the purpose of the warning.  I think you do
understand, but perhaps not all readers of this thread understand,
that vm/stat_refresh merges all per-cpu counts into the global atomic
immediately before deciding negative.  The only problem is that
"immediately" is not instantaneous across cpus, so the possibility
of work started on one cpu but completed on another during the course
of the refresh, causing false negatives, is real though not great.

> 
> In my humble opinion they might be quite useful: any systematic under- or
> overflow will eventually trigger this warning, and we'll know for sure that
> something is wrong. So I'd add a similar check for node counters without
> any hesitation.

It's true that while developing, we can all make mistakes so big that
"eventually" will show up quickly, and even that warning could help.
But since you'll only show them when they reach -16000 (sorry, I keep
going back to the 128 cpu case, just to make it more vivid), it won't
be of any use to catch races later in development, or in production.

Whereas my own patch would just fix the missing items, and continue
to annoy you with occasional ignorable warnings - so I cannot submit
that, and wouldn't want to submit it right now, without having tried
it out for a while, to check what kind of noise it will generate.

So I thought it best, either to leave mm/vmstat.c alone for the moment,
or else just delete the disputed and incomplete code; coming back to
it later when we have something we can agree upon.

But I think you're preferring to resubmit your 125*nr_cpus patch to akpm,
with the missing NR_VM_NODE_STAT_ITEMS added in (as either one or two
patches), with foreshortened testing but the reassurance that since
it's so hard to reach the point of showing the warnings, new negatives
will either be quiet, or easily fixed before v5.10 released: okay,
I can more easily Hack that to my preference than Ack it or Nak it.

Hugh
