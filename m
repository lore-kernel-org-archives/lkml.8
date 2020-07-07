Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7B1C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 13:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A89B82073E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 13:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594130209;
	bh=rakApM4C1sA4w8tj25qyu6TVNhWQSVuGr7eytlDaPBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kPDMdtun38H2hypUQQNO63Jee3WYsBx/l9jOPM0tepBRp1KVKmSnlRILm7xdwQzaV
	 Ehum3rkBg0jNiXq6Fwabeedh+FxFEBsfM+JSjoOvmzbzVlHTUU1Nb5sxINH9ygmv9C
	 gnUR3ouCGZcLgtvFWxlKBtaWdOaSgCWuwFCUG0wE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgGGN4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 09:56:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43815 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgGGN4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 09:56:47 -0400
Received: by mail-wr1-f66.google.com with SMTP id j4so42824219wrp.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 06:56:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FpuEvCsXRL4/W9jfe5wiH6evdM0ik5cj0/MlbIbZB5Q=;
        b=lIzzXaif3h6tDA54nQHTOlWMxVF4vohnh3M/OXDpzqGPz26T0tqZg5Pjm7L/o4NbuE
         UXxtPzXXskv51lsosgesaQDe24BEa2lf0Nv8QGNB7XfEdDGvXqBaQKNhHwQogC7YFrp5
         FI1zBGk4qQ+XIJaXlcr34O6Rv0Alk2S/wMAwth07IXtel4R+4OR/TMtq0fzZ8WbtPzle
         666vT+LURwM3sfX+VhJv6CiC91CgAUB5vYZ5JPVjZSAZkZDsMF6LHsDPzlvfK5mnuN1w
         tX6lpiIBqTG1SISqdAGfNhf0b96YPXN4m+BmQWF5kiRYnHM/T+0lP+HOAk4Lt9EZUNKw
         aFyg==
X-Gm-Message-State: AOAM533QLQWzFE1yK3Zi5Y4x5lfMeJcQ9qfIp57ILuBfBfNHcOq1YQWn
        9euzVGafcqPC26KN48hj7X8=
X-Google-Smtp-Source: ABdhPJwrH8FLw5jYEp0j5ccSsTyr9QNW1w/6kkEF3mbBOl+PJPAzLwu1mmfbxDSVPfvJ6XpNWcQEbQ==
X-Received: by 2002:a5d:6846:: with SMTP id o6mr54428442wrw.370.1594130205924;
        Tue, 07 Jul 2020 06:56:45 -0700 (PDT)
Received: from localhost (ip-37-188-179-51.eurotel.cz. [37.188.179.51])
        by smtp.gmail.com with ESMTPSA id u15sm1211094wrm.64.2020.07.07.06.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 06:56:45 -0700 (PDT)
Date:   Tue, 7 Jul 2020 15:56:43 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Feng Tang <feng.tang@intel.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, lkp@lists.01.org
Subject: Re: [mm] 4e2c82a409: ltp.overcommit_memory01.fail
Message-ID: <20200707135643.GV5913@dhcp22.suse.cz>
References: <AF8CFC10-7655-4664-974D-3632793B0710@lca.pw>
 <20200707120619.GO5913@dhcp22.suse.cz>
 <20200707130436.GA992@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200707130436.GA992@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07-07-20 09:04:36, Qian Cai wrote:
> On Tue, Jul 07, 2020 at 02:06:19PM +0200, Michal Hocko wrote:
> > On Tue 07-07-20 07:43:48, Qian Cai wrote:
> > > 
> > > 
> > > > On Jul 7, 2020, at 6:28 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > > > 
> > > > Would you have any examples? Because I find this highly unlikely.
> > > > OVERCOMMIT_NEVER only works when virtual memory is not largerly
> > > > overcommited wrt to real memory demand. And that tends to be more of
> > > > an exception rather than a rule. "Modern" userspace (whatever that
> > > > means) tends to be really hungry with virtual memory which is only used
> > > > very sparsely.
> > > > 
> > > > I would argue that either somebody is running an "OVERCOMMIT_NEVER"
> > > > friendly SW and this is a permanent setting or this is not used at all.
> > > > At least this is my experience.
> > > > 
> > > > So I strongly suspect that LTP test failure is not something we should
> > > > really lose sleep over. It would be nice to find a way to flush existing
> > > > batches but I would rather see a real workload that would suffer from
> > > > this imprecision.
> > > 
> > > I hear you many times that you really don’t care about those use
> > > cases unless you hear exactly people are using in your world.
> > > 
> > > For example, when you said LTP oom tests are totally artificial last
> > > time and how less you care about if they are failing, and I could only
> > > enjoy their efficiencies to find many issues like race conditions
> > > and bad error accumulation handling etc that your “real world use
> > > cases” are going to take ages or no way to flag them.
> > 
> > Yes, they are effective at hitting corner cases and that is fine. I
> > am not dismissing their usefulness. I have tried to explain that many
> > times but let me try again. Seeing a corner case and think about a
> > potential fix is one thing. On the other hand it is not really ideal to
> > treat such a failure a hard regression and consider otherwise useful
> 
> Well, terms like "corner cases" and "hard regression" are rather
> subjective.

Existing real life examples really makes them less subjective though.

[...]

> > LTP is a very useful tool to raise awareness of potential problems but
> > you shouldn't really follow those results just blindly.
> 
> You must think I am a newbie tester to give me this piece of advice
> then.

Not by even close. I can clearly see your involvement in testing and how
many good bug reports that results in.
-- 
Michal Hocko
SUSE Labs
