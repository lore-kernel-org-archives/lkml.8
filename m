Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553B1C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2995E207EA
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598887949;
	bh=+FACLGKqlSwMrilGYEKodDj+1GCcMCrZAibjV4DcC8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UoEAN3cNUDCk62h6R+WPlljpdRxJywpkzwJ3+jhR8TNmywvXt0KCmlV/ML6wVz47S
	 7JVcKVJxFCMpSArnKFbWPtqqILihE901+Cx3dNp8e3aT7yA29wmR+4av3XhRiKDqkI
	 9+vmw4BhBXM1L+R3ynpr4En+wwN3Avtsemf9Pg3s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbgHaPc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 11:32:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:43354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729034AbgHaPcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 11:32:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 104B3214D8;
        Mon, 31 Aug 2020 15:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598887919;
        bh=+FACLGKqlSwMrilGYEKodDj+1GCcMCrZAibjV4DcC8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=enZaZ4xuSfz6wg2z4qRun3Er3Js/N3kAJMDnLaROizndy+GaFn5r7RZ0n9/LEwD7w
         bcyHqaRjN0D5APLzVXDJ9CDbzViJFOMYFdPD0Wv5BpuovLR+eKeF8jSZ73xMJgb25e
         H6J4fzJecXudHB9UMWwxBk7WcAFvUIiUaZ0VEwUc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Simon Leiner <simon@leiner.me>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Sasha Levin <sashal@kernel.org>, xen-devel@lists.xenproject.org
Subject: [PATCH AUTOSEL 4.9 6/6] xen/xenbus: Fix granting of vmalloc'd memory
Date:   Mon, 31 Aug 2020 11:31:49 -0400
Message-Id: <20200831153150.1024799-6-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831153150.1024799-1-sashal@kernel.org>
References: <20200831153150.1024799-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Leiner <simon@leiner.me>

[ Upstream commit d742db70033c745e410523e00522ee0cfe2aa416 ]

On some architectures (like ARM), virt_to_gfn cannot be used for
vmalloc'd memory because of its reliance on virt_to_phys. This patch
introduces a check for vmalloc'd addresses and obtains the PFN using
vmalloc_to_pfn in that case.

Signed-off-by: Simon Leiner <simon@leiner.me>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Link: https://lore.kernel.org/r/20200825093153.35500-1-simon@leiner.me
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/xenbus/xenbus_client.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_client.c b/drivers/xen/xenbus/xenbus_client.c
index df27cefb2fa35..266f446ba331c 100644
--- a/drivers/xen/xenbus/xenbus_client.c
+++ b/drivers/xen/xenbus/xenbus_client.c
@@ -384,8 +384,14 @@ int xenbus_grant_ring(struct xenbus_device *dev, void *vaddr,
 	int i, j;
 
 	for (i = 0; i < nr_pages; i++) {
-		err = gnttab_grant_foreign_access(dev->otherend_id,
-						  virt_to_gfn(vaddr), 0);
+		unsigned long gfn;
+
+		if (is_vmalloc_addr(vaddr))
+			gfn = pfn_to_gfn(vmalloc_to_pfn(vaddr));
+		else
+			gfn = virt_to_gfn(vaddr);
+
+		err = gnttab_grant_foreign_access(dev->otherend_id, gfn, 0);
 		if (err < 0) {
 			xenbus_dev_fatal(dev, err,
 					 "granting access to ring page");
-- 
2.25.1

