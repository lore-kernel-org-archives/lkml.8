Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A573C433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 689AC208B8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="HW4qqfzQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbgGBM6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 08:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729218AbgGBM57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 08:57:59 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAECC08C5DC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 05:57:59 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id m9so12603176qvx.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 05:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9SWGnubDWqg/t2WsVA0LlntzVzjp9DweIcUd8FpWx0c=;
        b=HW4qqfzQl3zi9IpbnSdop+NeCDE2cAIEPclDJQJa7yfeofwC955o1D5TwSgfCpzdys
         j8KL9SCqcXxqdttZOSNOsd9m2+MehTVTm4nHLlzNK8q0PoQws1QFDCjj3jDJNQ/pftsZ
         KEQ1SsOPVNXykmJZB5iWF5BSK+xEo7yDkUf8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9SWGnubDWqg/t2WsVA0LlntzVzjp9DweIcUd8FpWx0c=;
        b=DlDh6+UE8nHjvNIUpHwFZcsu40IqkL04O+VHeZRlw25nl2lS5wW1fQH3jd+LQWBScM
         +e1WVgG3cICmnjbTXaB0WOilXsNC4nc0BPaJE0h3M8VMV78LtqnAktmyWKUwjVeIZ2PK
         MHs/vMBgkoQTls8JQDO/g01rPqpJjRdVzpQjMpxSDZ+dwk333zcOL49gvT99eAPcanFy
         VVrFd+Ubwds93mo/wAbWQeqDVC5RPhlIrAxdK6RvV2eaSi3/ufNrVmO4FZ44dFiodhQ8
         pl1McLBdP7MoWbhIirDf0rYfgyoPAXNov6EiFpv+6NfgGk+6shW8yCfQ1ndrEDuYhp40
         FdTQ==
X-Gm-Message-State: AOAM530zeF7ikOhurs4XqlKocQ1tzc3ex09f1vjLABgStnFVOhZeEEZ7
        zwOtDQ+f6iRPPIEJdO4bPAaedQ==
X-Google-Smtp-Source: ABdhPJxWYIcxMrGOwlVVjhse4DwsG1ruRLL36p51s+ouSOvVH0/rCvAdUYzop90Kphypjo9TODSIbw==
X-Received: by 2002:a0c:bda0:: with SMTP id n32mr30978862qvg.164.1593694678083;
        Thu, 02 Jul 2020 05:57:58 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id p7sm7930994qki.61.2020.07.02.05.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 05:57:57 -0700 (PDT)
Date:   Thu, 2 Jul 2020 08:57:57 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        mingo@kernel.org, fweisbec@gmail.com, keescook@chromium.org,
        kerrnel@google.com, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineethrp@gmail.com,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>, paulmck@kernel.org
Subject: Re: [RFC PATCH 06/16] sched: Add core wide task selection and
 scheduling.
Message-ID: <20200702125757.GB439212@google.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
 <ed924e2cb450a4cce4a1b5a2c44d29e968467154.1593530334.git.vpillai@digitalocean.com>
 <20200701232847.GA439212@google.com>
 <200c81ef-c961-dcd5-1221-84897c459b05@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200c81ef-c961-dcd5-1221-84897c459b05@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 05:54:11PM -0700, Tim Chen wrote:
> 
> 
> On 7/1/20 4:28 PM, Joel Fernandes wrote:
> > On Tue, Jun 30, 2020 at 09:32:27PM +0000, Vineeth Remanan Pillai wrote:
> >> From: Peter Zijlstra <peterz@infradead.org>
> >>
> >> Instead of only selecting a local task, select a task for all SMT
> >> siblings for every reschedule on the core (irrespective which logical
> >> CPU does the reschedule).
> >>
> >> There could be races in core scheduler where a CPU is trying to pick
> >> a task for its sibling in core scheduler, when that CPU has just been
> >> offlined.  We should not schedule any tasks on the CPU in this case.
> >> Return an idle task in pick_next_task for this situation.
> >>
> >> NOTE: there is still potential for siblings rivalry.
> >> NOTE: this is far too complicated; but thus far I've failed to
> >>       simplify it further.
> >>
> >> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >> Signed-off-by: Julien Desfossez <jdesfossez@digitalocean.com>
> >> Signed-off-by: Vineeth Remanan Pillai <vpillai@digitalocean.com>
> >> Signed-off-by: Aaron Lu <aaron.lu@linux.alibaba.com>
> >> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> > 
> > Hi Peter, Tim, all, the below patch fixes the hotplug issue described in the
> > below patch's Link tag. Patch description below describes the issues fixed
> > and it applies on top of this patch.
> > 
> > ------8<----------
> > 
> > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > Subject: [PATCH] sched: Fix CPU hotplug causing crashes in task selection logic
> > 
> > The selection logic does not run correctly if the current CPU is not in the
> > cpu_smt_mask (which it is not because the CPU is offlined when the stopper
> > finishes running and needs to switch to idle).  There are also other issues
> > fixed by the patch I think such as: if some other sibling set core_pick to
> > something, however the selection logic on current cpu resets it before
> > selecting. In this case, we need to run the task selection logic again to
> > make sure it picks something if there is something to run. It might end up
> > picking the wrong task.  Yet another issue was, if the stopper thread is an

"It might end up picking the wrong task" needs to be: "We might end up
picking a different task but that's Ok".

> > unconstrained pick, then rq->core_pick is set. The next time task selection
> > logic runs when stopper needs to switch to idle, the current CPU is not in
> > the smt_mask. This causes the previous ->core_pick to be picked again which
> > happens to be the unconstrained task! so the stopper keeps getting selected
> > forever.
> > 
> > That and there are a few more safe guards and checks around checking/setting
> > rq->core_pick. To test it, I ran rcutorture and made it tag all torture
> > threads. Then ran it in hotplug mode (hotplugging every 200ms) and it hit the
> > issue. Now it runs for an hour or so without issue. (Torture testing debug
> > changes: https://bit.ly/38htfqK ).
> > 
> > Various fixes were tried causing varying degrees of crashes.  Finally I found
> > that it is easiest to just add current CPU to the smt_mask's copy always.
> > This is so that task selection logic always runs on the current CPU which
> > called schedule().
> 
> 
> It looks good to me. 

Thank you for your review! Could I add your Reviewed-by tag to the patch?

 - Joel


> Thanks.
> 
> Tim
