Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF61C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 11:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6665D20663
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 11:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cSls9zjl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732024AbgEZLuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 07:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732012AbgEZLuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 07:50:16 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E79C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 04:50:16 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x11so7609222plv.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 04:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rzP5fzn/E340EPlW7gDpFBlyEkfSVaF1oJz6fYo76k8=;
        b=cSls9zjl0whNH0eR/l2i02O95OOhgGrNGwM26ZGFvkQW9VtZxJfxlywizJRke/rmbm
         DjeTG2qfQRIUFCJCYqf3IQGjZY5BYNOiPnuTiljaUSiUooWYyRzwspOmUiqDqG0M0ZC0
         NH/f8WAxs2sULx5ClU2rSJ/IVPF1eLlml+6rdIo1i25jIwEm+AfsqPAhvJRo8r0X4r3K
         IiHWdbIh+eGq5kqb6u0B/VzWcIY6fcWtE+dhbKonQdK7ew/58LBw5We1pNCxs/7oweP5
         Jjm4EUWxVNg2+Xy8U6NcCfQFYKXK3ubEYUyGEqX5s/R/MQ0L946l4eUlakQO2SpHpvOw
         LfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rzP5fzn/E340EPlW7gDpFBlyEkfSVaF1oJz6fYo76k8=;
        b=C4NoJBo/6mcEzVh4oaLWpaXZkVxmtg3m8wIX224e0t7exaVLM6G/aQscB5KJx+IfIu
         vv4udL70HbiMFvBKYKXv3jsJna7KWHuhLdYYyetffapTSt8ASRIpuJb8pP3CoJ1ikJwd
         alBxn5Jm//gzoJCzDm4glweYBn2Irjz0ydQ9P2EuIlvhcFFsqwbGM74eB3LwRwTPvss4
         y1b19iJQdyU4rL8LUeh59Ug86wmtbHG+gMxQL097YfrrQnXDWJLlSnQL9yrmQyFN3BOf
         bKphMYg4MlVX4FBTrbE97Ghn0PzfTnZadL7LG2eFWKcbKB2VJtNNkAk/ENPYxUhg3Rf3
         tYjQ==
X-Gm-Message-State: AOAM530YrzRBy2QPCQUuKZoxdrywqv7oSlHk41R8e+v06Lwe/AOSVW62
        PL1Kz+Ba7VcU846bx39Hu3dXig==
X-Google-Smtp-Source: ABdhPJzHFiU9uQ9tpgEPP89QRh+ApddGGVo2/M4MgxGlH4yKc3wRc1jVL2ox1xaiLvr1T78JAyGRGQ==
X-Received: by 2002:a17:90a:4809:: with SMTP id a9mr26082742pjh.196.1590493816386;
        Tue, 26 May 2020 04:50:16 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.9])
        by smtp.gmail.com with ESMTPSA id c12sm15586567pjm.46.2020.05.26.04.50.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 May 2020 04:50:16 -0700 (PDT)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        jean-philippe <jean-philippe@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH 2/2] iommu: calling pci_fixup_iommu in iommu_fwspec_init
Date:   Tue, 26 May 2020 19:49:09 +0800
Message-Id: <1590493749-13823-3-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590493749-13823-1-git-send-email-zhangfei.gao@linaro.org>
References: <1590493749-13823-1-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling pci_fixup_iommu in iommu_fwspec_init, which alloc
iommu_fwnode. Some platform devices appear as PCI but are
actually on the AMBA bus, and they need fixup in
drivers/pci/quirks.c handling iommu_fwnode.
So calling pci_fixup_iommu after iommu_fwnode is allocated.

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/iommu/iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 7b37542..fb84c42 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2418,6 +2418,10 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 	fwspec->iommu_fwnode = iommu_fwnode;
 	fwspec->ops = ops;
 	dev_iommu_fwspec_set(dev, fwspec);
+
+	if (dev_is_pci(dev))
+		pci_fixup_device(pci_fixup_iommu, to_pci_dev(dev));
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(iommu_fwspec_init);
-- 
2.7.4

