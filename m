Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD4CC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 02:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FEAD206C3
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 02:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="p5uIegYO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgFMCZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 22:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbgFMCZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 22:25:36 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE4AC03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 19:25:34 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id g7so5280481qvx.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 19:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HJ9Hy54QNj+UxnvQ+yVK0ru4Ot34nn3XlbCD/hu9EpQ=;
        b=p5uIegYO2W8tG4RqkxJ4EsNggd1V00b/VUmBx8QaujnBZ/xTCbU0QzlKcXqyGBEgs8
         Mw8Qg5WM8Sgtib/m4xTnQF25rzNz3plPA0DQdr8TzSBKfGy+5ajLzKBi7YjTT+WGlFhE
         5zyMer6mRbBo/QW6hOHlAqX9g6U80+fwxV5Es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HJ9Hy54QNj+UxnvQ+yVK0ru4Ot34nn3XlbCD/hu9EpQ=;
        b=cp4tH6x5Q88BNGrjNC/6ZbCpR6Ncf9x0YwbJo1vsyZA6AIGyF3BeKaPJDMr+4WDsoM
         /41OHmEgcDzXHT1R94bVzuJgZxrUtKvSowrOlqf1O6Wna6QiaFicidZEUy35nX7Q4HGH
         9YvyucGGu/PWJVdOPhuT3+rrT5cnZWA1aya4iYnQ884l41OWp+XrjEfQl+7Icx5Rukur
         +cUizNZGQ68h12JNmMUVNaCc5itu3POSrKMVWtPQNLYrJvD3gx2MB/klQYfY4Bj8/y/H
         JG3vajED3/hMRdLVJCoqjOXh7Nhz6yL7iiI7H+AtwPjRUbZACWbxh3qDmlSWKn+2P7Jx
         Owcw==
X-Gm-Message-State: AOAM532VIaMaLTMnepgnzAB37qMTPvc9MY6jlVexCrij8Sc4kb70UmYb
        5MYYCzSBbLc8+3gsIrn9yEnA7Q==
X-Google-Smtp-Source: ABdhPJyNPgYTD8x1uDKhOiIUFOnev1mxVxI8DpTUoP1oJA8BIvtLEKeaHLTAl6KpZyXt42YdTAF9Ww==
X-Received: by 2002:a05:6214:2c8:: with SMTP id g8mr13319742qvu.188.1592015131596;
        Fri, 12 Jun 2020 19:25:31 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id r195sm6076241qka.12.2020.06.12.19.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 19:25:30 -0700 (PDT)
Date:   Fri, 12 Jun 2020 22:25:30 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aubrey Li <aubrey.li@intel.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 11/13] sched: migration changes for core scheduling
Message-ID: <20200613022530.GA110162@google.com>
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <279f7f6606ea18e14d64517840bcada56deb0ce3.1583332765.git.vpillai@digitalocean.com>
 <20200612132127.GA90012@google.com>
 <CANaguZDguzOCvNmO1u7CZQU2DSFW0+uPt7ZwL18w4bG=-_Xe3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANaguZDguzOCvNmO1u7CZQU2DSFW0+uPt7ZwL18w4bG=-_Xe3Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 05:32:01PM -0400, Vineeth Remanan Pillai wrote:
> > AFAIR, that's what v4 did:
> >
> >                 if (available_idle_cpu(cpu))
> > #ifdef CONFIG_SCHED_CORE
> >                         if (sched_core_enabled(cpu_rq(cpu)) &&
> >                             (p->core_cookie == cpu_rq(cpu)->core->core_cookie))
> >                                 break;
> > #else
> >                         break;
> > #endif
> >
> This patch was initially not in v4 and this is a merging of 4 patches
> suggested post-v4. During the initial round, code was like above. But since
> there looked like a code duplication in the different migration paths,
> it was consolidated into sched_core_cookie_match() and it caused this
> extra logic to this specific code path. As you mentioned, I also feel
> we do not need to check for core idleness in this path.

Ok, so I take it that you will make it so in v6 then, unless of course
someone else objects.

thanks!

- Joel

