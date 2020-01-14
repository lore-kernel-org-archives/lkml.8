Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D00C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C5A8207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="fQKMNEvO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbgANPkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 10:40:43 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39042 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgANPkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:40:43 -0500
Received: by mail-oi1-f194.google.com with SMTP id a67so12214588oib.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 07:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u8XC9ay451hJukBxPp4gptSvR5akp33o0GT26Nx+rN4=;
        b=fQKMNEvOdLnsADksjSwSk8sRK5bp5aL4P/dfzdlnvRDMQ3qRzDbeLngRwBZEaQrOlj
         X4zhDwC9tSqko8r3mJs36SDOtRrGKqIllVXOjiTADvOj0sBT6AQssKY8wLHwuAkbSTfG
         YO69puHnqzXFJQumuUNxPOb2UpDOf8EaBAp8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u8XC9ay451hJukBxPp4gptSvR5akp33o0GT26Nx+rN4=;
        b=MI0RpEZ71uIXBLAce6IeXcELUa4b22bRwTpab99nHe6LKoX5ZVegOPwrpcGPriZ+T7
         g7/7mZ9N9Ib6lu6O2EJfHasN5VdA6G1xh1473tHFDIPatGB68+/WGK2OksU1IUBkv0mn
         NZIC/7cRy3cStuGTGsamQsuzxbB0LCE9Rfo5BnhPhq+JQc6d90aPVvuzCv4JCRQrrrD9
         5Lozm+hfD1be+Oc4B4tygKHY3hYVMKrvLyxhtluvYFw3niJ+8Q6Yo/Frh9YdcjAtuLdI
         rOEFKXkN3uq9+K+q0xPGgnwFP3aRcxwu64nW1m8d1C1H5dRR50t4IaDbbiHrUXKRy8E6
         nZOQ==
X-Gm-Message-State: APjAAAVadoZPCyDPoHFgPV4y4N72RECrFJ8t5hURy3+I0MGDN3MlMcVc
        bbOb9ap+hDS8TxTjJIqODyRSF+Y2r3iwQX21aocCmQ==
X-Google-Smtp-Source: APXvYqw9oJlg+tUTGvPGmuG74GW5vN5WjxpK0O2mxySKvUph8pLBk6qmod2aqAPm6odbKTbiPgZcbgK4GskfnUL65wo=
X-Received: by 2002:aca:ad11:: with SMTP id w17mr17844187oie.85.1579016442324;
 Tue, 14 Jan 2020 07:40:42 -0800 (PST)
MIME-Version: 1.0
References: <cover.1572437285.git.vpillai@digitalocean.com>
 <5e3cea14-28d1-bf1e-cabe-fb5b48fdeadc@linux.intel.com> <3c3c56c1-b8dc-652c-535e-74f6dcf45560@linux.intel.com>
In-Reply-To: <3c3c56c1-b8dc-652c-535e-74f6dcf45560@linux.intel.com>
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
Date:   Tue, 14 Jan 2020 10:40:31 -0500
Message-ID: <CANaguZAz+mw1Oi8ecZt+JuCWbf=g5UvKrdSvAeM82Z1c+9oWAw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
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
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 8:12 PM Tim Chen <tim.c.chen@linux.intel.com> wrote:

> I also encountered kernel panic with the v4 code when taking cpu offline or online
> when core scheduler is running.  I've refreshed the previous patch, along
> with 3 other patches to fix problems related to CPU online/offline.
>
> As a side effect of the fix, each core can now operate in core-scheduling
> mode or non core-scheduling mode, depending on how many online SMT threads it has.
>
> Vineet, are you guys planning to refresh v4 and update it to v5?  Aubrey posted
> a port to the latest kernel earlier.
>
Thanks for the updated patch Tim.

We have been testing with v4 rebased on 5.4.8 as RC kernels had given us
trouble in the past. v5 is due soon and we are planning to release v5 when
5.5 comes out. As of now, v5 has your crash fixes and Aubrey's changes
related to load balancing. We are investigating a performance issue with
high overcommit io intensive workload and also we are trying to see if
we can add synchronization during VMEXITs so that a guest vm cannot run
run alongside with host kernel. We also need to think about the userland
interface for corescheduling in preparation for upstreaming work.

Does it make sense to wait until 5.5 release for v5 considering the
above details?

Thanks,
Vineeth
