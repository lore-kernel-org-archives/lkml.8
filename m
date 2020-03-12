Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7629EC2BAEE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 00:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 809E32074D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 00:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583972336;
	bh=yrH8A3csbp8EDXHvz69GfkjLu1w5Rhlo4usxSozdQv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sC3UjHaUQDSipty8/ksXQO/W6t1sQ0olgjFdicxNO73GnRIohn5Q7heq3iXxCjx1D
	 bCsNcpfBqvBr1Dcj46ua/vBvlFungQRNj9gP9mmH27Hwomyu81e6PFvcwrey5P6HeF
	 5m2kVzcmZzJtkMcpSGezuAKW9S/8OPuAQg5h5rQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731587AbgCLASz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 20:18:55 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:54578 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731448AbgCLASy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 20:18:54 -0400
Received: by mail-pj1-f67.google.com with SMTP id np16so1761611pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 17:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3isA1tVj1/AbpkkjvWlQtyvSTX5nP5eHnvOxHnKorV8=;
        b=CTmv1WbC0xrnbJRiKZdyBIyWeB+rGR+GvhHbj4LPGOcZbO9BgNdSpdcEj4aEJzBDQ3
         Wuyu53x7TUcxik8cQa8+HFVGonAv4Tt7MJ2Syp1UHO6fcG7EK7nvUSWewSuRve7Aifcm
         TQ/rcpRnbKxpiKntiCFuy52Lu+CJggCblGtw6XhebnnlG6YVXx4bNS5Y9IkJGlSYiWYT
         6rMl6wgO8Xra21nZvtOotLDc8/Rj72ak/4LziLxctggtPAhAWAoGtd4hmaFmVBQeEywY
         mNBnlBKmNSzWhk3w6lWphn1OcbKORmJ/PGy4n1Wh9C+V/0IMFN7TszpixfpkS2kPmalk
         IV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3isA1tVj1/AbpkkjvWlQtyvSTX5nP5eHnvOxHnKorV8=;
        b=j8CM7kw27NdzXdWXBNTuprX/3g5unPl1pbOBcw3PLsHk4XQULFBIdT5ExUJFYRvAxu
         /OQ1dFRgfm60SWuc4aGCaHsse06IODUkIXoYsqry7FVrinaOxgueo8tRVNQveRJ4IXya
         PYOvxmVFPoWUQhhZZMZcuzWeEgYQ55LCi6r4ocx3fvjXrd1Gurgj3Z0GFMjlRB6PcX4J
         1pMPo6Jo/JsjjfWVgBOM8N8PR6JmD0gLJ6sRc1dqh7W2yJdvnjOJF/kMd9wiRVjgi2Gk
         ekEwQWwigQ5HLhBvmcm1qqRYhJEE3W2lHWf5ui7MIU95iplgbHZZFmyquQMBon2eSMl2
         YzvA==
X-Gm-Message-State: ANhLgQ3w6pwKcl0QOTaaojP5NQlGeZ1pK9VN4OUqKjLwUiAe6SPEX5vq
        WQsHlmAZQ5PkYxiRWiklc245ZzgJ
X-Google-Smtp-Source: ADFU+vswgzmTTZ+Ndgojb02iVVr1CeuBSH2oCPmu9usv/GeJ3lOAqfCO9/e4U6/j8JekpPsIXF3D5w==
X-Received: by 2002:a17:90a:25c8:: with SMTP id k66mr1322789pje.90.1583972331962;
        Wed, 11 Mar 2020 17:18:51 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id j21sm6477775pji.13.2020.03.11.17.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 17:18:50 -0700 (PDT)
Date:   Wed, 11 Mar 2020 17:18:49 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Jann Horn <jannh@google.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: interaction of MADV_PAGEOUT with CoW anonymous mappings?
Message-ID: <20200312001849.GA96953@google.com>
References: <CAG48ez0G3JkMq61gUmyQAaCq=_TwHbi1XKzWRooxZkv08PQKuw@mail.gmail.com>
 <20200310184814.GA8447@dhcp22.suse.cz>
 <CAG48ez2pNSKL9ZTH-PQ93+Kc6ObH6Pa1vVg3OS85WT0TB8m3=A@mail.gmail.com>
 <20200310210906.GD8447@dhcp22.suse.cz>
 <cf95db88-968d-fee5-1c15-10d024c09d8a@intel.com>
 <20200311084513.GD23944@dhcp22.suse.cz>
 <CALvZod6b73_ay_kxph143Aj+XBq04Np0z2bK4Rfn8qppihrmTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod6b73_ay_kxph143Aj+XBq04Np0z2bK4Rfn8qppihrmTw@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 04:53:17PM -0700, Shakeel Butt wrote:
> On Wed, Mar 11, 2020 at 1:45 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Tue 10-03-20 15:48:31, Dave Hansen wrote:
> > > Maybe instead of just punting on MADV_PAGEOUT for map_count>1 we should
> > > only let it affect the *local* process.  We could still put the page in
> > > the swap cache, we just wouldn't go do the rmap walk.
> >
> > Is it really worth medling with the reclaim code and special case
> > MADV_PAGEOUT there? I mean it is quite reasonable to have an initial
> > implementation that doesn't really touch shared pages because that can
> > lead to all sorts of hard to debug and unexpected problems. So I would
> > much rather go with a simple patch to check map count first and see
> > whether somebody actually cares about those shared pages and go from
> > there.
> >
> > Minchan, do you want to take my diff and turn it into the proper patch
> > or should I do it.
> >
> 
> What about the remote_madvise(MADV_PAGEOUT)? Will your patch disable
> the pageout from that code path as well for pages with mapcount > 1?

Maybe, not because process_madvise syscall needs more previliedge(ie,
PTRACE_MODE_ATTACH_FSCREDS) so I guess it would be more secure.
So in that case, I want to rely on the LRU chance for shared pages.

With that, the manager process could give a hint to several processes
and finally makes them paging out.

What do you think?
