Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873FCC2BA1B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 21:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D6420771
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 21:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hlOzkl87"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbgDHVVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 17:21:07 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:40185 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730241AbgDHVVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 17:21:04 -0400
Received: by mail-pj1-f65.google.com with SMTP id kx8so355997pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 14:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=AEQOYfD6KlwbjpX4Ij2ibJALe8Dqd/dC0Q9YV1bU9hM=;
        b=hlOzkl87l7nIU+B8Bum98roZyLl+ZMfJaTcRH7l/jQD6zH0udwiDBMGFstrB8ng5dY
         ESKBaujmUSYHqDlGCZi9sGtznbnc7plwdSbkEbKbunNkDwRbGGCqKl7WVAxMvpUuA4co
         vSNBNfPhXyuW7QZtSn5Hwuaphia3Y8qH1NGmpZi8hrcCraK36cefKtgFRchBtrdFW5jM
         DdLBpPsToRtf1raWBc/uoZxRrnB9RstWkcw5FHPtCtSQY7QWoSaalfTo096teDYbu1Kd
         LO5DBnriEvfsf/nnj5+xkPuFlCkzLPntys7HEo6jpLzoLxrugLLtshtfai3YL527HtMj
         bxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=AEQOYfD6KlwbjpX4Ij2ibJALe8Dqd/dC0Q9YV1bU9hM=;
        b=VtF+JS3CrdypGg4E2oEOWcS7FXcTFYi7zdROYSTqTeEiFCiSRhyJzVQi7OcffGlCbD
         O7a+a44rIsr0KKLeJ1s7Pl3SRpZ3WIrVyrseVhkY24glFTBkDqsoruoFGqPUSOhUUZLd
         NL4zWtSN4Rz+7NaL70QwY3Y6s9qNh+unqhx6WE2VxSXsxZEGSzdmjJXQ+7zaBnsMz7VE
         0lKxba/kToj/oZ8P2bp1p7ivFcQBrWf6gCbGHHukSgytNiWAGOGiiO9RqzNSoDA3zyPm
         3J8JBFnkCNERHTg+G9z4qtfoO/2i1pqp4lMMAMdPxiJxcxB/trRC8BqcdX64RRy95fdv
         WStg==
X-Gm-Message-State: AGi0PualBvRNzYpbd4tq189BClkjunI2GWJoD8L5t+2RvNG1lvsPKdkP
        21bRPYPYY6QqiDtd6RtKTz4PjCkcR9U=
X-Google-Smtp-Source: APiQypJDTfKjj7sgndXs5WeoWJl3rB/YtX+gIS/e9waoz46kcPWNFgoMgqM01OpNU49jLWl4Zbw8QA==
X-Received: by 2002:a17:90a:aa0e:: with SMTP id k14mr7567767pjq.74.1586380862157;
        Wed, 08 Apr 2020 14:21:02 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id 63sm17497048pfx.132.2020.04.08.14.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 14:21:01 -0700 (PDT)
Date:   Wed, 8 Apr 2020 14:21:00 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Christoph Hellwig <hch@lst.de>,
        Tom Lendacky <thomas.lendacky@amd.com>
cc:     "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Grimm, Jon" <jon.grimm@amd.com>, Joerg Roedel <joro@8bytes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: [rfc v2 0/6] unencrypted atomic DMA pools with dynamic expansion
In-Reply-To: <alpine.DEB.2.21.2003011535510.213582@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.2004081418490.19661@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1912311738130.68206@chino.kir.corp.google.com> <b22416ec-cc28-3fd2-3a10-89840be173fa@amd.com> <alpine.DEB.2.21.2002280118461.165532@chino.kir.corp.google.com> <alpine.DEB.2.21.2003011535510.213582@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set_memory_decrypted() may block so it is not possible to do non-blocking
allocations through the DMA API for devices that required unencrypted
memory.

The solution is to expand the atomic DMA pools for the various possible
gfp requirements as a means to prevent an unnecessary depletion of lowmem.
These atomic pools are separated from the remap code and can be selected
for configurations that need them outside the scope of
CONFIG_DMA_DIRECT_REMAP, such as CONFIG_AMD_MEM_ENCRYPT.

These atomic DMA pools are kept unencrypted so they can immediately be
used for non-blocking allocations.  Since the need for this type of memory
depends on the kernel config and devices being used, these pools are also
dynamically expandable.

There are a number of changes to v1 of the patchset based on Christoph's
feedback and the separation of the atomic pools out into the new
kernel/dma/pool.c.

NOTE!  I'd like eyes from Christoph specifically on patch 4 in the series
where we handle the coherent pools differently depending on
CONFIG_DMA_COHERENT_POOL and/or CONFIG_DMA_DIRECT_REMAP and from Thomas
on the requirement for set_memory_decrypted() for all DMA coherent pools.

Why still an RFC?  We are starting to aggressively test this series but
since there were a number of changes that were requested for the first
RFC, it would be better to have feedback and factor that into the series
earlier rather than later so testing can be focused on a series that
could be merged upstream.

This patchset is based on latest Linus HEAD:

commit ae46d2aa6a7fbe8ca0946f24b061b6ccdc6c3f25
Author: Hillf Danton <hdanton@sina.com>
Date:   Wed Apr 8 11:59:24 2020 -0400

    mm/gup: Let __get_user_pages_locked() return -EINTR for fatal signal
---
 arch/x86/Kconfig            |   1 +
 drivers/iommu/dma-iommu.c   |   5 +-
 include/linux/dma-direct.h  |   2 +
 include/linux/dma-mapping.h |   6 +-
 kernel/dma/Kconfig          |   6 +-
 kernel/dma/Makefile         |   1 +
 kernel/dma/direct.c         |  28 ++++-
 kernel/dma/pool.c           | 224 ++++++++++++++++++++++++++++++++++++
 kernel/dma/remap.c          | 114 ------------------
 9 files changed, 261 insertions(+), 126 deletions(-)
 create mode 100644 kernel/dma/pool.c

