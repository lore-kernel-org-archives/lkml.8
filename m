Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEBDC10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0F022525
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583780982;
	bh=3O79TieOFkUtHzE2g9CcJtw3BUGz8I3DPEqMzui1lOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pGNqseMZ14XkWKu6P6LSnXk5r1nyvqsWPslx1zzReYp3yAYXJQy2u0VssAmhCM5tt
	 Xie5mjHKl4hkP60fLnP7Asxb0Qyd0b8utZZ0U0Di0jgUeSsujs3dnCHPozaI0zZnJl
	 f5tD417bkGqZDWkB1BTqThsoioA5K1MKu/Ev7P+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgCITJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 15:09:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:50406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727431AbgCITJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:09:41 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DF5421D56;
        Mon,  9 Mar 2020 19:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583780980;
        bh=3O79TieOFkUtHzE2g9CcJtw3BUGz8I3DPEqMzui1lOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ACuP46S47HN6vyvYQy3/e6RabkHsldNOldpcLHPLZrZWwPSs1Dz4pHgQNNFcaCpRi
         xm1wNMlbAmW4CTyxjVwkFvg9OknITsRPpwFTT3FLtblIr4aHrBGYo+NquA5PpxP7A/
         ZbMv0X1SRytHO5nf8jAQGsUPDKiWP7rn2iUQw4Ds=
Date:   Mon, 9 Mar 2020 12:09:39 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkp@lists.01.org
Subject: Re: [fscrypt] 22d94f493b: will-it-scale.per_thread_ops 1.7%
 improvement
Message-ID: <20200309190939.GD1073@sol.localdomain>
References: <20200308140241.GP5972@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200308140241.GP5972@shao2-debian>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 08, 2020 at 10:02:41PM +0800, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a 1.7% improvement of will-it-scale.per_thread_ops due to commit:
> 
> 
> commit: 22d94f493bfb408fdd764f7b1d0363af2122fba5 ("fscrypt: add FS_IOC_ADD_ENCRYPTION_KEY ioctl")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: will-it-scale
> on test machine: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
> with following parameters:
> 
> 	nr_task: 50%
> 	mode: thread
> 	test: poll2
> 	cpufreq_governor: performance
> 	ucode: 0x500002c
> 
> test-description: Will It Scale takes a testcase and runs it from 1 through to n parallel copies to see if the testcase will scale. It builds both a process and threads based test in order to see any differences between the two.
> test-url: https://github.com/antonblanchard/will-it-scale

This looks like a flaky test.  That commit shouldn't have had any effect on this
performance test, either positive or negative.

- Eric
