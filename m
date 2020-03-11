Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C2CC0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 22:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD4862074D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 22:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KPGi6V35"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbgCKWOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 18:14:42 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39391 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729680AbgCKWOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 18:14:42 -0400
Received: by mail-pf1-f193.google.com with SMTP id w65so2134397pfb.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 15:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=kqs/8sz45lI1W+UaTgUeqYCXywblUMLwa/zPPOrBl34=;
        b=KPGi6V35T5HQHjCWG4Z7gR6q4bB8iESFyiWU6TFFkgFgzWsIuD7BumZRY8axcU9poH
         omhvgpVVX2TYOhkLTBAD0E+H8HQum0MaXIZl5p8UWGxp5LB7C2ZhRxUZGxeUjYkyGNb2
         IsNDwI2P03H/O84UiUKrsJbA7ZTKk8GDIhIhTG3G5p9yJv53AFZWT2Tjrg8ohpq88F2B
         DcdCJN6hUl3JV6bw/CidifP9bQ9fEdkNJuANrAQSY5bDPvqmM+YTfXU29Ja5VjvRKQYD
         a/QrEG7uKG9NEfOBNZcOYfymFr5x0J+zTjIGl0DvtXi0OXDLAdqyRJt6Jb8XMWFt62mZ
         9shw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=kqs/8sz45lI1W+UaTgUeqYCXywblUMLwa/zPPOrBl34=;
        b=WtKMs5cpQQYc7+NaOar50d9SF456JTJ4TddcRfJc/AmADToTzaqmFPrQk83WimXCTg
         +yxm8sK8LcO+ZVtjVAA4K7Q2k04+QCZC248pJMleEZcF4lZa/0C3hO+1swtEC4A63eki
         dvUyBx4rHWVjzhDisNq5lT8D/hs57o+ihI908ForQjxKUfkdFqLH5VTshzQ/b7aUSNub
         RabMuRUmHyApegWdQYrOF2IFxId3rsRaj3aXYkA/NkxINKVsHfO2GpPl40jl2K6SmlrO
         8Pl07WZLronLGgC3DCHnxTkn4S3fUFzAE8ZSjiVLf46wHeJnZNFeA0B1PVnpsieDRXkl
         zw3Q==
X-Gm-Message-State: ANhLgQ1RO+rpua06Sh+vKHj6nYadKZCr47m+x12COGSU7yjk3lYZtcl1
        C/FzGHSjK9mueUKy8+f2sXyJPQ==
X-Google-Smtp-Source: ADFU+vvvdCNlOyeeWNczq9HEHK2NE5DHDyL193IWO9aSZCph3fzDXs+kRhRT2y5MT6hUYAhpdQzbQA==
X-Received: by 2002:a63:5d8:: with SMTP id 207mr4716417pgf.413.1583964881100;
        Wed, 11 Mar 2020 15:14:41 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id a143sm29357820pfd.108.2020.03.11.15.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 15:14:40 -0700 (PDT)
Date:   Wed, 11 Mar 2020 15:14:39 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch] mm, oom: prevent soft lockup on memcg oom for UP
 systems
In-Reply-To: <993e7783-60e9-ba03-b512-c829b9e833fd@i-love.sakura.ne.jp>
Message-ID: <alpine.DEB.2.21.2003111513180.195367@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.2003101438510.161160@chino.kir.corp.google.com> <0e5ca6ee-d460-db8e-aba2-79aa7a66fad1@I-love.SAKURA.ne.jp> <alpine.DEB.2.21.2003101555050.177273@chino.kir.corp.google.com> <7a6170fc-b247-e327-321a-b99fb53f552d@i-love.sakura.ne.jp>
 <alpine.DEB.2.21.2003111235080.171292@chino.kir.corp.google.com> <993e7783-60e9-ba03-b512-c829b9e833fd@i-love.sakura.ne.jp>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Mar 2020, Tetsuo Handa wrote:

> > The cond_resched() here is needed if the iteration is lengthy depending on 
> > the number of descendant memcgs already.
> 
> No. cond_resched() here will become no-op if CONFIG_PREEMPTION=y and current
> thread has realtime priority.
> 

It's helpful without CONFIG_PREEMPTION for excessively long memcg 
iterations to avoid starving need_resched.

> > schedule_timeout_killable(1) does not make any guarantees that current 
> > will be scheduled after the victim or oom_reaper on UP systems.
> 
> The point of schedule_timeout_*(1) is to guarantee that current thread
> will yield CPU to other threads even if CONFIG_PREEMPTION=y and current
> thread has realtime priority case. There is no guarantee that current
> thread will be rescheduled immediately after a sleep is irrelevant.
> 
> > 
> > If you have an alternate patch to try, we can test it.  But since this 
> > cond_resched() is needed anyway, I'm not sure it will change the result.
> 
> schedule_timeout_killable(1) is an alternate patch to try; I don't think
> that this cond_resched() is needed anyway.
> 

You are suggesting schedule_timeout_killable(1) in shrink_node_memcgs()?
