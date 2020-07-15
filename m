Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F2FC433F2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF4202071B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KDslEjnS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730851AbgGOJcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 05:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730794AbgGOJcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 05:32:21 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75569C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 02:32:21 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z15so1671003wrl.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 02:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zIfwG4edfdZ0SvbrErNnoWeJSNFEawblVl9W1BGUl0c=;
        b=KDslEjnSQHAZDr3xp/DTWD275dXtqmIN+QWWeOPMn7d1pvYUjXDgd/tn/Bo5+lb9yw
         z2nomIjXCeRFimM3mGejfzSOIwkWxmxiINGCOb1l2Ouy54iLn9K+/YHASyZvHeauBB1l
         bxBgDn20+U53HF1nj2yuN8qjv3x+8sMpOjckq0v6LIiVqLy9G4+zui/A6JDuz/deobic
         ZRc0d2gzwL3i9evsEsgsgsOmDbXib9e8TVdfEWct5zZFqwmoU2Ycek3TFsTn/9iiebCp
         IAcudveq7zVF8eMOOg87/bSKwDQJIT9bmboQgQg8RHAdmsWS10wHat5RKdVRt+1VB1ba
         GQIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zIfwG4edfdZ0SvbrErNnoWeJSNFEawblVl9W1BGUl0c=;
        b=dWfm3xlgEr8ULC5G2S/5BKeyQaQM3f22z5VFmbuTR7WPhniWrufNJUNewKlTixkVh+
         qkR/e6uWSgdCJBysqlzgLUkRGzQ6k6VHir9zrNcwmh/Cr0BBeOgn6Lzt1wpAAXPWgqEV
         dXvF/mxS7a3Ku8htm6rmjq+mTfi+PLaD59AvubU2SnlK7Mc3vs9CqXIz2Wl4DZtLHO+r
         VtxmaBTI7KuiUln41aGvCaBNs5jAkhhiNFSt/xNUtlFWZS5KScnARJCzSvLsO6n8oeL9
         kH/bXMv+eWNTK9vThGT7DIOR3YdXglzw0KVmhLnM5Ne0/OPHOLEzJrY3YhNdJRMsQy8f
         33YA==
X-Gm-Message-State: AOAM5339PaIcQrHRGZyGzJO+pYhSFuUWhPojn/n2i0CnVv7QwMmWcY/z
        BVmTUL6sTqXdsja/9mzvmvHeew==
X-Google-Smtp-Source: ABdhPJzy9C1OIc07ZZJ+baBn+wPtrRgMaFIbwmLZzlKqBbVdIza75yrsP5fHxF0BGHIinI+EcMHu3w==
X-Received: by 2002:adf:f104:: with SMTP id r4mr10755413wro.90.1594805540164;
        Wed, 15 Jul 2020 02:32:20 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id s203sm2686991wms.32.2020.07.15.02.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 02:32:19 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Oliver Neukum <oneukum@suse.com>
Subject: [PATCH v2 6/8] usb: c67x00: c67x00-hcd: Demote obvious misuse of kerneldoc to standard comment blocks
Date:   Wed, 15 Jul 2020 10:32:07 +0100
Message-Id: <20200715093209.3165641-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715093209.3165641-1-lee.jones@linaro.org>
References: <20200715093209.3165641-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No attempt has been made to document any of the functions here.

Fixes the following W=1 kernel build warning(s):

 drivers/usb/c67x00/c67x00-hcd.c:237: warning: Function parameter or member 'sie' not described in 'c67x00_hcd_irq'
 drivers/usb/c67x00/c67x00-hcd.c:237: warning: Function parameter or member 'int_status' not described in 'c67x00_hcd_irq'
 drivers/usb/c67x00/c67x00-hcd.c:237: warning: Function parameter or member 'msg' not described in 'c67x00_hcd_irq'
 drivers/usb/c67x00/c67x00-hcd.c:267: warning: Function parameter or member 'hcd' not described in 'c67x00_hcd_start'
 drivers/usb/c67x00/c67x00-hcd.c:279: warning: Function parameter or member 'hcd' not described in 'c67x00_hcd_stop'

Cc: Peter Korsgaard <jacmet@sunsite.dk>
Cc: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
Changelog

v2: Removed accidental addition of unrelated change

 drivers/usb/c67x00/c67x00-hcd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/c67x00/c67x00-hcd.c b/drivers/usb/c67x00/c67x00-hcd.c
index c39eee17c0e46..39f2376663314 100644
--- a/drivers/usb/c67x00/c67x00-hcd.c
+++ b/drivers/usb/c67x00/c67x00-hcd.c
@@ -228,7 +228,7 @@ static int c67x00_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
  * Main part of host controller driver
  */
 
-/**
+/*
  * c67x00_hcd_irq
  *
  * This function is called from the interrupt handler in c67x00-drv.c
@@ -260,7 +260,7 @@ static void c67x00_hcd_irq(struct c67x00_sie *sie, u16 int_status, u16 msg)
 	}
 }
 
-/**
+/*
  * c67x00_hcd_start: Host controller start hook
  */
 static int c67x00_hcd_start(struct usb_hcd *hcd)
@@ -272,7 +272,7 @@ static int c67x00_hcd_start(struct usb_hcd *hcd)
 	return 0;
 }
 
-/**
+/*
  * c67x00_hcd_stop: Host controller stop hook
  */
 static void c67x00_hcd_stop(struct usb_hcd *hcd)
-- 
2.25.1

