Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B37C18E5A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7AB520637
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583915944;
	bh=1ypkZigz8H7QMG1SYMZpTh72qlp3GGyzzWk3Y+8utJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=w9EH5ASoO+ojQK2B7IQGMSXqlcWeRYr494QkGlLmUE8xtxYjcn+EmcSazxU4vzk6W
	 i9DlUYqKXoAW9OpUPdLBJl47z3g5KN/sbKgbhduXGROsNYgvonATOVJWSvaHTphrng
	 nLJ9+iuTFAu9Wp3h8oQzIuW+i5UwBKwa/SrMBJwo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbgCKIjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 04:39:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44659 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728263AbgCKIjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 04:39:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id l18so1395918wru.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 01:39:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C83D13RbbLMx100lu80tj5F+qur1iKkMPkCCyf8642M=;
        b=qgmR9LE0krcismS1swJKI4gB90CjjCXHhgw83BxO8WRSBjMPILGxZ4XkBGSn1FUHyn
         LRtAIscXPPjirZ6py0Bkkl1Vwd6topbKsuSTtwku04iMbpMxXsExfNbkHT/LLV5rj6TA
         TmPfLdtq59s9BjiGHeh6dQx8gz5Z8KhLxxpzbmqyzLlV0OzkeLbtubd54S7r+MRZ5iiQ
         3MHOnKMOP99/1sUua6ZczQkIfT0ZCMu+7A5a0sbCmr47Wb9DPhsIp9xvYUKAAquRjg34
         0qtGH2y5w/QZpeIsxoU9CIHB+0w3mFFuTZjhXIEiUVHGVjr0wJ5yaJ1hSRgNP0Q5SxqK
         5meg==
X-Gm-Message-State: ANhLgQ2DEKdwCNMqbRscuUvIKGtG9NE5tCF4q3Xaa5qOtLl3OUI3xYhw
        KMUtH+dDlubCOcFDr5VGTfqUwzQS
X-Google-Smtp-Source: ADFU+vs7t+U0ceJGkiZIaqRViEUlJVUvfjKGh7J9G6TaUk8MKCJbZ3ArKDHjsJXiBHb/gwLkAl4WmA==
X-Received: by 2002:adf:f105:: with SMTP id r5mr3155919wro.314.1583915941473;
        Wed, 11 Mar 2020 01:39:01 -0700 (PDT)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id n2sm1455019wrr.62.2020.03.11.01.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 01:39:00 -0700 (PDT)
Date:   Wed, 11 Mar 2020 09:39:00 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Robert Kolchmeyer <rkolchmeyer@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch] mm, oom: make a last minute check to prevent unnecessary
 memcg oom kills
Message-ID: <20200311083900.GC23944@dhcp22.suse.cz>
References: <alpine.DEB.2.21.2003101454580.142656@chino.kir.corp.google.com>
 <20200310221938.GF8447@dhcp22.suse.cz>
 <alpine.DEB.2.21.2003101547090.177273@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2003101547090.177273@chino.kir.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-03-20 15:54:44, David Rientjes wrote:
> On Tue, 10 Mar 2020, Michal Hocko wrote:
> 
> > On Tue 10-03-20 14:55:50, David Rientjes wrote:
> > > Killing a user process as a result of hitting memcg limits is a serious
> > > decision that is unfortunately needed only when no forward progress in
> > > reclaiming memory can be made.
> > > 
> > > Deciding the appropriate oom victim can take a sufficient amount of time
> > > that allows another process that is exiting to actually uncharge to the
> > > same memcg hierarchy and prevent unnecessarily killing user processes.
> > > 
> > > An example is to prevent *multiple* unnecessary oom kills on a system
> > > with two cores where the oom kill occurs when there is an abundance of
> > > free memory available:
> > > 
> > > Memory cgroup out of memory: Killed process 628 (repro) total-vm:41944kB, anon-rss:40888kB, file-rss:496kB, shmem-rss:0kB, UID:0 pgtables:116kB oom_score_adj:0
> > > <immediately after>
> > > repro invoked oom-killer: gfp_mask=0xcc0(GFP_KERNEL), order=0, oom_score_adj=0
> > > CPU: 1 PID: 629 Comm: repro Not tainted 5.6.0-rc5+ #130
> > > Call Trace:
> > >  dump_stack+0x78/0xb6
> > >  dump_header+0x55/0x240
> > >  oom_kill_process+0xc5/0x170
> > >  out_of_memory+0x305/0x4a0
> > >  try_charge+0x77b/0xac0
> > >  mem_cgroup_try_charge+0x10a/0x220
> > >  mem_cgroup_try_charge_delay+0x1e/0x40
> > >  handle_mm_fault+0xdf2/0x15f0
> > >  do_user_addr_fault+0x21f/0x420
> > >  async_page_fault+0x2f/0x40
> > > memory: usage 61336kB, limit 102400kB, failcnt 74
> > > 
> > > Notice the second memcg oom kill shows usage is >40MB below its limit of
> > > 100MB but a process is still unnecessarily killed because the decision has
> > > already been made to oom kill by calling out_of_memory() before the
> > > initial victim had a chance to uncharge its memory.
> > 
> > Could you be more specific about the specific workload please?
> > 
> 
> Robert, could you elaborate on the user-visible effects of this issue that 
> caused it to initially get reported?

Yes please, real life usecases are important when adding hacks like this
one and we should have a clear data to support the check actually helps
(in how many instances etc...)
-- 
Michal Hocko
SUSE Labs
