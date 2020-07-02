Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD31BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94D592067D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y+Hz7s1H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730289AbgGBOsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729990AbgGBOqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:46:49 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6EBC08C5EF
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 07:46:47 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o2so28286835wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 07:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ekU/9fToolV+bnxY6uX+/NgRtkggBCTFheSpOeaBTsQ=;
        b=y+Hz7s1H9c6E1muboBIQnKa1duyLm9Puyw0SItMBVefMB9XgGsxNMgUvs1xGrvIgYE
         RobvU+GQKeiKScPwvyKiIuVUYUcLaE1/nvfdKccNfyv5+MvA5wCwfQcKVx7zK139D7Jq
         ZJUwxai3KootCSJFle1ffk2k5vJ0aiBsqqJkOf4gPxUh/FsKJownzbYSvOU8wUkV2kBu
         WAfo0c9r1FtOS3RpnmvBUg+i4NU0VPGXBUIm7ORvIkZowhL8kNJlVkVdsGFOiWxADhCF
         PK3W1qdTIqxSrOrWTRaurHqtBvnHIyZ+Wty4zVcZOHLl2ktHh3fjxQS5H1I+pgpOIXQz
         1kjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ekU/9fToolV+bnxY6uX+/NgRtkggBCTFheSpOeaBTsQ=;
        b=dElOwgKGhj69/FNxq+UWCaydj2Y7o3aTOdPwBTvPfpsr293GL9gYxJ7Qz+JRj6vuYh
         8bZcbj/NZUUxhO3afn8z5pY/T+XRILjL9NHz47cLPbhANYsVfASgop2qXM71qNfBn0zl
         +AU9sQgjdqQn7vs5/D/d3OzMiR12MgLecm31hXcda/1JTyJDhtHkhz75c5vrpLaED9Te
         C8aIUgU7yX+M51QWGdJ7KzQ+/HaHthNlWiOz+N0rMytb122MI/nngBwl1zTEyz1eUcJ+
         VZYNfZm2rVnEsjXwnVvyMLIj0bQi9+dxDIj9WB4Rx+UfLYZRKMAZMpr6WVIUGZzOh2LA
         VMww==
X-Gm-Message-State: AOAM532pEm8REhsIHxw4hud6imcC+mcuJtIRzcdlrnn9tlUccvdzmVgb
        TVRT6XCg3zxsm22drpmkpTVSSg==
X-Google-Smtp-Source: ABdhPJyOOLDdd4ToMUJ/Ps2rddIfsLpgMyUtYk7cO7KTC+3Mst0iapsfhCWCGek0yCKObOQbs9rkww==
X-Received: by 2002:a7b:c3d0:: with SMTP id t16mr34759591wmj.117.1593701205836;
        Thu, 02 Jul 2020 07:46:45 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id g14sm7002737wrw.83.2020.07.02.07.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 07:46:45 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Ben Dooks <ben@simtec.co.uk>
Subject: [PATCH 11/30] usb: dwc2: gadget: Avoid pointless read of EP control register
Date:   Thu,  2 Jul 2020 15:46:06 +0100
Message-Id: <20200702144625.2533530-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702144625.2533530-1-lee.jones@linaro.org>
References: <20200702144625.2533530-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ec1f9d9f01384 ("usb: dwc2: gadget: parity fix in isochronous mode") moved
these checks to dwc2_hsotg_change_ep_iso_parity() back in 2015.  The assigned
value hasn't been read back since.  Let's remove the unnecessary H/W read.

Fixes the following W=1 warning:

 drivers/usb/dwc2/gadget.c: In function ‘dwc2_hsotg_epint’:
 drivers/usb/dwc2/gadget.c:2981:6: warning: variable ‘ctrl’ set but not used [-Wunused-but-set-variable]
 2981 | u32 ctrl;
 | ^~~~

Cc: Minas Harutyunyan <hminas@synopsys.com>
Cc: Ben Dooks <ben@simtec.co.uk>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/dwc2/gadget.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index 116e6175c7a48..fa07e3fcb8841 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -2975,10 +2975,8 @@ static void dwc2_hsotg_epint(struct dwc2_hsotg *hsotg, unsigned int idx,
 	u32 epctl_reg = dir_in ? DIEPCTL(idx) : DOEPCTL(idx);
 	u32 epsiz_reg = dir_in ? DIEPTSIZ(idx) : DOEPTSIZ(idx);
 	u32 ints;
-	u32 ctrl;
 
 	ints = dwc2_gadget_read_ep_interrupts(hsotg, idx, dir_in);
-	ctrl = dwc2_readl(hsotg, epctl_reg);
 
 	/* Clear endpoint interrupts */
 	dwc2_writel(hsotg, ints, epint_reg);
-- 
2.25.1

