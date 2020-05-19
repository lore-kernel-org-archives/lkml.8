Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43967C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A83120674
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qDxV66tU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbgESSO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 14:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgESSOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 14:14:25 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4294FC08C5C2
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 11:14:24 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x15so291951pfa.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 11:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=GWcc8oVpXNGnhmVFSGsMCYNch8YIZsE+7UZfyDX1b1s=;
        b=qDxV66tUkSvuPJb7KqJEMgMn6a6QQv5vMRFGKOOlXTaP9TVGqmf+swUWW6F3ibePpm
         jGMjoYXGMJ8J9WOVwGakwM02ksOKmj9XmG+n8Y08QaAYsEih7trLFLwaLPbOB5jjIQYf
         M6VJzccmMaUWK4jw+axMKaSnumIKZgFkncQKmXSBkOGyjK6KpvLwByruFYP26AUeF48n
         vZhgrMVSMOJCgzy1lqW8+8G3bJ3vjtcERhDeWf4LqQeSdMGrK3jtpSbPFVjEOSJ6kmfE
         MAkCOVpIY+z2/rCAXGW5/lFvs+sNwcKa8qUi9vV13a7eZ1lUXNUp0T4k2DnxpCWlFWg9
         FWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GWcc8oVpXNGnhmVFSGsMCYNch8YIZsE+7UZfyDX1b1s=;
        b=NlLuaWO/Rxdfn4DtG/u7/uXZR/diUmLZqonNWm+XSJjJCgwcNc/l+caNDLo1VjXCYh
         0L6JtPUvL1RhgVUNbQP5KjaLOGLwQSYMNrS+n6loEsXjSE+Er8BHZuqMTm3dI7NCLT3c
         EW+a5QwCY74RI6p/6wdiN2+2IYJNgxTBTigAHH6WO+8yUMzxy+RxD8wNygP++YSER1Kp
         O4XigOqXbL5qIXuZffKbUvJdrLpR+GBrt1ouc+x+ASp0Ykp1eb45zsoz4xSg1L5Wxc1w
         odkiPjVoQhCQ35pnPvvUdoKfxsdGn3SCFx6JqWqmEt05CRxfpk8bFidb+V7gCo0voBlm
         AAkw==
X-Gm-Message-State: AOAM530bURskIFYNTK2OXYAlpeuuHXVE7luRR83eXpHDrWyDbX6HaiV8
        GWyP/hYFtqiG4rusjAt3RTrB
X-Google-Smtp-Source: ABdhPJwugN3E28mkgq62MwyOHN6GuwFZQCbSjgrj5P9JL3FNCPKsli5EFHbI2c2y0hHHPx8+GvXwhA==
X-Received: by 2002:a62:5487:: with SMTP id i129mr312992pfb.77.1589912063535;
        Tue, 19 May 2020 11:14:23 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:908:98af:f00e:87b6:e4b4:50f0])
        by smtp.gmail.com with ESMTPSA id q201sm156543pfq.40.2020.05.19.11.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 11:14:22 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] net: qrtr: Fix passing invalid reference to qrtr_local_enqueue()
Date:   Tue, 19 May 2020 23:44:16 +0530
Message-Id: <20200519181416.4235-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once the traversal of the list is completed with list_for_each_entry(),
the iterator (node) will point to an invalid object. So passing this to
qrtr_local_enqueue() which is outside of the iterator block is erroneous
eventhough the object is not used.

So fix this by passing NULL to qrtr_local_enqueue().

Fixes: bdabad3e363d ("net: Add Qualcomm IPC router")
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 net/qrtr/qrtr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/qrtr/qrtr.c b/net/qrtr/qrtr.c
index 7ed31b5e77e4..2d8d6131bc5f 100644
--- a/net/qrtr/qrtr.c
+++ b/net/qrtr/qrtr.c
@@ -854,7 +854,7 @@ static int qrtr_bcast_enqueue(struct qrtr_node *node, struct sk_buff *skb,
 	}
 	mutex_unlock(&qrtr_node_lock);
 
-	qrtr_local_enqueue(node, skb, type, from, to);
+	qrtr_local_enqueue(NULL, skb, type, from, to);
 
 	return 0;
 }
-- 
2.17.1

