Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8048CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 04:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54CEF2072E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 04:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gJEWN7a7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgFJESi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 00:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgFJESh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 00:18:37 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C59C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 21:18:32 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d66so532828pfd.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 21:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=K0hwNtKfAibOJKiyWU3Z9GaQQI3EVYmF1iagX0XS7wk=;
        b=gJEWN7a7/A5UeFkZQMLzhzfOwv5PGiXLgXIVjALpG57ToRLaUkcY6YZoKjKGYfA/tV
         4JQkJQQ3fUSvGiHkhoY0sMj+mWtQo1UNQhj6IxrSeTu7B4mCW4QIKoxqgdtw3ruGc9yk
         XTd4Of+0FV++GHK1UFOq2yk8ckPg1Z+8bQn1TwMVnfuLnxPe8VoAAlaHfm9oYfrLYwHb
         d4Yhb2G9hqk2Ig5LrVsc4xSnb2LzjfNVakj98+pfkRm6ojd5bNJSBnVNF46mDpfeYjcW
         YjUY8HoLmotQyGFMo9eI3cF8SbQo2EBeXTINqT667/IgDO3s0Uh8h457KDYoftOHivD1
         wHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=K0hwNtKfAibOJKiyWU3Z9GaQQI3EVYmF1iagX0XS7wk=;
        b=OTZWbRwk52mFJvErmMNLWzuC0DVebpGb1Qi/Z2vdNUwcbZl2G+MVczQi61uqlI9TWP
         PWQbhv9bRjTeAQMw6P8wRYDKywPQzIkTRNWS6ktpoSvS7lB7+XIeZjRp6DUzY7/pYi3k
         +Sn+rI3oK1jIx1AbGy+HRjSYuoyDN47DWxoV1OhPzhuP0Dg2SxeRWPhyaN0Sb+6ua3ep
         oDh/xh7kKUvJs20T2oNi63RfShOZ2O6uedFZJQwp57I75D8j95PLnIYY21ZO2JGwkuEh
         ToHYDXgUnvFh1iHBqF6KZuC4fQvW51flNl7VhRd7j2bUT+tngMXQXNY2EPX66AtrteJG
         MohA==
X-Gm-Message-State: AOAM530huItSU0aQSigwofOA0mjooyhpeC3ks+YrrTz6NBzd7XkwaT86
        AemSEW/eqqbs+0hskPoxliyuMg==
X-Google-Smtp-Source: ABdhPJy2hbHFEpC3FXD1wOh+lpyB2FXygfpswDjRSUMDEb2dYdEHtFe2H6RSKJkmOXachpVQ8dioNQ==
X-Received: by 2002:a63:a36e:: with SMTP id v46mr1070419pgn.378.1591762710565;
        Tue, 09 Jun 2020 21:18:30 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.73])
        by smtp.gmail.com with ESMTPSA id w73sm11627476pfd.113.2020.06.09.21.18.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2020 21:18:29 -0700 (PDT)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        jean-philippe <jean-philippe@linaro.org>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [RFC PATCH] PCI: Remove End-End TLP as PASID dependency
Date:   Wed, 10 Jun 2020 12:18:14 +0800
Message-Id: <1591762694-9131-1-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platform devices appear as PCI and have PCI cfg space,
but are actually on the AMBA bus.
They can support PASID via smmu stall feature, but does not
support tlp since they are not real pci devices.
So remove tlp as a PASID dependency.

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/pci/ats.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 390e92f..8e31278 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -344,9 +344,6 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
 	if (WARN_ON(pdev->pasid_enabled))
 		return -EBUSY;
 
-	if (!pdev->eetlp_prefix_path)
-		return -EINVAL;
-
 	if (!pasid)
 		return -EINVAL;
 
-- 
2.7.4

