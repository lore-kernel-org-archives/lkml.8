Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2993C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE9320838
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580748067;
	bh=A/OInvNUnYl3sVuGtrPH4+JUTp1LNDxhwo2rpTolErQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dgknJMtAScJcITavarRC0q050hZ2xyGejhMNga1w+hDRYVbRMVhK7q2/ZWGrI9jY9
	 8D6Gy+SkLrNx1U2bKA4q0mDwI6CY4tNtDKpbB8MmPf6oEILCyfpQ5SbFuPIq1/g3dL
	 C8DtjeSFqgq0nlnva6NUA2ZLRNtdYgcAOBQ4V8UM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731472AbgBCQlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:41:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:50342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730998AbgBCQfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:35:30 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBAB32082E;
        Mon,  3 Feb 2020 16:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747729;
        bh=A/OInvNUnYl3sVuGtrPH4+JUTp1LNDxhwo2rpTolErQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YymrtlnITm362srKmyAzorZSzslxvrakTkXai984s3nk1pSxF6QTIbr3tjUGdb12G
         6sUG/VFA8ofjFpDuMgWJrtIu5zgNbFb4t2vQUdNXVG62kt3LE6wChtP3j+c1v/YEd4
         6ODHozwQY2hHQDDeOrVM6J3uppNty+D/zZp//xXA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Harry Pan <harry.pan@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 44/90] platform/x86: intel_pmc_core: update Comet Lake platform driver
Date:   Mon,  3 Feb 2020 16:19:47 +0000
Message-Id: <20200203161923.441970979@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161917.612554987@linuxfoundation.org>
References: <20200203161917.612554987@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harry Pan <harry.pan@intel.com>

[ Upstream commit 515ff674bb9bf06186052e352c4587dab8defaf0 ]

Adding new CML CPU model ID into platform driver support list.

Signed-off-by: Harry Pan <harry.pan@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel_pmc_core_pltdrv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/intel_pmc_core_pltdrv.c b/drivers/platform/x86/intel_pmc_core_pltdrv.c
index 6fe829f30997d..e1266f5c63593 100644
--- a/drivers/platform/x86/intel_pmc_core_pltdrv.c
+++ b/drivers/platform/x86/intel_pmc_core_pltdrv.c
@@ -44,6 +44,8 @@ static const struct x86_cpu_id intel_pmc_core_platform_ids[] = {
 	INTEL_CPU_FAM6(KABYLAKE, pmc_core_device),
 	INTEL_CPU_FAM6(CANNONLAKE_L, pmc_core_device),
 	INTEL_CPU_FAM6(ICELAKE_L, pmc_core_device),
+	INTEL_CPU_FAM6(COMETLAKE, pmc_core_device),
+	INTEL_CPU_FAM6(COMETLAKE_L, pmc_core_device),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_pmc_core_platform_ids);
-- 
2.20.1



