Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CA2C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 04:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE8020658
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 04:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mNx3FHBs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbgCQEJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 00:09:52 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34116 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgCQEJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 00:09:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id t3so10979158pgn.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 21:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Z+6I7LSHkEs5M85V4TZOGW66cdMpW8qoIqBOH7/6Bjw=;
        b=mNx3FHBsLJ+3er4/Hnav46Lvw50QHfMeReCyoPrnSZEUNJbq3wqVP/zvx1YxBtT8Dl
         5QW+81ZCJYC792J+4JhTl+UCDn067ApmSWH1p0kYp6nb3MxdmJ3DrQHpHdWssegV3V1w
         ggEB7VgpiSemlys8TiPeupRWtwlAUlaF6/UjlAVH4wG03VmBhvlfbDdfgy8Vl+SE3Qiw
         dDi9QPBRq7zmIRMs3YttH7jLG4x0QSiPkW20rnn4zI9mEJ6Q+XvEHL0G3d8yKzRPsnxz
         97FWK30TEzEKZGdB/8BadPUOWGKAqokm6GxDDPIeOKzt6Rys6aJxuoQXFkq+KQR06HCx
         XqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Z+6I7LSHkEs5M85V4TZOGW66cdMpW8qoIqBOH7/6Bjw=;
        b=LPfGZPWKirYGKj9gOgiOpxSOwM/tGPWpj6Xc8BoUsHhzu1iC9kWzVLjNrTurc+Juxl
         4f3F+7WP5PLHCQVuGN9NXgUoUka7szXa6susae/hAcJ7pn5sn1F2k07hcC7EIgDhWszH
         LC+FPyJcIylipxtBPwdGkUgayrb+2u5dF80ate7iF1VBPnHFKXBSpq0w/qRYB6dxWNr8
         isYsCKW1Sm7d9Y4oZ5+dWPqFApEWMkAgNJu8h2pis9u+6hT/IOx/m1nr953HIH0jxCGz
         lBi3TxDEetHe4TgCXU+xW7NrrvePrCqeNzQe1RwF+8o/oHnnM9ddoFyTREZw1qlvvuK4
         LGww==
X-Gm-Message-State: ANhLgQ0ssU1swtHZfzJT9hc6UFNsQHVCX/ZywBLRsXHjQkhZYVvFgDsf
        cgAHwMEdxWtnDkLM7MiAfzZlLQ==
X-Google-Smtp-Source: ADFU+vsCCWcwdv2Sf9VeaMIrfPdZ8NbMmUKezBXOoJWvpJn44FsyXNFN/OuI3bC2qenAMD39fik08g==
X-Received: by 2002:a63:2313:: with SMTP id j19mr3110234pgj.330.1584418190175;
        Mon, 16 Mar 2020 21:09:50 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id c15sm1122631pja.30.2020.03.16.21.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 21:09:49 -0700 (PDT)
Date:   Mon, 16 Mar 2020 21:09:48 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch] mm, oom: prevent soft lockup on memcg oom for UP
 systems
In-Reply-To: <202003170318.02H3IpSx047471@www262.sakura.ne.jp>
Message-ID: <alpine.DEB.2.21.2003162107580.97351@chino.kir.corp.google.com>
References: <8395df04-9b7a-0084-4bb5-e430efe18b97@i-love.sakura.ne.jp> <alpine.DEB.2.21.2003161648370.47327@chino.kir.corp.google.com> <202003170318.02H3IpSx047471@www262.sakura.ne.jp>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Mar 2020, Tetsuo Handa wrote:

> > 	if (!fatal_signal_pending(current))
> > 		schedule_timeout_killable(1);
> > 
> > So we don't have this reliance on all other memory chargers to yield when 
> > their charge fails and there is no delay for victims themselves.
> 
> I see. You want below functions for environments where current thread can
> fail to resume execution for long if current thread once reschedules (e.g.
> UP kernel, many threads contended on one CPU).
> 
> /*
>  * Give other threads CPU time, unless current thread was already killed.
>  * Used when we prefer killed threads to continue execution (in a hope that
>  * killed threads terminate quickly) over giving other threads CPU time.
>  */
> signed long __sched schedule_timeout_killable_expedited(signed long timeout)
> {
> 	if (unlikely(fatal_signal_pending(current)))
> 		return timeout;
> 	return schedule_timeout_killable(timeout);
> }
> 

I simply want the

	if (!fatal_signal_pending(current))
		schedule_timeout_killable(1);

after dropping oom_lock because I don't know that a generic function would 
be useful outside of this single place.  If it becomes a regular pattern, 
for whatever reason, I think we can consider a new schedule_timeout 
variant.

> /*
>  * Latency reduction via explicit rescheduling in places that are safe,
>  * but becomes no-op if current thread was already killed. Used when we
>  * prefer killed threads to continue execution (in a hope that killed
>  * threads terminate quickly) over giving other threads CPU time.
>  */
> int cond_resched_expedited(void)
> {
> 	if (unlikely(fatal_signal_pending(current)))
> 		return 0;
> 	return cond_resched();
> }
> 
> > 
> >  [ I'll still propose my change that adds cond_resched() to 
> >    shrink_node_memcgs() because we can see need_resched set for a 
> >    prolonged period of time without scheduling. ]
> 
> As long as there is schedule_timeout_killable(), I'm fine with adding
> cond_resched() in other places.
> 

Sounds good, thanks Tetsuo.
