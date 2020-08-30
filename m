Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2491AC433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 22:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F40FA2083E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 22:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMbtLvEa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgH3WoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 18:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgH3WoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 18:44:07 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8B0C061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 15:44:07 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id y4so3508808ljk.8
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 15:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FH5UUjbVRVLGG30ILlf1Mw1a+mIb68P/1duZpHI6CQg=;
        b=fMbtLvEawP9iGaMPblCEBigt2ybNssfPrUFcG5og0z9igfwEUozl2DBwb+p+BQYEfF
         bIJCksp2vjR2gdpOj42kOmPlNIyhSB08KjrMys+9VTlSkNCncQhvTnEh2el5n0YXToFF
         AuFujF0az4hd6IIOqn4c1jLlsO+b9rjS8vr+a5SuctQuCShGlog0uRnLhnt5F9ltvnNg
         KqozmVHhUHUqCST8KnWYrauDB78mIUOKENu01/9LNPXBdRHs13aX3sdkURQrieoxGSS1
         LCK3aZ5i/C3ZAKEPcR6k+DNQZOvKx/ISAJ1BEe+VeornRd67YJmZlksL+f6rJbTvNuY3
         X9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FH5UUjbVRVLGG30ILlf1Mw1a+mIb68P/1duZpHI6CQg=;
        b=nKkfuccXYjhU8eDaqWLn5RD/EjO73ZFrmruo6hlHqFmAaT2OGgunRFC3BqZzeBP5KF
         6EB+jdcORllfyZ+Lc0yJIWFTtLhn8PgbpglxyFBYifzYtL9adq1UZsAXv3Ua4i8W5S84
         qVX0cNIbmhAH/ZJnjHLotDwNJPId2nkwET3COI3BS4OnRpFLO7Pt1Imo00qWiv70NJxk
         BYzligyXJLQEmPFtYsQ3aDSGq4W9ZsTv+aG2cea469fWa09gA6t1Ngrj6sxA1L+/AdQ1
         4F07sKwhosES5vFFDvYYiIb+rqjKVPIxLH/oIWqy0tFXbKl9RN1X5kC3hyzLmhUe//Au
         uaiA==
X-Gm-Message-State: AOAM533hcOpo4dgroaS/rHTrZboyv1Vse8Ae5CbFrToXs31OpVnx8pCI
        yzRP2agrft+G/ef8ASGHY9k=
X-Google-Smtp-Source: ABdhPJz2m3VqwmCNYz3224c/S6uHbCY0/Pwmajjif0XaIWb8BojiMlNyAAaQuM69d4qpmQRLUKWJQw==
X-Received: by 2002:a05:651c:555:: with SMTP id q21mr3721947ljp.6.1598827445638;
        Sun, 30 Aug 2020 15:44:05 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id h8sm1176717ljk.138.2020.08.30.15.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 15:44:05 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] const_structs.checkpatch: add pinctrl_ops and pinmux_ops
Date:   Mon, 31 Aug 2020 00:43:52 +0200
Message-Id: <20200830224352.37114-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All usages of include/linux of these are const pointers, and all
instances in the kernel except one, that are not const can be made
const (patches have been posted for those separately).

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 scripts/const_structs.checkpatch | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/const_structs.checkpatch b/scripts/const_structs.checkpatch
index cd45cb3c2b04..1aae4f4fdacc 100644
--- a/scripts/const_structs.checkpatch
+++ b/scripts/const_structs.checkpatch
@@ -40,6 +40,8 @@ nvkm_device_chip
 of_device_id
 pci_raw_ops
 phy_ops
+pinctrl_ops
+pinmux_ops
 pipe_buf_operations
 platform_hibernation_ops
 platform_suspend_ops
-- 
2.28.0

