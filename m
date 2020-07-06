Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D27BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D2742070B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELwPSFaA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbgGFO07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 10:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729301AbgGFO0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 10:26:44 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D304C061755;
        Mon,  6 Jul 2020 07:26:44 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e4so45644887ljn.4;
        Mon, 06 Jul 2020 07:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IdXS2zHOX2BlBkxnBhep7q+a962Ik4UUszEKGg90Cxk=;
        b=ELwPSFaAlsrZ09Vvk1MYpH0UTTRny6IURyRdbYvF19kBXrBixZaltnk9zHwMQjzkhn
         AWZvRRDxEddUr8YLNYQzambWM6DP0EYYblJV+X9jnvEVvFRT8q3t6vB+g4Qo5BY+B4ge
         lWzLyOO1iZq79V7Mi7AMJywWjpVjJP2iiKNi+QVm8q0flyzku7Lpg6al8Kjn7p88uKPF
         cCjAxa8Q7BclZegCjsWvEW7LXGe9SmVi6pp6uyCPETAbKyTt7y0z5Pd6Jtw3A5vus0oI
         BMy9f7OpSU4lBd8KlzNyU4V1ZVmpiP05c5Gv0j8GERzpghi3hzorsUkDWRlGnf/ozaXO
         n0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IdXS2zHOX2BlBkxnBhep7q+a962Ik4UUszEKGg90Cxk=;
        b=ZyAk+redRLohWExQtxdFcQmGQ2Y/pipI4QwvmSVIM7Vz5K+mtgiWQcQTNtnjhEOhwk
         VNTfOyweLmG1D7g03q/nrAiT45u0nOb5Cr3zGNkWQbXm+YjoolsJp6I2zYPhxUclV0HH
         iLBy+raexU82mLcDeExkYbmda4OHzlHVBMl8BiC9DbYb52MTg2wOCUNE8Z0Ob+/qcgKR
         ORu6HGz2dY1LW5uwQwtKSVPN81AnV+5JP1UrgkJqDnYtcHBHWAZIPa1psB1y7sqavMMg
         //mX6qXuI4aELzsuxYR+CvCwe0OBg8cmqxKocQRa6nkyDSsWKcWU+o/Ebk5PuyJBS17H
         g8Xg==
X-Gm-Message-State: AOAM530KCscNuMYaGjUclL68QZuIfp7+BKISpW3fN/Kpw0oYWU6XW1SY
        xzoinhJrW/QDFqSVvvcQeqY7BKw8
X-Google-Smtp-Source: ABdhPJx2536UwTM0r6F8Cht0cNSJ+e5TEgYfI1W4CbxVvYLDweIFk4gzgQL7zdVo4VbSYeKvLCYO7A==
X-Received: by 2002:a2e:9908:: with SMTP id v8mr23281161lji.186.1594045602593;
        Mon, 06 Jul 2020 07:26:42 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id m14sm11744638lfp.18.2020.07.06.07.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 07:26:41 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Fugang Duan <fugang.duan@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH  4/5] net: fec: get rid of redundant code in fec_ptp_set()
Date:   Mon,  6 Jul 2020 17:26:15 +0300
Message-Id: <20200706142616.25192-5-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200706142616.25192-1-sorganov@gmail.com>
References: <20200706142616.25192-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code of the form "if(x) x = 0" replaced with "x = 0".

Code of the form "if(x == a) x = a" removed.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 drivers/net/ethernet/freescale/fec_ptp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index e455343..4152cae 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -485,9 +485,7 @@ int fec_ptp_set(struct net_device *ndev, struct ifreq *ifr)
 
 	switch (config.rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
-		if (fep->hwts_rx_en)
-			fep->hwts_rx_en = 0;
-		config.rx_filter = HWTSTAMP_FILTER_NONE;
+		fep->hwts_rx_en = 0;
 		break;
 
 	default:
-- 
2.10.0.1.g57b01a3

