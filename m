Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D148C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 580BB20720
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d1ILBA/2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbgGFNft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729306AbgGFNeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:34:02 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9582DC061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 06:34:02 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s10so40899277wrw.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 06:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KCHAGi+yis7rT4RcJ1xkGNsqK+uVMhPXLaq/wOq2nXg=;
        b=d1ILBA/20Tq+wf0tqPOsJ+Q7ruJ9GVdOks6k+ffLS4tTGE0XaURNCIQ3lPi3D8MqNy
         6bfpQGGIvvkd7dqLML2B/x3dDVz1X2KSrKeKImRiplCftwatlzk4iTY1bSQWuRoNS6CN
         n+d6tzIzTcqwW84lCy7LOKRcFOHHbSATtvadCsaCKyNI8wsUmOMuAtEzSoIoYXzf4TsO
         Pa25MqF0q1O3Onbn/OmoYNR44areZTUJ7E38CrsTHRAwH9fameB3YKH/n/EwJedUzvzp
         PiJOKFvVHKVlf5cdnE+5q7vJa6crbxjM7PG0iwmBGNtpdFRf+AbWmusFYIrj9TqmKxao
         h3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KCHAGi+yis7rT4RcJ1xkGNsqK+uVMhPXLaq/wOq2nXg=;
        b=jgRvVKoE6MCn5TADp7ESXbm38tYKBsLVoDyDDw6EfaLNjGmkhEZ5SCcZhqGiKcEH2n
         ZfoxJZ7mobX+L8A5PtffsHggRZ5Uoz8uMttd3WHDCYO855Cre8t3iNJCCniGmS6JY5Sg
         b4ErDG1q3nUw4JS+cgAgPdo8LLc9hcefQJs8Dvc+tmHrJ9RvUy6gyQjJfn7+91Elopau
         NjkJbSKZ+nm2zWT4GZ/cW+QycWfPIhnHzROUJSlBLwm4264L0a6tulDtEqmxy8D7dzh5
         NjBkYFyIv105FCTKbkucfM4zW8/cSNA1ewvoFDFm0Ynv4cM6T4NY0P6ZWBvr4F2TeSH7
         HdOA==
X-Gm-Message-State: AOAM532DUB11AdnPS/ndUdT9jJ2HivtnA+jhzuxaqz+DlNuwrBEIFaIi
        tIcdp7sxQ4gzOM/+IQCdfilhyA==
X-Google-Smtp-Source: ABdhPJy2Eg3D1zjnU2FxioIxSHD9bWpgEVorUJ2S4pILADo+vEbjB7rEn1A92h/ru5KDKIiVhqYg/w==
X-Received: by 2002:a5d:5706:: with SMTP id a6mr13466028wrv.328.1594042441319;
        Mon, 06 Jul 2020 06:34:01 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id v18sm25416082wrv.49.2020.07.06.06.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 06:34:00 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Chao Xie <chao.xie@marvell.com>,
        Neil Zhang <zhangwm@marvell.com>
Subject: [PATCH 14/32] usb: gadget: udc: mv_udc_core: Remove unused static const variable 'driver_desc'
Date:   Mon,  6 Jul 2020 14:33:23 +0100
Message-Id: <20200706133341.476881-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200706133341.476881-1-lee.jones@linaro.org>
References: <20200706133341.476881-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks as though it's never been used.  Driver was introduced in 2014.

Fixes the following W=1 kernel build warning(s):

 drivers/usb/gadget/udc/mv_udc_core.c:56:19: warning: ‘driver_desc’ defined but not used [-Wunused-const-variable=]
 56 | static const char driver_desc[] = DRIVER_DESC;
 | ^~~~~~~~~~~

Cc: Felipe Balbi <balbi@kernel.org>
Cc: Chao Xie <chao.xie@marvell.com>
Cc: Neil Zhang <zhangwm@marvell.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/gadget/udc/mv_udc_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/mv_udc_core.c b/drivers/usb/gadget/udc/mv_udc_core.c
index 2384b55f9d3e8..0fb4ef464321d 100644
--- a/drivers/usb/gadget/udc/mv_udc_core.c
+++ b/drivers/usb/gadget/udc/mv_udc_core.c
@@ -53,7 +53,6 @@
 static DECLARE_COMPLETION(release_done);
 
 static const char driver_name[] = "mv_udc";
-static const char driver_desc[] = DRIVER_DESC;
 
 static void nuke(struct mv_ep *ep, int status);
 static void stop_activity(struct mv_udc *udc, struct usb_gadget_driver *driver);
-- 
2.25.1

