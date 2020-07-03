Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D343C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBCFA20760
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsuoDq6u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgGCRFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbgGCRFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:05:24 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A8FC061794;
        Fri,  3 Jul 2020 10:05:24 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id y10so34959985eje.1;
        Fri, 03 Jul 2020 10:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C/UWxzVDvwTfW/F7gJ0+araj1vhoMccjRG9HH4mrlsE=;
        b=QsuoDq6um/kA+PYzNdRYnkSK/ma9zRfY4lNMHvhHvnqvCqn+mSz5vBUrrUDPyFZV2A
         z5WDAO1mqIL5Bs/vRi9eSJAVhoWk/KsgiBtbjvQaU8d+Sp7EVgANG8kalehZSlnJ2AGF
         QSf5fm9ms55AQV2wwteA7ZpBojv5fIaB5rFacJ95ydfUWQCjWSjJP5pCfEmkiOEpqUEn
         yWmbK5sqxmzz2xyqwobIaS6UQkE6LM+x4MfYDl+GJRvsrDHBGHqrSy2SNYDKngz6yKrB
         N1cRy0MM6yYQX2efE+fZjNA7oOAcXbjDwqcejGNLd3puass84+m3GmAaD7n4WbWjKrMR
         9bDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C/UWxzVDvwTfW/F7gJ0+araj1vhoMccjRG9HH4mrlsE=;
        b=TQvbs4+NFKN2u9RYoEabdXaCGOZLW3TS8I3kRn1vD5Sf0Cw4IwvOfFZ9XMthtvU+kI
         clpRNhd3iNfFzDMOplyfppkuGQ8Ruah1D3UN7AAjGPJxJZOoYGt16fy4IkpD0BXItRl3
         mWGT19o2Oyblh4oJR98dfiqctvw8nhaGTIevi5qMHLLs44rE8mhG9A1mjvLy/gABEvWZ
         eWkGFyNk8C1Epjc41Prb9ViDZZdwNLBh+8NQOhpLQuS9bhCo+/8P0guyaXzAkIIgAx4o
         3TBgibC0ggO1bvFO4QBP1RBIDTUC1IamB+tD3cjudNc3TWNifD5/eqv4T+pLEMeeYdwV
         JQGg==
X-Gm-Message-State: AOAM532h/QuEMOFSYwmYKq1FRj4L1ttznTenLETzPN3W/yK0FZ9PT2Sg
        hL/Z2vCiLarmFII897ljTX2IUDnOZuU=
X-Google-Smtp-Source: ABdhPJxcEO/i7pQNO4/24cr20ggEZvLGQNx2bKIyHv0PMOyYojz+7xnQeV+l+krumVA4mBwfBykytQ==
X-Received: by 2002:a17:907:20b4:: with SMTP id pw20mr34380818ejb.225.1593795923051;
        Fri, 03 Jul 2020 10:05:23 -0700 (PDT)
Received: from localhost.localdomain ([188.24.137.55])
        by smtp.gmail.com with ESMTPSA id dg8sm14342272edb.56.2020.07.03.10.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 10:05:22 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-actions@lists.infradead.org
Subject: [PATCH v3 6/6] MAINTAINERS: Add reset binding entry for Actions Semi Owl SoCs
Date:   Fri,  3 Jul 2020 20:05:12 +0300
Message-Id: <78d63d97e3a8a8f7a9048b6eec74a9d158578833.1593788312.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1593788312.git.cristian.ciocaltea@gmail.com>
References: <cover.1593788312.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a reset binding entry to match all members of Actions Semi Owl SoCs.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
Changes in v3:
 - Removed the "-reset.h" suffix from the binding entry, as suggested
   by Mani

Changes in v2:
 - None

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 496fd4eafb68..5033de342f31 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1533,6 +1533,7 @@ F:	drivers/mmc/host/owl-mmc.c
 F:	drivers/pinctrl/actions/*
 F:	drivers/soc/actions/
 F:	include/dt-bindings/power/owl-*
+F:	include/dt-bindings/reset/actions,*
 F:	include/linux/soc/actions/
 N:	owl
 
-- 
2.27.0

