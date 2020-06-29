Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8246FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F57A20675
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593460960;
	bh=Ug3cNKJnHBGUb+VWWfyKVtee2sfQFS0RCEUa9nf5CuE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=jfaFEPkvAbx5dX3dVvKWNSGCIIzalZVxIp/db4s97mlLG4sZeo70sG/StFxpiYIJK
	 IhDVpT8Wk1orrSHGxXimQn3grxTynTC+bTRuPRO+RL+L2sMSyJNYsZp9M8kb0+Cv3G
	 x+mU/J2bRweJNnX+fpzr8rdjzTjQcy7sQSHAEY2U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731849AbgF2UCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387619AbgF2UC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 16:02:26 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7A3C061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 13:02:26 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id d4so16620354otk.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 13:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w8kvw01QtTGGnsYhL3inZ/4k+CD9olJ2CUCa3W61+0s=;
        b=h1L1Z7dCrx47MCg268EgH0SJuOWCGNJVYK3LrZsWGdpQSI8cXVvV77KMlhMRwkXl+5
         5h1ZObJbPaMgUG071GI4uGPvN/JpsOIq1j302pkxd768GBERzyTzZYqMyV0ncuu27CI3
         uSwpLhh/RwPv04MiUhVNRC07ZflqVrx0sZYNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w8kvw01QtTGGnsYhL3inZ/4k+CD9olJ2CUCa3W61+0s=;
        b=LZrq25wCRFUs+3i2PS+b/h+efD38ZS6cMbUs17oNDvl3gaGxmlvso+JLyVLmYdNn5e
         p5H/I4Mm+tbsr6QXzOSmP+cxmKk9+N2/lJ01tgPLH1GsB0tJvs3hNdF4qIhLXcV/HJ7q
         cxpnKrgiRRodHvVrftrr+Y0ZdLmdfL3tq2oW3yL85XxfhTa3MT5NCPGxYMM42mdqpYJs
         ot8WQTD69b0piUmUn3MsEHTmQMcSPpHP/xjEuo8NY+gs9lgDBfy0cAphb8x6cMIhV8fX
         93OIFubZBVUxt4bzUftMlThU6xralSc9ykd1AchSSw4Qo5fWoUUcq69OpmgQ1ZhEAe6D
         xyPg==
X-Gm-Message-State: AOAM532KVcPTU9uUBLkIkHLRqHhpTmzRKRGu01YK1ohUpcvbEdR5/GP7
        Qf86oKGttJ+xeDZiLdtKLnWEYA==
X-Google-Smtp-Source: ABdhPJy2ZGQSMxPZ9QL1oqxm59wX+vcuGd8XulqX+fkUvR7Vkg2vUHQVJYME6VOTN++A2JPcd7OKJg==
X-Received: by 2002:a9d:4810:: with SMTP id c16mr2708947otf.197.1593460946248;
        Mon, 29 Jun 2020 13:02:26 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id p73sm213895oop.36.2020.06.29.13.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 13:02:25 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     trenn@suse.com, shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpupower: Fix comparing pointer to 0 coccicheck warns
Date:   Mon, 29 Jun 2020 14:02:22 -0600
Message-Id: <20200629200223.27322-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix cocciccheck wanrns found by:
make coccicheck MODE=report M=tools/power/cpupower/

tools/power/cpupower/utils/helpers/bitmask.c:29:12-13: WARNING comparing pointer to 0, suggest !E
tools/power/cpupower/utils/helpers/bitmask.c:29:12-13: WARNING comparing pointer to 0
tools/power/cpupower/utils/helpers/bitmask.c:43:12-13: WARNING comparing pointer to 0

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/power/cpupower/utils/helpers/bitmask.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/power/cpupower/utils/helpers/bitmask.c b/tools/power/cpupower/utils/helpers/bitmask.c
index 6c7932f5bd66..649d87cb8b0f 100644
--- a/tools/power/cpupower/utils/helpers/bitmask.c
+++ b/tools/power/cpupower/utils/helpers/bitmask.c
@@ -26,11 +26,11 @@ struct bitmask *bitmask_alloc(unsigned int n)
 	struct bitmask *bmp;
 
 	bmp = malloc(sizeof(*bmp));
-	if (bmp == 0)
+	if (!bmp)
 		return 0;
 	bmp->size = n;
 	bmp->maskp = calloc(longsperbits(n), sizeof(unsigned long));
-	if (bmp->maskp == 0) {
+	if (!bmp->maskp) {
 		free(bmp);
 		return 0;
 	}
@@ -40,7 +40,7 @@ struct bitmask *bitmask_alloc(unsigned int n)
 /* Free `struct bitmask` */
 void bitmask_free(struct bitmask *bmp)
 {
-	if (bmp == 0)
+	if (!bmp)
 		return;
 	free(bmp->maskp);
 	bmp->maskp = (unsigned long *)0xdeadcdef;  /* double free tripwire */
-- 
2.25.1

