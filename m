Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2059C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A36E720C56
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PLNdPqDK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390631AbgF2VW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729528AbgF2Swl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:52:41 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7099C00F818
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 05:32:23 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 22so15207038wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 05:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CmcV70ImeDYyJH0D86nMAPNtLmoBDPn40YdPz8GKRXM=;
        b=PLNdPqDKMGgcPUcP/wj6XHcodfWWaUwahn0fM8Nis0Z3g+IGDBQuQgfwhl+tvscw66
         0bWgg6XdXtXwj55wGKpPWE+CustOveiTYiE53BAPkQbfbUaak384QEuw3hTxZ0NTFH4e
         sUo6fniQ1atpO9eouosuvMdnPlGHmhCwHjmlrMt7uYm6ES9Kl/4oIlOaR9X+8svJhfai
         1XGu3s+iyX/dGMIHx1IM6fPCrW+YgvcUW9QGvkpS5zMlClxPVVl0cGmF4Mu3xsL8wtHN
         JqHNNRW6XasBi59uDasZ1MFEoJ7O1UEgOnyCUBjWfkvGYS/iSqIOALVNIP89ar/AU1dv
         RxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CmcV70ImeDYyJH0D86nMAPNtLmoBDPn40YdPz8GKRXM=;
        b=dpxk/2tjfBOxVWeQWGXOqRW2gMN4IYpDlrzXWASYixfPa5av/7QDXSTVNFPO1IPxqD
         bo3dkSsHumK7TuObl682k3YQJ5HKZOhGDFXsMygtyUmrMEj6qQbT0pUlD9ueHFQm69Qm
         A2RXkqWWUs9ti8Gd2+uxMRUH/V/+mh2QbCPBBjEEzwzePq3BOUwh7hRBRytWA39ch8RB
         xIgdi4B6BrrjwhHiqRS6kX9kMGOG3rSdiZ546x5tBtTpIlEKKEAab0cdcJIOUvntFd2g
         Z8k1DuMCxnJ2Pt3JvRG4HY+YOndreNBtJpzPUcergWT59nDenvT+fPFqKX+GGHdeDmtq
         NWJQ==
X-Gm-Message-State: AOAM533v6DIjw0Bm2QyiU/ZzhS1sZZVpGr7ndpVH95G3TUFRD/QmVTww
        wMdQBI+VS3P45VWR+ShNTnr+DQ==
X-Google-Smtp-Source: ABdhPJwt4s91RdM3HeV0ZjKpyywC+1yJrTUvPF1DKQrW4lw5NbJj9Mco8JDQ6isSDIY1/hJbYjX7fQ==
X-Received: by 2002:a1c:e18a:: with SMTP id y132mr16196622wmg.27.1593433942722;
        Mon, 29 Jun 2020 05:32:22 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id d201sm28064111wmd.34.2020.06.29.05.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 05:32:21 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrey Vostrikov <andrey.vostrikov@cogentembedded.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH 3/5] mfd: rave-sp: Fix mistake in 'struct rave_sp_deframer's kerneldoc
Date:   Mon, 29 Jun 2020 13:32:13 +0100
Message-Id: <20200629123215.1014747-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629123215.1014747-1-lee.jones@linaro.org>
References: <20200629123215.1014747-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Argument 'received' was incorrectly named by its struct type 'completion'
instead of its name.

Fixes the following W=1 warning:

 drivers/mfd/rave-sp.c:107: warning: Function parameter or member 'received' not described in 'rave_sp_reply'

Cc: Andrey Vostrikov <andrey.vostrikov@cogentembedded.com>
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/rave-sp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
index 26c7b63e008a8..abaab541df19d 100644
--- a/drivers/mfd/rave-sp.c
+++ b/drivers/mfd/rave-sp.c
@@ -96,7 +96,7 @@ struct rave_sp_deframer {
  * @data:	Buffer to store reply payload in
  * @code:	Expected reply code
  * @ackid:	Expected reply ACK ID
- * @completion: Successful reply reception completion
+ * @received:   Successful reply reception completion
  */
 struct rave_sp_reply {
 	size_t length;
-- 
2.25.1

