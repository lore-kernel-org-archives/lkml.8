Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F81C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 22:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA1E02072F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 22:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sa9ddKfV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgFIWMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 18:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbgFIWMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 18:12:43 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE04C05BD1E;
        Tue,  9 Jun 2020 15:12:42 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id z9so27058266ljh.13;
        Tue, 09 Jun 2020 15:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3C9MNSSLz5k4HgIlBTzG1S99/DUa1Q5oTEHE9/q2XSM=;
        b=Sa9ddKfVX/pQhio3QNjTFPjLCbmHUnC5fk3Ftrz3tilCnbI3guBN3BDIXX/LxeVTns
         6biEY98ZL2oqWwfIC8YkUdM7IvXd91VL4CtHs3gZiL1li4sh25fE/sfJSfq7Ba/g8hXu
         zQtwxCtnzelHvfrBg26ACFr7WDcWAL2r2lKiB/G6brVIx520FaZToBpLhP9hkPbAEop9
         B4b66sXcSkz4HPu226x56vUdhVKeEpKI6m0+4NlQ7RV+Pt6r0mcjLzXp23Uo0muQY5Ui
         uwYmrFG/Y1jx+VGj29/zzv8sraI9blE6diNqKs37qhT5FkrVVS0qgzkbSI0rOUH95xgp
         gToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3C9MNSSLz5k4HgIlBTzG1S99/DUa1Q5oTEHE9/q2XSM=;
        b=tuYxM1lINCLfXt7/eU0lEBY1zuqjlplPZy3Rp507a065tfx3hxx9f9LAlImElNtNln
         IxcT0gYg6xnouX2mOieYFdBTvwYndy95Hjbr+8Bl7bdc/Kijwio14KaM3TfNDuPb0yOU
         rpK2VJNN/rMVNZEdEgbWoN5C4ar0pnuGyK5fRFZE+++oJcIBksyoLuWd59hIJjuK066p
         QmCSBfsXHBFG00usSvQk/8kNglCCsdXPaXC9JKxD32s8jM2F18uKcgpyiyiVASf7NM5h
         o/nMNbZo3JxFajs0iXVHzXVaZg8b1EdZnha9HAJ5gni3y5N2QEZt2GA8Vc31D+6+9D23
         h1bA==
X-Gm-Message-State: AOAM533SavKqzSIMl3V4Uojfz3/O+KdDUNqzoIEY59D+e+yLfh/icXmj
        e8Fd99jIRuj1mW/U4nPDHts=
X-Google-Smtp-Source: ABdhPJypP95cSn79r40HgE6S7hKvSZl2oE1/rs4o7jDGGcf0d82K+Y5JRA3Cy2G4MWTbIWx5KJpqsg==
X-Received: by 2002:a2e:98d4:: with SMTP id s20mr196514ljj.83.1591740761017;
        Tue, 09 Jun 2020 15:12:41 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-136.NA.cust.bahnhof.se. [82.196.111.136])
        by smtp.gmail.com with ESMTPSA id r197sm5289226lff.5.2020.06.09.15.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 15:12:40 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, josephl@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] memory: tegra: Constify struct thermal_cooling_device_ops
Date:   Wed, 10 Jun 2020 00:12:35 +0200
Message-Id: <20200609221235.44602-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tegra210_emc_cd_ops is never modified and can be made const to allow the
compiler to put it in read-only memory.

Before:
   text    data     bss     dec     hex filename
  27936    5600     192   33728    83c0 drivers/memory/tegra/tegra210-emc-core.o

After:
   text    data     bss     dec     hex filename
  28040    5504     192   33736    83c8 drivers/memory/tegra/tegra210-emc-core.o

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/memory/tegra/tegra210-emc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/tegra/tegra210-emc-core.c b/drivers/memory/tegra/tegra210-emc-core.c
index cdd663ba4733..2dfcc0e2e15d 100644
--- a/drivers/memory/tegra/tegra210-emc-core.c
+++ b/drivers/memory/tegra/tegra210-emc-core.c
@@ -711,7 +711,7 @@ static int tegra210_emc_cd_set_state(struct thermal_cooling_device *cd,
 	return 0;
 }
 
-static struct thermal_cooling_device_ops tegra210_emc_cd_ops = {
+static const struct thermal_cooling_device_ops tegra210_emc_cd_ops = {
 	.get_max_state = tegra210_emc_cd_max_state,
 	.get_cur_state = tegra210_emc_cd_get_state,
 	.set_cur_state = tegra210_emc_cd_set_state,
-- 
2.27.0

