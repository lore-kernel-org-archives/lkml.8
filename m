Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F69C352A3
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 06:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E10420726
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 06:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STFkDA3d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgBOGBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 01:01:49 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45849 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgBOGBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 01:01:49 -0500
Received: by mail-lj1-f195.google.com with SMTP id e18so12999486ljn.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 22:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zxzlXnit2pajsH9JXNI/IWXgXkwjfOCbTSesFxmu85I=;
        b=STFkDA3dKtuhGhSK/zrgbO2q+jHym/SSO9PznaC3TlYvin2bI6rFa9LHCOw9JeI8UN
         AZFCv+EQuc2e8sZzrehpglcxSCt8kOyahRvKxKF4dTR933b6Fhhe9MY6N89h6bHBL0qm
         Fa0sxOwkMoq4DzRJJpA0Gd9K8yawdg6JFEKS1io2+esEptPTByl6QMRrfP4uf1woGEfA
         p7ysZukfI6laD1EnxnSUAx4X1/uKGAjvdhzZXnJ4edDy/g9oMOBRABng3O7/4Z6Kl/OT
         zVbGK8Xa1mggz3gi3C2zYhJzY2IEfw0aNfqw127+/jM/zHVf91PdWIMsuWFHkNdDpaUi
         OYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zxzlXnit2pajsH9JXNI/IWXgXkwjfOCbTSesFxmu85I=;
        b=gdG9RL97FTBo6qtVWj29coc8OvOK/gY8xvMyEbFRDRnCEBZC4tbzHTJFuwLdIYlOfE
         c9TefG+ZGHkWW3iqFYQxblQ9xrEfH3SChzLEpNLFpxLEFRdQ2Y2615C44ubLGvxxiR7K
         UHPBnZRf9FLtIeihVGX3BfcAd2udP++D9qBtM5k+YcVkBCEgPTKx3zH6IDkOO2NhieP6
         9n5f22++9YqUFArGYwwoMc3JsxXA3iGmnkbaA1iCGcr/Rp0pUkQkAzcXYGXyaKKzyAte
         pH4dOm9jem9geFSww4V6WIVyf8rzYRI6zs3mCQLHVQ2RuEQPZcGOI+5+PI18Vw8N4INt
         xl2Q==
X-Gm-Message-State: APjAAAXSwCw6bghaMNdWxlI9pPByDPig8utUG+bxzVvMd7EFFMV77Pgp
        EBcEbZJWA3QgCxaJeK8LDq9g55D8wPqwn8aaGvE=
X-Google-Smtp-Source: APXvYqwQP47j6vpUcH/kgRZycw3bvMqH0Nf7+UeJO/l/qk5iufA1v4iqmIHtP5bFVmysSPhZRdKgAnhQDxFwHIxXg0g=
X-Received: by 2002:a2e:9592:: with SMTP id w18mr4057852ljh.98.1581746507487;
 Fri, 14 Feb 2020 22:01:47 -0800 (PST)
MIME-Version: 1.0
References: <cover.1572437285.git.vpillai@digitalocean.com>
 <5e3cea14-28d1-bf1e-cabe-fb5b48fdeadc@linux.intel.com> <3c3c56c1-b8dc-652c-535e-74f6dcf45560@linux.intel.com>
 <CANaguZAz+mw1Oi8ecZt+JuCWbf=g5UvKrdSvAeM82Z1c+9oWAw@mail.gmail.com>
 <e322a252-f983-e3f3-f823-16d0c16b2867@linux.intel.com> <20200212230705.GA25315@sinkpad>
 <29d43466-1e18-6b42-d4d0-20ccde20ff07@linux.intel.com> <CAERHkruG4y8si9FrBp7cZNEdfP7EzxbmYwvdF2EvHLf=mU1mgg@mail.gmail.com>
 <CANaguZC40mDHfL1H_9AA7H8cyd028t9PQVRqQ3kB4ha8R7hhqg@mail.gmail.com>
In-Reply-To: <CANaguZC40mDHfL1H_9AA7H8cyd028t9PQVRqQ3kB4ha8R7hhqg@mail.gmail.com>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Sat, 15 Feb 2020 14:01:36 +0800
Message-ID: <CAERHkruPUrOzDjEp1FV3KY20p9CxLAVzKrZNe5QXsCFZdGskzA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dario Faggioli <dfaggioli@suse.com>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 11:05 PM Vineeth Remanan Pillai
<vpillai@digitalocean.com> wrote:
>
> Hi Aubrey,
>
> Thanks for the updated patches. Merged the changes to our testing branch
> in preparation for v5.
>
>>
>> I added a helper to check task and cpu cookie match, including the
>> entire core idle case. The refined patchset updated at here:
>> https://github.com/aubreyli/linux/tree/coresched_v4-v5.5.2
>
>
> I did not go through all the changes thoroughly, but on a quick glance,
> I feel a small change would optimize it a bit.
>
> +       /*
> +        * A CPU in an idle core is always the best choice for tasks with
> +        * cookies, and ignore cookie match if core scheduler is not enabled
> +        * on the CPU.
> +        */
> +       if (idle_core || !sched_core_enabled(rq))
> +               return true;
> +
> +       return rq->core->core_cookie == p->core_cookie;
> +}
> +
>
> I think check for sched_core_enabled would make sense to be done above the
> for loop. Something like this:
>
> +static inline bool sched_core_cookie_match(struct rq *rq, struct task_struct *p)
> +{
> +       bool idle_core = true;
> +       int cpu;
> +
> +       if (!sched_core_enabled(rq))
> +               return true;
> +
> +       for_each_cpu(cpu, cpu_smt_mask(cpu_of(rq))) {
> +               if (!available_idle_cpu(cpu)) {
> +                       idle_core = false;
> +                       break;
> +               }
> +       }
> +
> +       /*
> +        * A CPU in an idle core is always the best choice for tasks with
> +        * cookies.
> +        */
> +       return idle_core || rq->core->core_cookie == p->core_cookie;
> +}
> +
>
> We can avoid the unnecessary check for idle_core is sched_core is disabled.
> This would optimize in case of systems with lots of cpus.
>
> Please let me know!

Yes, this makes sense, patch updated at here, I put your name there if
you don't mind.
https://github.com/aubreyli/linux/tree/coresched_v4-v5.5.2-rc2

Thanks,
-Aubrey
