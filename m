Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC3EC2BB55
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 08:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC5821924
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 08:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgDJIYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 04:24:47 -0400
Received: from mga09.intel.com ([134.134.136.24]:58714 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgDJIYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 04:24:47 -0400
IronPort-SDR: N0DN82FGHIpSP2Gb04EusPYI7rI39p1GffVhtCAe9ls8i0QtMiwTmmIUhmGgpM0420tDtwXB6P
 BeS+KzaWdzXg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2020 01:24:47 -0700
IronPort-SDR: 4J82DjhtLJQl5YAb9QpZYCc1HHXmkr2XSVxtsqIJGROazogFMGxZu4IhH9LDJUmBlPg6y3PMoO
 lx3/P6QbX8Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,366,1580803200"; 
   d="scan'208";a="362390975"
Received: from brentlu-desk0.itwn.intel.com ([10.5.253.11])
  by fmsmga001.fm.intel.com with ESMTP; 10 Apr 2020 01:24:43 -0700
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Brent Lu <brent.lu@intel.com>,
        Richard Fontana <rfontana@redhat.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] ASoC: Intel: sst: ipc command timeout
Date:   Fri, 10 Apr 2020 16:18:25 +0800
Message-Id: <1586506705-3194-1-git-send-email-brent.lu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After sending an ipc command to DSP, the host waits for the reply message
which will be read from SST_IPCD register in sst_byt_irq_thread() to
complete the transaction. Sometimes the value read from SST_IPCD register
is still the reply message for previous command instead of the waiting
command so ipc command timeout happens.

In an experiment we read the same SST_IPCD register again when the defect
happens and found the value of second read is different from previous one
and is the correct reply message. It suggests the DSP is okay but the way
we read the register may be the cause.

Currently the driver is using memcpy_fromio() to read the value of 64-bit
registers. This function is based on __builtin_memcpy() call and depends
on the implementation of compiler. Since this issue happens right after
the toolchain switched from clang 10 to clang 11, we replace the register
read with two readl() function calls to avoid all optimization from
compiler's library.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/intel/common/sst-dsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/common/sst-dsp.c b/sound/soc/intel/common/sst-dsp.c
index ec66be2..12af7aa 100644
--- a/sound/soc/intel/common/sst-dsp.c
+++ b/sound/soc/intel/common/sst-dsp.c
@@ -42,7 +42,7 @@ u64 sst_shim32_read64(void __iomem *addr, u32 offset)
 {
 	u64 val;
 
-	memcpy_fromio(&val, addr + offset, sizeof(val));
+	sst_memcpy_fromio_32(NULL, &val, addr + offset, sizeof(val));
 	return val;
 }
 EXPORT_SYMBOL_GPL(sst_shim32_read64);
-- 
2.7.4

