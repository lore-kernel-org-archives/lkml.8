Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838F4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 696A520829
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgHLPTY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 11:19:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:41500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbgHLPTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 11:19:23 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC83C207F7;
        Wed, 12 Aug 2020 15:19:21 +0000 (UTC)
Date:   Wed, 12 Aug 2020 11:19:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Christian =?UTF-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>
Cc:     christian.koenig@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Shashank.Sharma@amd.com, daniel.vetter@ffwll.ch,
        alexander.deucher@amd.com
Subject: Re: [PATCH] drm/amdgpu: adjust the pid in the grab_id trace point
Message-ID: <20200812111920.06efa663@oasis.local.home>
In-Reply-To: <e48b6300-7ba7-f2fc-b7f7-a205d32607a4@gmail.com>
References: <20200807133658.1866-1-christian.koenig@amd.com>
        <20200807133658.1866-2-christian.koenig@amd.com>
        <20200812141755.GA8136@home.goodmis.org>
        <e48b6300-7ba7-f2fc-b7f7-a205d32607a4@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Aug 2020 16:36:36 +0200
Christian König <ckoenig.leichtzumerken@gmail.com> wrote:

> Am 12.08.20 um 16:17 schrieb Steven Rostedt:
> > On Fri, Aug 07, 2020 at 03:36:58PM +0200, Christian König wrote:  
> >> Trace something useful instead of the pid of a kernel thread here.
> >>
> >> Signed-off-by: Christian König <christian.koenig@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> >> index 5da20fc166d9..07f99ef69d91 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> >> @@ -228,6 +228,7 @@ TRACE_EVENT(amdgpu_vm_grab_id,
> >>   			     ),
> >>   
> >>   	    TP_fast_assign(
> >> +			   __entry->ent.pid = vm->task_info.pid;  
> > If the ent.pid is not the pid you are interested in for this trace event, just
> > add a "pid" field to the trace event and place it there. Do not modify the
> > generic pid that is recorded, as we would like that to be consistent for all
> > trace events.  
> 
> The problem my userspace guys have is that this doesn't work with 
> "trace-cmd -P $pid".
> 
> But I think I can teach them how filters work :)

Yep, trace-cmd record -e event -f "pid == $pid"

> 
> > The "ent.pid" turns into "common_pid" in the field, leaving "pid" free to use.
> > Other trace events (like sched_waking) record a pid field that is not the same
> > as the pid of the executing task.  
> 
> Yes, we thought about this alternative as well.
> 
> > The "ent.pid" should always be the pid of the task that executed the event.  
> 
> Why? For the case here we just execute a work item in the background for 
> an userspace process.
> 
> Tracing the pid of the worker pool which executes it doesn't seem to 
> make to much sense.

Maybe not for you, but it does for me. All trace events show what
happened when it happened and who executed it. I like to see what
worker threads are executing. I may filter on the worker thread, and by
changing the ent.pid, I wont see what it is doing.

That said, I think I may add a feature to a trace evnt for a special filter
to say, "test field to the set_event_pid", and if it exists in that
file to include that event in the filtered trace. This would include
sched_waking trace events as well.

That way "trace-cmd record -P $pid" will still work for your case.

-- Steve
