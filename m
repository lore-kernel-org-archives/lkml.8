Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF23C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 585D120775
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xT+yupj9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgGFNgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729267AbgGFNdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:33:54 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BD3C08C5E0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 06:33:54 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id w3so29666613wmi.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 06:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WegnVZ9DGyLW+kA2xpWSNAlVRAFvD3JLviW2wF/jZ6s=;
        b=xT+yupj9MavimR1wa5EZqEYTVTre9t7Il8BFvnEd4FOqKCV1obJEBkXayBjU4VTUpX
         EjG552aZP/iWzX7n5uCIBks2UnXw89KPGuPpFaGTfGBxeYUsPeDHCRpN2j7upHhRcoYp
         LKHDSdNN49TKwN3vrQQ3LH7oPAr3gSKkrpECRhZdCSuAfuNJxBkCyB4HSP+vs2T3balU
         /FH7pNPZ2YwlCJegT6qTrUN/oM2ejngS3tbIbVpgI0Y4EN1R+c5gIurEWJ+OMaofmHf4
         Xrrez6/t4LlVxxsjlS3b8/S+W4A2pXlnJB+OuOGyM5adoBRjPyRVSYVu37lfQ1r3xGMk
         vtNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WegnVZ9DGyLW+kA2xpWSNAlVRAFvD3JLviW2wF/jZ6s=;
        b=ghvzIC4qn934bbEInItSsUsGQ1rGj0nNumuEEudmOgmKigsHxxfhQV/R0acpFYhbzn
         dRWadubsiEjt6ykFksfWqdf2vpei85uVTGnTpfZUlIfc4uFxggVFdlDdkLGm91TWOhFj
         lLvuYEGNogS9tZglWgeiiBkzy4p7uyiihrUKWUYrorC/9xLcan6FE5t/EfSEyzH9C50e
         Bj0vNs2GEnGtD5YmUXWS8/iK8Rnx2N1KkXapDtPO2YhMfi5jEWn3SUT5ANEm12ZmGnJj
         rFUO51QJchEg7O2tpA9OgcPRtPtPuHCW4qrZhl7E4244b6JBE8SLXX9bXbYfTCXebJjF
         Cd+g==
X-Gm-Message-State: AOAM532JHYitGCytw+6Jn4oGms19opO/O2PuT8QdkyfA0XVwm9VpxPsB
        1tWjspq1Hd94ZTh/z0dOUBIjOJY4GfQ=
X-Google-Smtp-Source: ABdhPJyatwtDUIcCOL7ndILXzFNTrMtzJVDI0NWp8JnniRlD+OLzf4loG/6E3grgYnwIqqMACnTmYg==
X-Received: by 2002:a1c:48:: with SMTP id 69mr51473365wma.32.1594042433108;
        Mon, 06 Jul 2020 06:33:53 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id v18sm25416082wrv.49.2020.07.06.06.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 06:33:52 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Juergen Stuber <starblue@users.sourceforge.net>,
        David Glance <davidgsf@sourceforge.net>,
        david <david@csse.uwa.edu.au>,
        legousb-devel@lists.sourceforge.net
Subject: [PATCH 07/32] usb: misc: legousbtower: Demote function header which is clearly not kerneldoc
Date:   Mon,  6 Jul 2020 14:33:16 +0100
Message-Id: <20200706133341.476881-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200706133341.476881-1-lee.jones@linaro.org>
References: <20200706133341.476881-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/usb/misc/legousbtower.c:280: warning: Function parameter or member 'dev' not described in 'lego_usb_tower_debug_data'
 drivers/usb/misc/legousbtower.c:280: warning: Function parameter or member 'function' not described in 'lego_usb_tower_debug_data'
 drivers/usb/misc/legousbtower.c:280: warning: Function parameter or member 'size' not described in 'lego_usb_tower_debug_data'
 drivers/usb/misc/legousbtower.c:280: warning: Function parameter or member 'data' not described in 'lego_usb_tower_debug_data'

Cc: Juergen Stuber <starblue@users.sourceforge.net>
Cc: David Glance <davidgsf@sourceforge.net>
Cc: david <david@csse.uwa.edu.au>
Cc: legousb-devel@lists.sourceforge.net
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/misc/legousbtower.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/misc/legousbtower.c b/drivers/usb/misc/legousbtower.c
index 8aca55c4c95f1..f922544056de4 100644
--- a/drivers/usb/misc/legousbtower.c
+++ b/drivers/usb/misc/legousbtower.c
@@ -271,7 +271,7 @@ static struct usb_driver tower_driver = {
 };
 
 
-/**
+/*
  *	lego_usb_tower_debug_data
  */
 static inline void lego_usb_tower_debug_data(struct device *dev,
-- 
2.25.1

