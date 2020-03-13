Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74632C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 20:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 399952074D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 20:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584133188;
	bh=EU3iLOe1a0Yk1a2RCVDHW5czbssNAqVg49pMTct+NpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ljbXgRtTuK1UNgOEMUjZvidZsGUFaZ5SNGKDaAzEwV157RX+DgiyN83jmlGPUM9bI
	 RTUmiYawAERgz1pC0b7fIaVLMR1dP/N20NchF7iYRlPiPsTx1E6CMbTHv6zhZNJlly
	 szle0vnxHazXghz9GvO2x0sxnrf/1dAMfmHXJY10=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbgCMU7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 16:59:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36207 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgCMU7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 16:59:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id c7so5684956pgw.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 13:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6KL08/VlrvOVX8JGsKmdEdr7tZtj2psXJcqoH0aNQ9E=;
        b=nUljHM+ReiDkyC2R+TkiBL9zD7PUWDFKL6seMGWAuVu4mqMDvJc1vuCxPL7RB2DEsv
         gAepJ85pzPS6OdjoXuZsTgoqvRqkL3b64woxZdtZcrQroPl3VkaZ9/EYPB1KUuKx27ga
         1B0C86mihM7U4z6axbaUfvTU1+mKHBE0kdL037bai0rN8OTi5fRqb4eLTuJW+4jz1I0n
         LoVqpJi4ZHFdC1Lw4/wLbYl1ys0/WBktIG3WGWKiuNa70hSfRAAlDGgiqB1Le4cIVlju
         eXUSfUuHrSUqFZbakRpq55vzqJm7aax2lG+Fw35Y4iM8PqUOgLuOilZ/2R+T4mEtEcMW
         Bdug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6KL08/VlrvOVX8JGsKmdEdr7tZtj2psXJcqoH0aNQ9E=;
        b=J71OSPsBu357mPtRdHFAljOGRjHkTCEGXbuWClV5dmvIStbegO/4MmyYYzUqEFY91p
         WnRp+du3vvqeWXhllNAnRhJYpNAkxXIKw5VAQWWnaaPAZtWWF6C3RzuL/wFSgo6sjWlh
         +aiiFk2Ft1TDqiewrtyWvpZs8KWMmUhjvCO+7/skUoL3AGEwKCFNQWiSqblGihVlLrWh
         p58k0QkNkUsTI/U3c5zF7z9tzgjvK4/Evgh+2v+0a09nlIKflk4JIR+yBybkiL9fuoCx
         qEHVZuaoHQlbbBCSLUwceN0cpCFEjOVx55WGv6ryXBKbKwgKe3xw6ExYdQrJst4HA1wD
         Vhew==
X-Gm-Message-State: ANhLgQ0ecx+ittsX4j+nbKDgLLEOWiHaR80LNJJgE5dvswJszDsPCxjz
        sTXYtphiFZOCjnrszQYmG7s=
X-Google-Smtp-Source: ADFU+vv3guGrRRlNjprPZE5DGGby4h8Wjf72E2v3Vf2L8QeyQrhdJT9qfK7JaMVWTqLnRVIX9RRhUQ==
X-Received: by 2002:a63:fc52:: with SMTP id r18mr14152261pgk.96.1584133183843;
        Fri, 13 Mar 2020 13:59:43 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id d6sm12738897pjz.39.2020.03.13.13.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 13:59:42 -0700 (PDT)
Date:   Fri, 13 Mar 2020 13:59:41 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Jann Horn <jannh@google.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: interaction of MADV_PAGEOUT with CoW anonymous mappings?
Message-ID: <20200313205941.GA78185@google.com>
References: <CAG48ez0G3JkMq61gUmyQAaCq=_TwHbi1XKzWRooxZkv08PQKuw@mail.gmail.com>
 <20200312082248.GS23944@dhcp22.suse.cz>
 <20200312201602.GA68817@google.com>
 <20200312204155.GE23944@dhcp22.suse.cz>
 <20200313020851.GD68817@google.com>
 <20200313080546.GA21007@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313080546.GA21007@dhcp22.suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 09:05:46AM +0100, Michal Hocko wrote:
> On Thu 12-03-20 19:08:51, Minchan Kim wrote:
> > On Thu, Mar 12, 2020 at 09:41:55PM +0100, Michal Hocko wrote:
> > > On Thu 12-03-20 13:16:02, Minchan Kim wrote:
> > > > On Thu, Mar 12, 2020 at 09:22:48AM +0100, Michal Hocko wrote:
> > > [...]
> > > > > From eca97990372679c097a88164ff4b3d7879b0e127 Mon Sep 17 00:00:00 2001
> > > > > From: Michal Hocko <mhocko@suse.com>
> > > > > Date: Thu, 12 Mar 2020 09:04:35 +0100
> > > > > Subject: [PATCH] mm: do not allow MADV_PAGEOUT for CoW pages
> > > > > 
> > > > > Jann has brought up a very interesting point [1]. While shared pages are
> > > > > excluded from MADV_PAGEOUT normally, CoW pages can be easily reclaimed
> > > > > that way. This can lead to all sorts of hard to debug problems. E.g.
> > > > > performance problems outlined by Daniel [2]. There are runtime
> > > > > environments where there is a substantial memory shared among security
> > > > > domains via CoW memory and a easy to reclaim way of that memory, which
> > > > > MADV_{COLD,PAGEOUT} offers, can lead to either performance degradation
> > > > > in for the parent process which might be more privileged or even open
> > > > > side channel attacks. The feasibility of the later is not really clear
> > > > 
> > > > I am not sure it's a good idea to mention performance stuff because
> > > > it's rather arguble. You and Johannes already pointed it out when I sbumit
> > > > early draft which had shared page filtering out logic due to performance
> > > > reason. You guys suggested the shared pages has higher chance to be touched
> > > > so that if it's really hot pages, that whould keep in the memory. I agree.
> > > 
> > > Yes, the hot memory is likely to be referenced but the point was an
> > > unexpected latency because of the major fault. I have to say that I have
> > 
> > I don't understand your point here. If it's likely to be referenced
> > among several processes, it doesn't have the major fault latency.
> > What's your point here?
> 
> a) the particular CoW page might be cold enough to be reclaimed and b)

If it is, that means it's *cold* so it's really worth to be reclaimed.

> nothing really prevents the MADV_PAGEOUT to be called faster than the
> reference bit being readded.

Yeb, that's undesirable. I should admit it was not intended when I implemented
PAGEOUT. The thing is page_check_references clears access bit of pte for every
process are sharing the page so that two times MADV_PAGEOUT from a process could
evict the page. That's the really bug. It shouldn't have cleared the
access bit for other processes. What I wanted to do with MADV_PAGEOUT is just
check the reference from the other processes without clearing access bit of pte
and if it found other process pte has access bit, just bail out.

Okay so you're right. Current implementation could cause performance impact
since MADV_PAGEOUT unconditionally clear the access bit of other processes so
your patch will fix it.

Thanks.
