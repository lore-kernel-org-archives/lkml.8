Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E463C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DF40206E2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c53RgvRD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730234AbgGBOsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730057AbgGBOrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:47:00 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA10C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 07:47:00 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g75so27085650wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 07:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H2cePmcpx5tsP4U3KYd+LqwzZEatzdvDVRzwm5J/30A=;
        b=c53RgvRD10yT154GgQgeIyna2QYPrbkI+WTnp2UMoFo9CT36rTCyqrDngBqvuckw3S
         +oNa3YdgsimKjvPoCH/30TsKQMdDJPLwl5KHWSs/fy5BFSSaYO5/F8t+s9fUmd1kfbTt
         joQnwQce5qZ1EBcSIkEdbgflYXu4hOxUS6yHZw1bkvsDOdZNN1Lvp9vhf7mjC2cttpwR
         UMLjHgsZgsLUt6CM3mwFLJczW2/G2TFbYlK31eHuAJ0WUZDimWF74sk72FwUIAoR9soG
         5nDZgi3NL2ZhkzfWwoPAK4IyiU44YXnPmkhwRZ/mQsAqgQkNxutA+aNeEwTG27koO4xd
         N+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H2cePmcpx5tsP4U3KYd+LqwzZEatzdvDVRzwm5J/30A=;
        b=mTHindwold6Dgy+9F2//QChJ35t+9x6KNeouBjY5MK+wE41gSomEPiJJFvnHRa8CWt
         fSVEFKgASEMWU6qf0p0fgb/rdG5fkzX+1LQsLYdeljeQwAylFQ6iNQ/y+1LhVpyWzQQa
         H1LJCoGAxrK0JCu4F0PHHpwEFt90ameHLtDNGVC6xNAb0Y/Ecaf+0BS+Op8fogoTa9pF
         zo3PHx9CMWjd1dtaeKHBQPmLPZKepIkDbSsq0JcTO3k1L93bk5sUKG9F/5SwV1ibsGU7
         wKnYmOhhv9zIhmxzoaNI8M8dlMAQqBK1+qCq/AkLXmg/NR8LaI7viRFR8Ru57LyNcbas
         /pVA==
X-Gm-Message-State: AOAM531utSqBPQwvozrInse9BKPv+izLV5fmjzq29Df+FzFt+3nXogkt
        iQl9LD/dh5MiqXfGnmso1UXTQg==
X-Google-Smtp-Source: ABdhPJw0wDnk30+GzymRe6m8MX4bgQkP+1HG/vAC/QIiYL0ssvI94FAnR4CJhMTZpP/sPRSbJk6tYA==
X-Received: by 2002:a7b:c775:: with SMTP id x21mr17240384wmk.34.1593701218885;
        Thu, 02 Jul 2020 07:46:58 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id g14sm7002737wrw.83.2020.07.02.07.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 07:46:58 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Pawel Jez <pjez@cadence.com>, Peter Chen <peter.chen@nxp.com>
Subject: [PATCH 22/30] usb: cdns3: ep0: Move 'zlp' description to appropriate function header
Date:   Thu,  2 Jul 2020 15:46:17 +0100
Message-Id: <20200702144625.2533530-23-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702144625.2533530-1-lee.jones@linaro.org>
References: <20200702144625.2533530-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'zlp' was documented, but in the wrong place.

Fixes the following W=1 kernel build warning(s):

 drivers/usb/cdns3/ep0.c:36: warning: Function parameter or member 'zlp' not described in 'cdns3_ep0_run_transfer'
 drivers/usb/cdns3/ep0.c:705: warning: Excess function parameter 'zlp' description in 'cdns3_gadget_ep0_queue'

Cc: Pawel Laszczak <pawell@cadence.com>
Cc: Pawel Jez <pjez@cadence.com>
Cc: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/cdns3/ep0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/ep0.c b/drivers/usb/cdns3/ep0.c
index 5b3f682338e50..5b1aec80b2d7f 100644
--- a/drivers/usb/cdns3/ep0.c
+++ b/drivers/usb/cdns3/ep0.c
@@ -29,6 +29,7 @@ static struct usb_endpoint_descriptor cdns3_gadget_ep0_desc = {
  * @length: data length
  * @erdy: set it to 1 when ERDY packet should be sent -
  *        exit from flow control state
+ * @zlp: add zero length packet
  */
 static void cdns3_ep0_run_transfer(struct cdns3_device *priv_dev,
 				   dma_addr_t dma_addr,
@@ -695,7 +696,6 @@ static int cdns3_gadget_ep0_set_halt(struct usb_ep *ep, int value)
  * @ep: pointer to endpoint zero object
  * @request: pointer to request object
  * @gfp_flags: gfp flags
- * @zlp: add zero length packet
  *
  * Returns 0 on success, error code elsewhere
  */
-- 
2.25.1

