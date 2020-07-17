Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6B8C433EA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6733B208C7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBvN3FB7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgGQS5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 14:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728453AbgGQS5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 14:57:08 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B86C0619D2;
        Fri, 17 Jul 2020 11:57:08 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id b25so8447676qto.2;
        Fri, 17 Jul 2020 11:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AOjSWM+MrbGY0zQHUu/oyhXkb6IbHhbZkZNlZ3po4ok=;
        b=LBvN3FB7+24XUkHKhh/Lll6b+Aq/Bt/TlW0Zo/phhylWr8nfED4broCq2fMknLprkN
         ZfOvFbzYkoHbDLRXfdmr2mNZu2v9ybcY8VNiTuiFippcmdpFhHCYarqRrc9gdB6/kmen
         e8VS3JP2P3L+hmvd+fEinZGiK9jko73gR1VBpr5O5dIAwneb/UBmdqjZq4ysxVh4c2SM
         807b7AibufdHI8VYBZ9Gc5mNSLzcX2xjmnCggUkJKZg+31p7B/z1u31izN/sJSWiHhEo
         iOC6Jn+ePSnOru/gq6BFp8Mc7anzOV7q76KsI01PiS1hD+GKuKrCdoazlO04UP/OSfKr
         tN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AOjSWM+MrbGY0zQHUu/oyhXkb6IbHhbZkZNlZ3po4ok=;
        b=RA4kJ6MVp/oEbx9J0Y0X2fikt01J1Dk1mvMe95PK7IZTXqEDJdWxAKoIFwf3CraPe+
         wpa0i07/9PTIdgCzqEYsb+/wRcjm90bWi51gtxAa6XzKTf6pk95UZ4yZL8e+LvODLMA5
         YOxAGRfvx5UOPTGdXUQG/VHaKdoA8kq907PO8jkHt+noE9MfQwGGQTs5cw2cRROXPciV
         DzId1S1xNBSMFlwwVKkgqU22hwGcVwlLbtjSXjDmwlEcYqTDrutrbVCTXscuZu7Nyg+V
         f9I31pFqO29Ii35s8/v3nLcYYsp/wB9BzxIEYBValXe9pNFZCYX+JDH/bJ0sN9rAEoFo
         woWg==
X-Gm-Message-State: AOAM532QtsO2z2erKBlLqXm10ifFXKG/R1gs9jUlXYINu8UJiejiZ2Jl
        QcrZaGP0I0Qdab+d9Z8GiCsDuoS4QAk=
X-Google-Smtp-Source: ABdhPJyK5vnxa3GyAViGHxQ87dtpbK7XJTLfYBV/dPKOmBFkbsYRo50HtIqaRsQiFdQHrQTorSYCHA==
X-Received: by 2002:ac8:5181:: with SMTP id c1mr12276311qtn.173.1595012227810;
        Fri, 17 Jul 2020 11:57:07 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:7002:653c:f7ea:490a:10b0:ec39])
        by smtp.gmail.com with ESMTPSA id r6sm11380097qtt.81.2020.07.17.11.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 11:57:07 -0700 (PDT)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net, mchehab@kernel.org
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/25] Documentation: gpio/driver.h: fix sphinx warnings
Date:   Fri, 17 Jul 2020 15:56:06 -0300
Message-Id: <20200717185624.2009393-7-dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200717185624.2009393-1-dwlsalmeida@gmail.com>
References: <20200717185624.2009393-1-dwlsalmeida@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>

Fix the following warnings:

warning: Function parameter or member 'gc' not described in
'gpiochip_add_data'

warning: Excess function parameter 'chip' description in
'gpiochip_add_data'

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 include/linux/gpio/driver.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index c4f272af7af59..c11261f3c7247 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -481,7 +481,7 @@ extern int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 
 /**
  * gpiochip_add_data() - register a gpio_chip
- * @chip: the chip to register, with chip->base initialized
+ * @gc: the chip to register, with chip->base initialized
  * @data: driver-private data associated with this chip
  *
  * Context: potentially before irqs will work
-- 
2.27.0

