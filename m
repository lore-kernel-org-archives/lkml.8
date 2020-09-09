Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E67EC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 19:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6F2F21D7D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 19:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEQEt0vi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgIITll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 15:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgIITlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 15:41:39 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D876C061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 12:41:39 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g4so4214230wrs.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 12:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7XrmoZ2BYly3f5uTpv031CSkAY88yc/On/yMOgU2Hd4=;
        b=UEQEt0viSrmmWl85zt2NVLgJjfkwH9EqFEr8VF54y2KvOTiW2yENFKBx/Ekpdoi7YO
         FO41CUYAoDI43CaHOvNAmKcdYumD0ozGr9o2iVNKEMoPt97OAkCcTPpTNilhKt39o/aZ
         0DAEQe1E4c7NaBt7bsB1j9Q/gfZzgOhfk2a98WBdIMYOAt/MlwpnaSLGkOEYKiLQfAT6
         cVLd2qGrZZJ3O2+BV9vTDWc7s7ixsaiNsypvMF5d/dQGdRosDcn1wUjGyLXRXR6b+DhH
         aRUw46uLc5nUEpTg3WKRk9Rmrh9KvDwEh5eY1np9BOmAvEdH1/29HHH3xoHa+Wbp3SK2
         i5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7XrmoZ2BYly3f5uTpv031CSkAY88yc/On/yMOgU2Hd4=;
        b=e+W4XypJaxkVapbZAjtoNY5gP/4DcqDOgrev/StEKDwW43vyk7162+prCLz9oaqXcK
         uXNcHAlD3/YhgCsjrwy9Nf5DA1GoQO3g1hMc/SOipQcMSyNyXMssdkA9Y0gQ5ZlxJPyE
         FRMMJPaagY7VJktn0ywwo/PRXbdgJsQV5+rnmZlAO39ToX4wZW1vEEn+/Wc0Ju9MZ5U8
         Y7gUG53Lc4ek7MGeIrcK8VcpAa+qjn+y0ykaOsAg30G3x3qS8BctHr6wIOmIV3AVXa0j
         U35TUBlOh+LeJeXL3/cSL9CwI4qDPmLzgSLjE/0zVJy1D2wzfyqMaB3ZHM2DbYIL2NBc
         vhWg==
X-Gm-Message-State: AOAM532B9uwNuJgQ7e8fSqgi9Jsy9eyoGIyyDZr474rB9lrPguR7MgO/
        fWECtk+ehFmDtbsKoBw6sMM=
X-Google-Smtp-Source: ABdhPJxRY8/qKNEGtWyZ0RIIXtrKPru23aEmWZffvyHIeOsyYCgDMinZJVn5WM3F/SsdsHeJNJ1DvA==
X-Received: by 2002:adf:828e:: with SMTP id 14mr5810669wrc.217.1599680496578;
        Wed, 09 Sep 2020 12:41:36 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id w7sm5633947wrm.92.2020.09.09.12.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 12:41:36 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] w1: Remove pointless debug code
Date:   Wed,  9 Sep 2020 20:41:32 +0100
Message-Id: <20200909194132.212925-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It doesn't seem obvious why zeroing sl before freeing it would help with
debugging, so just remove this code.

Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 drivers/w1/w1.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index 4f597b0fd1da..02a0e66144a4 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -801,9 +801,6 @@ int w1_unref_slave(struct w1_slave *sl)
 
 		w1_family_notify(BUS_NOTIFY_DEL_DEVICE, sl);
 		device_unregister(&sl->dev);
-		#ifdef DEBUG
-		memset(sl, 0, sizeof(*sl));
-		#endif
 		kfree(sl);
 	}
 	atomic_dec(&dev->refcnt);
-- 
2.28.0

