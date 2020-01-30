Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E8EC35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 557E8205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580410170;
	bh=8I4N5SI5pfjtzoqByMlS3MkZ2k66b7rxqF1BnrKZr/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eLl4BK7a+DbcgU5yQQ+H1xiPtI9x3CEKD/3wpq5Iji8mZHA1XOwnepIUDw9vlDP3T
	 2xVo0v93qHKfGaPMYqYkDhGuYvgK/Hd096RC1qzuqzafG6HofcfTiyP0Z9VINsxPFU
	 aXZ/YOUniuQh9IPMu53buiGyCgSd2/Q7iuiu3WUo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731555AbgA3Ss1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:48:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:59148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731529AbgA3SsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:48:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8FDE20674;
        Thu, 30 Jan 2020 18:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580410097;
        bh=8I4N5SI5pfjtzoqByMlS3MkZ2k66b7rxqF1BnrKZr/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oQQhBF86433b1vBTlu5kwIv7pzOxv3RHhHCDuQAPiiBxAimMTgCahIJ/KWXFpr3i4
         bNOhlmiyT9iq0saBoegZN7mRY2bOiy8AxEzqSECNX6g3kil6JxW6jCwXCNo9nzS/G+
         0xYh/2aLsR7xlE3gmz6Uaae2AS4d6pnqCkcTNJPM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Dooks <ben.dooks@codethink.co.uk>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 44/55] ARM: OMAP2+: SmartReflex: add omap_sr_pdata definition
Date:   Thu, 30 Jan 2020 19:39:25 +0100
Message-Id: <20200130183616.560082057@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130183608.563083888@linuxfoundation.org>
References: <20200130183608.563083888@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Dooks <ben.dooks@codethink.co.uk>

[ Upstream commit 2079fe6ea8cbd2fb2fbadba911f1eca6c362eb9b ]

The omap_sr_pdata is not declared but is exported, so add a
define for it to fix the following warning:

arch/arm/mach-omap2/pdata-quirks.c:609:36: warning: symbol 'omap_sr_pdata' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/power/smartreflex.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/power/smartreflex.h b/include/linux/power/smartreflex.h
index 7b81dad712de8..37d9b70ed8f0a 100644
--- a/include/linux/power/smartreflex.h
+++ b/include/linux/power/smartreflex.h
@@ -296,6 +296,9 @@ struct omap_sr_data {
 	struct voltagedomain		*voltdm;
 };
 
+
+extern struct omap_sr_data omap_sr_pdata[OMAP_SR_NR];
+
 #ifdef CONFIG_POWER_AVS_OMAP
 
 /* Smartreflex module enable/disable interface */
-- 
2.20.1



