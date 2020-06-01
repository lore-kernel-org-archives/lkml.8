Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70399C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 20:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 419C620776
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 20:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591044761;
	bh=WQXsqdoLGClVLzrSpbcYLacxZoOLn5X6I5myDYMuTgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QiR95f5Gx0s/PCzK3sf0Wmn+1Up5uwY/7g4jqiGCSGjOU9qnvCCTELXlUIZ2k/1UM
	 zesy1MnMiqtuEKFe3RnsoGHe2U+rY4LuL1tjE06JC9EcMWjzGhYiF64rtwjrQD/fAN
	 BzHov/iTsyABjLe2FQFVWa2sUUNzsxFWkLrrQs9E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgFAUwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 16:52:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727113AbgFAUwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 16:52:40 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E7AA2076B;
        Mon,  1 Jun 2020 20:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591044759;
        bh=WQXsqdoLGClVLzrSpbcYLacxZoOLn5X6I5myDYMuTgo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dUoMHJ6PIyZBOpHeXjDWZgRcVNQhSZEEYJlEWZqc9TxnZFeu8TjTHhvb0hz9bH5xz
         Lcu/+AMK3MgqBj1uPQxo8hkZcaDY0pN2t28WS+b2ikNA1DteV09ZCraBAiWf1QTbdq
         j5Os35lQfOaFli1vK6e19y+frnHi+Fk2Ph2g2eEM=
Date:   Mon, 1 Jun 2020 16:52:38 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     mingo@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@redhat.com,
        alexey.budankov@linux.intel.com, songliubraving@fb.com,
        acme@redhat.com, allison@lohutok.net
Subject: Re: [PATCH v2 00/12] Fix up liblockdep for 5.7-rc
Message-ID: <20200601205238.GK1407771@sasha-vm>
References: <20200419015754.24456-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200419015754.24456-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping?

On Sat, Apr 18, 2020 at 09:57:42PM -0400, Sasha Levin wrote:
>Hi Ingo,
>
>This series fixes up most of liblockdep to work with the current kernel
>tree.
>
>Change in v2:
>
> - Rebase on top of the 5.7 merge window work.
>
>Sasha Levin (12):
>  tools headers: Add kprobes.h header
>  tools headers: Add rcupdate.h header
>  tools/kernel.h: extend with dummy RCU functions
>  tools bitmap: add bitmap_andnot definition
>  tools/lib/lockdep: add definition required for IRQ flag tracing
>  tools/kernel.h: add BUILD_BUG_ON_NOT_POWER_OF_2 macro
>  tools bitmap: add bitmap_clear definition
>  tools/lib/lockdep: Hook up vsprintf, find_bit, hweight libraries
>  tools/lib/lockdep: Enable building with CONFIG_TRACE_IRQFLAGS
>  tools/lib/lockdep: New stacktrace API
>  tools/lib/lockdep: call lockdep_init_task on init
>  tools/lib/lockdep: switch to using lockdep_init_map_waits
>
> tools/include/linux/bitmap.h                  | 10 ++++++
> tools/include/linux/kernel.h                  | 15 ++++++++
> tools/include/linux/kprobes.h                 |  7 ++++
> tools/include/linux/lockdep.h                 |  9 +++++
> tools/include/linux/rcupdate.h                | 12 +++++++
> tools/include/linux/stacktrace.h              |  8 +++++
> tools/lib/bitmap.c                            | 35 +++++++++++++++++++
> tools/lib/lockdep/Build                       |  2 +-
> tools/lib/lockdep/Makefile                    |  2 +-
> tools/lib/lockdep/include/liblockdep/common.h |  4 +--
> tools/lib/lockdep/include/liblockdep/mutex.h  |  2 +-
> tools/lib/lockdep/include/liblockdep/rwlock.h |  2 +-
> tools/lib/lockdep/lockdep.c                   |  4 +--
> tools/lib/lockdep/preload.c                   |  6 +++-
> 14 files changed, 109 insertions(+), 9 deletions(-)
> create mode 100644 tools/include/linux/kprobes.h
> create mode 100644 tools/include/linux/rcupdate.h
>
>-- 
>2.20.1
>

-- 
Thanks,
Sasha
