Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE50C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 00:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E60F246B7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 00:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jlj7siV1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgCBAFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 19:05:06 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33608 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbgCBAFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 19:05:06 -0500
Received: by mail-pf1-f196.google.com with SMTP id n7so4669024pfn.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 16:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=duQmTYNCdTI2ExbCdQAh/8UU3ifimZfip77jBZoZbNU=;
        b=jlj7siV1TsnOyaF1QtiqKfaebECjBDKmNmm8gEL4qjrYBk63y7xp8jMWhXyNh7Q7X2
         YSv0ijY85X5tt61zI80JKR8FceG+hyKaKTY13aWQdAlQd3TTRF2ASyO3Jzotsl2DI8oy
         dVs0kIJMxRuDvZDgHTR/gjlh32aMfFeoCmer8w1ttzI17Yse52omc1BYOuus4AqYc6I3
         4lt+mnUY60HfrHA7fHcIG72Wghpe4Mp2Z8GPGR3+bVH1wbtPlBBJsAeIizt1rVi8wPBw
         bFDGCbpr9j2QF8iBsvBDvcVib8UNAbqEc2YAoWyY+W/EpJX89VRUfkSA2+tjsSViVIVK
         ZLYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=duQmTYNCdTI2ExbCdQAh/8UU3ifimZfip77jBZoZbNU=;
        b=QGslXT/haoWvVtV9uEJj5rk3zO+BaB1b65O0VwF3oTIC3HJzL4jJ8j30ui1UODdjP5
         iYxoCj5CQTdA8cpTicPc3s26VSc8Enjw+71+rXj5FI2xpAGg235y2RZ6h8cC8DQDktcx
         /VS8fR0G/t1TEhT09sTCvXF5Bhxv6oAD7wrglEUzHbcQ9d05GJ1at4zlTAItwuInEGm0
         qPWqUADWwCYIEUpOQKBmEIUP6hoSCMOx4vai89TkCk+vHHHglA1a7IRUeSAvBPby4qo6
         9BbO+35Hs79Hww0YKLfCG6Pj5ccjFz1SrnRlQc4j50EiqFtLe+xhWT3RSLcNELg4PJA9
         drBw==
X-Gm-Message-State: APjAAAUkWwpdbP4+byN7kfr0u/Q30pJJoGsfGLh+3X+eSvMYIOBrRd1+
        9l7aZAUP8WrhNzzN77vWFmt45Q==
X-Google-Smtp-Source: APXvYqzfZsJg2bBBYco0M4jf0fO2AMzcS3eeNSjht5sN/BOWqYBPfvzUOG6Db9g5GtM1UnO9fzXdPg==
X-Received: by 2002:a63:7e52:: with SMTP id o18mr16843186pgn.46.1583107504654;
        Sun, 01 Mar 2020 16:05:04 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id y16sm18340134pfn.177.2020.03.01.16.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 16:05:03 -0800 (PST)
Date:   Sun, 1 Mar 2020 16:05:03 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Christoph Hellwig <hch@lst.de>,
        Tom Lendacky <thomas.lendacky@amd.com>
cc:     "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Grimm, Jon" <jon.grimm@amd.com>, Joerg Roedel <joro@8bytes.org>,
        baekhw@google.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: [rfc 0/6] unencrypted atomic DMA pools with dynamic expansion
In-Reply-To: <alpine.DEB.2.21.2002280118461.165532@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.2003011535510.213582@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1912311738130.68206@chino.kir.corp.google.com> <b22416ec-cc28-3fd2-3a10-89840be173fa@amd.com> <alpine.DEB.2.21.2002280118461.165532@chino.kir.corp.google.com>
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

These atomic DMA pools are kept unencrypted so they can immediately be
used for non-blocking allocations.  Since the need for this type of memory
depends on the kernel config and devices being used, these pools are also
dynamically expandable.

Some of these patches could be squashed into each other, but they were
separated out to ease code review.

This patchset is based on 5.6-rc4.
---
 arch/x86/Kconfig            |   1 +
 drivers/iommu/dma-iommu.c   |   5 +-
 include/linux/dma-direct.h  |   2 +
 include/linux/dma-mapping.h |   6 +-
 kernel/dma/direct.c         |  17 ++--
 kernel/dma/remap.c          | 173 +++++++++++++++++++++++++-----------
 6 files changed, 140 insertions(+), 64 deletions(-)
