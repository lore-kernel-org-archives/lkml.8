Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6272AC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 14:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 354DB21655
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 14:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583764596;
	bh=SagHTacFC7nUvUy/V0aicAWyNUl19D+O0X84xGBwYR4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=js/0iGvSusCyMv5XvmpZMdeceHxn4430qtdUcpAuiI7R93q6c9ns9Fxkexoq/9qP0
	 AJryOl+3OCCV/lHVwpsdAGk+WLViSNn6IanO4s0Zems7uDH6OMmdzItFbuQShtvv8H
	 3GMswxbtObt+YqAIb1WFpUXZBS1aB9RR81uhWx80=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgCIOgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 10:36:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:37794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbgCIOge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 10:36:34 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2B912067C;
        Mon,  9 Mar 2020 14:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583764594;
        bh=SagHTacFC7nUvUy/V0aicAWyNUl19D+O0X84xGBwYR4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=z4OU62tiqctI6JpAwROtj9AshzZtgak8fRMdxDLU71NHK7Trb7flfIV+UrcOzua0i
         l26ifi10dO5vo+vtIROBhhLtKpDcFnaxPFpDBGwVcIQn0D1IffTmzIXwvnSrNU8Rb0
         +TUIMu+p2wPrTatTi7ckYWAsL86o8pASee4a7oGw=
Message-ID: <e3783d060c778cb41b77380ad3e278133b52f57e.camel@kernel.org>
Subject: Re: [locks] 6d390e4b5d: will-it-scale.per_process_ops -96.6%
 regression
From:   Jeff Layton <jlayton@kernel.org>
To:     kernel test robot <rong.a.chen@intel.com>,
        yangerkun <yangerkun@huawei.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkp@lists.01.org, Neil Brown <neilb@suse.de>,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Date:   Mon, 09 Mar 2020 10:36:32 -0400
In-Reply-To: <20200308140314.GQ5972@shao2-debian>
References: <20200308140314.GQ5972@shao2-debian>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-03-08 at 22:03 +0800, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a -96.6% regression of will-it-scale.per_process_ops due to commit:
> 
> 
> commit: 6d390e4b5d48ec03bb87e63cf0a2bff5f4e116da ("locks: fix a potential use-after-free problem when wakeup a waiter")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: will-it-scale
> on test machine: 288 threads Intel(R) Xeon Phi(TM) CPU 7295 @ 1.50GHz with 80G memory
> with following parameters:
> 
> 	nr_task: 100%
> 	mode: process
> 	test: lock1
> 	cpufreq_governor: performance
> 	ucode: 0x11
> 
> test-description: Will It Scale takes a testcase and runs it from 1 through to n parallel copies to see if the testcase will scale. It builds both a process and threads based test in order to see any differences between the two.
> test-url: https://github.com/antonblanchard/will-it-scale
> 
> In addition to that, the commit also has significant impact on the following tests:
> 
> +------------------+----------------------------------------------------------------------+
> > testcase: change | will-it-scale: will-it-scale.per_thread_ops -51.3% regression        |
> > test machine     | 288 threads Intel(R) Xeon Phi(TM) CPU 7295 @ 1.50GHz with 80G memory |
> > test parameters  | cpufreq_governor=performance                                         |
> >                  | mode=thread                                                          |
> >                  | nr_task=100%                                                         |
> >                  | test=lock1                                                           |
> >                  | ucode=0x11                                                           |
> +------------------+----------------------------------------------------------------------+
> 

This is not completely unexpected as we're banging on the global
blocked_lock_lock now for every unlock. This test just thrashes file
locks and unlocks without doing anything in between, so the workload
looks pretty artificial [1].

It would be nice to avoid the global lock in this codepath, but it
doesn't look simple to do. I'll keep thinking about it, but for now I'm
inclined to ignore this result unless we see a problem in more realistic
workloads.

[1]: https://github.com/antonblanchard/will-it-scale/blob/master/tests/lock1.c
-- 
Jeff Layton <jlayton@kernel.org>

