Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A41C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 06:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC0B2076A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 06:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mmLkHpFK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbgCXGLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 02:11:19 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36606 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbgCXGLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 02:11:18 -0400
Received: by mail-pl1-f194.google.com with SMTP id g2so6983168plo.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 23:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=unGw6c2ZufitdrNu+5YBhFURhwCE/NrCJkMv+/OxkYg=;
        b=mmLkHpFKTPFen+ZlFBI6Y5O7t5YQ+gxaypgDSVkVsy6No15tBsYyZBcivmIjXfDksv
         b8nhz4EZZ2iBHdAZ7Tf53h3eN7oiBb36Drk1mSKlYwOTqmSdtbBLdT8D520MXrTRurDo
         7xqv+yuWmiIwS9kVde5JkGflRvjNS1N0smgCb/x/OBmVu/h62TxHhWMIA3vf2r5q0HI7
         EV90UIZSFydnGLXruPL0t4iOGrEzSIZNZJwJkn4ydW3o9zWPxu8ET4+SGNZpv3TXtIK9
         Q9+q6KYZv4mAmT9CO61IAZeT3ycG053BCwPz8IEDllMnFHISUO5In3GGDuJQEk0jA6yf
         qM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=unGw6c2ZufitdrNu+5YBhFURhwCE/NrCJkMv+/OxkYg=;
        b=YeGu707wZLaUgjoumawU4R9jM/3sDJP34BrKzfMxUAsfl0dRRDCRzoDHs9kbshYfdj
         NCcNXoaAqTzy3H1XmgzdXQRmYO3oYByxOv5VMPR/zYKifBY5cYsdhoJkpfIJwll+xqGI
         u+Y2tr44L3yOXxdCdn5VPTmRGK+PVmGyk/JNX01KT8hVu0LdYg6R8Oir6Ww6QF8bVABO
         dzUXm9Y5vdj9d52fWUwUk7lNm8zbNR/Kq4oqsc5/tc1PintUu4ld5xiS5hVxVHzv/dFt
         koOrXGHkppPDBLrkNoPGBLTQw7gME6HDo3HMfOFvPjr6Q/L+BoKcDlbPEyLQPLAkJao+
         hn9w==
X-Gm-Message-State: ANhLgQ3FHSkon/etyPFUIFuWKh8WJ1bAkM3j0yi6AHqimwbXKXrp0OdE
        gEo73zXfoZJd4uvvIz8fGydk
X-Google-Smtp-Source: ADFU+vtFqc4TbjsXoMhXd7IiEHDc7u0CViodMZ/TFGvHx0UxE3d9nvIjRCj5jVigaJYM4lcFty4yXg==
X-Received: by 2002:a17:90a:d101:: with SMTP id l1mr3604492pju.130.1585030277624;
        Mon, 23 Mar 2020 23:11:17 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:59b:91e:2dd6:dffe:3569:b473])
        by smtp.gmail.com with ESMTPSA id d3sm1198230pjc.42.2020.03.23.23.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 23:11:17 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org, davem@davemloft.net
Cc:     smohanad@codeaurora.org, jhugo@codeaurora.org,
        kvalo@codeaurora.org, bjorn.andersson@linaro.org,
        hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 3/7] bus: mhi: core: Initialize bhie field in mhi_cntrl for RDDM capture
Date:   Tue, 24 Mar 2020 11:40:46 +0530
Message-Id: <20200324061050.14845-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200324061050.14845-1-manivannan.sadhasivam@linaro.org>
References: <20200324061050.14845-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bhie field in mhi_cntrl needs to be initialized to proper register
base in order to make mhi_rddm_prepare() to work. Otherwise,
mhi_rddm_prepare() will cause NULL pointer dereference.

Fixes: 6fdfdd27328c ("bus: mhi: core: Add support for downloading RDDM image during panic")
Reported-by: Hemant Kumar <hemantk@codeaurora.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index d136f6c6ca78..f6e3c16225a7 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -979,7 +979,8 @@ int mhi_prepare_for_power_up(struct mhi_controller *mhi_cntrl)
 			goto bhie_error;
 		}
 
-		memset_io(mhi_cntrl->regs + bhie_off + BHIE_RXVECADDR_LOW_OFFS,
+		mhi_cntrl->bhie = mhi_cntrl->regs + bhie_off;
+		memset_io(mhi_cntrl->bhie + BHIE_RXVECADDR_LOW_OFFS,
 			  0, BHIE_RXVECSTATUS_OFFS - BHIE_RXVECADDR_LOW_OFFS +
 			  4);
 
-- 
2.17.1

