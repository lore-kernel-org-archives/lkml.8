Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83213C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 22:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58FA420738
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 22:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huthoZKn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgHUW0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 18:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgHUW0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 18:26:20 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88372C061573;
        Fri, 21 Aug 2020 15:26:20 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id v1so1343874qvn.3;
        Fri, 21 Aug 2020 15:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HrOAERB4tSMoXoJY/dYcv8QwQPeglxKI3SzuuvU5xXQ=;
        b=huthoZKn+508NeIu97asjfKk5ZibW6IM4BwjqcxZMPWYLra5ewPwdly+MfbsuG/QLg
         /8J4bHe3FCdTAaWgN1f+9zAk2hBtUQabdrpxqcr+bYnbaIgE0KglsnLM1B2CI8hWEMjW
         v2g9xTpt4HWouGnqaaBZmY2bLy+/A8KUyypw2yRLVXiI/Wi/0++zFTq6RCa+GvofiKbO
         oMH3tm9ILfkWDpuQ/eQ5LcSjaEGlHCGkaouhR09i+xxwU9Kd7vGD+kobDG1rQxwx4o2x
         OOk4mJ4QnSckrNzepGuU5gMtsCM1yGagTmh2AE3geFUXsq8bcKgBEn0HhgVmWs13eKsQ
         QItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HrOAERB4tSMoXoJY/dYcv8QwQPeglxKI3SzuuvU5xXQ=;
        b=PvRn00jmt/bgbFI/uiyoFa1U38sKy7OCYjFkJOJFf/qJTVTRn5buTdbUZC/jTIhxbl
         O2IXqRjCllRVbleSzvP4eXZTe3rmgiJoy2r8ljANc4pnPoeGI0GykreZqnjDwmUhQAwZ
         /TWNTdGvWy3/zPK6A1vfUow2J5JiOTf9377F4rXM97oU6Wn91a/A65SYcVs+R8Ub+nPP
         Ql+me5m937YywsnZbmmvVyQ0Imd+sPPZbKjmXNKYSFK8SPbbGfcgWvHE1OgWNj7E2HHD
         E1WICCtq5/Evadko/1hEwPDm2Kue/Jny95/MV2skJN4HYNXnk7oUra2l6wiLYlOH1pIY
         m/Dg==
X-Gm-Message-State: AOAM5309VHXC3Ik2mAZrAFxLOuAhtT7fLXkn4EGobIitTDqCY+8ib6J0
        ui+rQUjooe09CRW36S8hbVM=
X-Google-Smtp-Source: ABdhPJxmS78uvNp2NIm9J15TU+btuZga7HRhSpq2d0fpIuKjBRp8+b8fUxWDJ8Zt2GeSAQtcjSy/UA==
X-Received: by 2002:ad4:4ea7:: with SMTP id ed7mr4536770qvb.8.1598048779620;
        Fri, 21 Aug 2020 15:26:19 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:45d1:2600::1])
        by smtp.gmail.com with ESMTPSA id t32sm3649927qtb.3.2020.08.21.15.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 15:26:18 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] net: dsa: sja1105: Do not use address of compatible member in sja1105_check_device_id
Date:   Fri, 21 Aug 2020 15:25:16 -0700
Message-Id: <20200821222515.414167-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/net/dsa/sja1105/sja1105_main.c:3418:38: warning: address of
array 'match->compatible' will always evaluate to 'true'
[-Wpointer-bool-conversion]
        for (match = sja1105_dt_ids; match->compatible; match++) {
        ~~~                          ~~~~~~~^~~~~~~~~~
1 warning generated.

We should check the value of the first character in compatible to see if
it is empty or not. This matches how the rest of the tree iterates over
IDs.

Fixes: 0b0e299720bb ("net: dsa: sja1105: use detected device id instead of DT one on mismatch")
Link: https://github.com/ClangBuiltLinux/linux/issues/1139
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/net/dsa/sja1105/sja1105_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index c3f6f124e5f0..5a28dfb36ec3 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -3415,7 +3415,7 @@ static int sja1105_check_device_id(struct sja1105_private *priv)
 
 	sja1105_unpack(prod_id, &part_no, 19, 4, SJA1105_SIZE_DEVICE_ID);
 
-	for (match = sja1105_dt_ids; match->compatible; match++) {
+	for (match = sja1105_dt_ids; match->compatible[0]; match++) {
 		const struct sja1105_info *info = match->data;
 
 		/* Is what's been probed in our match table at all? */

base-commit: 4af7b32f84aa4cd60e39b355bc8a1eab6cd8d8a4
-- 
2.28.0

