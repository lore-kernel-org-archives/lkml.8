Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFD8C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 17:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A3272064C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 17:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="bTpWNY2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgGRRFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 13:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgGRRFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 13:05:12 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE64C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 10:05:12 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id o2so3117490qvk.6
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 10:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JMAp/sDYH2ueTLJSKr7aYQ3kPtyH5wY8UTV+mJwXCSg=;
        b=bTpWNY2Mxn8TGfdXtFJXcME+IGrzur5jfEsZVxSjrWgxJeAK1Q8A+Ol5jvLhiHfYun
         OH3leANhpPB+GgSjpPuUVVt9AsApzQpdj1UqQ8Uv9q+vRzpibG02G1oYIuqh02pKyOqm
         /Lfxk/60gSN0JMycBrcfm3hozkf1AvQV7IHT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JMAp/sDYH2ueTLJSKr7aYQ3kPtyH5wY8UTV+mJwXCSg=;
        b=et2ZlFGpNBrOXHg7BjnA8tCTts0TV/8A90nHQAmADJiov8aveS9d/hVEl1KbCjbzsL
         T7fYU2nCESx8VkRXjufaerS5wkUhfD1TB+7ld7OmgFgn7XkO376KomDm1VWwjAP5r/yK
         hF9Un9LbABLYtALIAKfxrWKePIrXCBIuDC8Z3GVHZJ9Ox4UMqqGzyEwVq/EA6cTjzGZW
         ac88LajlbZm3ifGJ3EMqcGS6xMdFwfEi48cxKN1KaWiL5CojMGtnOsDZ/ly763VL4wTj
         9o39mahSwEOU0/YDz9ZpY8J6WDTobTKJr/1NgAmEzjWxElo0ZYpAl9T0ftjm3jJfVPw6
         FzNA==
X-Gm-Message-State: AOAM530/nkrHWO9r8cgYmIJb4I7T9QCGzZlBD/Spe2cjS9p+05uyAcAf
        tuh+9W+RuIoDd7ZRGP+otvyoiw==
X-Google-Smtp-Source: ABdhPJzBirdye5BOc3lHApEAofSSP0bCzcdRVyPZVdpDAMqrcdXsLI8ahTJEohDhzDjkN+g40f/xqw==
X-Received: by 2002:a0c:e008:: with SMTP id j8mr14546159qvk.87.1595091911589;
        Sat, 18 Jul 2020 10:05:11 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id i20sm1188748qka.17.2020.07.18.10.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 10:05:10 -0700 (PDT)
Date:   Sat, 18 Jul 2020 13:05:10 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineethrp@gmail.com,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tim Chen <tim.c.chen@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [RFC PATCH 14/16] irq: Add support for core-wide protection of
 IRQ and softirq
Message-ID: <20200718170510.GA2162553@google.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
 <c783b3890b6df669a72c7c4a3012950d009b8034.1593530334.git.vpillai@digitalocean.com>
 <ed837e01-043b-e19b-293c-30d44df6f3a8@linux.intel.com>
 <87y2nhpvap.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2nhpvap.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 18, 2020 at 01:37:50AM +0200, Thomas Gleixner wrote:
> "Li, Aubrey" <aubrey.li@linux.intel.com> writes:
> > On 2020/7/1 5:32, Vineeth Remanan Pillai wrote:
> >
> > We saw a lot of soft lockups on the screen when we tested v6.
> >
> > [  186.527883] watchdog: BUG: soft lockup - CPU#86 stuck for 22s! [uperf:5551]
> > [  186.535884] watchdog: BUG: soft lockup - CPU#87 stuck for 22s! [uperf:5444]
> > [  186.555883] watchdog: BUG: soft lockup - CPU#89 stuck for 22s! [uperf:5547]
> > [  187.547884] rcu: INFO: rcu_sched self-detected stall on CPU
> > [  187.553760] rcu: 	40-....: (14997 ticks this GP) idle=49a/1/0x4000000000000002 softirq=1711/1711 fqs=7279 
> > [  187.564685] NMI watchdog: Watchdog detected hard LOCKUP on cpu 14
> > [  187.564723] NMI watchdog: Watchdog detected hard LOCKUP on cpu 38
> >
> > The problem is gone when we reverted this patch. We are running multiple
> > uperf threads(equal to cpu number) in a cgroup with coresched enabled.
> > This is 100% reproducible on our side.
> 
> ROTFL. I just predicted that from staring at the patch ....

Yes, sorry. It got fixed in the below patch which I was about to share before
you sent this email.  However, it still has (not yet) addressed the new
comments from you we have to discuss (will reply to that email).

Its purely a dirty test patch but it makes Aubrey's deadlock go away.
Basically, I moved the waiting code to prepare_exit_to_usermode() which
removes the lock vs wait dependencies. I will work on moving the code to the
right place based on the suggestions in the other email.

https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/commit/?h=sched/core-sched-fix-irq-deadlocks-v1&id=8857a261f3305887b063001c6c899869206667b6

thanks,

 - Joel

