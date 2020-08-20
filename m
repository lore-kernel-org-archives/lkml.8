Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EE8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3374220658
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597919079;
	bh=RDLsD+t0qNnmAcq5IMciZyMHkjOmdMiB6B13WZbUicA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bsSV0b15C+4vSRYbauSvKSEPLfts8uFYy0myEFKhzIQbSJVNqv/8wg206ODXWEnUq
	 aK6YAmhn4UlFU5qWndjPizrj2q1NPkHqgCmnWaG0upZyXvkZZgM2peYXIVuX1XyRmk
	 YrpnVNhX+UOX9buO2vtsLviU+NgKzRvgzOOkK4rE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731795AbgHTKYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:24:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:53072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731747AbgHTKXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:23:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C480A2072D;
        Thu, 20 Aug 2020 10:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597919010;
        bh=RDLsD+t0qNnmAcq5IMciZyMHkjOmdMiB6B13WZbUicA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1quxJmMdOrFjXOtGDnBkZcygXmVh9OOwiSmM8FI0JhzAawV/M8kbHDsjgWPXJslxi
         H49eDQz0zzLjkGnPi/xTW8m94Fi5OiP3zNkbTDLNn6UsNzh5/biZhFOqbF1jskM6Wl
         uARItckP/6sspcHn4mY5F3fy2WVTOh9RRVke5NxI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 137/149] iommu/omap: Check for failure of a call to omap_iommu_dump_ctx
Date:   Thu, 20 Aug 2020 11:23:34 +0200
Message-Id: <20200820092132.331198491@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820092125.688850368@linuxfoundation.org>
References: <20200820092125.688850368@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit dee9d154f40c58d02f69acdaa5cfd1eae6ebc28b ]

It is possible for the call to omap_iommu_dump_ctx to return
a negative error number, so check for the failure and return
the error number rather than pass the negative value to
simple_read_from_buffer.

Fixes: 14e0e6796a0d ("OMAP: iommu: add initial debugfs support")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Link: https://lore.kernel.org/r/20200714192211.744776-1-colin.king@canonical.com
Addresses-Coverity: ("Improper use of negative value")
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/omap-iommu-debug.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/omap-iommu-debug.c b/drivers/iommu/omap-iommu-debug.c
index 9bc20e2119a35..82bf208295f4b 100644
--- a/drivers/iommu/omap-iommu-debug.c
+++ b/drivers/iommu/omap-iommu-debug.c
@@ -101,8 +101,11 @@ static ssize_t debug_read_regs(struct file *file, char __user *userbuf,
 	mutex_lock(&iommu_debug_lock);
 
 	bytes = omap_iommu_dump_ctx(obj, p, count);
+	if (bytes < 0)
+		goto err;
 	bytes = simple_read_from_buffer(userbuf, count, ppos, buf, bytes);
 
+err:
 	mutex_unlock(&iommu_debug_lock);
 	kfree(buf);
 
-- 
2.25.1



