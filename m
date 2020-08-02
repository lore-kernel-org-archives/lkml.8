Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C55C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 12:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5C972075B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 12:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVdzxtUo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbgHBMi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 08:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728043AbgHBMi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 08:38:57 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C152C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 05:38:56 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id x9so36890338ljc.5
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 05:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZCwWa3wQ3B+vXB4XSBZx3GgzsfnhFIgec6eabtnva60=;
        b=LVdzxtUoUF6+yj43Wlmd1FTPM/kgDqw+0k16uHMMAXBGOItWntqoTikqgFHp3YxkTH
         i6bNHxoQgwnMl5vsBvz2DvNGVmI21NPIQnPBShmK9Z+6QpMO25i2vCiQaUDo7kgZyIIL
         gXQwC7GUh9PvbQErBY0V9jB7A7qrtDwICz9QbCkxwWTHvBLFbgf4mGdLRQ3B1p5KHMxx
         Cd/UVh+WOsVhsSnGP5u2f1p/lCQDD3M3/rKknNqttJnB0C82Q2kpJ2ZC1ry6Iym3s67q
         T7TBBTn4BIIQkyLp8/PAemM2AjtEk+0xnMIl7rM097Ik0fSzL3HYcc1AhSItyidw3ttU
         WFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZCwWa3wQ3B+vXB4XSBZx3GgzsfnhFIgec6eabtnva60=;
        b=T1rw0fKme70gUkD8kSn2WDj3LFuXTLe4DW3qIK0aFnwOlUV+aV1LhqIFCK4enRFZSp
         s8n6d+BVpad9VzHoFWwnEQCiR1rER8kb0SzJr/OUbRujig8MBZXooRKV5nYbnxgLfKzQ
         rm0POwdgVTeaSZGMTCjm2Y2X/S3l2FBTio7iVyaJ9HmBWbqZ6FepcNiwrEVD84FZRWnU
         di6iWBcKCXbTOWUwGsLYxeYLtRJ6TBIHcEN1ydRStRW/KCxpleMKxwAC7gWjzfGWWDGE
         l3ZpcbdbKWG0OV5NqIOjJZrQdT1bYWbZNzLeq7P0aRfPAcR1CLUrz12FlldAYQtlHnYT
         ZwiA==
X-Gm-Message-State: AOAM5331ZdHdfPZFnxr/jAV1PIEgc5loCZkc232z0LxdwVqKa2KH0+Jg
        KW2Xzn3m87uV1iR+PXEpuPg=
X-Google-Smtp-Source: ABdhPJx2WBmNwFisxAyj7HhSDW4AQnMsIPmYk0FBFS6x1YlKsfZ0iBIzC/dVbkWKNVh1oBLl7nzfng==
X-Received: by 2002:a2e:999a:: with SMTP id w26mr5333203lji.371.1596371934831;
        Sun, 02 Aug 2020 05:38:54 -0700 (PDT)
Received: from alpha (10.177.smarthome.spb.ru. [109.71.177.10])
        by smtp.gmail.com with ESMTPSA id z25sm3107028lji.33.2020.08.02.05.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 05:38:54 -0700 (PDT)
Received: (nullmailer pid 101483 invoked by uid 1000);
        Sun, 02 Aug 2020 12:43:38 -0000
From:   Ivan Safonov <insafonov@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Lukasz Szczesny <luk@wybcz.pl>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Ivan Safonov <insafonov@gmail.com>
Subject: [PATCH] staging: rtl8723bs: replace rtw_netdev_priv define with inline function
Date:   Sun,  2 Aug 2020 15:42:50 +0300
Message-Id: <20200802124249.101341-1-insafonov@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function guarantees type checking of arguments and return value.

Result of rtw_netdev_priv macro can be assigned to pointer
with incompatible type without warning. The function allow compiler
to perform this check.

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
 drivers/staging/rtl8723bs/include/osdep_service_linux.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/osdep_service_linux.h b/drivers/staging/rtl8723bs/include/osdep_service_linux.h
index 1710fa3eeb71..4a5bdb93e75d 100644
--- a/drivers/staging/rtl8723bs/include/osdep_service_linux.h
+++ b/drivers/staging/rtl8723bs/include/osdep_service_linux.h
@@ -129,8 +129,6 @@ static inline void rtw_netif_stop_queue(struct net_device *pnetdev)
 
 #define rtw_signal_process(pid, sig) kill_pid(find_vpid((pid)), (sig), 1)
 
-#define rtw_netdev_priv(netdev) (((struct rtw_netdev_priv_indicator *)netdev_priv(netdev))->priv)
-
 #define NDEV_FMT "%s"
 #define NDEV_ARG(ndev) ndev->name
 #define ADPT_FMT "%s"
@@ -144,6 +142,12 @@ struct rtw_netdev_priv_indicator {
 	void *priv;
 	u32 sizeof_priv;
 };
+
+static inline struct adapter *rtw_netdev_priv(struct net_device *netdev)
+{
+	return ((struct rtw_netdev_priv_indicator *)netdev_priv(netdev))->priv;
+}
+
 struct net_device *rtw_alloc_etherdev_with_old_priv(int sizeof_priv, void *old_priv);
 extern struct net_device * rtw_alloc_etherdev(int sizeof_priv);
 
-- 
2.26.2

