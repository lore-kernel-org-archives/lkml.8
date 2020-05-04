Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75583C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A1572073E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588615640;
	bh=cjiA2aoQ7vAk0PIsUJfA2z0tb4C6nX3WRSRkZbu7TFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t2sJQskTpniLA3zYCshji8yhmCqXNE4HiXe7xsy1TkHqSvZY0wrwRft+uXf0n7jaz
	 OORoBAtWJQeGyXTa5J1FMwcqChAaY2vQP/cFaL4Y7mIsfth5flYqcDYG7FKayQmpsR
	 /UzXDbeAq1pEmnlBBEQKLR6LkfZJdJwXOjhbURHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732121AbgEDSHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:07:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732104AbgEDSHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:07:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74534207DD;
        Mon,  4 May 2020 18:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588615632;
        bh=cjiA2aoQ7vAk0PIsUJfA2z0tb4C6nX3WRSRkZbu7TFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RP6oYUOaJ6Ija9ChTr0vMsq9sv3nvrRYuYY2u6dXEICqYj8ZNkh2YRQKpymdFeaBd
         UutHnBkGB8twA3XmFCZRoaNQcYbXnR8VuTbiI4R8AyV7aeJ0/CXLLMuRMBTlJUXcYR
         Mz4LUaajnNn4qz4hxGtvdNvhpM9vbcehEpdCDj20=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Will Deacon <will@kernel.org>,
        Joerg Roedel <jroedel@suse.de>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 5.6 60/73] iommu: Properly export iommu_group_get_for_dev()
Date:   Mon,  4 May 2020 19:58:03 +0200
Message-Id: <20200504165509.795667242@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504165501.781878940@linuxfoundation.org>
References: <20200504165501.781878940@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit ae74c19faa7d7996e857e13165bd40fc4a285e0d upstream.

In commit a7ba5c3d008d ("drivers/iommu: Export core IOMMU API symbols to
permit modular drivers") a bunch of iommu symbols were exported, all
with _GPL markings except iommu_group_get_for_dev().  That export should
also be _GPL like the others.

Fixes: a7ba5c3d008d ("drivers/iommu: Export core IOMMU API symbols to permit modular drivers")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Will Deacon <will@kernel.org>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: John Garry <john.garry@huawei.com>
Cc: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20200430120120.2948448-1-gregkh@linuxfoundation.org
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iommu/iommu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1428,7 +1428,7 @@ struct iommu_group *iommu_group_get_for_
 
 	return group;
 }
-EXPORT_SYMBOL(iommu_group_get_for_dev);
+EXPORT_SYMBOL_GPL(iommu_group_get_for_dev);
 
 struct iommu_domain *iommu_group_default_domain(struct iommu_group *group)
 {


