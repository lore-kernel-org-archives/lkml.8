Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E02C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 23:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DCF020725
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 23:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594338878;
	bh=elXY1Y1JhNqOjYMZAWqmWzjsV1fMWzZlD9JnIgaqQ9Y=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=Eh9TpHCL6SRj0wrJ7q+lwenJZwfeWfWOFvn8oQ/3uYqAo5Was74VrDI56eMavTLM6
	 fQU44rieL+7Gq1usitO9qUqzVT/9C2gxsH06/J35MpqV6Xh3QPRIQfGDItjAVRrkHE
	 JYlm40IIhD/PE/OR8iEVeIZnhEQKdnVQMZm6rMkw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgGIXyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 19:54:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:52292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbgGIXyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 19:54:36 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58B9320720;
        Thu,  9 Jul 2020 23:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594338876;
        bh=elXY1Y1JhNqOjYMZAWqmWzjsV1fMWzZlD9JnIgaqQ9Y=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=W79BzHftsScFy+05tzCDtleD6zEByf0DRttB/G+BnBPt36j12Dgmw+j0G6rPCGThK
         wyhM+uH6n4wPgPICfGJ5DY53lpiD4tiMVs/CK72vZhB/pJQXlqyPjpvb39wv6+GTnv
         aEG11CHI7qRXKkOEJFmgezLojGc/OSlqqZ2cmXNI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 425FE3522CE7; Thu,  9 Jul 2020 16:54:36 -0700 (PDT)
Date:   Thu, 9 Jul 2020 16:54:36 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@kernel.org, tglx@linutronix.de,
        bigeasy@linutronix.de, frederic@kernel.org
Subject: [PATCH smp 0/2] Provide CSD lock timeout diagnostics
Message-ID: <20200709235436.GA20922@paulmck-ThinkPad-P72>
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

This is a sneak preview of a series providing diagnostics to help track
down problems that would result in excessive csd_unlock() latencies:

1.	Add source and destination CPUs to __call_single_data.
	I freely admit that I found the union declaration a
	bit confusing!

2.	Provide CSD lock timeout diagnostics.

						Thanx, Paul

------------------------------------------------------------------------

 include/linux/smp.h       |    3 +
 include/linux/smp_types.h |    3 +
 kernel/smp.c              |  135 +++++++++++++++++++++++++++++++++++++++++++++-
 lib/Kconfig.debug         |   10 +++
 4 files changed, 150 insertions(+), 1 deletion(-)
