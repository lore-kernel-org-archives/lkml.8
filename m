Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6937AC0044D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 01:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D062051A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 01:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhWjCTip"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733161AbgCQBWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 21:22:31 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:42003 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732939AbgCQBWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 21:22:30 -0400
Received: by mail-il1-f196.google.com with SMTP id p2so10730548ile.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 18:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gHa0JTzyEoTOZCffeBozLM1zvC+PIGXjhON/tx6muwA=;
        b=fhWjCTipb3UY1+39YACCt/MXpv2E80jqT6ejg0UYL7h6BKKpuxQNTXhA1kbJqbKq4J
         L7yOPIR4GbNB5vCeIK7CLfHSnBE2kk87XxLloyWUEqnVo1WOGNinAtzF/eJBWP46rK3g
         0jrY4F4vMXJNrlc0Pm205fDelEU/8PoKYfYagijNbaPHMUbd+kJNUROHQXDd9/SszNSf
         0iKMYcq6rXWQQVO5zjp/ugTBdBai82zd+SjGGrpYgb/ZMkdkGJ7ycyFEJ4nkHAqFBJJJ
         BJ+UYtGN4C+RpWtBbyHP3+O7yrhWYPgqlRPvQ54dDRXwt0ubmbDvYNFCKX9MAITqrBXq
         QgFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gHa0JTzyEoTOZCffeBozLM1zvC+PIGXjhON/tx6muwA=;
        b=eNRafNu/CG2OeRZxaS5yKrA2aP7OKX4gAeLD5WDtnO67+3ObdWD6Zh+CY/XAH4EVEW
         5/iqQoXjrcqOUfQ4D3zltYv3/TqDojpiqODIhfx1+MdTuSKXYC0/e30arXu65RnAslz7
         IpTM5FbU260sphOKtVMo3OK50PUPkai7j8WE0+1rVtBSUYA7ayzhs7S5dYedujR1EhaU
         rWjawx33f3bB9PF1S47w6e2YjsepWtzqCrHtpzgeUpb5iNCK9mqG4zzGp04IcgBlIDXj
         UjDMi+d9N2nnTToXZE7tM5z6mbS/ziWCd98aWBVPhKV3utE6gDVwXOOWtyotZJlD5+YU
         EwJw==
X-Gm-Message-State: ANhLgQ3YuwzkklQ52wdfdYJzvSHHZWWaszAEbbfsPcXWSZGg9trs1Vjx
        bd7IXkl6IxHWb4o7TmBbw/yrdQu3iWiAZ1g1/T0=
X-Google-Smtp-Source: ADFU+vugqsxcKnpiclXGumoSGkqikkN0d500psosdsPbvzQzmUTSSzxf85ruDeZW3yUz2EhxWSG5GVLaSh482+O0iBE=
X-Received: by 2002:a92:7b10:: with SMTP id w16mr2572144ilc.93.1584408150127;
 Mon, 16 Mar 2020 18:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <1584355585-10210-1-git-send-email-laoar.shao@gmail.com> <20200316164056.GY22433@bombadil.infradead.org>
In-Reply-To: <20200316164056.GY22433@bombadil.infradead.org>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 17 Mar 2020 09:21:54 +0800
Message-ID: <CALOAHbAf8nMP=xSzLKkDNc8Jcywzdrn5-OFDJj5hZb5PYVpW3Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] psi: move PF_MEMSTALL out of task->flags
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>, mingo@redhat.com,
        Peter Zijlstra <peterz@infradead.org>, juri.lelli@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dietmar.eggemann@arm.com, Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>, mgorman@suse.de,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 12:40 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Mar 16, 2020 at 06:46:25AM -0400, Yafang Shao wrote:
> > +++ b/include/linux/sched.h
> > @@ -786,6 +786,10 @@ struct task_struct {
> >       /* to be used once the psi infrastructure lands upstream. */
>
> That comment looks out of date ...
>

Yes, I will remove this comment.

> >       unsigned                        use_memdelay:1;


-- 
Yafang Shao
DiDi
