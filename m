Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03412C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADA7E207DA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Xld7pf9N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgGCIIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 04:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgGCIIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 04:08:49 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B0CC08C5C1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 01:08:49 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id m22so4386794pgv.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 01:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LopYcBReotgDbclY6Ugi+8EmAR3M5tNcqkkP14Z9nTg=;
        b=Xld7pf9N8UfN4jsDJAe6Hh2FF4L9lb6K+ue4w+tAfAhL+MRotWDvoia9rVLGVgyso8
         Koy0WouCABcH6Jl10YYmNuAkOXiCVECGQMRRftSQk6+AD/5ItW45Y2TqY/pZhzXEo0KP
         Izu+ASc4AJ13gdCQnkXVZ+YIw7JbOY87mwwejNf0jXfz8v+Bbdah8qavy6oaSkaMZlCX
         LJ/vQGOCgCdYUuSaS1dALl/gL3sMNJyDfJhMvj1hUF/2FHHr8UUVDCfez4C2jrQNWEJK
         Se2c/f20NK8h9rEY3y2QKS5xqaNS7+Z62CoCG833UHCFYEm8lNyi6dsC4ct03KlyiJCX
         ecyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LopYcBReotgDbclY6Ugi+8EmAR3M5tNcqkkP14Z9nTg=;
        b=KlLWcS3YvqG+UiFvr5ewNXAio2x7ATk0KfULaorZxjcAYzCJzU1QsA454VhVK//afu
         SIGDUy3Oe0ZP2+fbzHbHz31MXUlMcAIZ8hrGOLVhSwalwQc8EwFP6kQ7NW11F4Hc1Bm5
         gLl7ml24LjmlzBEJjUNECJ0J9SB8wDcrv1M32qHEwxln5rpTzE72ZKSqAGQtUKlNbUNJ
         yfBGsdWsn5lwDcsvY3iDxoFlw295OL97JG1g2OP1sbx0eGUIDxjnN9sywwBsNzWgr27u
         3vrN4Pk0qGEqsCJRWtDUnvKx4yfZn6ZqPIv3AJ1Ovmdk3qqKe51qk9848ZzcND4JrmP1
         A0cg==
X-Gm-Message-State: AOAM532DPNfpN60JgaOX0LKnIYgPFKvnjWZI3C39QVLdf6+GNS9s+3f2
        f4JVKPD6J7QjJQ9UF0Eipa3CzcwOYxQ=
X-Google-Smtp-Source: ABdhPJwnYnV9njrlub0/lwcAaqAnvuBLHb2JW8nngjF9lqyE5Ss1u8InN5KxnculbcWRKRVlJn1kGA==
X-Received: by 2002:a62:c584:: with SMTP id j126mr8539951pfg.213.1593763729126;
        Fri, 03 Jul 2020 01:08:49 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id n63sm11079988pfd.209.2020.07.03.01.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 01:08:48 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     joe@perches.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH] scripts/Lindent: increase the maximum line length to 100
Date:   Fri,  3 Jul 2020 16:08:44 +0800
Message-Id: <050476a0ee608046569588936394159d650ab535.1593763492.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the patch 'bdc48fa11e46 ("checkpatch/coding-style: deprecate
80-column warning")', increase the default limit to 100 characters,
we also increase the maximum line length to 100 for indent script.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 scripts/Lindent | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Lindent b/scripts/Lindent
index 1688c44c2df6..11f14a4f2048 100755
--- a/scripts/Lindent
+++ b/scripts/Lindent
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 
-PARAM="-npro -kr -i8 -ts8 -sob -l80 -ss -ncs -cp1"
+PARAM="-npro -kr -i8 -ts8 -sob -l100 -ss -ncs -cp1"
 
 RES=`indent --version | cut -d' ' -f3`
 if [ "$RES" = "" ]; then
-- 
2.27.0

