Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145C0C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D532620899
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="MOdEZaH1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbgGBNX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 09:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729067AbgGBNX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 09:23:26 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3244DC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 06:23:26 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id h23so21218121qtr.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 06:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tQQycwGEKzdKxcoNoWPFauxOAQvh7OvU0dyuaE5A+6I=;
        b=MOdEZaH1q3CM9K5QJ5rNQe+0b02f+Gb3AdYcq8JjheThCfW7YCBE4XN5Wzq3fXpAs9
         cE1yb5GpwbZoNui7bGwgX738mAqWU14NTCrnH2KpL5aIAryjZNkpmKOQbKybAQVya2qI
         fZqYV8R0xz3dPNpT9uA2BDrmHtIeN2g4/HK5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tQQycwGEKzdKxcoNoWPFauxOAQvh7OvU0dyuaE5A+6I=;
        b=bhQ1YvwS8rH6i8vrVCtJGO4jZxxocX4XJvE7c2Dc5DTKo7ShoexC3Gh5XJFaPoq5nE
         l2D46vWaLH2rrxiPk07ex5kAUuBX6xQXzg6b2wPvDA5L7PRrzaiqXIwbciao38SC9x0H
         2aUT57Jc3qjZTyEoeynJLMNxAVuvCBzaG33FUvZut/eYjHQdOVvhu1hcTtQCJDoZ48bO
         dzRU8d4CW9ZJmUSDzomJ/Vqqtnt5caNwSXcXKE5vnNhuJj6WKVgkPlEmlgbI1EuZIJdY
         arvS2KlhmBeA7EncRDrdxvBvzLcBJsRHYKKlWEtkPtOWr7gfMwfzVgRqOkk2gb2TUH/7
         i4nQ==
X-Gm-Message-State: AOAM532hRk2NpuBeFTSfJ32ZdDrOVxKlcAYcLqqupt3ILwmrkblrTj5I
        /SAf7iCrjKawB6sxVX7DhZlBLw==
X-Google-Smtp-Source: ABdhPJzkeeg9iH8laiBBNmE+PF5PTv7RXVUhKDsmNRy7VIxnOsDAC2wA2dl1r3hI5OR1BYBKs7Q5LQ==
X-Received: by 2002:ac8:2928:: with SMTP id y37mr31690803qty.245.1593696205384;
        Thu, 02 Jul 2020 06:23:25 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id 21sm8386266qkj.56.2020.07.02.06.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 06:23:24 -0700 (PDT)
Date:   Thu, 2 Jul 2020 09:23:24 -0400
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
Message-ID: <20200702132324.GA643048@google.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
 <ed924e2cb450a4cce4a1b5a2c44d29e968467154.1593530334.git.vpillai@digitalocean.com>
 <20200701232847.GA439212@google.com>
 <200c81ef-c961-dcd5-1221-84897c459b05@linux.intel.com>
 <20200702125757.GB439212@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702125757.GB439212@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 08:57:57AM -0400, Joel Fernandes wrote:
[...] 
> > > unconstrained pick, then rq->core_pick is set. The next time task selection
> > > logic runs when stopper needs to switch to idle, the current CPU is not in
> > > the smt_mask. This causes the previous ->core_pick to be picked again which
> > > happens to be the unconstrained task! so the stopper keeps getting selected
> > > forever.
> > > 
> > > That and there are a few more safe guards and checks around checking/setting
> > > rq->core_pick. To test it, I ran rcutorture and made it tag all torture
> > > threads. Then ran it in hotplug mode (hotplugging every 200ms) and it hit the
> > > issue. Now it runs for an hour or so without issue. (Torture testing debug
> > > changes: https://bit.ly/38htfqK ).
> > > 
> > > Various fixes were tried causing varying degrees of crashes.  Finally I found
> > > that it is easiest to just add current CPU to the smt_mask's copy always.
> > > This is so that task selection logic always runs on the current CPU which
> > > called schedule().
> > 
> > 
> > It looks good to me. 
> 
> Thank you for your review! Could I add your Reviewed-by tag to the patch?

Julien and Vineeth, here is by coresched tree updated with this patch for
when you are sending the next series:
git://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git (branch coresched)

There are some trivial fixups to the debug patch, due to this commit. So
pulling from the above branch may save you some time.

thanks,

 - Joel


