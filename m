Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C6EC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 08:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72C7B2467B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 08:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580198940;
	bh=aV67ENHN8dC/CJwfv5vLFhh4K9vIsUsqIvG22EYGVvw=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=njKJlZk6t9zGTZAiYx+zn7l16IzwZ01yl60P7n383gv2c9f2QVw6fus71FKVjgV+X
	 dXg73ib4Egvc9nsZE9l4Fv3idkOFEpTRs+k0xFSegcrPAHOFDWIJtlyLesG1WbAtuV
	 bhuPNCsa08I+jn1TBt94NFszO5/ImktDhONs8wo0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgA1II7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 03:08:59 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:33891 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgA1II7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 03:08:59 -0500
Received: by mail-wr1-f48.google.com with SMTP id t2so14866805wrr.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 00:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=7lIcQfWVmCBP6bQ4+rU2Pi10xllyLCUnOsAfZ2ytPfM=;
        b=YaVyiAbaWy5ecroOYJh3XirYEvqtTxo67kgJEwXvyMz2XiRnAT43UkHEckTxOrNxm2
         7SFzNNNOy6lzCs949AeZ4YlPMhaMX80poxW1zpFQdf+PHb7/KCHX77IHFsll4I1edRQ8
         mjEoXn9tkFS+O9PQOZQm8/IEs6I4dxbAiRZmGMboEvKbCaJCDXKvIB8WRzXGlI3wAit1
         jWbzlZ/s3aDDi/KM0pv7eKr9w6NssyZMri8FiDX45my86xwdwFWSe0mvtkmSLbnFBY5F
         C8W0iIqICYiuMFL9i1cFOhNxTVidNdu5mgH0Teu04YIEH9nbJr2JrUFpa/MC/vzw75sN
         uUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=7lIcQfWVmCBP6bQ4+rU2Pi10xllyLCUnOsAfZ2ytPfM=;
        b=i3xR0FajMvGN/OrhvYr0KF/cUIbHHLDdMEY6B1VyIxTuxLq/Vk3/6nP99umzjnu7TM
         /uiFYdT7Nz//hmjUGCsMygCL6R2tRB1tnQ8Fr2CjRTVVIcNvAuHKkmVEqeNeAs0GO6Pg
         pk8Ds3ipr+U5Oal8bkrB1WRJbu+knN/Usqp4UArZKqJHJDkZsxGPkljHPXuTpSVdG+MW
         sBpRYWkYWuGc2jeDqwI2HJPYE39OisAxlJXsFpACywtUijfQOHRh/bZ6nUzpsrDN1jl4
         aB9iNUp2a3ZrHrfu4CINjTtueM5rZPyQeVzETn3jGZwGX7/4UKmeO8dAS9ddHNzCcwCD
         oUtg==
X-Gm-Message-State: APjAAAXXUSWGM+C8gRfYIW5kVLlvgEN6qKrA/mUSAJqw1ZzjM97pZ/yC
        Ex8RKjf4uBALo/Kqe8c4MTeByvzi
X-Google-Smtp-Source: APXvYqxvv1Ht+0eKgyFuBeOjd8Txi9emYdB08zjq7SUuP3sXzlU/v+kyXn7+lg5yDhqZccp30BKQLw==
X-Received: by 2002:a05:6000:1044:: with SMTP id c4mr28685986wrx.204.1580198937576;
        Tue, 28 Jan 2020 00:08:57 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id n12sm2028171wmi.18.2020.01.28.00.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 00:08:57 -0800 (PST)
Date:   Tue, 28 Jan 2020 09:08:55 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] locking changes for v5.6
Message-ID: <20200128080855.GA105098@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest locking-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-for-linus

   # HEAD: f5bfdc8e3947a7ae489cf8ae9cfd6b3fb357b952 locking/osq: Use optimized spinning loop for arm64

Just a handful of changes in this cycle: an ARM64 performance 
optimization, a comment fix and a debug output fix.

 Thanks,

	Ingo

------------------>
Waiman Long (3):
      locking/lockdep: Fix lockdep_stats indentation problem
      locking/qspinlock: Fix inaccessible URL of MCS lock paper
      locking/osq: Use optimized spinning loop for arm64


 arch/arm64/include/asm/spinlock.h |  9 +++++++++
 kernel/locking/lockdep_proc.c     |  4 ++--
 kernel/locking/osq_lock.c         | 23 ++++++++++-------------
 kernel/locking/qspinlock.c        | 13 +++++++------
 4 files changed, 28 insertions(+), 21 deletions(-)

