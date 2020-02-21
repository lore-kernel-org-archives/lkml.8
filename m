Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C84C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D6C324650
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582285455;
	bh=XlkurcWvOdbAlHwepPog2OjnadfMkPfYhanEHX/B9no=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=K81eeXYl2ZVaTQxD2mF0+Vne6ZBKYW1/FGCZsn7Pm4Xr4++u+bou4Nt/LRfkk8IBU
	 5I5h+WW3HstkiM68hvWK3aaP/vCDXTZdg3J3EIaYJtgqFIODeHaCW9NgmKJ8HobDpQ
	 pKwSCyButn5LJk8k2zP/mDU3LAZHIdkFGj8i6WHw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbgBULoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 06:44:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:42832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726909AbgBULoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 06:44:13 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 679B0222C4;
        Fri, 21 Feb 2020 11:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582285453;
        bh=XlkurcWvOdbAlHwepPog2OjnadfMkPfYhanEHX/B9no=;
        h=From:To:Cc:Subject:Date:From;
        b=s8C7l30ZeWRptTjjHJCZ7Dw239cSvoh2oPBVwb/hwhgaNCQ+niYrwrGNhjxZyy/Nz
         WmkGsiX/n7vL0d6ffxlZ9MGEkuSvSRQbQbQW3afuoXL7j3bm52zXzlbYPq3ENzw7HI
         XA43AYnpYLNRsysg4qCgcnX96BrCKLdz8ZHRZIrM=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, akpm@linux-foundation.org,
        Will Deacon <will@kernel.org>,
        "K . Prasad" <prasad@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Quentin Perret <qperret@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 0/3] Unexport kallsyms_lookup_name() and kallsyms_on_each_symbol()
Date:   Fri, 21 Feb 2020 11:44:01 +0000
Message-Id: <20200221114404.14641-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Despite having just a single modular in-tree user that I could spot,
kallsyms_lookup_name() is exported to modules and provides a mechanism
for out-of-tree modules to access and invoke arbitrary, non-exported
kernel symbols when kallsyms is enabled.

This patch series fixes up that one user and unexports the symbol along
with kallsyms_on_each_symbol(), since that could also be abused in a
similar manner.

Cheers,

Will

Cc: K.Prasad <prasad@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Quentin Perret <qperret@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>

--->8

Will Deacon (3):
  samples/hw_breakpoint: Drop HW_BREAKPOINT_R when reporting writes
  samples/hw_breakpoint: Drop use of kallsyms_lookup_name()
  kallsyms: Unexport kallsyms_lookup_name() and
    kallsyms_on_each_symbol()

 kernel/kallsyms.c                       |  2 --
 samples/hw_breakpoint/data_breakpoint.c | 11 ++++++++---
 2 files changed, 8 insertions(+), 5 deletions(-)

-- 
2.25.0.265.gbab2e86ba0-goog

