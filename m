Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B98C5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 12:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 323A520767
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 12:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584534673;
	bh=kLjhQrjVGrmQ3okhqTv278blsAPcCRrR0iRbaOow1DQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zKtRI9GxH3JW7UwGIzOwhaAfWWzmaNKf+Sav/g/LdW9rfe6gn3x+pw7B02fOJMo49
	 6pXMtNHimJIHErkqbIokDTC4oDhj1Qf/egXRQuvxKUTym6D4jgo+LPrJTAE2wI+W/I
	 31Tlgxkc/FXCkHmwp6kKrBAWFmcj9Bux8c1bCER8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgCRMbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 08:31:12 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:39897 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgCRMbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 08:31:11 -0400
Received: by mail-wm1-f50.google.com with SMTP id f7so3088622wml.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 05:31:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J4S1KIZkd3A7M+OXs6nSrJJ9jI8n39NroLM1YJ8t0Co=;
        b=htVjbyn8VmmtSTQvIrBipu5akQd2fsCkRtmS8WYdznFILk8fJ41L0bdybZi9tVaxWE
         38LmGlengTHLnbb8hVRe7LvTAVi4oIJswfd2VtJMSCrQBeQimlNhXYl5AFed2OMd5uil
         EX4f1d7sMdm1/kE/rds5xTgwQmVDj6tQd0awtFHFQvN5hPzJYNX+CBHftyR3ppNcOX3+
         Z8jpAGAR2swPG255i8eOmcnVYtCpT7ulrJylaKqy4vadiMtSIocP41th40KZzs6vCQVH
         fQYLOkISujQsasDEgcTSU7/FPww3JQZM+go/NGnQx44fsZp3JOSFsXsp3UxtSTEbEGSt
         CLfQ==
X-Gm-Message-State: ANhLgQ0tFe+wsQoQfo0jlMmJTHU00UY895r0kuBog+8CYuzQmpMOB5mK
        4/M1wOzFtdxzS/ZbAK8UtUFgovYZ
X-Google-Smtp-Source: ADFU+vu1q7abU8bVDZ1169q2Hs+UDQnlepqGsBEOdo4xPzkzICgyOmwTMtg4eef6jId+ldfF84vv8w==
X-Received: by 2002:a1c:3585:: with SMTP id c127mr5018236wma.124.1584534669710;
        Wed, 18 Mar 2020 05:31:09 -0700 (PDT)
Received: from localhost (ip-37-188-180-89.eurotel.cz. [37.188.180.89])
        by smtp.gmail.com with ESMTPSA id k126sm3928057wme.4.2020.03.18.05.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 05:31:08 -0700 (PDT)
Date:   Wed, 18 Mar 2020 13:31:07 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcg: make memory.oom.group tolerable to task
 migration
Message-ID: <20200318123107.GK21362@dhcp22.suse.cz>
References: <20200316223510.3176148-1-guro@fb.com>
 <20200317075212.GC26018@dhcp22.suse.cz>
 <20200317183836.GA276471@carbon.DHCP.thefacebook.com>
 <20200317185529.GV26018@dhcp22.suse.cz>
 <20200317203645.GC276471@carbon.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317203645.GC276471@carbon.DHCP.thefacebook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 17-03-20 13:36:45, Roman Gushchin wrote:
[...]
> > > And the we can put something like
> > > 	if (WARN_ON_ONCE(!mem_cgroup_is_descendant(memcg, oom_domain)))
> > > 		goto out;
> > > to mem_cgroup_get_oom_group?
> > 
> > This would be a user triggerable warning and that sounds like a bad idea
> > to me. We should just live with races. The only question I still do not
> > have a proper answer for is how much we do care. If we do not care all
> > that much about the original memcg then go with your patch. But if we
> > want to be slightly more careful then we should note the memcg in
> > oom_evaluate_task and use it when killing.
> 
> But it won't close the race, right?
>
> oom_evaluate_task() can race with a task migration too, so we can record
> the old or the new cgroup.

Are you sure? I thought that cgroups iterator code would take care of
those races. The documentation doesn't tell much in that respect. Maybe
it would be good to add a clarification there.
 
> Then I'd stick with my original patch which solves the main problem here:
> unnecessary killing of too many tasks.

OK, I am fine with that. I couldn't convince myself that the other part
of the problem is serious enough. Maybe we will find workloads which do
care and we can add that later on.
-- 
Michal Hocko
SUSE Labs
