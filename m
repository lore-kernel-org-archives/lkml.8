Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB30C47254
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 03:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FA9720857
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 03:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eb1igCkf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgEBDAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 23:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgEBDAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 23:00:21 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26764C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 20:00:21 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id m18so4124654otq.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 20:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ggxUrTEMdOBIpxo+ZeqC5vmjC50PL8n9qRt0O5YmVrM=;
        b=eb1igCkfmUfgb4anqtJRttFUI4TVCn/3yNA1G5fT0zedyad+1V2j+81W6vJFt7cLlD
         aG68D1ffrqudSWUhkI56J6cC5uPM3CYv1bOMbS8qAfQ1umWdECRBXahwKi33o7DtkKwI
         VVnUtuMhnBiGM8hriSFFh2EVa+jZWuzl4U9Qc67srDPGWclef6s2BhNQpUPKkMMA1NXC
         5UfYE7HIe2m37gTZ0X2jMtWMUp3Wn/FjUpT1c53/YEAV6HeRTETqrL0fKkig0r/cUGVA
         WM8peYfgVKsILX1Hf7jMdeD801vqnTsAW6A4wZgrBVuQerUic25nhMfEyA0ctZkNou9r
         vF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ggxUrTEMdOBIpxo+ZeqC5vmjC50PL8n9qRt0O5YmVrM=;
        b=L3S1r9hN0NmFeOY5IHkGn/ZMgd0qmGEtXF6bjhqtgUN5e53s9PKi2Yrbq6Hlq58FtH
         2jZMOm+mAouaAm2iyk1H5uxAGXEckOtob8JzPDNKCp6Hi5cg0ZtTkL/ZqSCqOeR8fVuN
         5GBwOmovra/FEFwoqE9JFYhp6+hU9OteXkI6GgEsdgkbmqvv+VHPt7woKzWv7AQSxJI0
         /F6K4JF6UQxLa7JbxitdEyBn/hmPjTsdEmRvdGHMNNHUkiEiQwTCGhX8wyzZGJeWpA/O
         2lSEP2xVthwv3/uAtYNg2i/oh2kFwajD1IDx7QBM2k2Jm0U8h/M2KFTMUxZGeSwFfHLH
         4Arg==
X-Gm-Message-State: AGi0PuarGNKguSY1cXbk+YNajClRayQZwEDZdBn4s6H3sxdiGTmCZP2+
        f6bZs6PQVAmalaCkSchYdTYPaWZg
X-Google-Smtp-Source: APiQypLe/yx/Dr+vgP6JwU9y00DcNo+QswijdAlkdRIVlQpMSj0oWburLhC645chJt4a8aZ3xjgOwg==
X-Received: by 2002:a9d:2782:: with SMTP id c2mr93426otb.106.1588388420239;
        Fri, 01 May 2020 20:00:20 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id f16sm468419oib.25.2020.05.01.20.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 20:00:19 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Michal Simek <michal.simek@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] firmware: xilinx: Export zynqmp_pm_fpga_{get_status,load}
Date:   Fri,  1 May 2020 19:59:58 -0700
Message-Id: <20200502025958.2714249-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building arm64 allmodconfig:

ERROR: modpost: "zynqmp_pm_fpga_load" [drivers/fpga/zynqmp-fpga.ko] undefined!
ERROR: modpost: "zynqmp_pm_fpga_get_status" [drivers/fpga/zynqmp-fpga.ko] undefined!

These functions were added to drivers/fpga/zynqmp-fpga.c but not
exported so the module build breaks. Export them so that they can be
used in modules properly.

Fixes: 4db8180ffe7c ("firmware: xilinx: Remove eemi ops for fpga related APIs")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/firmware/xilinx/zynqmp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index bfaf29a58eac..8095fa84d5d7 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -755,6 +755,7 @@ int zynqmp_pm_fpga_load(const u64 address, const u32 size, const u32 flags)
 	return zynqmp_pm_invoke_fn(PM_FPGA_LOAD, lower_32_bits(address),
 				   upper_32_bits(address), size, flags, NULL);
 }
+EXPORT_SYMBOL_GPL(zynqmp_pm_fpga_load);
 
 /**
  * zynqmp_pm_fpga_get_status - Read value from PCAP status register
@@ -778,6 +779,7 @@ int zynqmp_pm_fpga_get_status(u32 *value)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(zynqmp_pm_fpga_get_status);
 
 /**
  * zynqmp_pm_init_finalize() - PM call to inform firmware that the caller

base-commit: fb9d670f57e3f6478602328bbbf71138be06ca4f
-- 
2.26.2

