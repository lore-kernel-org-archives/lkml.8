Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11BCC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 15:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6EF2206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 15:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588088737;
	bh=Yt0kNAV63rZlj+8rIK/1wITuNIJnHMrCN2TxSpz2hc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RV9NoH1gVX8x5LXP1YHEIshDvEDaMSgNhcJFSP9V2YaKXcvthsoQ1KKxxOSjpNeO6
	 RVVbZXV3z5XsZTzuGzDi3xLqqpLDim05wCQLie39RbxO5dErJmwxsv7428iyAXijsZ
	 8Ep/XtF5zVVNUs5mD5wyaTXL8SMdVqH5arK+ah90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgD1Ppg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 11:45:36 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39646 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbgD1Ppg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 11:45:36 -0400
Received: by mail-wm1-f68.google.com with SMTP id y24so3415481wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 08:45:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F+qBIIhihWY7LXAEJKuLVI346OxpngCjUZfKFQQpAhY=;
        b=eJN7/NiPoYbPPhUDfdKIFgYGPdN/aTz5o6LZD1v2EGZAgChUXHjxhoXR+SsriEJUuo
         4hpqA3FcM73lcv8eLkgH06jqPH/1Y74dQJZl0CnUuDf+n9bL0J3jlrgp+jqt/3HHKNZs
         6fCSxqcn/qb7LIZVE2lx3jaNMxF+D3tf7CicXv/WKbiUypzWbwFiDKToRfCS6BxXhl4H
         m3UsJkrvlM9J/lw0XmlrprLc5KmXfWXSo63OcnMUK0aCLloticfYUgZj4OJ5w2V2+8Hh
         yC+bEwUFcuVoXtx/XDkGNrSgkckjW9FR8ZJ+F2T5vcExYDBxSRLBNZGpdmkituYX+AXM
         UEvA==
X-Gm-Message-State: AGi0PubmYXRM/WXouWpDM6repI2aZ7+3S3aKTR0cV+KnfzB9DmVy595x
        w2JG6fIb0PVyOTnsQ5rNvCA=
X-Google-Smtp-Source: APiQypLZz6e0wSZmdIJbenJSU967Mc5MReYmpEh08UPwN14N1pmP22y3zlSvPI1OLQi0R5pjaZDrQg==
X-Received: by 2002:a1c:f312:: with SMTP id q18mr5213147wmq.175.1588088734439;
        Tue, 28 Apr 2020 08:45:34 -0700 (PDT)
Received: from localhost (ip-37-188-130-62.eurotel.cz. [37.188.130.62])
        by smtp.gmail.com with ESMTPSA id q8sm3720728wmg.22.2020.04.28.08.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 08:45:33 -0700 (PDT)
Date:   Tue, 28 Apr 2020 17:45:32 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH] printk: Add loglevel for "do not print to consoles".
Message-ID: <20200428154532.GU28637@dhcp22.suse.cz>
References: <20200424024239.63607-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200425004609.GE8982@jagdpanzerIV.localdomain>
 <842ff40b-a232-6098-4333-996a3033b30a@i-love.sakura.ne.jp>
 <20200427062117.GC486@jagdpanzerIV.localdomain>
 <4dae86af-1d9a-f5a8-cff6-aa91ec038a79@i-love.sakura.ne.jp>
 <20200428121828.GP28637@dhcp22.suse.cz>
 <b4d74234-8009-9ffd-011f-bd5d1a4b85f6@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4d74234-8009-9ffd-011f-bd5d1a4b85f6@i-love.sakura.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28-04-20 22:11:19, Tetsuo Handa wrote:
> On 2020/04/28 21:18, Michal Hocko wrote:
> > On Tue 28-04-20 20:33:21, Tetsuo Handa wrote:
> >> On 2020/04/27 15:21, Sergey Senozhatsky wrote:
> >>>> KERN_NO_CONSOLES is for type of messages where "saved for later analysis" is
> >>>> important but "printed for immediate notification" is not important.
> >>>> In other words, KERN_NO_CONSOLES is NOT for dying messages where "printed for
> >>>> immediate notification" is important.
> >>>
> >>> per-console loglevel is a user configurable parameter.
> >>> KERN_NO_CONSOLES is a hard-coded policy.
> >>
> >> But given that whether to use KERN_NO_CONSOLES is configurable via e.g. sysctl,
> >> KERN_NO_CONSOLES will become a user configurable parameter. What's still wrong?
> > 
> > How do I as a kernel developer know that KERN_NO_CONSOLES should be
> > used? In other words, how can I assume what a user will consider
> > important on the console?
> > 
> 
> Existing KERN_$LEVEL allows a user to determine whether he/she wants that message
> to be printed on consoles (even if it spams his/her operation doing on consoles), and
> at the same time constrains that user whether that message is saved to log files.
> KERN_NO_CONSOLES allows a user to control whether he/she wants that message to be
> saved to log files (without spamming his/her operation doing on consoles).

I understand that. But how do I know whether the user considers the
particular information important enough to be dumped on the console.
This sounds like a policy in the kernel to me. I simply cannot forsee
any console configuration to tell whether my information is going to
swamp the console to no use or not. Compare that to KERN_$LEVEL instead.
I know that an information is of low/high importance. It is the user
policy to decide and base some filtering on top of that priority.
-- 
Michal Hocko
SUSE Labs
