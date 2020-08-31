Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF93C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 21:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A12E0206FA
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 21:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnCAH4XI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730240AbgHaVVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 17:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728649AbgHaVVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 17:21:20 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30F7C061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 14:21:19 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id f18so1389987pfa.10
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 14:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bcxQD2Sn/2bUGUgYSdbw9/nm0Vv2nDYXnd0y7jH8pec=;
        b=RnCAH4XIYXFutKK+MrfQTe25TGSO7ZeTBeo27ijs0y0ym14WJ4YUkp0Qa0tlOfZrfu
         d6h8HxDPQsjvBIZbtjC0KFDIPPae741UZABCuIJHLMLsW20MseA4EdHjL/MndQKvwGvZ
         y6kV5POE49Bu+TO7Oy3cfmEQXv9t/k5j7OmmxhmW5zkdDAcrPjIBPlwX55xMSJd4nh7B
         mjqv/YBlp98PD7WXqcswgqhg+21wLH98QUcfMidWgacAxa0or2nKjdtmnUJNJVHKmRh6
         JsxUOsI9IGZ19tl3jhSP8+quIUalEQt2j3ur1ExOdLdFIwDZ6HJ1L9gRqojTCQBBpXwK
         rdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bcxQD2Sn/2bUGUgYSdbw9/nm0Vv2nDYXnd0y7jH8pec=;
        b=BcgTqvWc3sf8FPm+PUFfUMRschiZrlw6DwFT4O3sLuwhIM8bNuMPmd2t/tdA0vVU/y
         nIMGnc7m55zb9HB2eKUeWPXLIpD2xtxZ1ph+reTodRQczoOSfYtVx4BL01o7DlEzK/Im
         PUqFRuTg97hBTG4dogo4StyaU6x66Fm3tQvQMCl6makDB+cgxCaoAVTdBReKAh+ssS3V
         6ddKK8pgetNE0da5RCjystK91OK4L+A6gi9YdXmppuH5K9Zqm0EAp4B+GzEPSQHNoglp
         O5ZuZdMNGwygsj9OTIJu9uRpI9iAmESNWV4x9YAIw5HZevM8tnXSLeQoKl/yDVBaCMH0
         bsrQ==
X-Gm-Message-State: AOAM530KHdtz+0WOQaTVukWu0CX0jrHAFrMIzJttyKee5Pw8BAtIPlsw
        cg/Z5KMWhms0ndmb6sCk50OJZJtxVHM=
X-Google-Smtp-Source: ABdhPJyZQ3xkdg7sLV2Kx4H8hS0SzKfHcYEtbNbzcy7L1p8EP8DE98CQkZ26JHkoK4iuuXPd1auMNw==
X-Received: by 2002:aa7:9569:: with SMTP id x9mr2815283pfq.16.1598908878426;
        Mon, 31 Aug 2020 14:21:18 -0700 (PDT)
Received: from localhost (g223.115-65-55.ppp.wakwak.ne.jp. [115.65.55.223])
        by smtp.gmail.com with ESMTPSA id y7sm540803pjm.3.2020.08.31.14.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 14:21:17 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Mike Rapoport <rppt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        openrisc@lists.librecores.org
Subject: [PATCH] openrisc: Reserve memblock for initrd
Date:   Tue,  1 Sep 2020 06:21:01 +0900
Message-Id: <20200831212102.4014642-1-shorne@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently OpenRISC added support for external initrd images, but I found
some instability when using larger buildroot initrd images. It turned
out that I forgot to reserve the memblock space for the initrd image.

This patch fixes the instability issue by reserving memblock space.

Fixes: ff6c923dbec3 ("openrisc: Add support for external initrd images")
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/setup.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
index b18e775f8be3..2c8aa53cc7ba 100644
--- a/arch/openrisc/kernel/setup.c
+++ b/arch/openrisc/kernel/setup.c
@@ -80,6 +80,15 @@ static void __init setup_memory(void)
 	 */
 	memblock_reserve(__pa(_stext), _end - _stext);
 
+#ifdef CONFIG_BLK_DEV_INITRD
+	/* Then reserve the initrd, if any */
+	if (initrd_start && (initrd_end > initrd_start)) {
+		memblock_reserve(ALIGN_DOWN(__pa(initrd_start), PAGE_SIZE),
+			ALIGN(initrd_end, PAGE_SIZE) -
+			ALIGN_DOWN(initrd_start, PAGE_SIZE));
+	}
+#endif /* CONFIG_BLK_DEV_INITRD */
+
 	early_init_fdt_reserve_self();
 	early_init_fdt_scan_reserved_mem();
 
-- 
2.26.2

