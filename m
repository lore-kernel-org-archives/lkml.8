Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B31DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 11:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2856020820
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 11:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591011612;
	bh=cwbptBQG0lst/6qxen2gXTCjoNh0Opi1g+edQ2IpEk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GBs/UbfWMQXOZt0yKJ8P76TYZ81bG81eSVUqiPRpKyM3xkBLyXbpJ1DzqQj11kpAX
	 JAlej+uKXQgxVKh9sJI7Y8I5mV2aiTAPIw/TX+gXB9dRb0SLoxEMP/Q2kKMpH/gyvr
	 VN9iW35TWn+5X5IgqeY+psNt9wRqovoXZCvdcCuc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbgFALkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 07:40:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgFALkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 07:40:11 -0400
Received: from localhost (lfbn-ncy-1-324-171.w83-196.abo.wanadoo.fr [83.196.159.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05254207FB;
        Mon,  1 Jun 2020 11:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591011610;
        bh=cwbptBQG0lst/6qxen2gXTCjoNh0Opi1g+edQ2IpEk0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wnr+cXKEsqxQv7bmTMgkk0NyNBryNAz8+E9CW3e60LVcZ72QW13gfQVUrR19cQmm6
         K7oIuxAYqgAq4JDpoITcwJPWJlUqhIHakmEIXxkvxcW/IGFNjB3+m9ar8b+PKn1KIO
         VfJ8W4t2ZrLHDh0ZujEsNCzHP66Qx/lJyHJJSOkc=
Date:   Mon, 1 Jun 2020 13:40:08 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Cc:     linux-tip-commits@vger.kernel.org, Qian Cai <cai@lca.pw>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        mgorman@techsingularity.net, x86 <x86@kernel.org>
Subject: Re: [tip: sched/core] sched: Fix smp_call_function_single_async()
 usage for ILB
Message-ID: <20200601114007.GA20995@lenoir>
References: <20200526161907.778543557@infradead.org>
 <159100514169.17951.11938781317668210343.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159100514169.17951.11938781317668210343.tip-bot2@tip-bot2>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 09:52:21AM -0000, tip-bot2 for Peter Zijlstra wrote:
> The following commit has been merged into the sched/core branch of tip:
> 
> Commit-ID:     19a1f5ec699954d21be10f74ff71c2a7079e99ad
> Gitweb:        https://git.kernel.org/tip/19a1f5ec699954d21be10f74ff71c2a7079e99ad
> Author:        Peter Zijlstra <peterz@infradead.org>
> AuthorDate:    Tue, 26 May 2020 18:10:58 +02:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Thu, 28 May 2020 10:54:15 +02:00
> 
> sched: Fix smp_call_function_single_async() usage for ILB
> 
> The recent commit: 90b5363acd47 ("sched: Clean up scheduler_ipi()")
> got smp_call_function_single_async() subtly wrong. Even though it will
> return -EBUSY when trying to re-use a csd, that condition is not
> atomic and still requires external serialization.
> 
> The change in kick_ilb() got this wrong.
> 
> While on first reading kick_ilb() has an atomic test-and-set that
> appears to serialize the use, the matching 'release' is not in the
> right place to actually guarantee this serialization.
> 
> Rework the nohz_idle_balance() trigger so that the release is in the
> IPI callback and thus guarantees the required serialization for the
> CSD.
> 
> Fixes: 90b5363acd47 ("sched: Clean up scheduler_ipi()")
> Reported-by: Qian Cai <cai@lca.pw>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: mgorman@techsingularity.net
> Link: https://lore.kernel.org/r/20200526161907.778543557@infradead.org

Many patches in the series lack some Reviewed-by tags.

Thanks.
