Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9836C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 04:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73DB921D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 04:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJLPHS6s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgB0Ep0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 23:45:26 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38056 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728284AbgB0EpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 23:45:25 -0500
Received: by mail-lj1-f196.google.com with SMTP id w1so1772921ljh.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 20:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PiXJcLUpRVHcpB6LdyRFbmWgKnATo19wj7jDFJArUOs=;
        b=KJLPHS6sNiGExqsGhENMjlF7WNsf4pdO9oI2TUbXQjbGP2cuPkDXsFSGEgM12IK8dT
         fGBXeIDJPvTWtGi78u2GkTp/PVg+no6pJoYQ7qRkl67iYsAjSHTkIgryXCszvaZT4lZ+
         g2+JRThSaEg/5ZOUuXeh6lCtLiqCXfOk4F3ftuJutmlmyJgqyxguCTZCBleoSKozBVz4
         ToTXZBCgQtzkVOtpz19rrMCMLntzZaLKwxnMJ631srZW3SYV1yOTLiYqqlAEghFV4bah
         Z4hI1YEU3IEsdiQggvHzPOuvgx9HyMf60MP1wtyQaelfCPj/2Qo7qwBH1zupB+zhhZYM
         Fl2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PiXJcLUpRVHcpB6LdyRFbmWgKnATo19wj7jDFJArUOs=;
        b=H9uYPxx6efCr7EdoCzlS5yJZjtReteNZHGpGajIUXxNSuCRgXR6kMRS9I+0kErkaQf
         ZAsKRFMhvXcTUBf6NobyQK6H1X6uzT3xWw9VJ36+ku72XeBJILVujctEZumTwenNwHTd
         eEpxIVcu5kBdX4cjZ/H3CypfIo0WTW484nPN5mBIqboJBOfDTlJocLqGcQUphOEsIHYl
         a6U8Hi1BZ9scmTYPd9HEtWF/c8tX5n/UTv3Bduic7TOE1HcWSVbUj+YrCUFhOObrJFz0
         f9HSSz1pICBUsqoREZMA6mevVd6y8oklBlx0y4t/dEcxkTj/EO8GhIUS7vb0MpvAOiXK
         lyaQ==
X-Gm-Message-State: ANhLgQ3Z1iwXkK2KCRWDcZT67/sbMkGlD57FukFPGH6ItPCDD62gdyyo
        iZOo+Nw4LzYNgGQ56/WZf9ubvSKkN6t7HS902D8=
X-Google-Smtp-Source: ADFU+vunsHih3UI7mrp2cAEPBa9YMpfMy5bn2oY1wt8S1xUx3GvGd48Yl0jlFc+dyBy7iGf6DSvQZnjSaNdOknNCNBU=
X-Received: by 2002:a2e:b6ce:: with SMTP id m14mr1401676ljo.99.1582778723339;
 Wed, 26 Feb 2020 20:45:23 -0800 (PST)
MIME-Version: 1.0
References: <cover.1572437285.git.vpillai@digitalocean.com>
 <5e3cea14-28d1-bf1e-cabe-fb5b48fdeadc@linux.intel.com> <3c3c56c1-b8dc-652c-535e-74f6dcf45560@linux.intel.com>
 <CANaguZAz+mw1Oi8ecZt+JuCWbf=g5UvKrdSvAeM82Z1c+9oWAw@mail.gmail.com>
 <e322a252-f983-e3f3-f823-16d0c16b2867@linux.intel.com> <20200212230705.GA25315@sinkpad>
 <29d43466-1e18-6b42-d4d0-20ccde20ff07@linux.intel.com> <CAERHkruG4y8si9FrBp7cZNEdfP7EzxbmYwvdF2EvHLf=mU1mgg@mail.gmail.com>
 <20200225034438.GA617271@ziqianlu-desktop.localdomain> <CANaguZD205ccu1V_2W-QuMRrJA9SjJ5ng1do4NCdLy8NDKKrbA@mail.gmail.com>
 <CAERHkrscBs8WoHSGtnH9mVsN3thfkE0CCQYPRE=XFUWWkQooQQ@mail.gmail.com> <CANaguZDQZg-Z6aNpeLcjQ-cGm3X8CQOkZ_hnJNUyqDRM=yVDFQ@mail.gmail.com>
In-Reply-To: <CANaguZDQZg-Z6aNpeLcjQ-cGm3X8CQOkZ_hnJNUyqDRM=yVDFQ@mail.gmail.com>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Thu, 27 Feb 2020 12:45:11 +0800
Message-ID: <CAERHkruh6_tW+cxx0GMksJSY2VrPNr5g8sLcgpiaOZE2JKj4QQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Aaron Lu <aaron.lwe@gmail.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
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
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 5:54 AM Vineeth Remanan Pillai
<vpillai@digitalocean.com> wrote:
>
> Hi Aubrey,
>>
>>
>> Thanks for the quick fix. I guess this patch should work for Aaron's case
>> because it almost removed the cookie checking here. Some comments
>> below:
>>
>> + if (rq->core->core_forceidle)
>> +         return true;
>>
>> We check cookie match during load balance to avoid two different
>> cookie tasks on the same core. If one cpu is forced idle, its sibling should
>> be running a non-idle task, not sure why we can return true directly here.
>> And if we need to check cookie, with this forced idle case, why it's special
>> to be picked up?
>
> The idea behind this was: If a core is forced idle, then we have a
> scenario where one task is running without a companion and one task
> is forced to be idle. So if this source task is of the same cookie
> as the forced idle task, then migrating this source task will offer a
> chance for the force idle task to run together with task in subsequent
> schedules. We don't have a framework to check the cookie of forced
> idle tasks and hence this if block is only partial fix.

To mitigate force idle, this helper is trying to prevent unmatched case, not
catch the matched case. If the task's cookie is matched with forced idle
cpu's sibling, it's able to pass the check later.  Comparing to my original
intention, this fix increases unmatched case as it returns immediately and
we don't check cookie later.

>>
>>
>> + if (task_h_load(p) > task_h_load(rq->curr))
>> +         return true;
>> + if (task_util_est(p) > task_util_est(rq->curr))
>> +         return true;
>>
>> These two need to exclude rq->curr == rq->idle case?
>> otherwise idle balance always return true?
>
> rq->curr being NULL can mean that the sibling is idle or forced idle.
> In both the cases, I think it makes sense to migrate a task so that it can
> compete with the other sibling for a chance to run. This function
> can_migrate_task actually only says if this task is eligible and
> later part of the code decides whether it is okay to migrate it
> based on factors like load and util and capacity. So I think its
> fine to declare the task as eligible if the dest core is running
> idle. Does this thinking make sense?
>
The intention here is stopping migration not allowing migration.
task_h_load(idle) is zero, but idle_task's sibling CPU is running
a task with cookieA, the fix returns immediately when
task_h_load(task cookieB) > 0, this puts another unmatched case in.

> On our testing, it did not show much degradation in performance with
> this change. I am reworking the fix by removing the check for
> task_est_util. It doesn't seem to be valid to check for util to migrate
> the task.

I'm not sure the check for task_h_load is exactly wanted here either.
From my understanding, the problem is because we stopped high
weight task migration because its cookie does not match with the target's,
can we check high load here instead of high weight?

Thanks,
-Aubrey
