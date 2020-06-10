Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FACCC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 22:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F0C42074B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 22:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOPAmT5q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgFJWr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 18:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgFJWrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 18:47:25 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27EBC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 15:47:24 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id y11so4569634ljm.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 15:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3hdR1U1pgJ2jCq0TI+wqRp17veeSC2dFXf50rAGsQmQ=;
        b=aOPAmT5qPIdXrvQjZrQTiIzegs+3vaL7fgwueUfXWSSIX4LyKA3791Ih3vxVTaPFZ5
         pmi20xz3KwbgflHzHF4yPyEsPAu+lSsvsnuvjYXyk6mdxXn9vaTsD1Ofw38z61AZx1ES
         7+Sz+sM9zzVE50+YQGPK0oTbwvioSi+Ti2MId7LOh/X+HXD0fgrMgi+2GXe4213r26LI
         3fMZ48Rk3sosSki5DUiMpteZyjP2BUpUSJuaLN/7UWsDbEflhyM13VT2BkJjXSXfJgHA
         eVrjW3kqmGSdYVFJLVtS/BWXJXV9yIYKBvKuJ6/L1+ZXmRmMIAIRlUD0fwzzQSQ/YyYP
         Hvkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3hdR1U1pgJ2jCq0TI+wqRp17veeSC2dFXf50rAGsQmQ=;
        b=EO1e7BxluSuDWcxvoiDTqW5FTcskRnzkwhEEowsbn7vGl6IN0zlnk7eG6zyLqyS6M0
         T4e9Di0rkkVDnVdTQXFQnd4kWxEC2aWOOsaQTzDInT4JWHS2goKHyJwwJtrbqDxCFzM6
         W2TUqRTlDtN0I3FFh+xIl0IMcvK7JPmKFtCWF1a855vdKTiayx8PcHVLbothaJylVK1G
         LoqHObkRoFKVyXKQG0p9bzJcT/OvhwvIdeZfcocqIm47F9ipaSa5m0UHbyFQWzCMU4KR
         WQSUx7Th/lHQweTDyBcNN/o2kD0/mSLNoMO2R/DfSPFDKpzWB/Xpw+nqe53uGss/T8A9
         PVeg==
X-Gm-Message-State: AOAM532gY+1X4+BdZQFdPs5+QkgtM2IlmOSveSM7UvbuC6SPh6s+hRdl
        n3q1dmu0Y3ecw3/57meic2Ej7FbNMaA=
X-Google-Smtp-Source: ABdhPJyk7L7Bfs2tzWEeEGYmP8Onu0TAiPwPQsPTGmJutewI+K0p9Tkw5ft/tbAeASzl8uyMe2GRVA==
X-Received: by 2002:a2e:8756:: with SMTP id q22mr3003764ljj.238.1591829243201;
        Wed, 10 Jun 2020 15:47:23 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-136.NA.cust.bahnhof.se. [82.196.111.136])
        by smtp.gmail.com with ESMTPSA id s17sm262506ljd.51.2020.06.10.15.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 15:47:22 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Frank Haverkamp <haver@linux.ibm.com>
Subject: [PATCH 2/4] misc: genwqe: Constify struct pci_error_handlers
Date:   Thu, 11 Jun 2020 00:47:02 +0200
Message-Id: <20200610224704.27082-3-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200610224704.27082-1-rikard.falkeborn@gmail.com>
References: <20200610224704.27082-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

genwqe_err_handler is never modified, so it can be made const to allow
the compiler to put it in read-only memory.

Before:
   text    data     bss     dec     hex filename
  20174    6104    2464   28742    7046 drivers/misc/genwqe/card_base.o

After:
   text    data     bss     dec     hex filename
  20270    6008    2464   28742    7046 drivers/misc/genwqe/card_base.o

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/misc/genwqe/card_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/genwqe/card_base.c b/drivers/misc/genwqe/card_base.c
index 1dc6c7c5cbce..9969c0003f15 100644
--- a/drivers/misc/genwqe/card_base.c
+++ b/drivers/misc/genwqe/card_base.c
@@ -1324,7 +1324,7 @@ static int genwqe_sriov_configure(struct pci_dev *dev, int numvfs)
 	return 0;
 }
 
-static struct pci_error_handlers genwqe_err_handler = {
+static const struct pci_error_handlers genwqe_err_handler = {
 	.error_detected = genwqe_err_error_detected,
 	.mmio_enabled	= genwqe_err_result_none,
 	.slot_reset	= genwqe_err_slot_reset,
-- 
2.27.0

