Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DD3C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 20:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C69AF22522
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 20:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vOS+qbOG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbgAOU1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 15:27:11 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40629 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgAOU1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 15:27:11 -0500
Received: by mail-pg1-f196.google.com with SMTP id k25so8724825pgt.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 12:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=kWBj9q//ngCI8CHduUy+zt1arDphaiPl0KmAyH3wXMI=;
        b=vOS+qbOG6Ei+ejHHP7brSCEHiRP3WSxVUn0SJkywCLHbCTk2meRAnqcz6CCmeNpPuZ
         x+5NcR43SKz4az/LB/QeA/hZePBit+amrkLl4DXNcz+tqWGr96jE5EqIpU8T7YKsGqF1
         9/+2PhqYvcoJ6e396p1+9uZ+joECShT7FVNWbVXmG19YLYpMuMIoTAEKRoefdJIZL7q0
         quXK7Tp7pAv7Zx/SiguSrQcdvFyaP4Xm+0OjB9SNoOUFbmQV3CbThGlSn56Emm8ISzP+
         OcbASV6uLDKyly7yXihP0pYSN8g7A/NWps5zy8MVh8FC7W3g8ZJn5EoOtBBukrrfu2oV
         iaUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=kWBj9q//ngCI8CHduUy+zt1arDphaiPl0KmAyH3wXMI=;
        b=ojWzD5Bpq+sp1VkwgmQ4S5RF43/77QKUZGPDx+cfE5bw3DrniPZN1igprif6QnghWK
         9jS6wBOnD4krs/Cvp7TTqfSJ0sM4H1YmQGtOD/CoUdbqBlsQjsI3a70vfJf4zMvwkmey
         E+cC6CsU7dj45BqCfteDvugMHyBXDBJyhYuDIc5caVzSao83MQP11lp0DzzIjlZIO0UM
         USVKHz8893y7fKGemGqths5htwUeZt6zG4l8gaF1nQMpb4LtstPvjsyM7bMzwxti0v2H
         PVtvMVgqPML/0JMi9OA4c1C3GYzQv3yo9n6mwmxIOxwMKpS7VmXuFBlqw4e322XYcxJt
         g6Xw==
X-Gm-Message-State: APjAAAUtLh/6xb8POkWGS3ZZtwf+J1gBCoXHoF4gk5uCYflGKx+qQVUq
        dSCvRl+fc6mS9Cgglp6jlFmGQKMvtWs=
X-Google-Smtp-Source: APXvYqwx103ddpfCyu40eH6QZZUjHXOFMIgHWpdjtdTq4tzEQ/4Gz956qvLsexoZqa4bRG/YlnpQ+A==
X-Received: by 2002:aa7:946a:: with SMTP id t10mr33616856pfq.165.1579120030646;
        Wed, 15 Jan 2020 12:27:10 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id u11sm277705pjn.2.2020.01.15.12.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 12:27:10 -0800 (PST)
Date:   Wed, 15 Jan 2020 12:27:09 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch] mm, oom: dump stack of victim when reaping failed
In-Reply-To: <9a7cbbf0-4283-f932-e422-84b4fb42a055@I-love.SAKURA.ne.jp>
Message-ID: <alpine.DEB.2.21.2001151223040.13588@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.2001141519280.200484@chino.kir.corp.google.com> <20200115084336.GW19428@dhcp22.suse.cz> <9a7cbbf0-4283-f932-e422-84b4fb42a055@I-love.SAKURA.ne.jp>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jan 2020, Tetsuo Handa wrote:

> >> When a process cannot be oom reaped, for whatever reason, currently the
> >> list of locks that are held is currently dumped to the kernel log.
> >>
> >> Much more interesting is the stack trace of the victim that cannot be
> >> reaped.  If the stack trace is dumped, we have the ability to find
> >> related occurrences in the same kernel code and hopefully solve the
> >> issue that is making it wedged.
> >>
> >> Dump the stack trace when a process fails to be oom reaped.
> > 
> > Yes, this is really helpful.
> 
> tsk would be a thread group leader, but the thread which got stuck is not
> always a thread group leader. Maybe dump all threads in that thread group
> without PF_EXITING (or something) ?
> 

That's possible, yes.  I think it comes down to the classic problem of how 
much info in the kernel log on oom kill is too much.  Stacks for all 
threads that match the mm being reaped may be *very* verbose.  I'm 
currently tracking a stall in oom reaping where the victim doesn't always 
have a lock held so we don't know where it's at in the kernel; I'm hoping 
that a stack for the thread group leader will at least shed some light on 
it.
