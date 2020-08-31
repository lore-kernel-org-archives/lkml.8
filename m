Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCB5C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 22:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 971E32083E
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 22:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598914153;
	bh=SyBMAWu0cxwQBtgnS4hDcUn+0EfPaKGKbNnucXwun6M=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=xMyqHnWaOiiOoOVL9vlLryQJTj+xd0t5oQ4i/jwsxXjToPem7ZCUj1kNugVwVuuKI
	 /aavcJcH4b6ybE5u3xBp6Sip4dGwl6NHztn5oIQLH9C+thbjVyuj3FKogKtGIgUMcS
	 6Ltd59JjmUzqhK3A8sCLmJR2g09NDu8nvGYXgQjc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgHaWtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 18:49:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbgHaWtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 18:49:11 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D68A206FA;
        Mon, 31 Aug 2020 22:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598914151;
        bh=SyBMAWu0cxwQBtgnS4hDcUn+0EfPaKGKbNnucXwun6M=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=0+DZYU6EMhJ1Y8p0o3GA1lRGSjg1jPAY8Lq+56ef8CUleDX70cd3hlIU1k+0BThFQ
         3OPl269afza3IKo8hSHdfzm29E9lAH/Ha7lG1oYjKTvk88VzIK49MIFVovklJ05Pzb
         7d6/S/wGR76rnL++skJPfmPPE7JBaMpNf7VKv1eE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0DD8A35230F1; Mon, 31 Aug 2020 15:49:11 -0700 (PDT)
Date:   Mon, 31 Aug 2020 15:49:11 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Question on task_blocks_on_rt_mutex()
Message-ID: <20200831224911.GA13114@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

The task_blocks_on_rt_mutex() function uses rt_mutex_owner() to
take a snapshot of the lock owner right up front.  At this point,
the ->wait_lock is held, which at first glance prevents the owner
from leaving.  Except that if there are not yet any waiters (that is,
the low-order bit of ->owner is zero), rt_mutex_fastunlock() might
locklessly clear the ->owner field.  And in that case, it looks like
task_blocks_on_rt_mutex() will blithely continue using the ex-owner's
task_struct structure, without anything that I can see that prevents
the ex-owner from exiting.

What am I missing here?

The reason that I am looking into this is that locktorture scenario LOCK05
hangs, and does so leaving the torture_rtmutex.waiters field equal to 0x1.
This is of course a legal transitional state, but I would not expect it
to persist for more than three minutes.  Yet it often does.

This leads me to believe that there is a way for an unlock to fail to wake
up a task concurrently acquiring the lock.  This seems to be repaired
by later lock acquisitions, and in fact setting the locktorture.stutter
module parameter to zero avoids the hang.  Except that I first found the
above apparently unprotected access to what was recently the owner task.

Thoughts?

							Thanx, Paul
