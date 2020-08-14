Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137C3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDD0920771
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A4lGPF1q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgHNLk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 07:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728244AbgHNLkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 07:40:24 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B314AC061349
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 04:40:23 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id 88so8087028wrh.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 04:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q/FqIBvN+0t9cxA9lwdZNhMsYA5WtnJIGQaoCfh6kvU=;
        b=A4lGPF1qqK/RBPApsZIFq57DhGKlB1PAjwNHo/P9mkGoWhYVX2FUFDB3X6YgvnfJJ2
         RcdCitWbbFxdfmNq0Sa/GrH9nUBC4ynez6bbnunyyQP6QTiO4erJqN6e5BJFWaYGhS+G
         FUFc+eX7o3H1MTuWVjUdKmOSXehxLnjWbzMahw4+DGLu4aCkTBOZaGF7NA+UQ9Q6kTrV
         1hszVBGy0R+zA4+TEkE2u9M5hluxntA1k7qEqbL+TXsYfOmxWPuF/MYDU+GIdzg2bZEE
         D6NHZJAbxG1S5zUc53w1FRqMYKYAJyxuVvYRKO5T4mGG0EfDpfaA+LW3X/47qL3EctUM
         EJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q/FqIBvN+0t9cxA9lwdZNhMsYA5WtnJIGQaoCfh6kvU=;
        b=iw4MUQ2zyLR1KJdhewru6m9pWJh3MV1BVfWpJzrtU1GLYS5XXB7RdvYFDu17mlcOzz
         YHvBJKveuoqEenji1mMB9OMYUnjlMb2ZSQGM0EMmCvAdgG0dKNE8JrN3eCPzLDlLWveF
         Ps8B5bWEuaP9Y9NEbbyj5fBpfqPces2YNG5Riv8fwn0thWwVbwYOZVWfH2qKVC1D81wo
         N5ALcnpXJmNwYA1PK8jVOyRJ4dCoGqAuz4HZ89TN2Ujuvv+vWJWK1+hnH5xda5zh7k+D
         FNgmcRqzxLXnytNXu4RtddwbgqEmU37ulameE/CrHw065Ycc5vvJQ6zmO1F5IrmhIlSa
         j6Ng==
X-Gm-Message-State: AOAM533yh/RtBW1eqOrEc4W85It5klxVORLguqZU1KObFGAfJmBOGh/P
        n3HaYZNzfNCnqqTE8mR2xuJJbp/RqwTZDQ==
X-Google-Smtp-Source: ABdhPJyogUeYk5/qsdEeYYnSqznYEWxbRW72A4UIroawVH0GTeV1KZwjfpT083upB00uThs9eWNPkA==
X-Received: by 2002:a5d:6345:: with SMTP id b5mr2595294wrw.204.1597405222493;
        Fri, 14 Aug 2020 04:40:22 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id 32sm16409129wrh.18.2020.08.14.04.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 04:40:21 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        netdev@vger.kernel.org
Subject: [PATCH 27/30] net: fddi: skfp: smt: Remove seemingly unused variable 'ID_sccs'
Date:   Fri, 14 Aug 2020 12:39:30 +0100
Message-Id: <20200814113933.1903438-28-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814113933.1903438-1-lee.jones@linaro.org>
References: <20200814113933.1903438-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This variable is present in many source files and has not been used
anywhere (at least internally) since it was introduced.

Fixes the following W=1 kernel build warning(s):

 drivers/net/fddi/skfp/smt.c:24:19: warning: ‘ID_sccs’ defined but not used [-Wunused-const-variable=]

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/fddi/skfp/smt.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/fddi/skfp/smt.c b/drivers/net/fddi/skfp/smt.c
index a151d336b9046..774a6e3b0a67f 100644
--- a/drivers/net/fddi/skfp/smt.c
+++ b/drivers/net/fddi/skfp/smt.c
@@ -20,10 +20,6 @@
 #define KERNEL
 #include "h/smtstate.h"
 
-#ifndef	lint
-static const char ID_sccs[] = "@(#)smt.c	2.43 98/11/23 (C) SK " ;
-#endif
-
 /*
  * FC in SMbuf
  */
-- 
2.25.1

