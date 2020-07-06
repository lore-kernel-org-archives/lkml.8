Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66299C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F40120702
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w6hRYUO7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbgGFNf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729337AbgGFNeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:34:10 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0470C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 06:34:09 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id j18so39372787wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 06:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=atQQd6B48grrwp+3FZv95LUICx56wwJRa1SpQXxMQxY=;
        b=w6hRYUO7YyVcZnrxkVQcL9i+DIcegwSxOpJpusHM7ek+/DIU5QwFI/PAYc6YFHkaCT
         k8FRF534bpubL0B0OmFF5oq6wY03Rw6yEomh35Tmx6FPDE/waGSczpU5Cgzrn5Uju7Cc
         bCaXLGQifZRD/R4nbrn64owZsuCBcCb1EC0ImDhAGAXd/cc+WlULEQCijrABf+IpaKDT
         3EKntJe03seySO6FPX3ZDocV61TFxZ1D1a4x8qhefwdg2zdjfgFY86PiagDVLamwPJy8
         Cryz85XcxwCCMuv2nwLw+AXH9YXajlbSNY8nVxl/zMp1+gxb+292tL9mvtsS+CABRwnw
         YPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=atQQd6B48grrwp+3FZv95LUICx56wwJRa1SpQXxMQxY=;
        b=ioGx3tVc9C7j1WFr4Yv0dQWIS9qHj/lFz0IUQYaSj7klyNRF2DUdeRP7yV86Kob69/
         i8KOxYcI/5S+TDZqQ8/K2DJLKW165vE0geO5CI2tZnhhON3aAtPzld7YjsMZjbuupN/r
         Pxoz00Nw63SQHlU9IQDt23dQkR4vGyWlUx0/x9yPjKqHvcCK+XQFtMZdCinp4aZnJVxh
         eA25FJbRCbeIBe8mXR8+YZWOvOXzP/8cnNxD3JwWJwx40R57lnVlRltjY2K30x5RpiEL
         EJJqBYKinfzR3POAzR4F+mhc/v1ug9dQrWSouT0mRwMdMDD+tSZO4/Ps42jvOgPk46L2
         zABw==
X-Gm-Message-State: AOAM531t7QuNA9KNpyU/4seM95W/JHBkrdntRTc64GQxzT5mInWeghhT
        rCQ1ju3+X5+zmneYDElvhjU8Hg==
X-Google-Smtp-Source: ABdhPJwn3KSyjv54N4scU2QXm9bSuHZxzD4jVab9Us5MgbW3y2o+Nt2CodWPVpAjqv1powTZgDaF9Q==
X-Received: by 2002:a1c:ed0b:: with SMTP id l11mr2416931wmh.121.1594042448527;
        Mon, 06 Jul 2020 06:34:08 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id v18sm25416082wrv.49.2020.07.06.06.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 06:34:07 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Chuhong Yuan <hslester96@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Felix Fietkau <nbd@openwrt.org>, Michael Buesch <m@bues.ch>
Subject: [PATCH 20/32] usb: host: bcma-hcd: Demote obvious misuse of kerneldoc to standard comment blocks
Date:   Mon,  6 Jul 2020 14:33:29 +0100
Message-Id: <20200706133341.476881-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200706133341.476881-1-lee.jones@linaro.org>
References: <20200706133341.476881-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No attempt has been made to document either of the demoted functions here.

Fixes the following W=1 kernel build warning(s):

 drivers/usb/host/bcma-hcd.c:180: warning: Function parameter or member 'usb_dev' not described in 'bcma_hcd_usb20_old_arm_init'
 drivers/usb/host/bcma-hcd.c:268: warning: Function parameter or member 'bcma_hcd' not described in 'bcma_hcd_usb20_ns_init'

Cc: Chuhong Yuan <hslester96@gmail.com>
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Felix Fietkau <nbd@openwrt.org>
Cc: Michael Buesch <m@bues.ch>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/host/bcma-hcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/bcma-hcd.c b/drivers/usb/host/bcma-hcd.c
index 652fa29beb273..b1b777f33521e 100644
--- a/drivers/usb/host/bcma-hcd.c
+++ b/drivers/usb/host/bcma-hcd.c
@@ -168,7 +168,7 @@ static void bcma_hcd_init_chip_mips(struct bcma_device *dev)
 	}
 }
 
-/**
+/*
  * bcma_hcd_usb20_old_arm_init - Initialize old USB 2.0 controller on ARM
  *
  * Old USB 2.0 core is identified as BCMA_CORE_USB20_HOST and was introduced
@@ -261,7 +261,7 @@ static void bcma_hcd_usb20_ns_init_hc(struct bcma_device *dev)
 	usleep_range(1000, 2000);
 }
 
-/**
+/*
  * bcma_hcd_usb20_ns_init - Initialize Northstar USB 2.0 controller
  */
 static int bcma_hcd_usb20_ns_init(struct bcma_hcd_device *bcma_hcd)
-- 
2.25.1

