Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9BDC352BE
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 00:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CB6D2076B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 00:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LJKP9ekR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634547AbgDOAE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 20:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbgDOAEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 20:04:52 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83261C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 17:04:52 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t4so565627plq.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 17:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=9sAv1VN5EHJYZMrc5W3hn8v84B5WLiBXmj1ZlRYwv5k=;
        b=LJKP9ekRVjrczRzWFYpENLjwjVXF3zdmaqJ/JFc1pSY2R3iC/CByObkBIDxDA+K26e
         80PmMHYhalYwRWIxUwy0R/+9A/CybyFDb3fQ8mgmD56W5RXgIGgWnO52OJKFEPRnjdY4
         /MAGh+KOfUIR4fdxE6TD8dSFKUARBFfJz2NITB0tFq3rHU01NLecmmjlPWGFPzLlx5bK
         pAuB5BcQr3XKZE/Rwt0+P7Wimj1ykmlIBN/AjkKd7m3upkM2uQGfKexQaooLHSmC4W0V
         SWx0SW6syfH9MiCSM/REU1Int4BqdM2tlulRJ6/ro822O0LXAEeU9iJX11yi0TtGM46x
         fXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=9sAv1VN5EHJYZMrc5W3hn8v84B5WLiBXmj1ZlRYwv5k=;
        b=B6Wf9cNxWDsqmdLTPOBOzYGzdRrwEzmdeno5AVgp1zqdxBpLlo2owLXs0u1sEPN1YK
         eDRkPtCTHQiwRAntUhnbnClaIrKGaaslqAPFZkU/z1oi+KRGkgnpXqaDPfES8wVZWXBJ
         mZXdkyL9HqUZu92PYxh9wa5nNy8Kiy4paUAEq9yUub+miXlm50LF8yvpBxHBFddbCsSN
         eYM12XOZqCiEKLwdlSXn0D0NHTPB5n9a9Swny7ejOG+nC2sY9USJEBqcUEecCZ5fI14I
         JRHMOZYax4iFI4L1ogo+ZwEs4ur5I+tC+pl/fyyTzA9acWa4mG4JX5MTT5IPXFdrtjh3
         5HCQ==
X-Gm-Message-State: AGi0PubvdEGO9G/RqV7Dh6IJVWixwdwXcngQ2zvgM80gYYNxtI/QsMn6
        Iw3gvQz/+512cikKMuYk6qcIBw==
X-Google-Smtp-Source: APiQypK98tyTd/KevIl3fxm0IIe9EmtjEsqtvMJvZnnzaKdB0nFTK4nEy9awjtJ71/AIZH54kDbepg==
X-Received: by 2002:a17:902:968a:: with SMTP id n10mr2231605plp.96.1586909091613;
        Tue, 14 Apr 2020 17:04:51 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id g22sm5108300pju.21.2020.04.14.17.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 17:04:51 -0700 (PDT)
Date:   Tue, 14 Apr 2020 17:04:50 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Christoph Hellwig <hch@lst.de>,
        Tom Lendacky <thomas.lendacky@amd.com>
cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Jon Grimm <jon.grimm@amd.com>, Joerg Roedel <joro@8bytes.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Subject: [patch 0/7] unencrypted atomic DMA pools with dynamic expansion
Message-ID: <alpine.DEB.2.22.394.2004141700480.68516@chino.kir.corp.google.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
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

The sizes of the various atomic DMA pools is exported through debugfs at
/sys/kernel/debug/dma_pools.

This patchset is based on latest Linus HEAD:

commit 8632e9b5645bbc2331d21d892b0d6961c1a08429
Merge: 6cc9306b8fc0 f3a99e761efa
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue Apr 14 11:58:04 2020 -0700

    Merge tag 'hyperv-fixes-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux
---
 arch/x86/Kconfig            |   1 +
 drivers/iommu/dma-iommu.c   |   5 +-
 include/linux/dma-direct.h  |   2 +
 include/linux/dma-mapping.h |   6 +-
 kernel/dma/Kconfig          |   6 +-
 kernel/dma/Makefile         |   1 +
 kernel/dma/direct.c         |  56 ++++++--
 kernel/dma/pool.c           | 275 ++++++++++++++++++++++++++++++++++++
 kernel/dma/remap.c          | 114 ---------------
 9 files changed, 334 insertions(+), 132 deletions(-)
 create mode 100644 kernel/dma/pool.c
