Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB04CC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 20:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A684220C56
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 20:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpEQqCm3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgIDUvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 16:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbgIDUvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 16:51:04 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C455C061245
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 13:51:04 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id kk9so1207832pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 13:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CiIeU7VL4tMoVGzTU+NA9ADQCjCTiXtDHd4RfiX4JPU=;
        b=TpEQqCm3U0bm8vIfXBH7ZpINW0GzAA2v2l1AOR7PdceZ3Rqtw0iDq5cIbjBsJoUHHw
         AiIUBroQDv5sVxpMzGIp0MKqXgCX+jBzF9a+ROmyIzJAEfnR2U0SUh3yK0eXzrx/0FD/
         ZimrQv8wjydfRRM3Sj6NBaoTy6qp43DRr05Kg6/ZuQSukzUZIemtyT33gnMBoeMkuYCH
         rMqZv03e/ssGDdNjXcxF2NG0/Vy8nwTU69XfOo0bGkEd0H+C3CiECS0hgEPUD5FwXS7v
         zMUwbKoWaE8PmahUdTX2xkTYiuh01g8aKrRbGBKvdaDMt1WmHjN/Cps+YXc2vn60Ol1N
         9skA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CiIeU7VL4tMoVGzTU+NA9ADQCjCTiXtDHd4RfiX4JPU=;
        b=S/GneQlq6iG6wBedklU85haVnhV8Oo1YE9kJ934kLDba2xEeX+n6B7p1eLM4zT7eMj
         qthytFELZloFe/LzwtuQetSMAByJR2FnmMM9kY6WP7g9d/n30eVSutcFk6bV8JvYqRzK
         +7hrhDaHIQLkAhfuDslJTTlF5nVDcdZE4HnuOfpEJXGW8nvF87i4XefCv8fUpPXwBcyw
         yF9drd7zPXI3tET3SnytHle2ONeIl64rj3Cnd/OixhZv2lhTOJeLtdD4vGJq1nkXUMHe
         66EPHvzL7AtZyR02pI7s4MO3u4GSAwKr/jEfxl9hvBEgXxSNswaG7bXczxzlmrX37te0
         B5EA==
X-Gm-Message-State: AOAM530IlGH5HcL0NbVe6QjPRkpvlMFWhRotfDlDgaltg807fYrH2Edx
        Z9S4LBBvMBBPTVxsrOxMkb1hdEeOHu0=
X-Google-Smtp-Source: ABdhPJzC4UU7SlZa++HoA/QEWbA2QJaK1tz5LVrwGN7Y80q0tOgaZYPjxs72HElFd1mqzt51GqdExQ==
X-Received: by 2002:a17:902:ac8b:b029:d0:89f4:6220 with SMTP id h11-20020a170902ac8bb02900d089f46220mr8738797plr.8.1599252664111;
        Fri, 04 Sep 2020 13:51:04 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id gb17sm6193305pjb.15.2020.09.04.13.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 13:51:03 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/4] soc: brcmstb: biuctrl: Tune MCP settings for 72165
Date:   Fri,  4 Sep 2020 13:50:53 -0700
Message-Id: <20200904205055.3309379-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200904205055.3309379-1-f.fainelli@gmail.com>
References: <20200904205055.3309379-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

72165 uses a Brahma-B53 CPU and its Bus Interface Unit, tune it
according to the existing values we have.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/soc/bcm/brcmstb/biuctrl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/bcm/brcmstb/biuctrl.c b/drivers/soc/bcm/brcmstb/biuctrl.c
index a4b01894a9ad..d448a89ceb27 100644
--- a/drivers/soc/bcm/brcmstb/biuctrl.c
+++ b/drivers/soc/bcm/brcmstb/biuctrl.c
@@ -131,6 +131,7 @@ static const u32 a72_b53_mach_compat[] = {
 	0x7211,
 	0x7216,
 	0x72164,
+	0x72165,
 	0x7255,
 	0x7260,
 	0x7268,
-- 
2.25.1

