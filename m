Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE178C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 22:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D9F20733
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 22:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbgC2Wwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 18:52:36 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:58804 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727591AbgC2Wwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 18:52:36 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7E9CC15CD7C3C;
        Sun, 29 Mar 2020 15:52:35 -0700 (PDT)
Date:   Sun, 29 Mar 2020 15:52:32 -0700 (PDT)
Message-Id: <20200329.155232.1256733901524676876.davem@davemloft.net>
To:     torvalds@linux-foundation.org
Cc:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT] Networking
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAHk-=wgoySgT5q9L5E-Bwm_Lsn3w-bzL2SBji51WF8z4bk4SEQ@mail.gmail.com>
References: <20200328.183923.1567579026552407300.davem@davemloft.net>
        <CAHk-=wgoySgT5q9L5E-Bwm_Lsn3w-bzL2SBji51WF8z4bk4SEQ@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 29 Mar 2020 15:52:35 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 28 Mar 2020 19:03:05 -0700

> Btw, your pull request information really leaves something to be desired.
> 
> You seem to have randomly picked one thing from each thing you merged
> (eg that memory leak case from the merge from Steffen Klassert).
> 
> Hmm?

Yeah I could definitely do better, I try to pick the "highlights" but
that didn't work out so definitely this time :-/

Meanwhile, we have a wireless regression, and I'll get the fix for
that to you by the end of today.

Sorry about all of this.
