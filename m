Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D980C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 274BE24698
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221290;
	bh=fbz50UvltV7L5z12zkYmwND53mguKXWQP2DHuEXL1A0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RL8GPgKrfsMnsQcTv7OpfN661yVXY2FjUW8TDfAUziVYWPmBjis825IEiyptT12ic
	 VlgmFHCX5dniDngpro/3chh1zMXm7kJCD6HRvW+bXQU43CgCfuRTudKT0ARGBEnUo4
	 tDRGmx1JxYm8FRWttow8jxSfVcJBpekDNVuwAK9Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730351AbgA1OV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:21:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:46768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731272AbgA1OV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:21:26 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BC7124681;
        Tue, 28 Jan 2020 14:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221285;
        bh=fbz50UvltV7L5z12zkYmwND53mguKXWQP2DHuEXL1A0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CyyOO+nknEpeRNPTNpK5zCQ8306YyoP8fSBSJlj/7dhYtrwiFBTI9yAOlGri4QV6a
         FpThsW0ZBMmBdoOAxfnKzZHvcDI8IO1ueGb3IoP5kMcvRkBrak11yUJz7vSfM4qAJ3
         kXWXwF5JOXfabTyZbeCy8spkvNazPVTur0AHAwn4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 164/271] mfd: intel-lpss: Release IDA resources
Date:   Tue, 28 Jan 2020 15:05:13 +0100
Message-Id: <20200128135904.792844046@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135852.449088278@linuxfoundation.org>
References: <20200128135852.449088278@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 02f36911c1b41fcd8779fa0c135aab0554333fa5 ]

ida instances allocate some internal memory for ->free_bitmap
in addition to the base 'struct ida'. Use ida_destroy() to release
that memory at module_exit().

Fixes: 4b45efe85263 ("mfd: Add support for Intel Sunrisepoint LPSS devices")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/intel-lpss.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
index 22dd8c055048c..71cecd7aeea0c 100644
--- a/drivers/mfd/intel-lpss.c
+++ b/drivers/mfd/intel-lpss.c
@@ -533,6 +533,7 @@ module_init(intel_lpss_init);
 
 static void __exit intel_lpss_exit(void)
 {
+	ida_destroy(&intel_lpss_devid_ida);
 	debugfs_remove(intel_lpss_debugfs);
 }
 module_exit(intel_lpss_exit);
-- 
2.20.1



