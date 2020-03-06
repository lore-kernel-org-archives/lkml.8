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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967EEC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA4320726
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LeqqtLzf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgCFK7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 05:59:50 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:44602 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgCFK7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 05:59:50 -0500
Received: by mail-yw1-f65.google.com with SMTP id t141so1763371ywc.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 02:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TBvqtw1rT8oj53bds/9pHiEsrfFjmVYGB/WkMRXU24A=;
        b=LeqqtLzfeKmOQZLpcaR8j9znQ9JAD/wOHzJiUppULGsU1OylgqthG2XwJxJvoTMxFy
         Rw2qeixGoG9BYFvrU6lJc6Gk9IxsVLv49Wg+zJSrl8976wjf4J2XggJC5QWRUHntt2ZK
         sHLEGesp1zL2jILZ0z+rjVyKuefITlxFSHgjGkDp1Ifkw6C0S+Cxze3aSqxUpZq2PTOt
         BwwvjJMM9wAdY6tkpH0J6Q96WxMSGAoqC1HtV7w1/F3cc/kn5TcEdMvoN3NXO6SlU36u
         gFSH7SHvfAJ5yH+Zw4/X/uIBe73adze+q0vMnX394KdW26jtM/TQr2qw0zpJXm7g9KOD
         U6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TBvqtw1rT8oj53bds/9pHiEsrfFjmVYGB/WkMRXU24A=;
        b=Vuxg+Qxip86UWtDSHugsD27hSxqp3TT5Yoe9Q8PkF7C0f57je1vLgyFkyOyLHsNCCH
         K4NCgCOkaHamnDDE036YY+/qkewXEdlo6uykRyOV6LCvsyuV35FqySt9xhQHOgSUOvfV
         gcnNeG+c8Oh7zU2CLXquNmgsNHc2QEcA7w6n9OO4d92IFdhIoINnY+gcBDbiVOre84RC
         GWPC4E/a22k2q2eKTFqqTHzAh7fYIJw5AY/lB5nc1I5xm3B7yeBW4PEUQGSw/h6MHO8M
         iPammVS5Ppjz+M0+VpugxbVQ0WucHEif1q5nzfMkXBKqvvmUr2iGVexGdT80JAM9jAvc
         SIeA==
X-Gm-Message-State: ANhLgQ0GOp0XsKBTOS80zk8ORcs++In5FS74oLdpBhNxcDtDpH0BWdeJ
        t9KRyds9MCSHqQAy61DK6jAkxRPeHdM=
X-Google-Smtp-Source: ADFU+vvc5MWvUlx6fGSwjfqz5fE9ypyuPklzAgTPtnQyPQSNrECNvjeXBVQ49MSdX60DrEU/05vliA==
X-Received: by 2002:a25:7ac3:: with SMTP id v186mr3179149ybc.181.1583492387622;
        Fri, 06 Mar 2020 02:59:47 -0800 (PST)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id 133sm13775687ywj.25.2020.03.06.02.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 02:59:47 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: defconfig: Enable AT24 EEPROM as module
Date:   Fri,  6 Mar 2020 04:59:39 -0600
Message-Id: <20200306105939.1233360-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Beacon EmbeddedWorks Kit based on i.MX8M Mini uses an AT24
EEPROM on one of its I2C buses.

This patch enables the AT24 as a module.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index ab71a407288f..8018a52f6792 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -224,6 +224,7 @@ CONFIG_BLK_DEV_NBD=m
 CONFIG_VIRTIO_BLK=y
 CONFIG_BLK_DEV_NVME=m
 CONFIG_SRAM=y
+CONFIG_EEPROM_AT24=m
 CONFIG_EEPROM_AT25=m
 # CONFIG_SCSI_PROC_FS is not set
 CONFIG_BLK_DEV_SD=y
-- 
2.25.0

