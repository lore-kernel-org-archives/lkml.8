Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EA0C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 20:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E2A820C56
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 20:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPeGRx64"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbgIDUvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 16:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbgIDUvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 16:51:00 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDCFC061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 13:51:00 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id 2so3747303pjx.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 13:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NF/DlTFr3CO7Zm3/didOQxlrQS1ovpJ5R8P371nvhlU=;
        b=NPeGRx64Zlo2p7VWTvzm4uZ5uVtq6heUWYOQHeioGKpgv4GspXg2zzQPPiBWXPK2qr
         ooajWzaH+ZdvoZPRrfSS1tahgyMGUkAHuiMoWVNu1hVMAmjK6CimdZXUcuuKYMFPO6jy
         CVPPKzldygukxMirGR1UZfJdMlopX+pl65itFp9MkHmgiLADPq7E+sMfruRCK6NM4hOk
         Qiw17YeLEt23wi5zVRVeGj9ldE7c7To9QnMwwFtUn5TYo1FdRWU6uZ6mugVtprCK3WUv
         AOf5hp7wmbufjTMbb1W+OD5emwB9YoSxA3xXZ0OSl4OOm/BmMRSOjuxX0sH8nD9Lk9y+
         OG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NF/DlTFr3CO7Zm3/didOQxlrQS1ovpJ5R8P371nvhlU=;
        b=YoSXzdel4A1HgntmXfXIK6LLUghUWqAu6TgPMImQDrzgJW4o551i73UR4POopqUVaA
         Ad76asV54fJk/CbuEtoNRv85rS1brS2J9x97amAEKtqenNWspMyvj+cOM9BChm6bcWJy
         q3sZQEYpObl04MZhdytxg8TQV947dmPQVP1/dhavNEeW+sVUa0IOqXKQr9Le8srGXTyX
         A8wArd0lznLG6To09PQ7i6USnxwfoKmXHcMcr0EXqv94Qp/0Lrg3SEQPz5yaKQUEYD0l
         rMak+Gkrmu6Nj4pFgcTNu7ErqllOxqxeCaC1ohkRRvX58CcPBC5tlI3qaB9HiSMqxk3l
         0Ayg==
X-Gm-Message-State: AOAM531i6zqnUm2JboDVJcU7MsV4zdf0x7MOC2fBhGaCK7/uISUElaFV
        aCZDgx1hMYnVQQa4BzsP+N8=
X-Google-Smtp-Source: ABdhPJxwibCP4zO3bV14qVU5GrjrL1NKSDtpQZQLmyjPjoV1lbhmtA3yXgS/0AsMxcpSQTbwm+ZXDQ==
X-Received: by 2002:a17:902:6a8b:: with SMTP id n11mr10543995plk.156.1599252659553;
        Fri, 04 Sep 2020 13:50:59 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id gb17sm6193305pjb.15.2020.09.04.13.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 13:50:58 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/4] soc: bcm: brcmstb: BIUCTRL updates
Date:   Fri,  4 Sep 2020 13:50:50 -0700
Message-Id: <20200904205055.3309379-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for two new STB chips: 72164 and 72165
and allows them to be tuned the same way other Brahma-B53 chips are.

The last two changes are some minor configuration changes to the
read-ahead cache logic to improve performance for Cortex-A72 based
systems.

Florian Fainelli (4):
  soc: bcm: brcmstb: biuctrl: Tune MCP settings for 72164
  soc: bcm: brcmstb: biuctrl: Tune MCP settings for 72165
  soc: bcm: brcmstb: biuctrl: Change RAC prefetch distance from +/-1 to
    +/- 2
  soc: bcm: brcmstb: biuctrl: Change RAC data line prefetching after 4
    consecutive lines

 drivers/soc/bcm/brcmstb/biuctrl.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

-- 
2.25.1

