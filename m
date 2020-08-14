Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAB7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0D7320771
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E1U4hFDl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgHNLli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 07:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbgHNLkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 07:40:19 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E87C06134F
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 04:40:13 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id p20so8089309wrf.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 04:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B0W9kY9gOABObNMzFU7qR/h3u0fr5wbeuus7asIVtUU=;
        b=E1U4hFDlHsWCrCkg8hTw44iOHiljc6bi7sr1Wngty/U98hc+h9XGcyQ8CEPIhui25F
         417ZFpDXtzly+m5CyiKiImTP9a7jsJEnrbK2mDUY4RV2aUb8RAaOTOeYXrnu7x2pZkJP
         MXMXxJm2OxEMEeCtooLzYPX5nKAMBlZ8mOkgLiyuBoIxkxGXJcrQPFqxhI7DueNgEDNW
         1Tko1MSqREU27ERvsb1rPQmtYkym9UhJw73R4INHVU0lLcDfaladGaiFIpKRdzSlBrGl
         uhWKAE6rof7skSjSOHuNbtr8UJgLSnlj/vtEhmYu5cLxOVa6hirwnLYWuAtE2zYZv3rN
         WPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B0W9kY9gOABObNMzFU7qR/h3u0fr5wbeuus7asIVtUU=;
        b=FRN+8QUsj/86Ge2NPFrMOGcflncyHhnWF9VpwN0Musni9idb7ibAkYK/xxwL/FireS
         M8EDOzHXXAHeEGjy42oLmc4+HxTltljtk0tPGY69yUpZejNWlMk+DsnCdgoHjxZ8x4PI
         6Mr8yNuxRUTwZ+AdXj+gWTW4bnMWce3nHN2AjgdOOoQFQzA2pnKtAchsWHT6hNDhE3GL
         lTGOBsJcZqbKBUBmD2bea7+Yan/o/yA1UVkEJH3cCYHdNt9M1+duOo3zTukbfUY8gz/X
         Cb8eL7G2OOQyS1oYBcMvEmPYuFhy9E7PgegJqxKOTEyuRz134X8iHbmyEJOhRJ5s3XLU
         A4Ig==
X-Gm-Message-State: AOAM531LxdhZj505KBoGw4rZP3yH0kjcSqribY5eYtnybGlxnPprUaC5
        VR9GR7UHDZKgadfHGtMZEhwA/A==
X-Google-Smtp-Source: ABdhPJwZp2MJiKoowkR6rTySosLQ4LI6NDWDp3ihnDEADkd3a0DOkIa7HHs6uIgFFvyT1RnLJb/lDA==
X-Received: by 2002:a5d:6748:: with SMTP id l8mr2534059wrw.358.1597405211761;
        Fri, 14 Aug 2020 04:40:11 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id 32sm16409129wrh.18.2020.08.14.04.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 04:40:11 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Luis R. Rodriguez" <mcgrof@winlab.rutgers.edu>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH 20/30] net: wireless: ath: ath5k: base: Fix kerneldoc formatting issue
Date:   Fri, 14 Aug 2020 12:39:23 +0100
Message-Id: <20200814113933.1903438-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814113933.1903438-1-lee.jones@linaro.org>
References: <20200814113933.1903438-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc expects attributes/parameters to be in '@*.: ' format and
gets confused if the variable does not follow the type/attribute
definitions.

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/ath/ath5k/base.c:1111: warning: Function parameter or member 'ah' not described in 'ath5k_drain_tx_buffs'

Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Nick Kossifidis <mickflemm@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: "Luis R. Rodriguez" <mcgrof@winlab.rutgers.edu>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/ath/ath5k/base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath5k/base.c b/drivers/net/wireless/ath/ath5k/base.c
index 65a4c142640d0..b70acefdc3fb7 100644
--- a/drivers/net/wireless/ath/ath5k/base.c
+++ b/drivers/net/wireless/ath/ath5k/base.c
@@ -1098,7 +1098,7 @@ ath5k_beaconq_config(struct ath5k_hw *ah)
 /**
  * ath5k_drain_tx_buffs - Empty tx buffers
  *
- * @ah The &struct ath5k_hw
+ * @ah: The &struct ath5k_hw
  *
  * Empty tx buffers from all queues in preparation
  * of a reset or during shutdown.
-- 
2.25.1

