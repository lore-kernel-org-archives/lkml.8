Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20142C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 01:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7980206EC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 01:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="oKgU+/Eq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbgCRBLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 21:11:00 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37062 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgCRBLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 21:11:00 -0400
Received: by mail-qk1-f193.google.com with SMTP id z25so31211316qkj.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 18:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z7eeYy5ulhx+d1mhg7bEsRqN6ya3Xwkc0RHtj8giZaY=;
        b=oKgU+/EqahKewvjJN9RoBQd8FnOKPFQx6NtcRZJOu+zdcbfTCElQ8m7y4C50KW3/I/
         dyhLgsXQzo5Wcb9S0n435uB3H0OSg/Ns0nPKatB4rQrEsl8UQZGH9xDxpcI3J5LJ/g8f
         Nq8ku8R/3b4y5DLSNLx93XuxFZSFqMU2h4OvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z7eeYy5ulhx+d1mhg7bEsRqN6ya3Xwkc0RHtj8giZaY=;
        b=UOVA+3P9g7dHu7vYJVgXtILWHrhsdM2+KFxNr0/r+vM0FwnktVm/mHXcmeSXhiKx08
         yhtFOco3Wtq9Jbcle6AKyGtnQ0ruE82vexrfYu9Z0H7Ds/xcaMbJbMAS9kJnGc+OzUwV
         UByTxiKrUxmFyQcAt9QlMeGe6RoftR7njHEfwJ5AwvPnqU8t8dguKVpA/5Le0+HO9yXW
         8dFOCkVTvM325A1qeN0Zd9IIW2vjwqewIf9feZ8xz/7JK047IceCOYAEr+h5oSpZiyJf
         epDMIyg5HDZu6IjN8iTikXJXVW1wo5/Gy6pprC+iG+wLiEyJGrqnIUkk5AW/iznUrINP
         2HFA==
X-Gm-Message-State: ANhLgQ1dN/ddbdMq4At0BYyCGUs08a83lZre1/9ZNJB4BTdYOQ0AAVKL
        OHeIwgHsXlBEirPBAhB0v5qqTw==
X-Google-Smtp-Source: ADFU+vv1aEqzI0khyZkUEThEjrkkfRyGnJdVoH/Pup1ol71yZ5+7d3HsygjfCpmBLEPKVJprtho6qA==
X-Received: by 2002:a37:8e45:: with SMTP id q66mr1733237qkd.129.1584493859289;
        Tue, 17 Mar 2020 18:10:59 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id x5sm3402326qti.5.2020.03.17.18.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 18:10:58 -0700 (PDT)
Date:   Tue, 17 Mar 2020 21:10:58 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dario Faggioli <dfaggioli@suse.com>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
Message-ID: <20200318011058.GB111608@google.com>
References: <20200212230705.GA25315@sinkpad>
 <29d43466-1e18-6b42-d4d0-20ccde20ff07@linux.intel.com>
 <CAERHkruG4y8si9FrBp7cZNEdfP7EzxbmYwvdF2EvHLf=mU1mgg@mail.gmail.com>
 <CANaguZC40mDHfL1H_9AA7H8cyd028t9PQVRqQ3kB4ha8R7hhqg@mail.gmail.com>
 <CAERHkruPUrOzDjEp1FV3KY20p9CxLAVzKrZNe5QXsCFZdGskzA@mail.gmail.com>
 <CANaguZBj_x_2+9KwbHCQScsmraC_mHdQB6uRqMTYMmvhBYfv2Q@mail.gmail.com>
 <20200221232057.GA19671@sinkpad>
 <20200317005521.GA8244@google.com>
 <ee268494-c35e-422f-1aaf-baab12191c38@linux.intel.com>
 <1075ba53-91ed-2138-89b3-60fbfbd80b57@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075ba53-91ed-2138-89b3-60fbfbd80b57@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim,

On Tue, Mar 17, 2020 at 01:18:45PM -0700, Tim Chen wrote:
[..] 
> Did you guys have a chance to try out v5 core scheduler?
> 
> > - Joel(ChromeOS) found a deadlock and crash on PREEMPT kernel in the
> >   coreshed idle balance logic
> 
> We did some patches to fix a few stability issues in v4.  I wonder
> if v5 still has the deadlock that you saw before?

I have not yet tested v5. I fixed the RCU-related deadlock in the scheduler
with this patch sent few days ago:
https://lore.kernel.org/patchwork/patch/1209561/

I'll rebase my tree on v5 soon.

Thanks!

 - Joel

