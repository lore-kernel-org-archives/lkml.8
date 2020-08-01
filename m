Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F039C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 21:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D0DA206E9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 21:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByDgdXPj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgHAVBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 17:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgHAVBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 17:01:05 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03959C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 Aug 2020 14:01:04 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k8so12172263wma.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Aug 2020 14:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=YNOPC6OV3IJPHCoLM7Sk8cEozPcvLYb3g8nhCI3rNjw=;
        b=ByDgdXPjj0NlssWjr8JfIFbtljdpLzNBF/AN9bUxJGEZ1lH1Q/EC3HUVuJosse5AjQ
         J+TMbEgWjOylaIzNXKyV4X8+0xS9NTCpuCfYTP6DHcQwApbynuIOtgLpFEe4UYBf+MDc
         ihiL2JT6oLS7nw44N4pnvQWZUiWOXsdNr0+a4X1GghhkCrtM6RVYcviJr/cgWzZFZJ23
         jvpy7o4ds7MDq892kGoujmlEMFxsovucL7xw6bsBQVEB2oCNswdcamTSB9UcFNUniEXp
         Y1J9StgYDbhw71oP+BveoK01u5fMv5qsjL5CNVx2s/jJqKlY3XDEOTuEyHchEL97reN9
         aHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=YNOPC6OV3IJPHCoLM7Sk8cEozPcvLYb3g8nhCI3rNjw=;
        b=X9bU1jH5y0k16J8aI8kGAylcvTG8rr/t9DlyQXqCHmgrrx7IFQUOXjsdO+kJpAnhcp
         o2DbhDYeXdSSxxxrvVj4WRhY26PYYbCkelxTqhHeT1csAxscLWCA8t80CEHRNphLU4P+
         yjSgYeTZTR+jsvZB7xQHhpuGy9YNKsjRH/VTfncjSAufJ5JWdgCjevSwOzhtcDXuuNIq
         CDKLyEV4+bIAyrjUl+u6Gz9zbCfhWJfXXjNx93Kz1+puUePxDE3WaDLO7JRJQucaMLYD
         lTFAvkRBiiTf/lhs2fhPpLq7SoMATPZz4dL9E3R8kwXPk3M+1q7QEyBEPXsEmD+iOWxW
         Bm3Q==
X-Gm-Message-State: AOAM533eFFD8/FS2yWsDMzrlINAdCkOZu6Ct8KhA6u8GmMEs4jirhpT6
        e/kmvYFYKxfXAVaaPjEPnLIWcC+/NJooOxnR
X-Google-Smtp-Source: ABdhPJwLYlErY2BJuRL9fCALw6w7tFCagE0qC+VGRvhG44X5BAhDF9HYfpJt7D9szyTSUkf2FNeUJA==
X-Received: by 2002:a1c:9a02:: with SMTP id c2mr10186406wme.16.1596315662791;
        Sat, 01 Aug 2020 14:01:02 -0700 (PDT)
Received: from tsnow (IGLD-83-130-60-139.inter.net.il. [83.130.60.139])
        by smtp.gmail.com with ESMTPSA id z6sm18344203wrs.36.2020.08.01.14.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 14:01:02 -0700 (PDT)
Date:   Sun, 2 Aug 2020 00:00:56 +0300
From:   Tomer Samara <tomersamara98@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rts5208: clear alignment style issues
Message-ID: <20200801210056.GA305272@tsnow>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Clear checkpatch alignment style issues in rtsx_transport.c.
  CHECK: Alignment should match open parenthesis

Signed-off-by: Tomer Samara <tomersamara98@gmail.com>
---
 drivers/staging/rts5208/rtsx_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
index 5f1eefe80f1e..0027bcf638ad 100644
--- a/drivers/staging/rts5208/rtsx_transport.c
+++ b/drivers/staging/rts5208/rtsx_transport.c
@@ -678,7 +678,7 @@ static int rtsx_transfer_buf(struct rtsx_chip *chip, u8 card, void *buf,
 
 	/* Wait for TRANS_OK_INT */
 	timeleft = wait_for_completion_interruptible_timeout(&trans_done,
-			msecs_to_jiffies(timeout));
+							     msecs_to_jiffies(timeout));
 	if (timeleft <= 0) {
 		dev_dbg(rtsx_dev(chip), "Timeout (%s %d)\n",
 			__func__, __LINE__);
-- 
2.25.1

