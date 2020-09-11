Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D723C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 09:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CC5821D92
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 09:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KfefxcN2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbgIKJjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 05:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgIKJjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 05:39:46 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1531C061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 02:39:46 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id jw11so1441939pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 02:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KlLBYhev4Wfr30ELlYvsH52U84dkhIKc99s8OuU9b24=;
        b=KfefxcN2qmiKm7hShLw/DbW+tGavlLL9yPgswsVnIa1mZF/9xadoxJtaLstqBG2QQI
         2iFp2DEEFEOgr8UqwKZiS5kZav4nfauaqhjHUupxkrZEWPSo9XbX0QeAuvFGhY9v6k2O
         1c5fG89iT8bZxJpCepC3R2wbgtrXNTUGFSGhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KlLBYhev4Wfr30ELlYvsH52U84dkhIKc99s8OuU9b24=;
        b=bSuA11RpBc1+3g5Dz0LlxxSU1kaaALc+6zuTQIA1jvxe4CUhC+cW3I3PFzDnxXCscE
         XV6K2EOZuSbAXvXDw/7jrR2ZUPv/15NiHePjp23CCZVHaeldAFwC6sh89bvJGKeskWCO
         yofEF5Y4T+Q2cuBB+A+eW+C0LL+P5Q9nKbm9p+7P1EATII2M1GMxrfB5W1RT+cASG143
         hERrdCsSGcjEauabFYt3jNJH/qH73BoiiidXRal/ljEsEMHYD8LBM3bdCiA9YXznVD+s
         eCog7qyRhxbpEdr0o6FWsVUpYDwtW3ppikpeZ8GNo7HL87bdRLkUYN3tl0NHS7g/mbVu
         4M3A==
X-Gm-Message-State: AOAM532eRasAm/eQnQv5J6usl1I+mddfInHDcsbi+8xPfnAAopNoqd4M
        7tyA4rUNJ2Js/qpz012gRDXN3w==
X-Google-Smtp-Source: ABdhPJwI8ziC5/OM7tf5UKEvZbcS15PybCTYMTPLwIM6mRVaAnhqXfsGqJWqnsxQyXN/ZYuTJY7BoA==
X-Received: by 2002:a17:90a:184:: with SMTP id 4mr1482988pjc.148.1599817186148;
        Fri, 11 Sep 2020 02:39:46 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:1a60:24ff:fe89:3e93])
        by smtp.gmail.com with ESMTPSA id v1sm1433465pjh.16.2020.09.11.02.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 02:39:45 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Changqi Hu <changqi.hu@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 2/2] tty: serial: 8250_mtk: set regshift for mmio32
Date:   Fri, 11 Sep 2020 17:39:28 +0800
Message-Id: <20200911093927.608024-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
In-Reply-To: <20200911093927.608024-1-hsinyi@chromium.org>
References: <20200911093927.608024-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To use mmio32, we also need to set regshift.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/tty/serial/8250/8250_mtk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index 7b0dec14c8b80..41f4120abdf29 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -669,6 +669,7 @@ static int __init early_mtk8250_setup(struct earlycon_device *device,
 		return -ENODEV;
 
 	device->port.iotype = UPIO_MEM32;
+	device->port.regshift = 2;
 
 	return early_serial8250_setup(device, NULL);
 }
-- 
2.28.0.618.gf4bc123cb7-goog

