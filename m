Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B24C43460
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3961F2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kzgxGc3N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730374AbgGMOvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 10:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730064AbgGMOti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 10:49:38 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87043C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:49:38 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z15so16857331wrl.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TMIlOVRDCYaSAty7/afpaXFLg9AMRQm1G5k0VXrMmr0=;
        b=kzgxGc3N8RHSM05U2cbTEttiKSICBcl2ap2J0SyaJCAFyWNkScXmvzI5l9237ZFd1d
         tYsXS/CeVODSP5dh4AWxjwEuEkqLu+CgMnsfbDviVEovHt+0LGQZFxUHJruUpQtDWG72
         qo5ALHeTQEJI9nQQsPE1He4vUb8WBW76u4uqMfiS0ju6c42oM7GTIJz4gufaQDzEsjpH
         ezTKmNoHvf7lI7S2BZ5C1i5uvizrblnH0UrVvxd/Yn/iBUuFoaCcKGDq40SFwrGKhTOo
         tKxOdIxWkjDQywgSxP6+Va8svUfh1YnRBM/zfU2PLdIyms1JpFYFkoqfCIE2NUfGNhGp
         vIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TMIlOVRDCYaSAty7/afpaXFLg9AMRQm1G5k0VXrMmr0=;
        b=SFGkcMdKcXFdEBmq+tH1YzYoZ2KnrHV33Y0rxIL6H7qKSs0x//xfDP8s6vpBioVVQR
         RXJN0mSwdLCAiXCvOFPefkRcqOO7I4UpJFd5X8zq410ARatyB6Egw0T6/eDz87Jdkkih
         u0jHYbN1peENkT8wl+WCNYdp+hv0NzMgnBBkhOsfZoZc47UJvfLO8cEMNpHBoigiEsN6
         Mjyq7sJvXZFlCyb6hkpfQGsGQJPCJGFXnb3nRswJ1QllJzVmXD3F2hgEYfKTz6kVwh7L
         UWeX5tPwbZnIyV//H7sQoLCL+TFO/FrE5eFP20LyeIZxCdC3Qz2BNtB7NzCh+NXtyDkX
         J8ww==
X-Gm-Message-State: AOAM530dSXS2bc5pKpQFhmNAfMxWgy3MBh9BG45lbhMc6as6SW2GO6uY
        cEya7OHplZ/zCtT7esazAXX73Q==
X-Google-Smtp-Source: ABdhPJwTKT4GJlQvG77L7gfYBSDpFZ6xtFBDE25t9ON82D4FbSU0ehp1cSeDnYtWZ7DbCKQ93IbN9w==
X-Received: by 2002:a5d:684f:: with SMTP id o15mr76695440wrw.148.1594651777326;
        Mon, 13 Jul 2020 07:49:37 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.6])
        by smtp.gmail.com with ESMTPSA id o29sm26207756wra.5.2020.07.13.07.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 07:49:36 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH 04/25] pinctrl: bcm: pinctrl-iproc-gpio: Rename incorrectly documented function param
Date:   Mon, 13 Jul 2020 15:49:09 +0100
Message-Id: <20200713144930.1034632-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200713144930.1034632-1-lee.jones@linaro.org>
References: <20200713144930.1034632-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/pinctrl/bcm/pinctrl-iproc-gpio.c:141: warning: Function parameter or member 'chip' not described in 'iproc_set_bit'
 drivers/pinctrl/bcm/pinctrl-iproc-gpio.c:141: warning: Excess function parameter 'iproc_gpio' description in 'iproc_set_bit'

Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pinctrl/bcm/pinctrl-iproc-gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c b/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
index a38f0d5f47ce9..e2bd2dce6bb41 100644
--- a/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
+++ b/drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
@@ -131,7 +131,7 @@ static inline unsigned iproc_pin_to_gpio(unsigned pin)
  *  iproc_set_bit - set or clear one bit (corresponding to the GPIO pin) in a
  *  Iproc GPIO register
  *
- *  @iproc_gpio: Iproc GPIO device
+ *  @chip: Iproc GPIO device
  *  @reg: register offset
  *  @gpio: GPIO pin
  *  @set: set or clear
-- 
2.25.1

