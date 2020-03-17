Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D71EC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E726120663
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584465628;
	bh=gq6eni/CM56JRFlvAks1OzWIMBPayIbsR0YlSXDKPg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mwLx74BisKWs9gnjCwcjVtmCD8bLzL5tlZtId4egGNGH5KdHiOhaH+PGFZibtuoi6
	 S/bBQdiwJkVbdAy2Wcr/Bo73ymaCoKB4HeBui2LDCvIUQp9Hk2KDyobxggnZzC6dND
	 Y9T5CC4lNwLj3naIHYA7Gb1ajVhpLYH9I27pvUII=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgCQRU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:20:26 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:43001 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgCQRU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:20:26 -0400
Received: by mail-pl1-f175.google.com with SMTP id t3so9897205plz.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 10:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nWbdbsJ13Q5NKkmy2CBTWFaOaDCn2fTrTpvwXFs+GyY=;
        b=lEwGPTTiBodJ9sKj25HMDSAH+JGZ1Rik23rCQNCodLP4iEnOC0bNp8B8qDNu12YXJo
         9gEZ9Vt1sdRaowLp2xl+6jdAlX19IXAgb8NFCRehh5sh00+Wx1L4uX9P1f+h5+uT1+mY
         VPRvJi79Zfo06t/CT7prW2jBtYg+t5JIz+P0kyySyL5bFiHoY7zbnOK+jDERGWULzzuD
         z8ieD9+xWYTG3v3rz22x/Mj4BKmosjWf4SLAtaJWDoOiLy5Krsby3duOcz9pRT/K9QPn
         qtIOefoI9IK1dkmTNLE1c0FyADVlBv+xcBX+xc+MxvUlAt6y7sBveFJCz7zsaIRfLCBG
         GsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=nWbdbsJ13Q5NKkmy2CBTWFaOaDCn2fTrTpvwXFs+GyY=;
        b=c7BSGQdC8ayCUEzbnueNTFWlo3fgChSys/ePoyacjTIMz417c/5Vp7Q7AoMwSDZ0Q9
         78QPgSAJ3zpAoUCJcbZFzKrq5ps/2ycHgAeVPwByXEOMFSmOvvzULgIHyYqFESnRsogu
         UBPZ2uyGB4VgtEZr2un5nawyq3/46up9dnvqqu/5KMYhtLd2vxREZxkd7YRu/92LlBE3
         vGriGwvLbHRzYAhfAK+rRiMcf2US0kmETkB85pSGeM+MTx0Peh4wFVgAejwssh6XplX2
         rm7BQBa6ILRKOSFoA/f+0fmji19XaSMcLKt2QQIPPLM+r9pYfrjqy/UNPBekhe4hGeWA
         xwHg==
X-Gm-Message-State: ANhLgQ0vibsYRRmt2NT2/VtGkjhAosEGshMCmEDdYAOAXZ8ShxYhnRlx
        +GniuDoYvyeVucjKSeuSKCY=
X-Google-Smtp-Source: ADFU+vseSefs8izYUDjRT/iTG1UXiU8ssaQG0e/NgGwkksRz+2wSI0FaQYZpyo8m5MfQxiqTmCs9yA==
X-Received: by 2002:a17:90a:5218:: with SMTP id v24mr273042pjh.90.1584465625132;
        Tue, 17 Mar 2020 10:20:25 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id t60sm53380pjb.9.2020.03.17.10.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 10:20:23 -0700 (PDT)
Date:   Tue, 17 Mar 2020 10:20:22 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Jann Horn <jannh@google.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: interaction of MADV_PAGEOUT with CoW anonymous mappings?
Message-ID: <20200317172022.GD73302@google.com>
References: <20200312201602.GA68817@google.com>
 <20200312204155.GE23944@dhcp22.suse.cz>
 <20200313020851.GD68817@google.com>
 <20200313080546.GA21007@dhcp22.suse.cz>
 <20200313205941.GA78185@google.com>
 <20200316092052.GD11482@dhcp22.suse.cz>
 <20200317014340.GA73302@google.com>
 <20200317071239.GB26018@dhcp22.suse.cz>
 <20200317150055.GC73302@google.com>
 <20200317155855.GS26018@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317155855.GS26018@dhcp22.suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 04:58:55PM +0100, Michal Hocko wrote:
> On Tue 17-03-20 08:00:55, Minchan Kim wrote:
> > On Tue, Mar 17, 2020 at 08:12:39AM +0100, Michal Hocko wrote:
> [...]
> > > Just to make it clear, are you really suggesting to special case
> > > page_check_references for madvise path?
> > > 
> > 
> > No, (page_mapcount() >  1) checks *effectively* fixes the performance
> > bug as well as vulnerability issue.
> 
> Ahh, ok then we are on the same page. You were replying to the part
> where I have pointed out that you can control aging by these calls
> and your response suggested that this is somehow undesirable behavior or
> even a bug.

Sorry about the confusing.

I want to clarify my speaking.

If we don't have vulnerability issue Jann raised, the performance issue
Daniel pointed should be fixed by introducing a special flag in
page_check_references from madvise path to avoid cleaning of access bit
from other processes's pte. With it, we don't need to limit semantic of
MADV_PAGEOUT as "exclusive page only" so that MADV_PAGEOUT will work
*cold* shared pages as well as exclusive one.

However, since we have the vulnerability issue, *unfortunately*, we need
to make MADV_PAGEOUT's semantic working with only exclusive page. 
Thus, page_mapcount check in madvise patch will fix both issues
*effectively*.

Thanks.
