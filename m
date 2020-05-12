Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658A0C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34EC9206D3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZhPd6Wjn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbgELNiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 09:38:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54415 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729336AbgELNiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 09:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589290685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vpuG4LdlTObF0DQc+LqTI9SVhJ+s5m4hiTckSgBvBgM=;
        b=ZhPd6WjnqmvTGcHvYJFEqus0mmgYJbpub7KbhTdmEpGNqr16ZAkE+HzYQwVs/x7jx1lG19
        pepx7R3gaf8yVnSELFnYTxA0fTRW5KWb1N1jnJCa2UGGZmSxXjYg2p6/hWXHEWh6yFBNxX
        litQxE8lGGp9a5ROAqI5pvTSuzNVvIY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-YKWHldjWOECPGJJQik2Ejg-1; Tue, 12 May 2020 09:38:01 -0400
X-MC-Unique: YKWHldjWOECPGJJQik2Ejg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7AEA5475;
        Tue, 12 May 2020 13:38:00 +0000 (UTC)
Received: from lorien.usersys.redhat.com (ovpn-114-4.phx2.redhat.com [10.3.114.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F19AA75291;
        Tue, 12 May 2020 13:37:56 +0000 (UTC)
Date:   Tue, 12 May 2020 09:37:55 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH v2] sched/fair: Fix enqueue_task_fair warning some more
Message-ID: <20200512133755.GB2201@lorien.usersys.redhat.com>
References: <20200506141821.GA9773@lorien.usersys.redhat.com>
 <20200507203612.GF19331@lorien.usersys.redhat.com>
 <CAKfTPtAztaT_===uTs6feFp4ZwPX=+UJKHwOoTOVSdsERNG3WQ@mail.gmail.com>
 <20200511204410.GI13245@lorien.usersys.redhat.com>
 <9b95fb7d-68e2-bb69-1293-af2017be4cdb@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b95fb7d-68e2-bb69-1293-af2017be4cdb@arm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dietmar,

On Tue, May 12, 2020 at 11:00:16AM +0200 Dietmar Eggemann wrote:
> On 11/05/2020 22:44, Phil Auld wrote:
> > On Mon, May 11, 2020 at 09:25:43PM +0200 Vincent Guittot wrote:
> >> On Thu, 7 May 2020 at 22:36, Phil Auld <pauld@redhat.com> wrote:
> >>>
> >>> sched/fair: Fix enqueue_task_fair warning some more
> >>>
> >>> The recent patch, fe61468b2cb (sched/fair: Fix enqueue_task_fair warning)
> >>> did not fully resolve the issues with the rq->tmp_alone_branch !=
> >>> &rq->leaf_cfs_rq_list warning in enqueue_task_fair. There is a case where
> >>> the first for_each_sched_entity loop exits due to on_rq, having incompletely
> >>> updated the list.  In this case the second for_each_sched_entity loop can
> >>> further modify se. The later code to fix up the list management fails to do
> >>> what is needed because se no longer points to the sched_entity which broke
> >>> out of the first loop.
> >>>
> >>> Address this by calling leaf_add_rq_list if there are throttled parents while
> >>> doing the second for_each_sched_entity loop.
> >>>
> >>
> >> Fixes: fe61468b2cb (sched/fair: Fix enqueue_task_fair warning)
> >>
> >>> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> >>> Signed-off-by: Phil Auld <pauld@redhat.com>
> >>> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> >>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> >>> Cc: Ingo Molnar <mingo@kernel.org>
> >>> Cc: Juri Lelli <juri.lelli@redhat.com>
> >>
> >> With the Fixes tag and the typo mentioned by Tao
> >>
> > 
> > Right, that last line of the commit message should read "list_add_leaf_cfs_rq"
> > 
> > 
> >> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> > 
> > Thanks Vincent.
> > 
> > Peter/Ingo, do you want me to resend or can you fix when applying?
> 
> 
> Maybe you could add that 'the throttled parent was already added back to
> the list by a task enqueue in a parallel child hierarchy'.
> 
> IMHO, this is part of the description because otherwise the throttled
> parent would have connected the branch.
> 
> And the not-adding of the intermediate child cfs_rq would have gone
> unnoticed.

Okay, I'll add that statement. For those curious here are the lines from about
70ms earlier in the trace where the throttled parent (0xffffa085e48ce000) is added
to the list.

bz1738415-test-6264  [005]  1271.315046: sched_waking:         comm=bz1738415-test pid=6269 prio=120 target_cpu=005
bz1738415-test-6264  [005]  1271.315048: sched_migrate_task:   comm=bz1738415-test pid=6269 prio=120 orig_cpu=5 dest_cpu=17
bz1738415-test-6264  [005]  1271.315050: bprint:               enqueue_task_fair: se 0xffffa081e6d7de80 on_rq 0 cfs_rq = 0xffffa085e48ce000
bz1738415-test-6264  [005]  1271.315051: bprint:               enqueue_entity: Add_leaf_rq: cpu 17: nr_r 2; cfs 0xffffa085e48ce000 onlist 0 tmp_a_b = 0xffffa085ef92c868 &rq->l_c_r_l = 0xffffa085ef92c868
bz1738415-test-6264  [005]  1271.315053: bprint:               enqueue_entity: Add_leaf_rq: cpu 17: nr_r 2: parent onlist  Set tmp_alone_branch to 0xffffa085ef92c868
bz1738415-test-6264  [005]  1271.315053: bprint:               enqueue_task_fair: current se = 0xffffa081e6d7de80, orig_se = 0xffffa081e6d7de80
bz1738415-test-6264  [005]  1271.315055: bprint:               enqueue_task_fair: Add_leaf_rq: cpu 17: nr_r 2; cfs 0xffffa085e48ce000 onlist 1 tmp_a_b = 0xffffa085ef92c868 &rq->l_c_r_l = 0xffffa085ef92c868
bz1738415-test-6264  [005]  1271.315056: sched_wake_idle_without_ipi: cpu=17

> 
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Thanks,

Phil


> 
> [...]
> 

-- 

