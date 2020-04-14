Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7ACC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 07:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 998D220575
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 07:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWhgMvQb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406662AbgDNHa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 03:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406631AbgDNHav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 03:30:51 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1CBC0A3BDC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 00:30:50 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g12so4931040wmh.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 00:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Rwt7p9rV0ZpScS3OX0rGuyv3x/Zc5Fmy91OFilUZ1Y=;
        b=QWhgMvQbdUrtrel97IpCVi+K+iGufbSjnOoA6HrP+kHc7QLpRClgyLZPt/To2X1zLD
         zGwi7s7p30TVDfrGjxYXVA5WRFotAT2cgStakuBB5AvgCMtB/TQdUiIXnNZvcKT8p7XL
         EZ0L/ZNkOV618PvidBgSPyXtklufOJ/WK2MRpHnzHLCKIapm0o8+VM9z2JtFUT3CtqE7
         5/cmytS2jTxz8sa1YnDlC50zOH4qOmDsqM+ss1rQq05M5tqsOTzMQuL2KC3bhil0ocCx
         G0A9XlRrVG/OE/hUtszlsyfRtUikc9wa540m+78690soPnF2DD4wrAUKSQCzONBW5CXF
         6pbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Rwt7p9rV0ZpScS3OX0rGuyv3x/Zc5Fmy91OFilUZ1Y=;
        b=ZwYtvD77Z91sc/vJk6U1Puf7uiHrbVk+DtPHWbUn2lJ5zrG6a6Mn5mbP+3wA+9gjBh
         uBIbSMOmu+ffmoO9MHtbs/y8JfA6kisBApE1dOCICk7Y71jw0Z3bAvummdSpP7knDUwf
         9QUtc9dUCYJ8iHrdwXPTvq5nLvXOMgrSzro/Phtr2erW7pdnWPD7DhFJ9LzRbCuVQIsE
         BJpk9bZKsWndQyDzpmyFMgJDYhAIPC5cYcOCCHyxBKY1rP4yUzb4CdIP0FDl3xPvH78t
         oFa00nl424vmRjFgxOzYqugv5K66+khUpsl+eMWiJJJoybAw+9tqCNsZE1oNEIIrNgcM
         ZsGg==
X-Gm-Message-State: AGi0PuZvVPC0EnM/i0tlOMZyU+F6mJ0bd6wIyQ39A2JLAjY58dp/QN/9
        gS74FQ8jkp85MgYyJ8706Bw=
X-Google-Smtp-Source: APiQypIR5EPu+VhS8tNtQUnOjVREATqTvrressnlxnmBB29KUQZb99svQvmsU19ioztDuD9CYUCwKg==
X-Received: by 2002:a1c:4186:: with SMTP id o128mr2448247wma.21.1586849449238;
        Tue, 14 Apr 2020 00:30:49 -0700 (PDT)
Received: from localhost.localdomain ([31.4.236.74])
        by smtp.gmail.com with ESMTPSA id g74sm17755486wme.44.2020.04.14.00.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 00:30:48 -0700 (PDT)
From:   carlosteniswarrior@gmail.com
To:     gregkh@linuxfoundation.org
Cc:     nsaenzjulienne@suse.de, linux@jaseg.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Carlos=20Guerrero=20=C3=81lvarez?= 
        <carlosteniswarrior@gmail.com>
Subject: [PATCH] Staging: fbtft : fbtft-bus: fixed two checkpatch errors
Date:   Tue, 14 Apr 2020 09:30:47 +0200
Message-Id: <20200414073047.2757-1-carlosteniswarrior@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Carlos Guerrero Álvarez <carlosteniswarrior@gmail.com>

Fixed two checkpatch space prohibited before that close parenthesis errors.

Signed-off-by: Carlos Guerrero Álvarez <carlosteniswarrior@gmail.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 63c65dd67b17..cdb451dd3fde 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -62,9 +62,9 @@ out:									      \
 }                                                                             \
 EXPORT_SYMBOL(func);
 
-define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8,)
 define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
+define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16,)
 
 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
-- 
2.26.0

