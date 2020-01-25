Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D35C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 16:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FA5D2070A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 16:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyRM1gAs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgAYQku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 11:40:50 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42961 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgAYQku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 11:40:50 -0500
Received: by mail-lj1-f195.google.com with SMTP id y4so6019030ljj.9
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jan 2020 08:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Gy15FxdlwV/ac7vwDKQQCIZM9lkSBSU4U/Z/vHLCiqw=;
        b=UyRM1gAsfISmEVy9GCeq+wVkdJddRPWsNSZM81ZAEjadthzbFVhdDXmjf/s7nj9LQT
         x/+c3uPY64VDTnyxGXfmcjZXvwP/h8ArWQYektjiH5CI+OV5NFq3FIRQbfRJCUrYvv6I
         d+nHOjLDFENe4N3F2gm8IZCmRrncCHqDsWZwOW9MPfzmmcah6APB8cBcZbvanbMCMNnC
         FBvJkkvRT0Bs6+J+33GrxuYHhfOjtA3kqHpB04QelWXok15Ojw8nrfYpqUbwENncY2UX
         5aSlemcWm+xa0MzPuxPJ6lzXhsl/Xt33sa/f9ayi2Kv7Xh1q8BuJ+9/wEiqCcTsSnvcb
         NSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gy15FxdlwV/ac7vwDKQQCIZM9lkSBSU4U/Z/vHLCiqw=;
        b=GuhWhraGFu85JGLOt1TH80r/Od/yKc3Nvh+Xe6Bm0rNs533xool9Y0bZ0Iv0eLIiI7
         vt3p5dR3WEkXiSO6gdUIncI9UaE7OO0bcSPxfPKghIW3pvf8GqZAQ9oFjkwnN4f9AXg4
         5Ms1joTkXoR17Ntn0LRKkv+bUaoeB3x5ay2MzWv/vF8iEFCqgU+3wpXWZuwaMsjW93pc
         IOweR71bPlU0LtJ0UJz+avYEXok8p47H39kF+08nizRMNm571WADpE+dQtijYLVYt5SB
         F/fhR1/X6YNeXX2Aa/qLTB6VmVLRbe8TYf0MpAp0+CrteBknk1+1CDUNCTs/bN2b5UXn
         q/fg==
X-Gm-Message-State: APjAAAVgzsT+FQN3BzcvDjXpIgOjo9r0VepYrj4MZ+wJ6TpTTHN+fGPW
        50jYQ8z+6rQPoPWPbwLktW4=
X-Google-Smtp-Source: APXvYqw1jaVB5iQgPd7pPX+SF9fS6JGJA2uWjEqRZK4gvjJXUgczWu0OTN0Xs9oWKCz8EGtrY++kiw==
X-Received: by 2002:a2e:8699:: with SMTP id l25mr5184509lji.137.1579970448039;
        Sat, 25 Jan 2020 08:40:48 -0800 (PST)
Received: from uranus.localdomain ([5.18.171.94])
        by smtp.gmail.com with ESMTPSA id t20sm4954293ljk.87.2020.01.25.08.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2020 08:40:46 -0800 (PST)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 84A10461625; Sat, 25 Jan 2020 19:40:46 +0300 (MSK)
Date:   Sat, 25 Jan 2020 19:40:46 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH] sched/rt: optimize checking group rt scheduler
 constraints
Message-ID: <20200125164046.GQ2437@uranus>
References: <157996383820.4651.11292439232549211693.stgit@buzz>
 <20200125153211.GP2437@uranus>
 <417d11b4-d5a2-96c2-8007-5e8f90a422cb@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417d11b4-d5a2-96c2-8007-5e8f90a422cb@yandex-team.ru>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2020 at 07:15:16PM +0300, Konstantin Khlebnikov wrote:
> > > +	css_task_iter_start(&tg->css, 0, &it);
> > > +	while (!ret && (task = css_task_iter_next(&it)))
> > > +		ret |= rt_task(task);
> > 
> > Plain 'ret = rt_task(task);' won't work?
> 
> Should work too =)

:-) no need for new patch then, we could update it on top if needed
but i guess compiler would optimize it as is.
