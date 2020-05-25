Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA66C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 21:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 852452071C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 21:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0Dm69Md"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389295AbgEYVuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 17:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729559AbgEYVuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 17:50:12 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61406C08C5C0
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 14:50:11 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id z6so22118523ljm.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 14:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iEiJkh8NOisGzIdjA2H8Ok8XHFo6aNWnpKwvRPxnlbI=;
        b=F0Dm69MdRLl1SxBsFc77E4osmjMTyNBL9fquMX9me9JytXqkrntX0IB1ESMq2khzr5
         yLJvt9nWa+eIDZ6fzdHAf82L5UJYn06C4sRahqCU0cBjfLoCgHmNaxq0KFTJFaRCvXhc
         Ftu6ItywBCl7PQFZY6hSErjbpHd5VzG+rqhCvHoAHTZ7BarMhuHbAH4mXP8hZ4WgYUZW
         2VgnUpRQ+CXevOpYJQNKZiTj+SRdLTbMIa8E98zZl0B6You97hjFSK3purxPAfsjk5b0
         qrLy3Fs+ur2e3NrQEFbAmjpBlKFq1GiP59sap03Fh4plngauYBQh0O0lzlGnB4lwMdw3
         vavA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iEiJkh8NOisGzIdjA2H8Ok8XHFo6aNWnpKwvRPxnlbI=;
        b=om//RroKLE6+8s7kz2AZS8HsW8G/IjVuIaBA/QKoFqwr6iC06Alj7Uu2ywhAnXwNW0
         ZVE7kaBnMnkzsqlXFCgnPSt0/l1m0VmSnoa0dpswVKaFloIFKa3sVGuNJOGWmc7nWjtc
         r4IbMPuW94dfphoqemDGSFM9DwGO+0Vkn2vuXLWlUQTd92WwaSObpHnHQbYeWQsWyDbN
         vxEfwtj04Okd7xlj+2Lz0/vV6y4drTnC39YfQiZOIPyFUxo+xluQGXSPbLXvAD96595G
         wOg+QGN2hwznU4Et6Wc25h/CMbgj2dvxsoeGqzTn1f4UUjpkTViFMYu61fpbQauHGrw0
         phhg==
X-Gm-Message-State: AOAM532CaHPsn4GjCD/HaQp+P2v1Pss+Sbc5UrlbJR0q7bZomgzdKIw9
        L72WMRwUIULKC/3kU0c0rO8=
X-Google-Smtp-Source: ABdhPJyP8HJlSTai+vcBxS4V7LXTWrEOfp1rNKWJ8hrEnvT9KdNn/GE2gqtjW3JuXID/TJTQaI/afw==
X-Received: by 2002:a2e:8e28:: with SMTP id r8mr13086965ljk.460.1590443409926;
        Mon, 25 May 2020 14:50:09 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-22.NA.cust.bahnhof.se. [158.174.22.22])
        by smtp.gmail.com with ESMTPSA id e21sm3893338ljj.86.2020.05.25.14.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 14:50:09 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] iommu/sun50i: Constify sun50i_iommu_ops
Date:   Mon, 25 May 2020 23:49:58 +0200
Message-Id: <20200525214958.30015-3-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200525214958.30015-1-rikard.falkeborn@gmail.com>
References: <20200525214958.30015-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct sun50i_iommu_ops is not modified and can be made const to
allow the compiler to put it in read-only memory.

Before:
   text    data     bss     dec     hex filename
  14358    2501      64   16923    421b drivers/iommu/sun50i-iommu.o

After:
   text    data     bss     dec     hex filename
  14726    2117      64   16907    420b drivers/iommu/sun50i-iommu.o

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/iommu/sun50i-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index 1fa09ddcebd4..fce605e96aa2 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -771,7 +771,7 @@ static int sun50i_iommu_of_xlate(struct device *dev,
 	return iommu_fwspec_add_ids(dev, &id, 1);
 }
 
-static struct iommu_ops sun50i_iommu_ops = {
+static const struct iommu_ops sun50i_iommu_ops = {
 	.pgsize_bitmap	= SZ_4K,
 	.attach_dev	= sun50i_iommu_attach_device,
 	.detach_dev	= sun50i_iommu_detach_device,
-- 
2.26.2

