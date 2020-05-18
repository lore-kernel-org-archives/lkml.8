Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABFEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AB8F20643
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgERJGx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 05:06:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53678 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgERJGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 05:06:52 -0400
Received: from mail-pg1-f197.google.com ([209.85.215.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jabjW-0005dA-E9
        for linux-kernel@vger.kernel.org; Mon, 18 May 2020 09:06:50 +0000
Received: by mail-pg1-f197.google.com with SMTP id g1so7495918pgk.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 02:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=fv0kKG3R4oPc9uFx9caWNL7elOwRa1h8BPa4WaUkiiM=;
        b=Ol3uHCvGNu2PMsZx56jvQxKg5IrxKVak2r4M6LXRVPWt1UI+hMd1rQOqEaVYaSYGzN
         NCdS/HOh0TCMKQR0VCqGZ574qSbKelqqd0NTaCP8znKQ24IijdJR59A8ImwFG1ux2fPV
         0u4hAS9v+3+5ItZs09wNyUBa1F+h7JP1N4TGWkBchAzANfwqOojt4z7id5vAUs9euRLN
         5w7+pqHtqLR8lZFLo/H7IzmXrKgX4uFEBo4petqbEu6yQhtmVAEaoGVG7d6ehx72nqy6
         jtymeZVhXS5KMyi+bhlcjLxNrPEtWLaQcB9QhMWnHE64+itnbTusgMm5oAgUkxLYaw3L
         8MkA==
X-Gm-Message-State: AOAM53309IKTgthF5GhbmrkhNiKZAMzQnO7WUqi55zVd19ca3MAKXABS
        wbF/QxHVQSF76hKToy2BUcs7rxdi6knaKGZIgrwHEy4+k5K9YiHFrgZuI7vVXa2kCYLiO0HWoax
        EXIjJrIgtvcAGxpqWVyFwGJ+AjQw5FVQ9CfaC6p4XpA==
X-Received: by 2002:a63:ef09:: with SMTP id u9mr14812921pgh.406.1589792808677;
        Mon, 18 May 2020 02:06:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwRZ2pXW3DEvSMRoiu8LhnK3SCXnElDfQr9CARMhtvMOM3TQfOJr4A6y1/dCWHqF4xIEWWNg==
X-Received: by 2002:a63:ef09:: with SMTP id u9mr14812892pgh.406.1589792808351;
        Mon, 18 May 2020 02:06:48 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id z190sm8256455pfb.1.2020.05.18.02.06.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2020 02:06:47 -0700 (PDT)
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: [Regression] "iommu/amd: Relax locking in dma_ops path" makes tg3
 ethernet transmit queue timeout
Message-Id: <4E9B03FB-9DA5-4831-B4CE-A0AA645D3F22@canonical.com>
Date:   Mon, 18 May 2020 17:06:45 +0800
Cc:     iommu@lists.linux-foundation.org,
        open list <linux-kernel@vger.kernel.org>
To:     jroedel@suse.de
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Broadcom ethernet tg3 unusable after commit 92d420ec028d ("iommu/amd: Relax locking in dma_ops path").
After a short period it stops:
[  122.717144] WARNING: CPU: 0 PID: 0 at net/sched/sch_generic.c:303 dev_watchdog+0x237/0x240()
[  122.717152] NETDEV WATCHDOG: enp3s0 (tg3): transmit queue 0 timed out

After testing the patch section by section, this is the part that caused the regression:

@@ -2578,19 +2580,8 @@ static dma_addr_t map_page(struct device *dev, struct page *page,
 
        dma_mask = *dev->dma_mask;
 
-       spin_lock_irqsave(&domain->lock, flags);
-
-       addr = __map_single(dev, domain->priv, paddr, size, dir, false,
+       return __map_single(dev, domain->priv, paddr, size, dir, false,
                            dma_mask);
-       if (addr == DMA_ERROR_CODE)
-               goto out;
-
-       domain_flush_complete(domain);
-
-out:
-       spin_unlock_irqrestore(&domain->lock, flags);
-
-       return addr;
 }

Particularly, as soon as the spinlock is removed, the issue can be reproduced.
Function domain_flush_complete() doesn't seem to affect the status.

However, the .map_page callback was removed by be62dbf554c5 ("iommu/amd: Convert AMD iommu driver to the dma-iommu api"), so there's no easy revert for this issue.

This is still reproducible as of today's mainline kernel, v5.7-rc6.

Kai-Heng
