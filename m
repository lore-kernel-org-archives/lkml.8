Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78426C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 436F7206E6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XBXhwrse"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731986AbgIHQrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:47:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55082 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731949AbgIHQrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599583621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G4z0R4ULl6ssTJu5oaK+D6sBXkjeMYkO19vzwQBeYp4=;
        b=XBXhwrseid5kTFY29lsZUSLLspVyrUMbZkaWOr+oieCVkFNkv/N4mn/V99px13HQtO8dLk
        Qq/T+Yc9J9TzqnTaJCYH1n9XKGAKOfAs1v/Xfc48NSU6SbGXUCJH+YUJa5zMKLNDj9zQYq
        TI0yVWc9RdkKXcvX3Dlq15aOpZfqZss=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-Im3WMzNYN7WVf2AUAgsCtg-1; Tue, 08 Sep 2020 09:19:58 -0400
X-MC-Unique: Im3WMzNYN7WVf2AUAgsCtg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D300810BBED3;
        Tue,  8 Sep 2020 13:19:56 +0000 (UTC)
Received: from lorien.usersys.redhat.com (ovpn-113-114.phx2.redhat.com [10.3.113.114])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ED5B027BCB;
        Tue,  8 Sep 2020 13:19:55 +0000 (UTC)
Date:   Tue, 8 Sep 2020 09:19:54 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        vincent.donnefort@arm.com, mingo@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com
Subject: Re: [PATCH v2] sched/debug: Add new tracepoint to track cpu_capacity
Message-ID: <20200908131954.GA147026@lorien.usersys.redhat.com>
References: <1598605249-72651-1-git-send-email-vincent.donnefort@arm.com>
 <20200828102724.wmng7p6je2pkc33n@e107158-lin.cambridge.arm.com>
 <1e806d48-fd54-fd86-5b3a-372d9876f360@arm.com>
 <20200828172658.dxygk7j672gho4ax@e107158-lin.cambridge.arm.com>
 <58f5d2e8-493b-7ce1-6abd-57705e5ab437@arm.com>
 <20200902135423.GB93959@lorien.usersys.redhat.com>
 <20200907110223.gtdgqod2iv2w7xmg@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907110223.gtdgqod2iv2w7xmg@e107158-lin.cambridge.arm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quais,

On Mon, Sep 07, 2020 at 12:02:24PM +0100 Qais Yousef wrote:
> On 09/02/20 09:54, Phil Auld wrote:
> > > 
> > > I think this decoupling is not necessary. The natural place for those
> > > scheduler trace_event based on trace_points extension files is
> > > kernel/sched/ and here the internal sched.h can just be included.
> > > 
> > > If someone really wants to build this as an out-of-tree module there is
> > > an easy way to make kernel/sched/sched.h visible.
> > >
> > 
> > It's not so much that we really _want_ to do this in an external module.
> > But we aren't adding more trace events and my (limited) knowledge of
> > BPF let me to the conclusion that its raw tracepoint functionality
> > requires full events.  I didn't see any other way to do it.
> 
> I did have a patch that allowed that. It might be worth trying to upstream it.
> It just required a new macro which could be problematic.
> 
> https://github.com/qais-yousef/linux/commit/fb9fea29edb8af327e6b2bf3bc41469a8e66df8b
> 
> With the above I could attach using bpf::RAW_TRACEPOINT mechanism.
>

Yeah, that could work. I meant there was no way to do it with what was there :)

In our initial attempts at using BPF to get at nr_running (which I was not
involved in and don't have all the details...) there were issues being able to
keep up and losing events.  That may have been an implementation issue, but
using the module and trace-cmd doesn't have that problem. Hopefully you don't
see that using RAW_TRACEPOINTs.


Fwiw, I don't think these little helper routines are all that hard to maintain.
If something changes in those fields, which seems moderately unlikely at least
for many of them, the compiler will complain.

And I agree with you about preferring to use the public headers for the module.
I think we can work around it though, if needed.


Cheers,
Phil

> Cheers
> 
> --
> Qais Yousef
> 

-- 

