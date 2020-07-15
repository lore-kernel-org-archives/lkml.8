Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4155C433E8
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0FFC206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kr848DQ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730838AbgGOJc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 05:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730789AbgGOJcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 05:32:20 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D04C08C5DD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 02:32:20 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r12so1615558wrj.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 02:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LLJr1BBujxQgRf198E6OimaqdThx6WekIFuCOWBUZHE=;
        b=kr848DQ9ivIVfBHU6WJ8Wly8JL0ZbRIf1G3oj2WAD7ofS9XQNvwMS2e0gmX4WhVzKi
         D8jxSQC44EqtEw5q8u+Z/ZBHCwviGXkyI0Qg9St4qOfJ4GlXrtdZSweriaNAyUcqy6Jx
         rzzCf6Br8pwtRvpnhljycULVdv60T2JVS4og79hV89iNKWb0a/HI+Was+ROyYO1Umeij
         muJIBhE8XjmyQoDccGKD6GnIC+QYey0ZhjgZQxhZo4OPdfvo5vAkT+3iF/shc0GmpEit
         q5fVyQUAajS3Q9bmzwwkVJK4pAREl9iG0gxQI7B17lhvkJj6lyL2SNDqU5nDl2u3mVEf
         UZ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LLJr1BBujxQgRf198E6OimaqdThx6WekIFuCOWBUZHE=;
        b=qlkgH7NQK2Mu8/VhiP9usQXumwTfi2OPg+mCfrDNZOdTVuCvcGXZQXHt46BMeTUtIl
         kERNg/Gse1Ok4U5aXHFjxe4wqDNDaWTIUpDIHCu4g3aC1pqCQVWJxjAIPoagI+Xj9Dib
         BwW3oYp4a616RdYP41oKXVRdn96ZeN/22dPCvSVNAhxzGCG714izRhbXOHBoOM1CkwRL
         fCfjg3dAlrHIvKAx/Z1B+nPGP4cguZQAhPRo8U09FlHlq1VmbS1HOdRsiTD+Sbu2xKJ0
         rX6uX1c/63TRqmUmLTCgngwY3KKQlBIhx+B5bcbEPPamu8OTGibi4Ok4MfxWHxElOJpI
         Unag==
X-Gm-Message-State: AOAM532y3lmrluuEMoANMIHhf05DrsUBzZdul07yRyi3Oh5V10dSizWR
        xJgqvh2PnZC1eYPiZQF1u4zgmg==
X-Google-Smtp-Source: ABdhPJzeuYlG/tm0jxRW34wzZNpRlF352IlkECXOk6bLtk1cRbbPoxaw5zCmvUSrZuy8Wcsq493Kew==
X-Received: by 2002:a5d:4d8b:: with SMTP id b11mr10407200wru.341.1594805538872;
        Wed, 15 Jul 2020 02:32:18 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id s203sm2686991wms.32.2020.07.15.02.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 02:32:18 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Oliver Neukum <oneukum@suse.com>
Subject: [PATCH v2 5/8] usb: class: cdc-wdm: Provide description for usb_cdc_wdm_register()'s manage_power arg
Date:   Wed, 15 Jul 2020 10:32:06 +0100
Message-Id: <20200715093209.3165641-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715093209.3165641-1-lee.jones@linaro.org>
References: <20200715093209.3165641-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A good attempt was made to document everything else.

Fixes the following W=1 kernel build warning(s):

 drivers/usb/class/cdc-wdm.c:961: warning: Function parameter or member 'manage_power' not described in 'usb_cdc_wdm_register'

Cc: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
Changelog

v2: Fixed-up trailing whitespace (and enabled highlighting)

 drivers/usb/class/cdc-wdm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
index e3db6fbeadef8..7f5de956a2fc8 100644
--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -940,7 +940,8 @@ static int wdm_probe(struct usb_interface *intf, const struct usb_device_id *id)
  * @intf: usb interface the subdriver will associate with
  * @ep: interrupt endpoint to monitor for notifications
  * @bufsize: maximum message size to support for read/write
- *
+ * @manage_power: call-back invoked during open and release to
+ *                manage the device's power
  * Create WDM usb class character device and associate it with intf
  * without binding, allowing another driver to manage the interface.
  *
-- 
2.25.1

