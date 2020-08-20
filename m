Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95277C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B96A20658
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597918940;
	bh=dmuw/duFBzbPQYSIBOiWV0yYjkq2jDV+QOtdQeCfB+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vQ/IH2G6lNnxQthkuGYnRLYtzZwLgRX5nVdohaYHJrAe8UE0/Pu4R1sA+boKFoqFk
	 IwdDTgZzRB2nF0zsMusFpZiusx5o5wdOVpodGRiEWQZ517zSvGgehHRKB7g6J/Fs9p
	 eZBjUhz4iXyDghaTa4tpHDMYXJKDt8ZW9kwfeRyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731612AbgHTKWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:22:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:49278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731586AbgHTKWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:22:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FD5F20658;
        Thu, 20 Aug 2020 10:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918922;
        bh=dmuw/duFBzbPQYSIBOiWV0yYjkq2jDV+QOtdQeCfB+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l8IQyOqK2b5voiMkj3bv3b3I1wMYE157pI7f8OwG65o9GhDzrsGdTJRDJL8nGOL8S
         g+TatQcI7fBYQiI0hw1ZfhQ/2qXk1NxdLtUhxhWy0+Bc30fs8YgRA+y2lFAeeKdYum
         xl74C6uX+FB6WdpvqEouSGZ3xmEVH5T+hSjvQYDw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sven Schnelle <svens@stackframe.org>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 4.4 116/149] parisc: mask out enable and reserved bits from sba imask
Date:   Thu, 20 Aug 2020 11:23:13 +0200
Message-Id: <20200820092131.317296232@linuxfoundation.org>
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

From: Sven Schnelle <svens@stackframe.org>

commit 5b24993c21cbf2de11aff077a48c5cb0505a0450 upstream.

When using kexec the SBA IOMMU IBASE might still have the RE
bit set. This triggers a WARN_ON when trying to write back the
IBASE register later, and it also makes some mask calculations fail.

Cc: <stable@vger.kernel.org>
Signed-off-by: Sven Schnelle <svens@stackframe.org>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/parisc/sba_iommu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/parisc/sba_iommu.c
+++ b/drivers/parisc/sba_iommu.c
@@ -1277,7 +1277,7 @@ sba_ioc_init_pluto(struct parisc_device
 	** (one that doesn't overlap memory or LMMIO space) in the
 	** IBASE and IMASK registers.
 	*/
-	ioc->ibase = READ_REG(ioc->ioc_hpa + IOC_IBASE);
+	ioc->ibase = READ_REG(ioc->ioc_hpa + IOC_IBASE) & ~0x1fffffULL;
 	iova_space_size = ~(READ_REG(ioc->ioc_hpa + IOC_IMASK) & 0xFFFFFFFFUL) + 1;
 
 	if ((ioc->ibase < 0xfed00000UL) && ((ioc->ibase + iova_space_size) > 0xfee00000UL)) {


