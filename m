Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B15CC83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA98E20B80
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588170073;
	bh=c34v9NtwKoQHI/9MaR4ETHlQXBUj6Aq5bk+CjSZT1tg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=urqSKFhuanit23B1jePMMfpPYT23A6K3nWfrq62CmWdq4Dd7R8uyGFJF/OwrG7ZJM
	 /K9NjvC6YUH4sPiFt9hmNotMGQvuAQqaaUR0mJsmgOKe36OIWG23aaZyv3/t1GjMg9
	 jV46C3Kn6J2rYZmc3Hv54MpBJXbcLoVYNWMEztN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgD2OVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 10:21:13 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36590 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbgD2OVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 10:21:12 -0400
Received: by mail-wm1-f66.google.com with SMTP id u127so2242277wmg.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 07:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ojboWOZgZoqIyeUJJnXwlgbMdttS6Y5MRL/4YmrAAyE=;
        b=FAXP1rFryOM4haayFqYW/qE6c81HBken5bHAX7Rl1hPJ2+rPVjYGY0TUhYoo8HlTrO
         pAiQmvFT+z5u/YuQYEv3rJRqiTf/V5kiJDbs+GerD8NMJFgvpZBgcz5EW6tdL7k18LTc
         szPHFK2fUCJ3mvWGzZmaeUczL7FIIjTqddcxvHayC+/TwTysROVL1k/4BTmdnxa9cXzx
         93V+eFCYULgnmkmxxWuXwWIDcxQUoLDMBeO0k1iR9E6bIiRY6rp/jogk11rk8E2Hp/pL
         2rd4npQhHkXESqNe01Z+7mzq2pqDAcNmO8uUy4w3dXbtQFzJXVCe+TNcgOtcR9VVY4GI
         M5Qg==
X-Gm-Message-State: AGi0PubxdvBaTwQ4lSKsOhXQt2UhaH/8bCvVXo0Mdkq4fUMAucNdfnEj
        VMeN+cen18ZECPQorXwrVSA=
X-Google-Smtp-Source: APiQypLUUIxAecxWn46o/w3oVsvyKgab1TmUTlZwPcVaBr3LKUmKsIOfjUwuvmxqJtEXm/x4GVlxlA==
X-Received: by 2002:a05:600c:210:: with SMTP id 16mr3389215wmi.57.1588170069159;
        Wed, 29 Apr 2020 07:21:09 -0700 (PDT)
Received: from localhost (ip-37-188-130-62.eurotel.cz. [37.188.130.62])
        by smtp.gmail.com with ESMTPSA id s6sm8007704wmh.17.2020.04.29.07.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 07:21:08 -0700 (PDT)
Date:   Wed, 29 Apr 2020 16:21:06 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH] printk: Add loglevel for "do not print to consoles".
Message-ID: <20200429142106.GG28637@dhcp22.suse.cz>
References: <20200424024239.63607-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200425004609.GE8982@jagdpanzerIV.localdomain>
 <842ff40b-a232-6098-4333-996a3033b30a@i-love.sakura.ne.jp>
 <20200427062117.GC486@jagdpanzerIV.localdomain>
 <4dae86af-1d9a-f5a8-cff6-aa91ec038a79@i-love.sakura.ne.jp>
 <20200428121828.GP28637@dhcp22.suse.cz>
 <b4d74234-8009-9ffd-011f-bd5d1a4b85f6@i-love.sakura.ne.jp>
 <20200428154532.GU28637@dhcp22.suse.cz>
 <b1d507b1-dae7-f526-c74a-d465ddecea6a@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1d507b1-dae7-f526-c74a-d465ddecea6a@i-love.sakura.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 29-04-20 01:23:15, Tetsuo Handa wrote:
> On 2020/04/29 0:45, Michal Hocko wrote:
> > On Tue 28-04-20 22:11:19, Tetsuo Handa wrote:
> >> Existing KERN_$LEVEL allows a user to determine whether he/she wants that message
> >> to be printed on consoles (even if it spams his/her operation doing on consoles), and
> >> at the same time constrains that user whether that message is saved to log files.
> >> KERN_NO_CONSOLES allows a user to control whether he/she wants that message to be
> >> saved to log files (without spamming his/her operation doing on consoles).
> > 
> > I understand that. But how do I know whether the user considers the
> > particular information important enough to be dumped on the console.
> > This sounds like a policy in the kernel to me.
> 
> I'm still unable to understand your question.

I am trying to say that KERN_NO_CONSOLES resembles more a policy than a
priority. Because I as a developer have no idea whether the message is
good enough for console or not.

> >                                                I simply cannot forsee
> > any console configuration to tell whether my information is going to
> > swamp the console to no use or not.
> 
> Neither can I.
> 
> >                                     Compare that to KERN_$LEVEL instead.
> > I know that an information is of low/high importance. It is the user
> > policy to decide and base some filtering on top of that priority.
> 
> Whether to use KERN_NO_CONSOLES is not per-importance basis but per-content basis.
> 
> Since both pr_info("[%7d] %5d %5d %8lu %8lu %8ld %8lu         %5hd %s\n", ...) from dump_tasks() and
> pr_info("oom-kill:constraint=%s,nodemask=%*pbl", ...) from dump_oom_summary() use KERN_INFO importance,
> existing KERN_$LEVEL-based approach cannot handle these messages differently. Since changing the former to
> e.g. KERN_DEBUG will cause userspace to discard the messages, we effectively can't change KERN_$LEVEL.

I believe we are free to change kernel log levels as we find a fit. I
was not aware that KERN_DEBUG messages are automatically filtered out.
Even if this is the case then this doesn't really disallow admins to
allow KERN_DEBUG into log files. Dump of the oom eligible tasks is
arguably a debugging output anyway. So I disagree with your statement.

> If the kernel allows the former to use KERN_NO_CONSOLES in addition to KERN_INFO, the administrator can
> select from two choices: printing "both the former and the latter" or "only the latter" to consoles.

I am not really familiar with all the possibilities admins have when
setting filtering for different consoles but KERN_NO_CONSOLES sounds
rather alien to the existing priority based approach. You can fine tune
priorities and that is all right because they should be reflecting
importance. But global no-consoles doesn't really fit in here because
each console might require a different policy but the marking is
unconditional and largely unaware of existing consoles.
-- 
Michal Hocko
SUSE Labs
