Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC69C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 01:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF8420724
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 01:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584409428;
	bh=OEMc4ILQXTMRwpM+jtvyEYvPoIiljQ9u3pjLvQVoEZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sUYpU+lXOoP15zvNdSKLNxP/smaOSAz9gvBxXHX3nGmXKJPeXVsJoaYcAC5eCLHI2
	 12ngMBuc0DD21alp0ZLEj2nBJs0yCCfgNGzA09Z3GqPzqlH1JPCbbITVeL7XCaJPwV
	 qQWkW3xqr/oZrFx0oalqsGkOap0yAnkCRK2vfqns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgCQBnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 21:43:46 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:33132 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbgCQBnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 21:43:46 -0400
Received: by mail-pg1-f181.google.com with SMTP id m5so10814568pgg.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 18:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YPrE3TC9cvR5eow6UPNLAi081AyK8g0VypG98zq/3rI=;
        b=Qs7KHkvGrxolIHTiAhyQGd2igPK8/UgI2BqNWe8908q+A6DbfydjZ89uzH8KvnLNG7
         bxKuwqDsn/gl0UbTRoIEIZgf6ViRSq9GQRIrCNibxeR52oKm7yVGsTqWvBckF5PHJ5Hw
         WjfnQU+Q+v973TV+wdXPdsOtge82uAMlVNlwqb0OqohYOi47Kht7dzaKMteRyAVcRBSp
         868NkrAAF0c8BBzyHhbBv8B12BDOldVVIZCDBQwFK5mmln13hICY8/+hhp5dHjlgoRnM
         ezqNu3oeHGObMUlKU2uaEYQ+soCYl5bKQt2P0xnFoSM5k6hTgmmCYfVgrhlulFRMqIFD
         rWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YPrE3TC9cvR5eow6UPNLAi081AyK8g0VypG98zq/3rI=;
        b=NAQNbXSOwLtCVhOrhdgl3bmx7740KXObwVncn6Z2R64Xyzpl0BXCSyb+mgpbfRTzVw
         0y1MaTzFdtSxT9fzaERsttokmrU2r2HceYRsdDa3U9yOFJMAq5frLwOfuMtlCevTILhF
         lkDw7hDK6HDrXGGx3cnQIwm/6/d5CpXf8i3ovNJr0o0huZzjyY3OESGLFU9SMiEHAO3Z
         PKTxPtG+r0VpGfPenbzEpAv89bM6GtjoJZwtl1cykhzmpej6/qcQybUhQm2AkNizV+Gt
         Pql5/2WI2TUn6fg4d7Jrd1R5Jt9Pfd0RRo+WnL9lAQbjnCsJwnb8D9HoPbLiUVb3mVxj
         zusw==
X-Gm-Message-State: ANhLgQ3jtCFiBiuEQNPD9GleCcxbF3C4T2wI6q1jNNhvZVKWbSdP6Ygx
        3xFdxffqsGxEmmGxGjgduwM=
X-Google-Smtp-Source: ADFU+vuLfSSQxDO7LSW23UwCfFLT6vWrf39N6cgbnHenoukHb5KoqNoLNE7b8ejtHEZzZijNiDuTFw==
X-Received: by 2002:a63:1f58:: with SMTP id q24mr2755192pgm.334.1584409424318;
        Mon, 16 Mar 2020 18:43:44 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id d84sm1031512pfd.197.2020.03.16.18.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 18:43:42 -0700 (PDT)
Date:   Mon, 16 Mar 2020 18:43:40 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Jann Horn <jannh@google.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: interaction of MADV_PAGEOUT with CoW anonymous mappings?
Message-ID: <20200317014340.GA73302@google.com>
References: <CAG48ez0G3JkMq61gUmyQAaCq=_TwHbi1XKzWRooxZkv08PQKuw@mail.gmail.com>
 <20200312082248.GS23944@dhcp22.suse.cz>
 <20200312201602.GA68817@google.com>
 <20200312204155.GE23944@dhcp22.suse.cz>
 <20200313020851.GD68817@google.com>
 <20200313080546.GA21007@dhcp22.suse.cz>
 <20200313205941.GA78185@google.com>
 <20200316092052.GD11482@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316092052.GD11482@dhcp22.suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 10:20:52AM +0100, Michal Hocko wrote:
> On Fri 13-03-20 13:59:41, Minchan Kim wrote:
> > On Fri, Mar 13, 2020 at 09:05:46AM +0100, Michal Hocko wrote:
> > > On Thu 12-03-20 19:08:51, Minchan Kim wrote:
> > > > On Thu, Mar 12, 2020 at 09:41:55PM +0100, Michal Hocko wrote:
> > > > > On Thu 12-03-20 13:16:02, Minchan Kim wrote:
> > > > > > On Thu, Mar 12, 2020 at 09:22:48AM +0100, Michal Hocko wrote:
> > > > > [...]
> > > > > > > From eca97990372679c097a88164ff4b3d7879b0e127 Mon Sep 17 00:00:00 2001
> > > > > > > From: Michal Hocko <mhocko@suse.com>
> > > > > > > Date: Thu, 12 Mar 2020 09:04:35 +0100
> > > > > > > Subject: [PATCH] mm: do not allow MADV_PAGEOUT for CoW pages
> > > > > > > 
> > > > > > > Jann has brought up a very interesting point [1]. While shared pages are
> > > > > > > excluded from MADV_PAGEOUT normally, CoW pages can be easily reclaimed
> > > > > > > that way. This can lead to all sorts of hard to debug problems. E.g.
> > > > > > > performance problems outlined by Daniel [2]. There are runtime
> > > > > > > environments where there is a substantial memory shared among security
> > > > > > > domains via CoW memory and a easy to reclaim way of that memory, which
> > > > > > > MADV_{COLD,PAGEOUT} offers, can lead to either performance degradation
> > > > > > > in for the parent process which might be more privileged or even open
> > > > > > > side channel attacks. The feasibility of the later is not really clear
> > > > > > 
> > > > > > I am not sure it's a good idea to mention performance stuff because
> > > > > > it's rather arguble. You and Johannes already pointed it out when I sbumit
> > > > > > early draft which had shared page filtering out logic due to performance
> > > > > > reason. You guys suggested the shared pages has higher chance to be touched
> > > > > > so that if it's really hot pages, that whould keep in the memory. I agree.
> > > > > 
> > > > > Yes, the hot memory is likely to be referenced but the point was an
> > > > > unexpected latency because of the major fault. I have to say that I have
> > > > 
> > > > I don't understand your point here. If it's likely to be referenced
> > > > among several processes, it doesn't have the major fault latency.
> > > > What's your point here?
> > > 
> > > a) the particular CoW page might be cold enough to be reclaimed and b)
> > 
> > If it is, that means it's *cold* so it's really worth to be reclaimed.
> > 
> > > nothing really prevents the MADV_PAGEOUT to be called faster than the
> > > reference bit being readded.
> > 
> > Yeb, that's undesirable. I should admit it was not intended when I implemented
> > PAGEOUT. The thing is page_check_references clears access bit of pte for every
> > process are sharing the page so that two times MADV_PAGEOUT from a process could
> > evict the page. That's the really bug.
> 
> I do not really think this is a bug. This is a side effect of the
> reclaim process and we do not really want MADV_{PAGEOUT,COLD} behave

No, that's the bug since we didn't consider the side effect.

> differently here because then the behavior would be even harder to

No, I do want to have difference because it's per-process hint. IOW,
what he know is for only his context, not others so it shouldn't clean
others' pte. That makes difference between LRU aging and the hint.

> understand.

It's not hard to understand.. MADV_PAGEOUT should consider only his
context since it's per-process hint(Even, he couldn't know others'
context) so it shouldn't bother others.

Actually, Dave's suggestion is correct to fix the issue if there
was no isse with side channel attack. However, due to the attack
issue, page_mapcount could prevent the problem effectively.
That's why I am not against of the patch now since it fixes
the bug as well as vulnerability.
