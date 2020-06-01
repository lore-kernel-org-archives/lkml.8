Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FFFC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 478D62074B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591034720;
	bh=ttal6Socy+wf1TW4ZGub8oJIz1dz2K1N+AjsjsnUzuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZhVDRu+6sQ7F9kOzPqKjkoGUQLJ5S+2FhmQa20vViK6iZ+tZafLS6Jb1wDTfXo0Ls
	 WdYxifx7FbVtKGEE5Nz+c+Z3pKhLV08Z+DVSR/eNuTpakdx0XbzPvVqlRVIYCnQz9R
	 Ci4Tl+V/4ncyDV1jvbUx6QkvhV3unfszptJMkw+8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgFASFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:05:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:49944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730277AbgFASE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:04:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A5A92077D;
        Mon,  1 Jun 2020 18:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034698;
        bh=ttal6Socy+wf1TW4ZGub8oJIz1dz2K1N+AjsjsnUzuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D4z8yf9i+parUJBrwZ8TbJyC1l/A3NxLLKQPZlBI7dXxc18DDDzVGV2uD2gZ7xrC5
         AdI9hiJKXdR4ZsA0kPQHN2UK0VDDgXym0//2g59iM6CXwblYUD5PYKz3FRW3BDBigq
         KFUkIXFKVw8eKzOzk3t35zGZcB3YPOFNjg/OQ0ls=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 68/95] iommu: Fix reference count leak in iommu_group_alloc.
Date:   Mon,  1 Jun 2020 19:54:08 +0200
Message-Id: <20200601174031.616996019@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174020.759151073@linuxfoundation.org>
References: <20200601174020.759151073@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

[ Upstream commit 7cc31613734c4870ae32f5265d576ef296621343 ]

kobject_init_and_add() takes reference even when it fails.
Thus, when kobject_init_and_add() returns an error,
kobject_put() must be called to properly clean up the kobject.

Fixes: d72e31c93746 ("iommu: IOMMU Groups")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
Link: https://lore.kernel.org/r/20200527210020.6522-1-wu000273@umn.edu
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/iommu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -392,7 +392,7 @@ struct iommu_group *iommu_group_alloc(vo
 				   NULL, "%d", group->id);
 	if (ret) {
 		ida_simple_remove(&iommu_group_ida, group->id);
-		kfree(group);
+		kobject_put(&group->kobj);
 		return ERR_PTR(ret);
 	}
 


