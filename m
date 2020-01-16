Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB02BC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9986720728
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kNW0UDv2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388312AbgAPVF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 16:05:58 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33688 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbgAPVF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 16:05:58 -0500
Received: by mail-pl1-f194.google.com with SMTP id ay11so8871700plb.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 13:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ztqTmZ7YiqRf6ApCzAEB+/k7Mj4yZkONfuvT5Qk/M94=;
        b=kNW0UDv2/8wGSElhlvzmne2xJbuCS0295e/QWJQltkChHiMM1ccvnLMx/xMdgspFeW
         8nrbCpIRigEYvOpeiF/TisClyOU6qRiuBCTQy8EX7ZA+tgJ7nE5bOQP1jkigxeN4XDl6
         Vx3DRMKDtfdoVoDALLWwUjacsLpjnom3mXr1M//g++5lYA2wmeRABZAfZUvb9NMROtcu
         RE8MTTE5/W5lrSwoOQmXuv9olAY2uC1UL3CCTNNk43GiuhfT+5HQ9JkMlyu4ZA6P9fl2
         1h56C2TC6eBBPl8tCF/S/JTvfj6L4mL4QPX68YKJTHjqVHeI4pbqZF97S+wqO4lZGSWi
         b/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ztqTmZ7YiqRf6ApCzAEB+/k7Mj4yZkONfuvT5Qk/M94=;
        b=jjfclDQUlqJPk9SNqGZN9UGZR05okcm8rMYXSg2Nhq7O3kNHAPWCA2mw0tCzjnU+If
         oKfTgLI9bqytImY/7JOw2iQozZMcERMuEcGYBKC3BRoI6MxBFw1ZH90Otg2EfNBf0mVt
         UICtLHQO41zXgUFOnJjydIHANCDoj62ODrHgOL/5NwwS6uVDgSpyehnY9SCulMe6NSWv
         6MTJ24xOmbqGueBJ6qr1np22URH5PtF0mNwwryoR/9LCFV1+cZg8xnyBQxCn3Z5NHiYs
         NzDuInnA7X0Mf48pIudKzltdl5ALtyWD8wlDx9echT7ZqSH3HrBXWMh1VNx/VkD3JuV5
         tgwQ==
X-Gm-Message-State: APjAAAUU/D0TiJIVWY6w9ukn2AzDNTfMHrQSZFrYruN2hFvufNmP3uPG
        hMGuWV99us0XmrZORERrAcG8QbanbFo=
X-Google-Smtp-Source: APXvYqzOFbR9rr/janV/gfdMZqa7nHLObA91eV42iB+A0tw887kkzh0tVTVAeKHb9ISe9/UMOfc39w==
X-Received: by 2002:a17:902:d711:: with SMTP id w17mr35055534ply.303.1579208757499;
        Thu, 16 Jan 2020 13:05:57 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id 64sm27049026pfd.48.2020.01.16.13.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 13:05:56 -0800 (PST)
Date:   Thu, 16 Jan 2020 13:05:56 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch] mm, oom: dump stack of victim when reaping failed
In-Reply-To: <84fddb8e-a23b-e970-c8e9-74aa2fe2716d@i-love.sakura.ne.jp>
Message-ID: <alpine.DEB.2.21.2001161301570.101032@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.2001141519280.200484@chino.kir.corp.google.com> <20200115084336.GW19428@dhcp22.suse.cz> <9a7cbbf0-4283-f932-e422-84b4fb42a055@I-love.SAKURA.ne.jp> <alpine.DEB.2.21.2001151223040.13588@chino.kir.corp.google.com>
 <84fddb8e-a23b-e970-c8e9-74aa2fe2716d@i-love.sakura.ne.jp>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jan 2020, Tetsuo Handa wrote:

> > I'm 
> > currently tracking a stall in oom reaping where the victim doesn't always 
> > have a lock held so we don't know where it's at in the kernel; I'm hoping 
> > that a stack for the thread group leader will at least shed some light on 
> > it.
> > 
> 
> This change was already proposed at
> https://lore.kernel.org/linux-mm/20180320122818.GL23100@dhcp22.suse.cz/ .
> 

Hmm, seems the patch didn't get followed up on but I obviously agree with 
it :)

> And according to that proposal, it is likely i_mmap_lock_write() in dup_mmap()
> in copy_process(). We tried to make that lock killable but we gave it up
> because nobody knows whether it is safe to do make it killable.
> 

I haven't encountered that particular problem yet; one problem that I've 
found is a victim holding cgroup_threadgroup_rwsem in the exit path, 
another problem is the victim not holding any locks at all which is more 
concerning (why isn't it making forward progress?).  This patch intends to 
provide a clue for the latter.

Aside: we may also want to consider the possibility of doing immediate 
additional oom killing if the initial victim is too small.  We rely on the 
oom reaper to solve livelocks like this by freeing memory so that 
allocators can drop locks that the victim depends on.  If the victim is 
too small (we have victims <1MB because of oom_score_adj +1000!) we may 
want to consider additional immediate oom killing because it simply won't 
free enough memory.
