Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C509C47258
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 07:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AEE12173E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 07:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uSMKBOO6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbgEAHj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 03:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbgEAHj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 03:39:58 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8C1C035495
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 00:39:56 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 18so1279127pfx.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 00:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=7dbuQPhIsTcQHi6Sc8OBXbUFsIKd1Ghgu7yJHTjcrBA=;
        b=uSMKBOO6QIs4uLVfahwgnBUw2gO5QWpFhQb6F1MFxTptPMF+Z0o/WwC6bov2PX1B+z
         GpMi0QLlCm5bjeCQb1Ib4KAhIABJItLI42QmCZQZGMtFoAd5BloKynNn9kQq3/e29zu2
         9IyjzXDmbfN8mJesTXXH8vGo6U5pKfc97OK3wq90VHEBym+PgXw/vn++YmU/npiUaTr5
         EKndS27RG5ykIcMNfuIjRBSN+x85vpHDVdCcNP20vltiVGnPnJOhrLIPCacJWk+nw8H5
         h/1ZfEiY9PDJtMZv9WMs5aKqGIRak+Cy8hyL1nVn2z4TqrdRTnPu7SgigutOZnbMfMx7
         2gGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7dbuQPhIsTcQHi6Sc8OBXbUFsIKd1Ghgu7yJHTjcrBA=;
        b=iusXlkYu+fsHrc9iNfgQx673pk3V0uf1qBwpx3g5jJ9xMEbHnwSLsC+k8MlPNx10si
         2JYYK8htf9YozZ8wtCOFRSc04pZuZy9czG01yeDXfif+pcsCL0t/yE+3yaq1kYbyWAW7
         KP+Uwx1WhLsEtEoZHwidrrkeMlc8//k3vwGcEm3grVJT/g0aA0eta+7Pwd4ffnXm5YcB
         lvHEZEzqBn3R/NERS4w6a4XF48AbxWpLSnhVpE18QcbyzOOJxSlGOo4BoO4CuqVeCsCA
         h8tsvQWCsTTilnhHHeJFLtiP8w27nfpVdogd539lGaTQkrz349hLUSfMvKP6/KsNrR35
         cI6A==
X-Gm-Message-State: AGi0PuZ42O5gmPALxghsC+vEq5ujCqky6lc3U5PMJstUzuGYvHuNlogx
        +TtAJvucZYdlImii5i00BWnvmg91UnM=
X-Google-Smtp-Source: APiQypJ4tRvRarVqfbdjkqTxsXvJvyOp8AuLCGCLRECI0h2PDJqsBBZbjfCR605Pbtspben2FOegvQ==
X-Received: by 2002:a62:7bcf:: with SMTP id w198mr2002566pfc.226.1588318796201;
        Fri, 01 May 2020 00:39:56 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id w12sm1557841pfq.133.2020.05.01.00.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 00:39:55 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "Andrew F. Davis" <afd@ti.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mm@kvack.org
Subject: [RFC][PATCH 0/4] Support non-default CMA regions to the dmabuf heaps interface
Date:   Fri,  1 May 2020 07:39:45 +0000
Message-Id: <20200501073949.120396-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a much belated second stab at allowing non-default CMA
regions to be exposed via the dmabuf heaps interface.

Previous attempt was here:
 https://lore.kernel.org/lkml/20191025225009.50305-2-john.stultz@linaro.org/T/

This pass tried to take Rob's earlier suggestion to use a flag
property.

Feedback would be greatly welcome!

thanks
-john

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: "Andrew F. Davis" <afd@ti.com>
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Liam Mark <lmark@codeaurora.org>
Cc: Pratik Patel <pratikp@codeaurora.org>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Brian Starkey <Brian.Starkey@arm.com>
Cc: Chenbo Feng <fengc@google.com>
Cc: Alistair Strachan <astrachan@google.com>
Cc: Sandeep Patil <sspatil@google.com>
Cc: Hridya Valsaraju <hridya@google.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: devicetree@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-mm@kvack.org

John Stultz (4):
  devicetree: bindings: Add linux,cma-heap tag for reserved memory
  mm: cma: Add dma_heap flag to cma structure
  dma-buf: cma_heap: Extend logic to export CMA regions tagged with
    "linux,cma-heap"
  example: dts: hi3660-hikey960: Add dts entries to test cma heap
    binding

 .../reserved-memory/reserved-memory.txt        |  3 +++
 .../boot/dts/hisilicon/hi3660-hikey960.dts     |  7 +++++++
 drivers/dma-buf/heaps/cma_heap.c               | 18 +++++++++---------
 include/linux/cma.h                            |  3 +++
 kernel/dma/contiguous.c                        |  3 +++
 mm/cma.c                                       | 11 +++++++++++
 mm/cma.h                                       |  1 +
 7 files changed, 37 insertions(+), 9 deletions(-)

-- 
2.17.1

