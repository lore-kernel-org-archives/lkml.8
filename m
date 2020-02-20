Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5996C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AEAC208CD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CGND8mQo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbgBTPOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 10:14:05 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37208 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728363AbgBTPOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:14:04 -0500
Received: by mail-pg1-f194.google.com with SMTP id z12so2090184pgl.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 07:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yzWbD38fGnPMNDB+mPMR8vs+Kyqti3fjaH0RxbMQHQA=;
        b=CGND8mQo6NA2hbXEsUuj6uXHfhFI6vwrpGHIp24GCGsxoHAMbu+rBb9ujY6WTKG0rF
         sg9gdEcoLJG5FVm+CgXPMTm2tjaU5HEEaE8EbRWA5EHhwWiSOgaR3NKKlPg8IEZfcPiM
         RsGA6v5TilXZmf+5auFkfmSQHWOhy8+Gcdn3IdwYaxCiPjstNt8W/TYx/8w7eFzcycXS
         1NdLOhrNEoOJCO4/QM2sloPIXxt57P8WcwrxZmwNTqSHAniSNzU/mnWquSOnLFVYlvQd
         mRjiLFwHocME/TCY9n5NzrmBbP1PlQUXxfrnsamj1uA4UZfv1jPMnZfETrlr5TT7evDd
         ulDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yzWbD38fGnPMNDB+mPMR8vs+Kyqti3fjaH0RxbMQHQA=;
        b=iKP/ohBAXJaMP8ZNhpOIhQwjhqJDlWqr8y6IvVMdbIML2CAM3x7S11smkcteVlf8ym
         K24tLC12XH16DJoC3kjboeTnfF4R44GNEUChkAbpxbbDJ3Hd8NMASwNJ+jhc0w9bsIpY
         z1cSvYNhcvMdZLqrb9iSKeF9uiweXu9gCLKNMq9gkUcYMsoPPQ3zEcl4HNuLEkNerHxd
         OUBHH9xy93lfOATGkdcnjvr6hxqLnR3E5Kve2tgC5jUgR/ZDXRu9L/J8g+JB9r/dn/VD
         2pvj+o30G+ImchdcPkT12x4s+63eI0kI8tdNe1eBHFeU2aLOrK/UUq5h4lvoc5DY07bv
         n2Sg==
X-Gm-Message-State: APjAAAVMl0+FnbgbAdHmCIvyaXDpfA8XIpKTGVISD/7PihRNSxcdh87O
        HWAW0l19HLzHL61zw2PfgqjiUwvwCw==
X-Google-Smtp-Source: APXvYqy+++z18RA5eKgJ3aaVOY5sb3E60qtfvQyLT0R3LHWgQrmt4iTPqhRkVF0tpM990OfICWUCNA==
X-Received: by 2002:aa7:946b:: with SMTP id t11mr31899751pfq.57.1582211644002;
        Thu, 20 Feb 2020 07:14:04 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:315:9501:8d83:d1eb:ead7:a798])
        by smtp.gmail.com with ESMTPSA id z16sm3865548pff.125.2020.02.20.07.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 07:14:03 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvalo@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 2/2] net: qrtr: Fix the local node ID as 1
Date:   Thu, 20 Feb 2020 20:43:27 +0530
Message-Id: <20200220151327.4823-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200220151327.4823-1-manivannan.sadhasivam@linaro.org>
References: <20200220151327.4823-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to start the QRTR nameservice, the local node ID needs to be
valid. Hence, fix it to 1. Previously, the node ID was configured through
a userspace tool before starting the nameservice daemon. Since we have now
integrated the nameservice handling to kernel, this change is necessary
for making it functional.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 net/qrtr/qrtr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/qrtr/qrtr.c b/net/qrtr/qrtr.c
index c758383ba866..423310896285 100644
--- a/net/qrtr/qrtr.c
+++ b/net/qrtr/qrtr.c
@@ -7,7 +7,6 @@
 #include <linux/netlink.h>
 #include <linux/qrtr.h>
 #include <linux/termios.h>	/* For TIOCINQ/OUTQ */
-#include <linux/numa.h>
 #include <linux/spinlock.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
@@ -97,7 +96,7 @@ static inline struct qrtr_sock *qrtr_sk(struct sock *sk)
 	return container_of(sk, struct qrtr_sock, sk);
 }
 
-static unsigned int qrtr_local_nid = NUMA_NO_NODE;
+static unsigned int qrtr_local_nid = 1;
 
 /* for node ids */
 static RADIX_TREE(qrtr_nodes, GFP_ATOMIC);
-- 
2.17.1

