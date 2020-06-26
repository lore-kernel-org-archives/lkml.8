Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB3FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 01:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBE402070A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 01:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="fxtYlJ3B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgFZBrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 21:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgFZBrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 21:47:21 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF16C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 18:47:20 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id x9so7190799ila.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 18:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZI2QAbeI3wF4VjzbAFwJj32Q7EvyNWiBzjCp0xpHBhs=;
        b=fxtYlJ3BSjV7XZtuTFdwqinV6SHT6cwTm9+rCgEISc2G09/DLhxARQYlBy/UK4+DJl
         4KrM9uLJUfl8oLdjmHBPY3Pa8Leoo1jfNizQje6oIZmcNdos0Vzfj+xpwPom436JEru3
         2V+5CuUGRrEMuw5bgXzwjxYWqBLKa5rdq10EM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZI2QAbeI3wF4VjzbAFwJj32Q7EvyNWiBzjCp0xpHBhs=;
        b=iU+rKxkkMg2gU9nIy1MzCC8aH+FIX5pNZF3tSmEZ6DIzr14AoJU+eTfBr1GnBrHgpR
         h4qGuBcYInPD+D1z6FZ9TGWC6U6xoaumPE43Zg/1zDHEHWfpg3PlVHdE9Nevq0eDxAlr
         0JUKAWWC9FoGQDtIjAHQXCyf8xEaDw5NDyveDDgezfdu9fJVPmcNuhc9+EFPQb56Z1S/
         /j3bbIP/JVhqYi+UIywN18byB2BMfjppFjRwBTOdiNcf/ie6KSumFOaImQIM6JWlkFlo
         rsorU1WmxpsEEkISbf28OcUb2cXeXLeWqLUk9MaKuADRkHcdScXFxjGSO+j9ZPnkAD4g
         8mSQ==
X-Gm-Message-State: AOAM533MrPor3kUDnEm6G5s4FaaO14+cyP5aViMIo7qm/MsWYCrDwv3J
        c51zxRFS4AcSu4i6AXRUlBBAnIHx4RfaAjRU/URqOw==
X-Google-Smtp-Source: ABdhPJw28e7/Trivi1/ysunIp3gfsfVNHRSV6GM7hynzLAzphh1A9aI+nfopxiE0hEGN1WS4lZ36n1Mx5S7DDNdRbFE=
X-Received: by 2002:a92:cf42:: with SMTP id c2mr858886ilr.13.1593136040186;
 Thu, 25 Jun 2020 18:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583332764.git.vpillai@digitalocean.com> <CANaguZBQMarzMb-iXBEx8wJqkTYtRskTL+xQnShuAW7hP9UdqA@mail.gmail.com>
In-Reply-To: <CANaguZBQMarzMb-iXBEx8wJqkTYtRskTL+xQnShuAW7hP9UdqA@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 25 Jun 2020 21:47:08 -0400
Message-ID: <CAEXW_YSU5=ZUf-4j55av9Q8b+PRiM2DCKydM9Bv__mzL2MWx4g@mail.gmail.com>
Subject: Re: [RFC PATCH 00/13] Core scheduling v5
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
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
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>,
        Paul Turner <pjt@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 4:12 PM Vineeth Remanan Pillai
<vpillai@digitalocean.com> wrote:
[...]
> TODO lists:
>
>  - Interface discussions could not come to a conclusion in v5 and hence would
>    like to restart the discussion and reach a consensus on it.
>    - https://lwn.net/ml/linux-kernel/20200520222642.70679-1-joel@joelfernandes.org

Thanks Vineeth, just want to add: I have a revised implementation of
prctl(2) where you only pass a TID of a task you'd like to share a
core with (credit to Peter for the idea [1]) so we can make use of
ptrace_may_access() checks. I am currently finishing writing of
kselftests for this and post it all once it is ready.

However a question: If using the prctl(2) on a CGroup tagged task, we
discussed in previous threads [2] to override the CGroup cookie such
that the task may not share a core with any of the tasks in its CGroup
anymore and I think Peter and Phil are Ok with.  My question though is
- would that not be confusing for anyone looking at the CGroup
filesystem's "tag" and "tasks" files?

To resolve this, I am proposing to add a new CGroup file
'tasks.coresched' to the CGroup, and this will only contain tasks that
were assigned cookies due to their CGroup residency. As soon as one
prctl(2)'s the task, it will stop showing up in the CGroup's
"tasks.coresched" file (unless of course it was requesting to
prctl-share a core with someone in its CGroup itself). Are folks Ok
with this solution?

[1]  https://lore.kernel.org/lkml/20200528170128.GN2483@worktop.programming.kicks-ass.net/
[2] https://lore.kernel.org/lkml/20200524140046.GA5598@lorien.usersys.redhat.com/
