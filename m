Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC5FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 00:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 817A520756
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 00:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="QD3uIFRZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgHLAQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 20:16:04 -0400
Received: from crapouillou.net ([89.234.176.41]:52130 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbgHLAQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 20:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1597191324; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OiD8JCLx67JzjWgveRnje+NFfpOX7CKvakHy/Siehxk=;
        b=QD3uIFRZjTrL5TyETWf0viZmKczWuWM2zbGeoCvsH0xR5QMcqUBzZoK3Om67qUO99vV+Hj
        aXMacjvb1rDaG1FAPaXAQLeMoTrT4B0FBZcEZLkg3WtkWc9oTFhkcQ9txUuyumngHg+FIA
        BdSlXs/fw5IW/DbUTZl/xVITXYd46GM=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Paul Burton <paulburton@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0?= <zhouyanjie@wanyeetech.com>,
        od@zcrc.me, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 06/13] MIPS: generic: Init command line with fw_init_cmdline()
Date:   Wed, 12 Aug 2020 02:15:03 +0200
Message-Id: <20200812001510.460382-7-paul@crapouillou.net>
In-Reply-To: <20200812001510.460382-1-paul@crapouillou.net>
References: <20200812001510.460382-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function bootcmdline_init() in arch/mips/kernel/setup.c will
populate the boot_command_line string using the parameters hardcoded in
the kernel, and those provided in the devicetree file. Then, it would
append the content of the arcs_cmdline variable, which is filled by the
board's plat_mem_setup() function.

The plat_mem_setup() function for the generic MIPS board would just copy
the current boot_command_line to arcs_cmdline, which is nonsense for two
reasons:
- the result will be appended to the boot_command_line anyway, so all it
  does is duplicate every single parameter on the command line;
- the code did not perform at all what it's supposed to, which is to
  retrieve the parameters passed by the bootloader.

Fix this by calling fw_init_cmdline() in plat_mem_setup(), which will
properly initialize arcs_cmdline to the parameters passed by the
bootloader.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: New patch

 arch/mips/generic/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/generic/init.c b/arch/mips/generic/init.c
index 805d0135a9f4..029f47ea390c 100644
--- a/arch/mips/generic/init.c
+++ b/arch/mips/generic/init.c
@@ -106,7 +106,7 @@ void __init plat_mem_setup(void)
 	if (mach && mach->fixup_fdt)
 		fdt = mach->fixup_fdt(fdt, mach_match_data);
 
-	strlcpy(arcs_cmdline, boot_command_line, COMMAND_LINE_SIZE);
+	fw_init_cmdline();
 	__dt_setup_arch((void *)fdt);
 }
 
-- 
2.28.0

