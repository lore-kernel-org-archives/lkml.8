Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50477C2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB50206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgDFSZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 14:25:30 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57986 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgDFSZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 14:25:30 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8DB6515DB0249;
        Mon,  6 Apr 2020 11:25:29 -0700 (PDT)
Date:   Mon, 06 Apr 2020 11:25:28 -0700 (PDT)
Message-Id: <20200406.112528.895031681027517472.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Sparc
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 06 Apr 2020 11:25:29 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


A per-device DMA ops conversion for sparc32 by Chrstioph Hellwig.

Please pull, thanks a lot!

The following changes since commit bef7b2a7be28638770972ab2709adf11d601c11a:

  Merge tag 'devicetree-for-5.7' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux (2020-04-02 17:32:52 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to 255a69a94b8cbbcfef142137b5e7f99b5d168771:

  sparc32: use per-device dma_ops (2020-04-02 18:11:55 -0700)

----------------------------------------------------------------
Christoph Hellwig (1):
      sparc32: use per-device dma_ops

 arch/sparc/include/asm/dma-mapping.h | 15 ++-------------
 arch/sparc/kernel/ioport.c           |  3 ---
 arch/sparc/kernel/of_device_common.c |  1 +
 arch/sparc/mm/io-unit.c              |  9 ++++-----
 arch/sparc/mm/iommu.c                | 15 ++++++++-------
 arch/sparc/mm/mm_32.h                |  3 ---
 arch/sparc/mm/srmmu.c                |  4 +---
 7 files changed, 16 insertions(+), 34 deletions(-)
