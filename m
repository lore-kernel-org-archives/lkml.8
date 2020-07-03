Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D5AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 22:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B2AF20772
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 22:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5KnVuYr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgGCWWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 18:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgGCWWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 18:22:31 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2214C061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 15:22:30 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id q7so25385200ljm.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 15:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RyL/27fhtr142h3y889Pn+A0n7ftUy7d4PNyw21qW/g=;
        b=e5KnVuYrtd9lFOZ6UyFiavj+At9RqXDaxTtIpWXIVj9J6+nChcPwDXZvM3iF+/0CxC
         WUtPRy++h69cTspgVxkptjYcSoLAUaIsrbindlPVv3qKBop6nPs3U4xEJKOZh9g4lE05
         +/I4vC8wKlg4hK+TdAG6B5WW90Lrpj/1MsFh1xjsL76iF6kvPLUtZEDj2exbJZVXPaZX
         EWkFWRoAX312YN/0QVWfiJgt6/kvppJ5qYz4tWx4imDbqdr0LnLRpRhaCAXXsJ8Zw8nB
         fsAwGw6xw2W8EWq7olnYAfWzunOKEZfxiKfo7gns21sU142ovD5ujMA57hzxJwYnwDx6
         Visw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RyL/27fhtr142h3y889Pn+A0n7ftUy7d4PNyw21qW/g=;
        b=Ce4626kAOMBABpzL0MwoVbkIl7XZW+OxDpNAKXxLCkITKv/SVvUNDciIgnhAl12njC
         FTmCi+92o+pe9FaUMONRcooQSXUTo+gVnKctiHsl8r8mY7hNBUP6gWO2qU330LPQcCtI
         p6pAC29GPcBeuOn/XZzqQiFZfpYC6idvNI+3TgqGacfTGM22N8nBns6dTL41RBv3rG/p
         gQLKQzfRHuYlmcO9GDxAAZ1N1tToSQ8qrcBy+2vjqSz9L16shxFIa6MTPX2q+bO+s/EA
         qco7dr/K9Ci+/KIuIikxT1b1xb8IulEEHqZKJnWkMNi3tX8kTIYXjZyfWJO8GFVgU157
         tztQ==
X-Gm-Message-State: AOAM531ssMnxaJo/AlLXRyU6wjYer3ohFZe05/wEZsyiX9GxeWZBoinU
        TDUu+lL+i0VIHLsZsVIn1II=
X-Google-Smtp-Source: ABdhPJz3DsPbDv8YQ80+y27DTaE0MqIpaJc2MR+AZNcfvQ0LRivXpbkYmgUfBhXF8foyZ9pwrcO9Yw==
X-Received: by 2002:a2e:858e:: with SMTP id b14mr21823946lji.301.1593814949243;
        Fri, 03 Jul 2020 15:22:29 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id r19sm2882312ljm.32.2020.07.03.15.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 15:22:28 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Sat, 4 Jul 2020 00:22:26 +0200
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        peter enderborg <peter.enderborg@sony.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        GregKroah-Hartmangregkh@linuxfoundation.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: nr_cpu_ids vs AMD 3970x(32 physical CPUs)
Message-ID: <20200703222226.GA7472@pc636>
References: <20200703155749.GA6255@pc636>
 <8a2a55e6-6087-e4bf-3d35-ed4b4c216369@sony.com>
 <20200703192807.GB5207@pc636>
 <CAHk-=wiagrzJs9OBe_6bHK+Cc6RdoCOV85CiJAd3MhYnc8idfw@mail.gmail.com>
 <20200703212047.GA6856@pc636>
 <20200703215157.GI25523@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703215157.GI25523@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 10:51:57PM +0100, Matthew Wilcox wrote:
> On Fri, Jul 03, 2020 at 11:20:47PM +0200, Uladzislau Rezki wrote:
> > Some background:
> > Actually i have been thinking about making vmalloc address space to
> > be per-CPU, i.e. divide it to per-CPU address space making an allocation
> > lock-less. It will eliminate a high lock contention. When i have done
> > a prototype i noticed and realized that there is a silly issue with
> > nr_cpu_ids on some systems.
> 
> vfree() may happen on a different CPU from the one which called vmalloc(),
> so I'm not sure you're going to get as large a win as you think you will.
>
Hmm.. According to my tests the difference is approximately 7x/10x but
i also need to say as of now those tests are draft. Indeed vfree() can
be done on different CPU, but i do not think it is a big issue. The main
goal is to make the vmalloc() to be scaled to number of CPUs in a system.
Because as number of CPUs increase as tight an allocation becomes.

Doing vfree() on another CPU would be kind of noise(critical section is
short), whereas other ones will be able to do progress because of their
own locks.

--
Vlad Rezki
