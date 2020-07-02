Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCB6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 17:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C767120760
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 17:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593709816;
	bh=spX3bAMuiRarrcPtYgKD6VANVNAlIDIOa74LYQDQwao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wMJxgIqjb3SFxaju72Ix7E58WOGz/0lGVU3Ge8dQMOgiWbM0x4jPlRHsIBolS4qR0
	 BL1et57274Z4k95998exvkqiOl6H3BldjCVdmdY8r2kO1vZhHpwVo0lDSjV8rreasB
	 iNH+6ePl1/XltcT5Vgh3useNCme3RddLikMB5nIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgGBRKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 13:10:15 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40620 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgGBRKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 13:10:15 -0400
Received: by mail-ed1-f67.google.com with SMTP id b15so24759869edy.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 10:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UQMqU/oqcviJOT6ra19wu8jEYcT3DRqeElrxLzrejiE=;
        b=tEVSxNf7lqz43gjsG+VzL/bEnSOgLvsmpBAsrOS4qnA9k9ih3uR3NlEQuzhQfG0pVG
         mIm+HRIRsL7zODtLFlIGuJcUKE8hCTe/FhvM3rMeLTu7dUs+dRIZrlXIKXExldQvj3U9
         vOm5Rrp1j/Z2GilHAvkQHStBDFevHDj4zmxDLrnV5zNSXtNexQT/WMYp7b67MqWTDzf8
         IeTVcA7JXl+YoGnEd70tSLN7Eys/py3m0LiNgvhcLm9uythcPmgtVsNUVUHC3LVNyTTG
         SCvXxZOmlE1uE/3vPK9NsHBAn2iF/iImMswmY/frTml3lIPV8t2u+LrwH6BHsECEIF0I
         ZqvQ==
X-Gm-Message-State: AOAM5315JB/mDUnb3oQrMeSZfo1qBsSxDnZAwqAbUTgbGIkeiDn7m+RH
        CE3GbBl2w/ZsAxBbToA/MRaiPEkB
X-Google-Smtp-Source: ABdhPJzyGu71dP9RLdC6H2sfNId5snu3Frn1YijkjVhsim2Awf7BRCd1sb1+/DQWTr4J1fG7g0X5EQ==
X-Received: by 2002:a05:6402:337:: with SMTP id q23mr36693172edw.63.1593709813149;
        Thu, 02 Jul 2020 10:10:13 -0700 (PDT)
Received: from localhost (ip-37-188-168-3.eurotel.cz. [37.188.168.3])
        by smtp.gmail.com with ESMTPSA id bw7sm7410420ejb.5.2020.07.02.10.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 10:10:12 -0700 (PDT)
Date:   Thu, 2 Jul 2020 19:10:11 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Roman Gushchin <guro@fb.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Chris Down <chris@chrisdown.name>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: BUG: Bad page state in process - page dumped because: page still
 charged to cgroup
Message-ID: <20200702171011.GJ18446@dhcp22.suse.cz>
References: <CA+G9fYs=3UG3k-2trqQuB-gJh9D1YygkNQ4qWiHtcaRMSWTmrQ@mail.gmail.com>
 <20200701082904.GM2369@dhcp22.suse.cz>
 <20200701184552.GA61684@carbon.DHCP.thefacebook.com>
 <20200702162202.GI18446@dhcp22.suse.cz>
 <57270a15-a792-5175-757b-c4bde6da3694@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57270a15-a792-5175-757b-c4bde6da3694@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 02-07-20 18:35:31, Vlastimil Babka wrote:
> On 7/2/20 6:22 PM, Michal Hocko wrote:
> > On Wed 01-07-20 11:45:52, Roman Gushchin wrote:
> > [...]
> >> >From c97afecd32c0db5e024be9ba72f43d22974f5bcd Mon Sep 17 00:00:00 2001
> >> From: Roman Gushchin <guro@fb.com>
> >> Date: Wed, 1 Jul 2020 11:05:32 -0700
> >> Subject: [PATCH] mm: kmem: make memcg_kmem_enabled() irreversible
> >> 
> >> Historically the kernel memory accounting was an opt-in feature, which
> >> could be enabled for individual cgroups. But now it's not true, and
> >> it's on by default both on cgroup v1 and cgroup v2.  And as long as a
> >> user has at least one non-root memory cgroup, the kernel memory
> >> accounting is on. So in most setups it's either always on (if memory
> >> cgroups are in use and kmem accounting is not disabled), either always
> >> off (otherwise).
> >> 
> >> memcg_kmem_enabled() is used in many places to guard the kernel memory
> >> accounting code. If memcg_kmem_enabled() can reverse from returning
> >> true to returning false (as now), we can't rely on it on release paths
> >> and have to check if it was on before.
> >> 
> >> If we'll make memcg_kmem_enabled() irreversible (always returning true
> >> after returning it for the first time), it'll make the general logic
> >> more simple and robust. It also will allow to guard some checks which
> >> otherwise would stay unguarded.
> >> 
> >> Signed-off-by: Roman Gushchin <guro@fb.com>
> 
> Fixes: ? or let Andrew squash it to some patch of your series (it's in mmotm I
> think)?

I would rather make it its own patch because this is really subtle.
-- 
Michal Hocko
SUSE Labs
