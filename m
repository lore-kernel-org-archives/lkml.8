Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04654C54E8D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAAB620643
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UQ3nVx9z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730285AbgELOY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 10:24:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58047 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725929AbgELOY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:24:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589293495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eL5uBzw+ELV0YldIknQoZ/rUWnaP9+Cb1DjPLXI8JBo=;
        b=UQ3nVx9zQ+vnugO9BaI68pZvd27L79Og5UIcv3h/5nHzvDokwxcwcwsB+CzI7kpxvl42/p
        X7cymHI2+3wYyQ08lkgG5qPJ7RdNsvSTjb5y5FimyfXKTba9jHylywOTgH41LstL6URC61
        DbR/nT+XdGxoJQwn2PP7ochXglNK6Ko=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-REHyjhYROC-9sRgWcDylTw-1; Tue, 12 May 2020 10:24:54 -0400
X-MC-Unique: REHyjhYROC-9sRgWcDylTw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAC51473;
        Tue, 12 May 2020 14:24:52 +0000 (UTC)
Received: from lorien.usersys.redhat.com (ovpn-114-4.phx2.redhat.com [10.3.114.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1391D5C1BB;
        Tue, 12 May 2020 14:24:48 +0000 (UTC)
Date:   Tue, 12 May 2020 10:24:47 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        vincent.guittot@linaro.org, juri.lelli@redhat.com,
        zohooouoto@zoho.com.cn, dietmar.eggemann@arm.com
Subject: Re: [PATCH v3] sched/fair: Fix enqueue_task_fair warning some more
Message-ID: <20200512142447.GA4256@lorien.usersys.redhat.com>
References: <20200506141821.GA9773@lorien.usersys.redhat.com>
 <20200512135222.GC2201@lorien.usersys.redhat.com>
 <20200512141048.GL2978@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512141048.GL2978@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 04:10:48PM +0200 Peter Zijlstra wrote:
> On Tue, May 12, 2020 at 09:52:22AM -0400, Phil Auld wrote:
> > sched/fair: Fix enqueue_task_fair warning some more
> > 
> > The recent patch, fe61468b2cb (sched/fair: Fix enqueue_task_fair warning)
> > did not fully resolve the issues with the rq->tmp_alone_branch !=
> > &rq->leaf_cfs_rq_list warning in enqueue_task_fair. There is a case where
> > the first for_each_sched_entity loop exits due to on_rq, having incompletely
> > updated the list.  In this case the second for_each_sched_entity loop can
> > further modify se. The later code to fix up the list management fails to do
> > what is needed because se does not point to the sched_entity which broke out
> > of the first loop. The list is not fixed up because the throttled parent was
> > already added back to the list by a task enqueue in a parallel child hierarchy.
> > 
> > Address this by calling list_add_leaf_cfs_rq if there are throttled parents
> > while doing the second for_each_sched_entity loop.
> > 
> > v3: clean up commit message and add fixes and review tags.
> 
> Excellent, ignore what I just sent, I now have this one.
> 

Thank you!


Cheers,
Phil
-- 

