Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22A7C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 07:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 968C820674
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 07:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584431984;
	bh=fl8pl4W7bSue8L5SJNVLfRm5YSGX6fuIy5fWAbnSqaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dOBAgTSmA4yMwY+QHQhDZArRfxMjsd/RUKrDE1TiGw2JtOqRRcUSTw0/77SxN9go7
	 RbeNLTqAEAEa3yWThIoy0q3TY8mSMqJnRr5qtQJ2Kxy0syERIghzlXtfGQOSzZrnf+
	 E3Y224V/aHCV5ukMpMsQliYZgrIbllyiIs4aetaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgCQH7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 03:59:43 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45503 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgCQH7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 03:59:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id t2so14271204wrx.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 00:59:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=COSdnxnIOsN3EOb8hRM3mTHRvlfS3wYkyMMxHIL4X4U=;
        b=SEuTFLHGlaomHAU4fZMLOFQF+EUokRlMT4xEddcj+JnMm8+WPXWu8Gq+Z5iZLR9lzp
         NvsjdbD62w2mC+JvPprLyyzjIvlystsYOgxFWOxUGB5jl/id/Ant5FPayHNcsa9Qgjy8
         LqMl0sOLaLQr0eRERDCk2tGzPfr2LCCZwK2f2RjLCR+xR+qXcdThDHl2DbTOVDke/AXi
         D+MoKdmTlJ4Cbxae8HVDXbmoBWPTBaCXeXVk3kMh+5OhCNz2ziLmYmdaHY3Th7uArgn8
         FmtbatRL0S+mop3Ee9HGrfa1RmyOtHgFMSnUm+WRN+Xg6cXnnIazkknRaiF6Dxq+Dg4F
         NIzQ==
X-Gm-Message-State: ANhLgQ1ifQAws2gVR2DExyKGnybWXRFZW2wPWViSHH9nq1rBfsFwUy6L
        bN3lzyTndXfEdNoV02mYaJg=
X-Google-Smtp-Source: ADFU+vuwKantGoDyxWPeXBYjQjtbjYm5qNqzH0vpREbbQTITnn51vvyBJ7rwuV3Mw+wIV2o2vgzf0g==
X-Received: by 2002:adf:bb06:: with SMTP id r6mr4533468wrg.324.1584431981101;
        Tue, 17 Mar 2020 00:59:41 -0700 (PDT)
Received: from localhost (ip-37-188-255-121.eurotel.cz. [37.188.255.121])
        by smtp.gmail.com with ESMTPSA id x13sm3150071wmj.5.2020.03.17.00.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 00:59:40 -0700 (PDT)
Date:   Tue, 17 Mar 2020 08:59:39 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Robert Kolchmeyer <rkolchmeyer@google.com>,
        David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch] mm, oom: make a last minute check to prevent unnecessary
 memcg oom kills
Message-ID: <20200317075939.GD26018@dhcp22.suse.cz>
References: <alpine.DEB.2.21.2003101454580.142656@chino.kir.corp.google.com>
 <20200310221938.GF8447@dhcp22.suse.cz>
 <alpine.DEB.2.21.2003101547090.177273@chino.kir.corp.google.com>
 <20200311083900.GC23944@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311083900.GC23944@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 11-03-20 09:39:01, Michal Hocko wrote:
> On Tue 10-03-20 15:54:44, David Rientjes wrote:
> > On Tue, 10 Mar 2020, Michal Hocko wrote:
> > 
> > > On Tue 10-03-20 14:55:50, David Rientjes wrote:
> > > > Killing a user process as a result of hitting memcg limits is a serious
> > > > decision that is unfortunately needed only when no forward progress in
> > > > reclaiming memory can be made.
> > > > 
> > > > Deciding the appropriate oom victim can take a sufficient amount of time
> > > > that allows another process that is exiting to actually uncharge to the
> > > > same memcg hierarchy and prevent unnecessarily killing user processes.
> > > > 
> > > > An example is to prevent *multiple* unnecessary oom kills on a system
> > > > with two cores where the oom kill occurs when there is an abundance of
> > > > free memory available:
> > > > 
> > > > Memory cgroup out of memory: Killed process 628 (repro) total-vm:41944kB, anon-rss:40888kB, file-rss:496kB, shmem-rss:0kB, UID:0 pgtables:116kB oom_score_adj:0
> > > > <immediately after>
> > > > repro invoked oom-killer: gfp_mask=0xcc0(GFP_KERNEL), order=0, oom_score_adj=0
> > > > CPU: 1 PID: 629 Comm: repro Not tainted 5.6.0-rc5+ #130
> > > > Call Trace:
> > > >  dump_stack+0x78/0xb6
> > > >  dump_header+0x55/0x240
> > > >  oom_kill_process+0xc5/0x170
> > > >  out_of_memory+0x305/0x4a0
> > > >  try_charge+0x77b/0xac0
> > > >  mem_cgroup_try_charge+0x10a/0x220
> > > >  mem_cgroup_try_charge_delay+0x1e/0x40
> > > >  handle_mm_fault+0xdf2/0x15f0
> > > >  do_user_addr_fault+0x21f/0x420
> > > >  async_page_fault+0x2f/0x40
> > > > memory: usage 61336kB, limit 102400kB, failcnt 74
> > > > 
> > > > Notice the second memcg oom kill shows usage is >40MB below its limit of
> > > > 100MB but a process is still unnecessarily killed because the decision has
> > > > already been made to oom kill by calling out_of_memory() before the
> > > > initial victim had a chance to uncharge its memory.
> > > 
> > > Could you be more specific about the specific workload please?
> > > 
> > 
> > Robert, could you elaborate on the user-visible effects of this issue that 
> > caused it to initially get reported?
> 
> Yes please, real life usecases are important when adding hacks like this
> one and we should have a clear data to support the check actually helps
> (in how many instances etc...)

Friendly ping.
-- 
Michal Hocko
SUSE Labs
