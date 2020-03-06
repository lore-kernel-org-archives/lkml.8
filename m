Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E18EC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F24F2072D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDBeq9tb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgCFKi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 05:38:56 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:33587 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgCFKiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 05:38:55 -0500
Received: by mail-yw1-f67.google.com with SMTP id j186so1793188ywe.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 02:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i8oFDlEjKTXEkp27gAlgE/r86E023g4raleT3ZcWqMY=;
        b=JDBeq9tb1A5OkcYN7ne8hRchnK8x+Fq37ru+O+Q+fD7WVcbhle0adu+Cdmr0brRaM5
         8vtoJn+q+iOBGjDEYBtmu3IjeIzh5p38VpPcORFAbmgXxKs6hDA2li882ZuOn6lOPZrk
         +9Pe06OR22siPhRjC5gTI2JFmcopftpJcIONCxLlEr4IgED1/jWQQ45CmcUBruNnlLqJ
         JXWmOiiOAq4ziwRWbhh75TcyyMeBjJby14CpboJt8h749mpqd9p/fH3TWb1j3a5X8l18
         co1Ib79LCPsCCGe6hAaVPqmR6OotNq7BAFLNwByPqjvXJgTcyCsihLWtdlsvhrXRTtBC
         qJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i8oFDlEjKTXEkp27gAlgE/r86E023g4raleT3ZcWqMY=;
        b=p62TgJorddc8uBWh4+0VPf3kMvKhEGgSXZLu/4vW/9cPIxhbD3p2mQCpDyWCJN7+a9
         xSE665ocXAZLYAYmIs3w9ZFjDXioPX4mOmzl1D8OKBrU+8oTZ5uIXGi/WMojbRn/kkgZ
         Yc9zkBw4JqWZg97B/J9yU+d/XE92jP0h7KereQR8PuxeqQeDu217YhHfk2BiNQS8F3tB
         QzmJQ6yScYpE+5cchrTpD+lv4yPAl2XzKZXgSwSqDJd6teyfLgzY2JBikS1L/y4EZUYt
         laxBiczF8gUOm8HsNl+itMHgdTSXyjRKU+PQDFgxCusiMU+QBkchGqrXr0/EwtstYEEX
         bcnA==
X-Gm-Message-State: ANhLgQ1TXJa2XuVJEFjUUIKCc1pAGT4x+YzM5fHh2YuEMILsKImYXdSY
        aNdmbfcrzMfCm4zc43g6MeM=
X-Google-Smtp-Source: ADFU+vvKy8+4rNwuHHdT+UTdEbLzaEdtIoXz141O2iee73ZMJ6cAVqem+QhqWc3dAu9IKjJxAwh0ww==
X-Received: by 2002:a0d:d303:: with SMTP id v3mr3167981ywd.299.1583491134096;
        Fri, 06 Mar 2020 02:38:54 -0800 (PST)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id w132sm13345575ywc.51.2020.03.06.02.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 02:38:53 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: defconfig: Enable IMX27 PWM controller
Date:   Fri,  6 Mar 2020 04:38:37 -0600
Message-Id: <20200306103839.1231057-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8M Mini and others use the i.MX27 PWM controller.
This patch enables it as a module so various boards can use it.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a8de3d327d03..d19ca82b3c40 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -830,6 +830,7 @@ CONFIG_MPL3115=m
 CONFIG_PWM=y
 CONFIG_PWM_BCM2835=m
 CONFIG_PWM_CROS_EC=m
+CONFIG_PWM_IMX27=m
 CONFIG_PWM_MESON=m
 CONFIG_PWM_RCAR=m
 CONFIG_PWM_ROCKCHIP=y
-- 
2.25.0

