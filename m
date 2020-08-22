Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25D2C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 03:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 974AE20720
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 03:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="LFH7dq46"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgHVDCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 23:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgHVDB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 23:01:57 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBB7C061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 20:01:57 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id s16so2652213qtn.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 20:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=FWsoHq1nutPT8JV7CuIelWuDNWJa/Pzi1Ayj6/nx3mc=;
        b=LFH7dq46xjHzIlv0mUXdLTUOI4My3LQ20jPxNWGFQHoHzkHyShe7+BBbv/GExR4FX0
         wSYfjgzqV+LOGjDq3rlIoGZIi7jJ+osMrDOmFWMvpki8pRFWi1lLRtAXkhTGzWsyokcf
         mH8/O1L/A2gn/2s9YlgWPmD1egxRn4IsllzfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=FWsoHq1nutPT8JV7CuIelWuDNWJa/Pzi1Ayj6/nx3mc=;
        b=WYGPwZqclah3Qv3Bn0Dfoqo9YEKjYf/JM4Bo6LHpckQFCr7M43dk4NuP23tUtIQRJI
         s1q/JHU8P8p0qhJVM/6UcIfEFRVN0mGLakBrYj2UlyzI9N5XG4j83CcSopSZtfbli4To
         yEcTOY9eqwejFjPTu35Oq53UvSiMLky79s/G5XMH11oVs0ExphsKJMeA8I2GYy8WhtJO
         pfrgrRdAH3c/ErCjMrvD7+cE+EX/RqzAXZVrSzA7rhEGtcKq5kd2qJumWB2pRJQM598I
         AnrojqpmGabF9eWOayHH8RCaS29MlIf3O/wI/ONsvEn1xOZ24dyXhFphErhOwQuyBzGn
         eOtA==
X-Gm-Message-State: AOAM5339zIC/BcBaOSoTr/k6yvXWpUc0NGAyQpzGAmXkWGGSvxEAqAZW
        qypfsafXHoKkvJOH9QaWKuLzuA==
X-Google-Smtp-Source: ABdhPJzW3MctcP4ZxF8JVoFH4r1WyAMfsvqAXrwMchAY1m2eiyB6ilE3ZqFRyN7RfENIteJ8iIsswg==
X-Received: by 2002:ac8:6d0f:: with SMTP id o15mr5274095qtt.121.1598065316418;
        Fri, 21 Aug 2020 20:01:56 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id k55sm4347111qtf.17.2020.08.21.20.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 20:01:55 -0700 (PDT)
Date:   Fri, 21 Aug 2020 23:01:55 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        JulienDesfossez@google.com, jdesfossez@digitalocean.com,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>, joel@joelfernandes.org,
        vineethrp@gmail.com, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        chris.hyser@oracle.com, dhaval.giani@gmail.com, paulmck@kernel.org,
        joshdon@google.com, xii@google.com, haoluo@google.com,
        bsegall@google.com
Subject: [RFC] Design proposal for upstream core-scheduling interface
Message-ID: <20200822030155.GA414063@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
Core-scheduling aims to allow making it safe for more than 1 task that trust
each other to safely share hyperthreads within a CPU core [1]. This results
in a performance improvement for workloads that can benefit from using
hyperthreading safely while limiting core-sharing when it is not safe.

Currently no universally agreed set of interface exists and companies have
been hacking up their own interface to make use of the patches. This post
aims to list usecases which I got after talking to various people at Google
and Oracle. After which actual development of code to add interfaces can follow.

The below text uses the terms cookie and tag interchangeably. Further, cookie
of 0 is assumed to indicate a trusted process - such as kernel threads or
system daemons. By default, if nothing is tagged then everything is
considered trusted since the scheduler assumes all tasks are a match for each
other.

Usecase 1: Google's cloud group tags CGroups with a 32-bit integer. This
int32 is split into 2 parts, the color and the id. The color can only be set
by privileged processes and the id can be set by anyone. The CGroup structure
looks like:

   A         B
  / \      / \ \ 
 C   D    E  F  G

Here A and B are container CGroups for 2 jobs are assigned a color by a
privileged daemon. The job itself has more sub-CGroups within (for ex, B has
E, F and G). When these sub-CGroups are spawned, they inherit the color from
the parent. An unprivileged user can then set an id for the sub-CGroup
without the knowledge of the privileged daemon if it desires to add further
isolation. This setting of id can be an unprivileged operation because the
root daemon has already isolated A and B.

Usecase 2: Chrome browser - tagging renderers. In Chrome, each tab opened
spawns a renderer. A renderer is a sandboxed process and it is assumed it
could run arbitrary code (Javascript etc). When a renderer is created, a
prctl call is made to tag the renderer. Every thread that is spawned by the
renderer is also tagged. Essentially this turns SMT off for the renderer, but
still gives a performance boost due to privileged system threads being able
to share a core. The tagging also forbids the renderer from sharing a core
with privileged system processes. In the future, we plan to allow threads to
share a core as well (especially once we get syscall-isolation upstreamed.
Patches were posted recently for the same [2]).

Usecase 3: ChromeOS VMs - each vCPU thread that is created by the VMM is
tagged thus disallowing core sharing between the vCPU thread and any other
thread on the system. This is because such VMs may run arbitrary user code
and attack both the guest and the host systems sharing the core.

Usecase 4: Oracle - Setting a sub-CGroup as trusted (cookie 0). Chris Hyser
talked to me on IRC that in a CGroup hierarcy, some CGroups should be allowed
to not have to share its parent's CGroup tag. In fact, it should be allowed to
untag the child CGroup if needed thus allowing them to share a core with
trusted tasks. Others have had similar requirements.

Proposal for tagging
--------------------
We have to support both CGroup and non-CGroup users. CGroup may be overkill
for some and the CGroup v2 unified hierarchy may be too inflexible.
Regardless, we must support CGroup due its easy of use and existing users.

For Usecase #1
----------
Usecase #1 requires a 2-level tagging mechanism. I propose 2 new files
to the CPU controller:
- tag : a boolean (0/1). If set, this CGroup and all sub-CGroups will be
  tagged.  (In the kernel, the cookie will be derived from the pointer value
  of a ref-counted cookie object.). If reset, then the CGroup will inherit
  the parent CGroup's cookie if there is one.

- color : The ref-counted object will be aligned say to a 256-byte boundary
  (for example), then the lower 8 bits of the pointer can be used to specify
  color. Together, the pointer with the color will form a cookie used by the
  scheduler.

Note that if 2 CGroups belong to 2 different tagged hierarchies, then setting
their color to be the same does not imply that the 2 groups will share a
core. This is key.  Also, to support usecase #4, we could add a third tag
value -- 2, along with the usual 0 and 1 to suggest that the CGroup can share
a core with cookie-0 tasks (Chris Hyser feel free to add any more comments
here).

For Usecase #2
--------------
We could add an interface that Peter suggested where 2 PIDs A and B want to
share a core. So if A wants to share a core with B, then it issues
prctl(SET_CORE_SHARE, B). ptrace_may_access() can be used to restrict access.
For renderers though, we want to likely allow a renderer to share a core
exclusive with only threads within a renderer and no one else. To support
this, renderer A could simply issue prctl(SET_CORE_SHARE, A).

For Usecase #3
--------------
By default, all threads within a process will share a core. This makes the
most sense because threads in a process share the same virtual address space.
However, for virtual machines in ChromeOS, we would like vCPU threads to not
share a core with other vCPU threads as mentioned above. To support this,
when a vCPU thread is forked, a new clone flag - CLONE_NEW_CORE_TAG could be
introduced to cause the forked thread to not share a core with its parent.
This could also support usecase #2 in the future (instead of prctl, a new
renderer being forked can simply be passed CLONE_NEW_CORE_TAG which will tag the
forked process or thread even if the forking process is not tagged).

Other considerations:
- To share a core anyway even if tags don't match: If we assume that the only
  purpose of core-scheduling is to enforce security, then if the kernel knows
  that CPUs are not vulnerable then cores can be shared anyway, whether the
  tasks are tagged or not (Suggested-by PeterZ).

- Addition of a new CGroup controller: Instead of CPU controller, it may be
  better to add a new CGroup controller in case the CPU controller is not
  attached to some parts of the hierarchy and it is still desirable to use
  CGroup interface for core tagging.

- Co-existence of CGroup with prctl/clone. The prctl/clone tagging should
  always be made to override CGroup. For this purpose, I propose a new
  'tasks_no_cg_tag' or a similar file in the CGroup controller. This file
  will list all tasks that don't associate with the CGroup's tag. NOTE: I am not
  sure yet how this new file will work with prctl/clone-tagging of individual
  threads in a non-thread-mode CGroup v2 usage.

- Differences in tagging of a forked task (!CLONE_THREAD): If a process is
  a part of a CGroup and is forked, then the child process is automatically
  added to that CGroup. If such CGroup was tagged before, then the child is
  automatically tagged. However, it may be desired to give the child its own
  tag. In this case also, the earlier CLONE_NEW_CORE_TAG flag can be used to
  achieve this behavior. If the forking process was not a part of a CGroup
  but got a tag through other means before, then by default a !CLONE_THREAD
  fork would imply CLONE_NEW_CORE_TAG. However, to turns this off, a
  CLONE_CORE_TAG flag can be added (forking process's tag will be inheritted
  by the child).

Let me know your thoughts and looking forward to a good LPC MC discussion!

thanks,

 - Joel

[1] https://lwn.net/Articles/780703/
[2] https://lwn.net/Articles/828889/

