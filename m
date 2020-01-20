Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAC7C33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 21:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E18C12253D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 21:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e4c5GH3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgATVK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 16:10:59 -0500
Received: from mail-pj1-f43.google.com ([209.85.216.43]:38805 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbgATVK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 16:10:58 -0500
Received: by mail-pj1-f43.google.com with SMTP id l35so337053pje.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 13:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=SSadIyR7qVLBxGpfBtC2uRk5NBC+TncNZKu7gCEZ7pA=;
        b=e4c5GH3yb99tS4U3zqHkIHT5zq1PHemkzbJQ92TpbvDrMbCVfVqwabuhKEcIkWE7Bh
         sAr74tq9kNLnOcxliIkDllPWCaggxJJZHdNJcM7gieitVYuq2XQac8TrMmY8lQYtifoJ
         3QdaLVI/+OJNhSQZkv23hZAWELVCl/TWUfHLdHReQ9zLjUChBhD2GiFsjtiw9au6skhY
         eubc51eHF6ddYbcLVSGjVrF7psbbypJu8Dwzowo7/2+/6Qi2qGHcc8qzwzr9fbRFURgC
         0WwM1o+ZzL4xpJj1ZwnQdbzV5CXuKZXYVga+2FGM+yTAH2tV5ATQAvhA1SCDU3CUqqH7
         Kuvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=SSadIyR7qVLBxGpfBtC2uRk5NBC+TncNZKu7gCEZ7pA=;
        b=M5ZQ+7iTYLbjA8j/A89baiTFJCH/MCuE/lmtuZ9cfvP9zm4Vjn6LUSxV/r8MGyzexD
         UeU5KMWU56viPEpEha0OmZMzCY28fFheiSVIbDTYuhOvS2L0kPSNm8lWSI8Xhjx0rDvp
         m9LXBwmjYh7Q8J6jshsdXgZTdlb9+7YTi2mtJHJO0A9uv9uBj0V551nH1y+8rkREa85P
         946Pa7Yn3Y+mZLz91k4eq1ae0C8hLXVVAeMIzSVi1wCTM1IXDw+f66JcR9mZv9kZd/AH
         /1SBTixdM66+G7IByt9MwF1XnQwD1kV0e5Hg7yA6S+rFT15n0/gF/+UWryw8W3dY+Idv
         fOBA==
X-Gm-Message-State: APjAAAU6UvT38SS4e8FTWWCjSFoTGltAGkzCXSVg/DPb6FUnbxex77nw
        9J63ynHOd5Q3vM+sDsnz34Ukvw==
X-Google-Smtp-Source: APXvYqwVcFkW1ppmvT8X3m7D+blK3vBxTjJDijtegUcyGaMfvlBh63AN6tKuiyhKNGXLfow1BgyhVQ==
X-Received: by 2002:a17:90a:e397:: with SMTP id b23mr1018122pjz.135.1579554657933;
        Mon, 20 Jan 2020 13:10:57 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id j14sm38145864pgs.57.2020.01.20.13.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 13:10:57 -0800 (PST)
Date:   Mon, 20 Jan 2020 13:10:56 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richardw.yang@linux.intel.com>, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, ktkhai@virtuozzo.com,
        kirill.shutemov@linux.intel.com, yang.shi@linux.alibaba.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, alexander.duyck@gmail.com,
        stable@vger.kernel.org
Subject: Re: [Patch v4] mm: thp: remove the defer list related code since
 this will not happen
In-Reply-To: <20200120072237.GA18451@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.2001201307520.259466@chino.kir.corp.google.com>
References: <20200117233836.3434-1-richardw.yang@linux.intel.com> <20200118145421.0ab96d5d9bea21a3339d52fe@linux-foundation.org> <alpine.DEB.2.21.2001181525250.27051@chino.kir.corp.google.com> <20200120072237.GA18451@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jan 2020, Michal Hocko wrote:

> > When migrating memcg charges of thp memory, there are two possibilities:
> > 
> >  (1) The underlying compound page is mapped by a pmd and thus does is not 
> >      on a deferred split queue (it's mapped), or
> > 
> >  (2) The compound page is not mapped by a pmd and is awaiting split on a
> >      deferred split queue.
> > 
> > The current charge migration implementation does *not* migrate charges for 
> > thp memory on the deferred split queue, it only migrates charges for pages 
> > that are mapped by a pmd.
> > 
> > Thus, to migrate charges, the underlying compound page cannot be on a 
> > deferred split queue; no list manipulation needs to be done in 
> > mem_cgroup_move_account().
> > 
> > With the current code, the underlying compound page is moved to the 
> > deferred split queue of the memcg its memory is not charged to, so 
> > susbequent reclaim will consider these pages for the wrong memcg.  Remove 
> > the deferred split queue handling in mem_cgroup_move_account() entirely.
> 
> I believe this still doesn't describe the underlying problem to the full
> extent. What happens with the page on the deferred list when it
> shouldn't be there in fact? Unless I am missing something deferred_split_scan
> will simply split that huge page. Which is a bit unfortunate but nothing
> really critical. This should be mentioned in the changelog.
> 

Are you referring to a compound page on the deferred split queue before a 
task is moved?  I'm not sure this is within the scope of Wei's patch.. 
this is simply preventing a page from being moved to the deferred split
queue of a memcg that it is not charged to.  Is there a concern about why 
this code can be removed or a suggestion on something else it should be 
doing instead?
