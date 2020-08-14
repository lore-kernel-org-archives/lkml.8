Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C63AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 567CC208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U7sxSLVW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgHNLkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 07:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728243AbgHNLkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 07:40:24 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EEAC061348
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 04:40:22 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id p20so8089698wrf.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 04:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XO8EPoQb4LLTq78EddIBY+0bDLZNec0c1XiicaUFJYo=;
        b=U7sxSLVW1sh8DVHNuWMgFrMIpseyetwKXM8Pfy8sOE/mGMowDRS3KKckwCDm2Cltu6
         qUeQt0IXWET7Og1vfVvhhjeN190SZNq2N9/Btm8L9444qTRkss6jUErqKC8V8q+XuFo4
         MrhlkXXslgeK2Kn/tSqPvaYxPLzs6u/Z/J5AHt3MqEbYrA+RS7AmLohpC128ndB+0vtY
         a3EJDOQgaMqNPGvthcbFSAY1MwTX6aduR+ooQYmXTFuXDKYajNYYBV1kfitOALgCKHOw
         g1eMSIdSoyt8DsPMxi+6WJf4rVqcYkATcvNKzG7IzqfMMapnpINB1c8XnupmnDXG8Sju
         pwng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XO8EPoQb4LLTq78EddIBY+0bDLZNec0c1XiicaUFJYo=;
        b=JWkYJYKa5/VPFabuzx9mGpdyd5ba7c/ysJOmftPG67NQ/o5rBWYhYxo6g15jXnrEEd
         44zCAYD8G4tfbehAYmUCAT4LfnSUjYpruoPN0Gxdm0FsLvH+sb+xZW6Ms7bW13MirIDm
         aWJZUZpIAjL/2gjT2GuYKUHLajHo32x4puk/xWHtKL9pRlaXnyEnZanWIKO8wv+qxL63
         dT5ObCBFrIDBT2VbvcnIg+1oc2+QwGygXAaJE9BLlxtFZCZ3eN2wosScLUI0HRXL0H2q
         zNLPgUusNvKd5XrgDpzMUlwSguzhosJoqnU0ubz0vcRlIfGvhq3lKfvKF/CCiWC0uh80
         2Lmw==
X-Gm-Message-State: AOAM533vk4lELauKSnKlXjT5BWC98GDbH22763BPm3yojE4zSuTNKt0k
        RHXCNqMFVPEr1/jVsjlyKKygFw==
X-Google-Smtp-Source: ABdhPJyXRRYLrDoG3M9VfBg386tn7Y7Pbra593U8XbwJE8gHTjQ2o5hAlSZL15+Ss1XCPPuij8eTeg==
X-Received: by 2002:adf:edc3:: with SMTP id v3mr2357786wro.193.1597405220978;
        Fri, 14 Aug 2020 04:40:20 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id 32sm16409129wrh.18.2020.08.14.04.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 04:40:20 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Martin Langer <martin-langer@gmx.de>,
        Stefano Brivio <stefano.brivio@polimi.it>,
        Michael Buesch <m@bues.ch>, van Dyk <kugelfang@gentoo.org>,
        Andreas Jaggi <andreas.jaggi@waterwave.ch>,
        linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org,
        netdev@vger.kernel.org
Subject: [PATCH 26/30] net: wireless: broadcom: b43: phy_common: Demote non-conformant kerneldoc header
Date:   Fri, 14 Aug 2020 12:39:29 +0100
Message-Id: <20200814113933.1903438-27-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814113933.1903438-1-lee.jones@linaro.org>
References: <20200814113933.1903438-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/broadcom/b43/phy_common.c:467: warning: Function parameter or member 'work' not described in 'b43_phy_txpower_adjust_work'

Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc: Martin Langer <martin-langer@gmx.de>
Cc: Stefano Brivio <stefano.brivio@polimi.it>
Cc: Michael Buesch <m@bues.ch>
Cc: van Dyk <kugelfang@gentoo.org>
Cc: Andreas Jaggi <andreas.jaggi@waterwave.ch>
Cc: linux-wireless@vger.kernel.org
Cc: b43-dev@lists.infradead.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/broadcom/b43/phy_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/b43/phy_common.c b/drivers/net/wireless/broadcom/b43/phy_common.c
index 1de4de094d61b..285490f6f0a1d 100644
--- a/drivers/net/wireless/broadcom/b43/phy_common.c
+++ b/drivers/net/wireless/broadcom/b43/phy_common.c
@@ -458,7 +458,7 @@ void b43_software_rfkill(struct b43_wldev *dev, bool blocked)
 	b43_mac_enable(dev);
 }
 
-/**
+/*
  * b43_phy_txpower_adjust_work - TX power workqueue.
  *
  * Workqueue for updating the TX power parameters in hardware.
-- 
2.25.1

