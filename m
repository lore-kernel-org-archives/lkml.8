Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77952C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 14:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C528207DA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 14:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgHLOSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 10:18:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:36132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726468AbgHLOSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 10:18:04 -0400
Received: from home.goodmis.org (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA5B420781;
        Wed, 12 Aug 2020 14:18:02 +0000 (UTC)
Date:   Wed, 12 Aug 2020 10:17:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Shashank.Sharma@amd.com,
        daniel.vetter@ffwll.ch, alexander.deucher@amd.com
Subject: Re: [PATCH] drm/amdgpu: adjust the pid in the grab_id trace point
Message-ID: <20200812141755.GA8136@home.goodmis.org>
References: <20200807133658.1866-1-christian.koenig@amd.com>
 <20200807133658.1866-2-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200807133658.1866-2-christian.koenig@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 03:36:58PM +0200, Christian König wrote:
> Trace something useful instead of the pid of a kernel thread here.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> index 5da20fc166d9..07f99ef69d91 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> @@ -228,6 +228,7 @@ TRACE_EVENT(amdgpu_vm_grab_id,
>  			     ),
>  
>  	    TP_fast_assign(
> +			   __entry->ent.pid = vm->task_info.pid;

If the ent.pid is not the pid you are interested in for this trace event, just
add a "pid" field to the trace event and place it there. Do not modify the
generic pid that is recorded, as we would like that to be consistent for all
trace events.

The "ent.pid" turns into "common_pid" in the field, leaving "pid" free to use.
Other trace events (like sched_waking) record a pid field that is not the same
as the pid of the executing task.

The "ent.pid" should always be the pid of the task that executed the event.

-- Steve


>  			   __entry->pasid = vm->pasid;
>  			   __assign_str(ring, ring->name)
>  			   __entry->vmid = job->vmid;
> -- 
> 2.17.1
