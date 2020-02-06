Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1030C35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 22:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4618214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 22:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="hp8jM5tK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgBFWhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 17:37:43 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36567 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgBFWhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 17:37:42 -0500
Received: by mail-qt1-f194.google.com with SMTP id t13so428278qto.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 14:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0QUSZaUS6lpueeg0cJquN32oCvdVi4VI7dUOvoGpNbU=;
        b=hp8jM5tKzKQO0oK4w5Y9LD9/K3JqCEkYzCNyTz0jjyNhRVAy+VuFqbTqLRvUsmMVSw
         BIMLnvHvtGJGkazop9goIupJil8FDucav9ch45IgvjP4StVBm9PLv67vjCCAyEhze/3O
         znHx+oB74/ufK2TWRYrBvVAu7uqZmFdKyJHRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0QUSZaUS6lpueeg0cJquN32oCvdVi4VI7dUOvoGpNbU=;
        b=e7icx94vhh0QMLevk2R0juhmkvcY5ZNhyIEnbixVwXHTNyl7nTWlkPi7Px6yFyqyhR
         440eRo0YeUfqZP1LxjtNoO1mzHyeMX2X3EYNsG7e8b1bDMJD2pu4I6x+vbhrLZRuDKwv
         bxCxyhgpx6oVbquyhCQSx3ZXJ3ht4ake8+j0epBURgqWKvGUyJNi+sdA84rAR/7bSFmY
         zpvNm6kHB6kEhBtssPfGgiD19Yc6UmMdFOJ+8YEYxaa1Eqkau0bxJ6dwtHsAmd7X8bBq
         avA8xWo8fw0xW99hXkEIxF28gMOiFVMGDNFrKNPAW0U+cUfPRW4IJ8Uc02jvN1xX6Nw8
         zMsQ==
X-Gm-Message-State: APjAAAWW1bww9hNpKEym2hn6ntDxV+00uePLqqrSIcVvivGX9Ug+S0zv
        bSeTkVUiNOH7ms5TsSwZrNR1+A==
X-Google-Smtp-Source: APXvYqxVUOIm9blk4cxk2eembPkGx5DTaX7XvSjKzkCPEmTch4lMfErG3I/tQdNJfYqosv1MT13l1g==
X-Received: by 2002:ac8:33f4:: with SMTP id d49mr4839052qtb.145.1581028660438;
        Thu, 06 Feb 2020 14:37:40 -0800 (PST)
Received: from sinkpad (192-222-189-155.qc.cable.ebox.net. [192.222.189.155])
        by smtp.gmail.com with ESMTPSA id j58sm386347qtk.27.2020.02.06.14.37.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Feb 2020 14:37:39 -0800 (PST)
Date:   Thu, 6 Feb 2020 17:37:30 -0500
From:   Julien Desfossez <jdesfossez@digitalocean.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
Message-ID: <20200206223730.GA27942@sinkpad>
References: <cover.1572437285.git.vpillai@digitalocean.com>
 <5e3cea14-28d1-bf1e-cabe-fb5b48fdeadc@linux.intel.com>
 <3c3c56c1-b8dc-652c-535e-74f6dcf45560@linux.intel.com>
 <CANaguZAz+mw1Oi8ecZt+JuCWbf=g5UvKrdSvAeM82Z1c+9oWAw@mail.gmail.com>
 <e322a252-f983-e3f3-f823-16d0c16b2867@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e322a252-f983-e3f3-f823-16d0c16b2867@linux.intel.com>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-Feb-2020 04:28:18 PM, Tim Chen wrote:
> Have you guys been able to make progress on the issues with I/O intensive workload?

Hi Tim,

We are in the process of retesting everything with the following branch:
https://github.com/digitalocean/linux-coresched/tree/coresched/v4-v5.5.y

The CPU-intensive case that becomes overcommitted when we disable SMT
behaves the same as before (core scheduling is a clear win there). So we
are now digging a bit more in our mixed tests with CPU and IO (MySQL
benchmark running in parallel with low-activity VMs). The tests are
still running, but I expect to be able to present some numbers tomorrow.

We will keep the list informed.

Julien
