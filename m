Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C69C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 240AD206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="GHT1e+xy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387840AbgF2TlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733200AbgF2TlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:41:15 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C975CC03E979
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 12:41:15 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id x83so7853309oif.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 12:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hGexIaT8CwluIqqizyzXpQ7j6qkMuzI/CkS1DRj6oWo=;
        b=GHT1e+xybW7cSMRjiOJNskRGbqCBCcu7GxLVqKldbleFHJMoICodTLII5Fil7CImrt
         7ZDwx8qVW94n7P9LJmGppi30mq4fWKrED7dVtBZQZCw5GcdvujnGv5AfBYKcKnUWVJqB
         mOaYqbayQcZiaSTPdetU2mYYsr/SU88cbfZLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hGexIaT8CwluIqqizyzXpQ7j6qkMuzI/CkS1DRj6oWo=;
        b=IUQveFmhp6Ri4eLXCKfp3xbkG+CoXAcfn+LuKFkq5UCTA9jYN7eZJTfcka5J2GTkAe
         GTuCrw19tNoDST+xhbCjcwIxppw7N0TS74rCTpk5eCciSzfVUUSK8W5jFQw1XjBHv2qQ
         PqiCxF9aYWMk+wCD8dxyGCdZSfErYIvzCEwK5KuZtp/9rB8n2mxjjVNXozc+l4OqK9PV
         U1L0UOBu2XA+rGkSd6maHdSaQrK3hqhvNgeAnYbExk0Q9v2BKjRo4R37UUhoJ6w0xlX7
         xGaGtfTJUP/H92xI5oJFjNbWM0RJ4WAmoPBMcKAnBm8L/i5Lj4wIxQzEkSnF/6cgv7bt
         W/+g==
X-Gm-Message-State: AOAM531zaj3slIeE0PGvyWDfZSnSlNu/aj7X8JrwbCpLAvomVG2iEb8B
        yG/q2TKjm/+86tBRQe4CiGE6G92xZP6HCYXZSA+jDQ==
X-Google-Smtp-Source: ABdhPJwv8yb0f9OhR6M3vN5uZIe1nZ2BMLDXD0xNf+Gs6g3qLHpu1FTIRsddJkS4o346lt1JVlcWMrbRgOx0sgMASF8=
X-Received: by 2002:a54:4585:: with SMTP id z5mr13725249oib.110.1593459675085;
 Mon, 29 Jun 2020 12:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <CANaguZBQMarzMb-iXBEx8wJqkTYtRskTL+xQnShuAW7hP9UdqA@mail.gmail.com> <1e3c84b1-78c3-af2c-cfe5-bdd96f520576@linux.intel.com>
In-Reply-To: <1e3c84b1-78c3-af2c-cfe5-bdd96f520576@linux.intel.com>
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
Date:   Mon, 29 Jun 2020 15:41:04 -0400
Message-ID: <CANaguZB1_wBMXMzb=itEfhhYTh6F0GbMT_1OWmw_XS-ufi7Umg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/13] Core scheduling v5
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Paul Turner <pjt@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aubrey,

On Mon, Jun 29, 2020 at 8:34 AM Li, Aubrey <aubrey.li@linux.intel.com> wrote:
>
> >  - Load balancing/migration changes ignores group weights:
> >    - https://lwn.net/ml/linux-kernel/20200225034438.GA617271@ziqianlu-desktop.localdomain
>
> According to Aaron's response below:
> https://lwn.net/ml/linux-kernel/20200305085231.GA12108@ziqianlu-desktop.localdomain/
>
> The following logic seems to be helpful for Aaron's case.
>
> +       /*
> +        * Ignore cookie match if there is a big imbalance between the src rq
> +        * and dst rq.
> +        */
> +       if ((src_rq->cfs.h_nr_running - rq->cfs.h_nr_running) > 1)
> +               return true;
>
> I didn't see any other comments on the patch at here:
> https://lwn.net/ml/linux-kernel/67e46f79-51c2-5b69-71c6-133ec10b68c4@linux.intel.com/
>
> Do we have another way to address this issue?
>
We do not have a clear fix for this yet, and did not get much time to
work on this.

I feel that the above change would not be fixing the real issue.
The issue is about not considering the weight of the group when we
try to load balance, but the above change is checking only the
nr_running which might not work always. I feel that we should fix
the real issue in v6 and probably hold on to adding the workaround
fix in the interim.  I have added a TODO specifically for this bug
in v6.

What do you think?

Thanks,
Vineeth
