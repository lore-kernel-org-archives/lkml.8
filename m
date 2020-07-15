Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1177C433E6
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0298206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j1hC6fbF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbgGOJcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 05:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730760AbgGOJcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 05:32:16 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738F8C08C5DB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 02:32:15 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id o8so4660892wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 02:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Z3KCPJPJ9xqOxMrVh/E1QUCCirSlEPo9eFXpxRTSLE=;
        b=j1hC6fbFvEKSfKk3vGCWwkBbfplkz5E48kA4VMiG9AJs8jLE2MQYYlqUG4PUexzeWZ
         JaAxqVumQic3OZhO1DNUlAwOkwiHCXh5UE3M2Z+S87THP6F5wND7f9Ee0wmUgmoEegsZ
         LVnSYFgKt+rh9f+IXR2jnsPTcDcBsap1QoK8duiDrdW8QG78i3ll5N03D/juvat4fj7k
         X1b6UEJ/f13U3vfWT5XhHJr0ty7jwnu35Q6LggfCBPBNOw8noBWj6GmoDQ/nQyU7nP+D
         XmMKy432/ChdZt0+jP09xTU+QNTA3a3+aRuWXDbxAe9tU8D26pQELScIlU5dAIpuwSar
         zzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Z3KCPJPJ9xqOxMrVh/E1QUCCirSlEPo9eFXpxRTSLE=;
        b=grZHp8nSjz7xc1nATiC8Lemm5zUPuQSvNaKE6v6RtUnmgjSchsmAqdR2JmADrSVTsO
         vaYk90jX81Q8gQnx4JeWzsdr/tHRk0zQL12/fkEN1CGpMMB+KXhpbjKcBF4lQHh8jDjo
         GIEID8lwa+4PZuR94AycgJ+Vn+t60bR9QSYrzXVYg/ROYESTt/TjUxR/KvuzyBNKgIB3
         0h9JVyBj8EFgK2OdViYjDdttkmXGdR2zhuHy4dIGzDWM8IN3gixTqMjcwbeqxcEgTY8K
         s7NBVh4JmnddiIsINM/lYlcqoYk/5EsZlHb0CDN8vP8oeyTAqSo4+jHePZZ9lMZAADRt
         ZBkw==
X-Gm-Message-State: AOAM5318feDWBFixXpPsYttZs2/ynINbVu3aEHFI+6ln0YvT+YXo0BIj
        pP1LGqMUqU3Tnl9otETCt5Z9ww==
X-Google-Smtp-Source: ABdhPJz2F7AQdDuodvs3Nhzm9b78oR7eczk/gzHg9MMwyTt6vuYsGoFv1+7G/mzU5URIZ5Ey8K5mdg==
X-Received: by 2002:a1c:e0c4:: with SMTP id x187mr7495953wmg.153.1594805534090;
        Wed, 15 Jul 2020 02:32:14 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id s203sm2686991wms.32.2020.07.15.02.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 02:32:13 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Ben Dooks <ben@simtec.co.uk>
Subject: [PATCH v2 1/8] usb: dwc2: gadget: Make use of GINTMSK2
Date:   Wed, 15 Jul 2020 10:32:02 +0100
Message-Id: <20200715093209.3165641-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715093209.3165641-1-lee.jones@linaro.org>
References: <20200715093209.3165641-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The value obtained from GINTSTS2 should be masked with the GINTMSK2
value.  Looks like this has been broken since
dwc2_gadget_wkup_alert_handler() was added back in 2018.

Also fixes the following W=1 warning:

 drivers/usb/dwc2/gadget.c: In function ‘dwc2_gadget_wkup_alert_handler’:
 drivers/usb/dwc2/gadget.c:259:6: warning: variable ‘gintmsk2’ set but not used [-Wunused-but-set-variable]
 259 | u32 gintmsk2;
 | ^~~~~~~~

Cc: Minas Harutyunyan <hminas@synopsys.com>
Cc: Ben Dooks <ben@simtec.co.uk>
Fixes: 187c5298a1229 ("usb: dwc2: gadget: Add handler for WkupAlert interrupt")
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
Changelog:

v2: Re-written to *use* instad of *remove* gintmsk2

 drivers/usb/dwc2/gadget.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index df5fedaca60a0..03cf1fa856219 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -260,6 +260,7 @@ static void dwc2_gadget_wkup_alert_handler(struct dwc2_hsotg *hsotg)
 
 	gintsts2 = dwc2_readl(hsotg, GINTSTS2);
 	gintmsk2 = dwc2_readl(hsotg, GINTMSK2);
+	gintsts2 &= gintmsk2;
 
 	if (gintsts2 & GINTSTS2_WKUP_ALERT_INT) {
 		dev_dbg(hsotg->dev, "%s: Wkup_Alert_Int\n", __func__);
-- 
2.25.1

