Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9367C33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74DFA22314
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="PCAWkObW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgATMji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 07:39:38 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34301 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgATMji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 07:39:38 -0500
Received: by mail-lj1-f194.google.com with SMTP id z22so33706276ljg.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 04:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TxcZ5gyvyMAgWE8zHU3HifF3Fj3ukkucBXjXg88KovY=;
        b=PCAWkObWDbbTFIQ1ugmtB5pD7ljXba/wOrfyWCcL8dptxDUMYcrKsRmAG3412CyDOv
         2gAlZeRWl9vywmflZjmWPH1mtTfptJANf8mPSUUa2qBkkG2vxOV3nWh4WJAISnK+kQtO
         p5Muy0WCS9KnIBpGUQF9mHYO0fH4RH+CNrOVfilg2mgme0fl0PY5wuePuvulc/Ad1SS1
         3HR+Or5BOXDV7lywWlRMG6GznoYkJFg85EEVIM77LrgAEm72hDHqQO6gURFgQaDdUaRh
         AzyKaHE0ZYaZ26aAfnWmiIfFZRCb64flEOjh6Z/OFWGhGSt/kIuGs2d1bKpUONGSkihT
         by1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TxcZ5gyvyMAgWE8zHU3HifF3Fj3ukkucBXjXg88KovY=;
        b=SMOVW+CTUcUxyQnwXwG/QEOmWqOsgOyrPAWyzJgFfpMBvEVhxykxJIrbzuMuL7kjbF
         wIB3CnHydYoFDeT/yPDYCElnXDohvufvdwfmsBRa/83AiaSeYp7QgEj0HnLO4OI3FQ1g
         KgUkIPSUdc9VtAFwQ+JQ1m/EK/grWI1jaHfIqEbQ72tgTlQy/t0Hocl31O+Ptugcikcn
         wCpYoQFUPxIyKy4C7PanZfXox8xRraaEW0MN9jYdu782GMAf79XrV2TejmKC7qADH3HU
         Sc0MFLQSY7xvmNjv+Ch0DLhEhIxIR+HIievy/VrLj2psFeqLo5Dy6NVKo0bjTZWu5gPl
         NDUQ==
X-Gm-Message-State: APjAAAWZQViA81sqOp8x/wH+B1JaHNVCf+xLOuLLHHeksuHDpFsfqTzk
        +TuL6KjD1z6sd+R3aynAY9FA9Q==
X-Google-Smtp-Source: APXvYqyCrWaBVFSqX45/nJucM5iUdC2e7/exiIERGd9UGx/QLkroIBW7eIbWO2Dqaeq30shQT9IOyw==
X-Received: by 2002:a2e:b0c9:: with SMTP id g9mr13409453ljl.134.1579523975389;
        Mon, 20 Jan 2020 04:39:35 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id m16sm16791904ljb.47.2020.01.20.04.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 04:39:34 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 3BD3E1001CE; Mon, 20 Jan 2020 15:39:35 +0300 (+03)
Date:   Mon, 20 Jan 2020 15:39:35 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        oleksandr@redhat.com, Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>, christian.brauner@ubuntu.com,
        sjpark@amazon.de
Subject: Re: [PATCH v2 2/5] mm: introduce external memory hinting API
Message-ID: <20200120123935.onlls7enjtzenbvt@box>
References: <20200116235953.163318-1-minchan@kernel.org>
 <20200116235953.163318-3-minchan@kernel.org>
 <20200117115225.GV19428@dhcp22.suse.cz>
 <f57fb198-4070-d3b4-b6bd-43b29ff40a2c@virtuozzo.com>
 <20200120112722.GY18451@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120112722.GY18451@dhcp22.suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 12:27:22PM +0100, Michal Hocko wrote:
> On Mon 20-01-20 13:24:35, Kirill Tkhai wrote:
> > On 17.01.2020 14:52, Michal Hocko wrote:
> > > On Thu 16-01-20 15:59:50, Minchan Kim wrote:
> > >> There is usecase that System Management Software(SMS) want to give
> > >> a memory hint like MADV_[COLD|PAGEEOUT] to other processes and
> > >> in the case of Android, it is the ActivityManagerService.
> > >>
> > >> It's similar in spirit to madvise(MADV_WONTNEED), but the information
> > >> required to make the reclaim decision is not known to the app. Instead,
> > >> it is known to the centralized userspace daemon(ActivityManagerService),
> > >> and that daemon must be able to initiate reclaim on its own without
> > >> any app involvement.
> > >>
> > >> To solve the issue, this patch introduces new syscall process_madvise(2).
> > >> It uses pidfd of an external processs to give the hint.
> > >>
> > >>  int process_madvise(int pidfd, void *addr, size_t length, int advise,
> > >> 			unsigned long flag);
> > >>
> > >> Since it could affect other process's address range, only privileged
> > >> process(CAP_SYS_PTRACE) or something else(e.g., being the same UID)
> > >> gives it the right to ptrace the process could use it successfully.
> > >> The flag argument is reserved for future use if we need to extend the
> > >> API.
> > >>
> > >> I think supporting all hints madvise has/will supported/support to
> > >> process_madvise is rather risky. Because we are not sure all hints make
> > >> sense from external process and implementation for the hint may rely on
> > >> the caller being in the current context so it could be error-prone.
> > >> Thus, I just limited hints as MADV_[COLD|PAGEOUT] in this patch.
> > >>
> > >> If someone want to add other hints, we could hear hear the usecase and
> > >> review it for each hint. It's more safe for maintainace rather than
> > >> introducing a buggy syscall but hard to fix it later.
> > > 
> > > I have brought this up when we discussed this in the past but there is
> > > no reflection on that here so let me bring that up again. 
> > > 
> > > I believe that the interface has an inherent problem that it is racy.
> > > The external entity needs to know the address space layout of the target
> > > process to do anyhing useful on it. The address space is however under
> > > the full control of the target process though and the external entity
> > > has no means to find out that the layout has changed. So
> > > time-to-check-time-to-act is an inherent problem.
> > > 
> > > This is a serious design flaw and it should be explained why it doesn't
> > > matter or how to use the interface properly to prevent that problem.
> > 
> > Really, any address space manipulation, where more than one process is
> > involved, is racy.
> 
> They are, indeed. But that is not the point I wanted to make.
> 
> > Even two threads on common memory need a synchronization
> > to manage mappings in a sane way. Managing memory from two processes
> > is the same in principle, and the only difference is that another level
> > of synchronization is required.
> 
> Well, not really. The operation might simply attempt to perform an
> operation on a specific memory area and get a failure if it doesn't
> reference the same object anymore. What I think we need is some form of
> a handle to operate on. In the past we have discussed several
> directions. I was proposing /proc/self/map_anon/ (analogous to
> map_files) where you could inspect anonymous memory and get a file
> handle for it. madvise would then operate on the fd and then there
> shouldn't be a real problem to revalidate that the object is still
> valid. But there was no general enthusiasm about that approach. There
> are likely some land mines on the way.

Converting anon memory to file-backed is bad idea and going to backfire.
It will break many things around rmap (for THP in particular). We have
assumption that an anon page cannot be mapped twice in the same process.
Breaking rules around memory inheritance is not helpful too.

It is a major re-design of the subsystem and I don't see any real need for
this.

-- 
 Kirill A. Shutemov
