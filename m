Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213A4C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 16:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2E1A21473
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 16:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587400455;
	bh=hXdqdvStMdt0tN5I2czOifevXXjFsXK/cpNbPz7EVHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=M5lq0Z7qe4jyE1Yu2SiDiYiA1kiZfhTz1w0DnzWQlqwuN3aP05CqMA6Ur5v2bQYEP
	 2V0GrchdusSLyAP7fmv1cRucjRDlSbKMVdrVWNKcjq7xeCZD2hXp5sbcMEkKfHVRwj
	 sZPE98/4Nn/0KcGAyG/Wbu/Gp1tes7kk2l+Fw9r0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgDTQeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 12:34:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725287AbgDTQeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 12:34:13 -0400
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2E2A20775;
        Mon, 20 Apr 2020 16:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587400453;
        bh=hXdqdvStMdt0tN5I2czOifevXXjFsXK/cpNbPz7EVHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0D8LAaLFzEt8AA3I7m6syrw55ULBFted7FhihglL6mxivC0E6Y5omZQfiE02trxNb
         KZ2CU/KKWdsasYMmjJrHS+Co2gp9EIhPNVRkoHt9Lj4PPLsM6x+oDPGwCVq3SvEPp5
         yuXpncSXdm8rPrPhDSFSv06SbCTPExMnOsdsq3b8=
Date:   Mon, 20 Apr 2020 18:34:10 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Li RongQing <lirongqing@baidu.com>
Cc:     peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
        srikar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/isolation: allow isolcpus and nohz_full for
 different cpus
Message-ID: <20200420163409.GB10024@lenoir>
References: <1587027078-16239-1-git-send-email-lirongqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587027078-16239-1-git-send-email-lirongqing@baidu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 04:51:18PM +0800, Li RongQing wrote:
> when both isolcpus and nohz_full are set, their cpus must be
> same now, in fact isolcpus and nohz_full are not related, and
> different cpus are expected for some cases, for example, some
> cores for polling threads wants to isolcpus, and some cores for
> dedicated threads, only nohz_full is expected
> 
> so define two housekeeping mask to save these two configuration
> separately and make cpus same only when both nohz_full and
> isolcpus with nohz are passed into kernel
> 
> fix a build error when CONFIG_CPUMASK_OFFSTACK is not configured
> reported by kbuild test robot <lkp@intel.com>

What is the usecase when you want to affine managed interrupt?
Do you only want to affine IRQ or do you also want to affine
every unbound work, such as kthread, workqueues, timers, etc...?

In the end I would like to group the isolation features that only
make sense together. So we could end up with three cpumasks, one
for "domains", one for "nohz" and one for all "unbound" works.

In fact "domains" should even disappear and become "unbound" +
"load_balance", as that's the desired outcome of having NULL domains.

I'm trying to prepare a suitable interface for all that in cpusets
where we already have the load_balance part.

Thanks.
