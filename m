Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4ECC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 18:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E79F2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 18:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ik+geL+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbgAUS0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 13:26:49 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43213 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbgAUS0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 13:26:46 -0500
Received: by mail-pf1-f196.google.com with SMTP id x6so1906327pfo.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 10:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=CNg/6m7g/bunj5QfST0/ZxYqaCoQRNcdlNdjQXkWwNM=;
        b=Ik+geL+F59AE1Fi2N+Wlip48+W/+Sd4x4KXe51lgnVM70gKmmpZ0MPVfxp9LREfO75
         7tzSZKywuTbDQK+Od6ekWVYTmACj0sp/awHwAu+01o6ZZoE6axnrLCa+Jv2MD3updsdE
         394T/JuO90HailtNweEUhQVpnAIHd98DMq69/b3vJkZWrtVsykjYZYaXAIxY+fYRoXCo
         VUGg7os7QnYGyEeoi7o3pwdtqrHHUH0kdJSe5fKRy5ucvM/FyryculSCw2PManyo2C3s
         zT+aPNsTFqbvepyu8ViBm9p/9WmN2JOl+uadPX87InMCmk/wHF8qsjRtBEqZ9Cd+aWRc
         FdJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=CNg/6m7g/bunj5QfST0/ZxYqaCoQRNcdlNdjQXkWwNM=;
        b=b10zqvL5vm3taS5VSwnCtbBUlvOYUiijr89y35fJTrIKbbY0Qef9xMyCHbHeWPZYzv
         3uQ4lqwNaqHX200XD3t48hhXUPYaJuq23il4Iz8K2UoZcvlEO7XDEkBQZXOh/FFBgW9Q
         sfXxppA6Sodj1z1FiFG/dEz3WydK4Dgvx6dpoF1PHca8ovRTjZoS1PQ0WIeRXbUe8k0/
         qcC2qi/4WO3rF1tazJuBWISmXZrmiOmPnWwRke1o+qLkXL19wNJsE3T3O440GzT/cSoZ
         g7Bp95YKB3re6/GCK9zkDMKP6Xs5vw8hfhVazUFCUQNfhF0IJsLKLRk4aPPMsdH/sLm3
         PlrA==
X-Gm-Message-State: APjAAAWBPtlIcL1LvX/dMV7qAc5hz903r/yfKvdZC5mWBffuxn13fUEF
        y+s0PBIxu6YR24YQ3S8GfvJWSiKKI/w=
X-Google-Smtp-Source: APXvYqwCtZpS9cVgmbxaaK38WjKo15e/6fG+QC9OQLnmVrX1kZojzjhs8k/yoT+tNQe/NThEl4n5Xg==
X-Received: by 2002:a63:e409:: with SMTP id a9mr6809734pgi.108.1579631204786;
        Tue, 21 Jan 2020 10:26:44 -0800 (PST)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2cd:202:39d7:98b3:2536:e93f])
        by smtp.gmail.com with ESMTPSA id e15sm131115pja.13.2020.01.21.10.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 10:26:43 -0800 (PST)
From:   bsegall@google.com
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     bsegall@google.com, Vincent Guittot <vincent.guittot@linaro.org>,
        mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair : prevent unlimited runtime on throttled group
References: <1579011236-31256-1-git-send-email-vincent.guittot@linaro.org>
        <xm26blr5oprc.fsf@bsegall-linux.svl.corp.google.com>
        <20200120094625.GL14879@hirez.programming.kicks-ass.net>
Date:   Tue, 21 Jan 2020 10:26:42 -0800
In-Reply-To: <20200120094625.GL14879@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Mon, 20 Jan 2020 10:46:25 +0100")
Message-ID: <xm267e1koecd.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Tue, Jan 14, 2020 at 10:29:43AM -0800, bsegall@google.com wrote:
>> Vincent Guittot <vincent.guittot@linaro.org> writes:
>> 
>> > When a running task is moved on a throttled task group and there is no
>> > other task enqueued on the CPU, the task can keep running using 100% CPU
>> > whatever the allocated bandwidth for the group and although its cfs rq is
>> > throttled. Furthermore, the group entity of the cfs_rq and its parents are
>> > not enqueued but only set as curr on their respective cfs_rqs.
>> >
>> > We have the following sequence:
>> >
>> > sched_move_task
>> >   -dequeue_task: dequeue task and group_entities.
>> >   -put_prev_task: put task and group entities.
>> >   -sched_change_group: move task to new group.
>> >   -enqueue_task: enqueue only task but not group entities because cfs_rq is
>> >     throttled.
>> >   -set_next_task : set task and group_entities as current sched_entity of
>> >     their cfs_rq.
>> >
>> > Another impact is that the root cfs_rq runnable_load_avg at root rq stays
>> > null because the group_entities are not enqueued. This situation will stay
>> > the same until an "external" event triggers a reschedule. Let trigger it
>> > immediately instead.
>> 
>> Sounds reasonable to me, "moved group" being an explicit resched check
>> doesn't sound like a problem in general.
>
> Do I read that as an Ack from you Ben? :-)

Yeah,

Acked-by: Ben Segall <bsegall@google.com>

The only question I see is if we care about avoiding the overhead for
non-cfsb cases, but cgroup attach is already slow enough that it's
probably not a real problem, and it's reasonable to check if it's still
right to run this task in general.
