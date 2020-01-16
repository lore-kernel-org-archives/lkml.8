Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51864C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 201F82471C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579196441;
	bh=v9JXYCfiRRgPlHlhNKPFjSagykLqpovTatdjLA02VfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FyoQSc29q5+vSrK+ZXV3me4DFkwXVcp8bZMoyubldtFfya8TJf+TsrLuzjAl/j1v3
	 jPmBl/8VCvSU1YWd8TjTqyXgoKpcsnkxKDSZQSH5d7UqjsLxmGi/WwLTfCR2QVm9ix
	 SxEjuoomSVJIAQluxiwB6AyIHckYZfeAL72HtRso=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393654AbgAPRkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:40:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:56150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393493AbgAPRjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:39:40 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F926246E7;
        Thu, 16 Jan 2020 17:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196379;
        bh=v9JXYCfiRRgPlHlhNKPFjSagykLqpovTatdjLA02VfM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A1T9vIMm1QEOnR/oFPalQ/uuwnE0LTpSDghx6elq3XZYHGd2T+BjGPu2vTNDlC2cA
         KcTVBb0TJZOPnPo9V3/gQNYZKskove0Xm6B/yQapD18fXZOf5Me5FJcY9Jc2pPF8kp
         wmn2gffNEf2jPMqnX7cz+mizRVtbv1TgnWQ1jiNA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 163/251] mfd: intel-lpss: Release IDA resources
Date:   Thu, 16 Jan 2020 12:35:12 -0500
Message-Id: <20200116173641.22137-123-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116173641.22137-1-sashal@kernel.org>
References: <20200116173641.22137-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 22dd8c055048..71cecd7aeea0 100644
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

