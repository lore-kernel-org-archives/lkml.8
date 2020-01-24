Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882B3C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B23B21734
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579865546;
	bh=sl4NdRa+WOVYw8gmukFFneHGdSjLAGmayVkxy0HW92Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aoJ0GylsHXT2metCpjU64qEEMu4TMi/VZ59rMm4xaZxnE3/r/7nVHqibLUpZfZZ3N
	 /xgt7eO+tIiiV/IDgAH/GDjNEQ1RvT8aKG8VIqizVCoJX1V82yk4+TK8De+MLKGbeN
	 O3ET2G6XpZLpdlUU0JqX/QKnmkWgALhD9ueVQXkI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404436AbgAXLcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:32:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:51188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404431AbgAXLcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:32:19 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74F7421556;
        Fri, 24 Jan 2020 11:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579865539;
        bh=sl4NdRa+WOVYw8gmukFFneHGdSjLAGmayVkxy0HW92Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EiJtUAdUs7HWZ6qvXUfpMMEv1vPAmlFQtvblrHenDCUpYx3MTBvyybdSBVuzn7UaZ
         yo4JTXMGYgMCtzz2fUbqQA1A1o4FhWDTRviO7ttxSjeldChuCqRc1gItwtpH8vldqU
         hB5bKakIbr4wF4/TKTOjQOEIqBYtEZm5ggzV8XJI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filippo Sironi <sironi@amazon.de>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 573/639] iommu/amd: Wait for completion of IOTLB flush in attach_device
Date:   Fri, 24 Jan 2020 10:32:23 +0100
Message-Id: <20200124093201.189937837@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Filippo Sironi <sironi@amazon.de>

[ Upstream commit 0b15e02f0cc4fb34a9160de7ba6db3a4013dc1b7 ]

To make sure the domain tlb flush completes before the
function returns, explicitly wait for its completion.

Signed-off-by: Filippo Sironi <sironi@amazon.de>
Fixes: 42a49f965a8d ("amd-iommu: flush domain tlb when attaching a new device")
[joro: Added commit message and fixes tag]
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd_iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 9991386fb7000..bea19aa337587 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2153,6 +2153,8 @@ skip_ats_check:
 	 */
 	domain_flush_tlb_pde(domain);
 
+	domain_flush_complete(domain);
+
 	return ret;
 }
 
-- 
2.20.1



