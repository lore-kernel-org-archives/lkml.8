Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAB8C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 15:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 932622086A
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 15:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uATvaf9E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbgEXP0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 11:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728934AbgEXP0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 11:26:31 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D509C061A0E;
        Sun, 24 May 2020 08:26:31 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id f21so4626007pgg.12;
        Sun, 24 May 2020 08:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u9ROz91xuBH6QrjqqF0E1q2Di/i7mALUiHHp8nW2VMk=;
        b=uATvaf9EwRAjCsc3Fm4imKQPHtWb+PG7n6SLpFGmWXaXVEF614vPPtWWTUDhaGZIW6
         79lm6ASLhrCZKWOgonOmBNzfHH2wn3SurHT2I+17iMm46ybLOeRk5JPuw8MngSpw1NkG
         9QyivYVeGhLBcb/WHKh8FBZW/F+BMySD1/7L2+/WS2n5mUCV053XoeOGAoD7kMvuS/2T
         z/MItTct5sPGPYTNcmxJt65IKcrKd8I5YFZGWYq6iZ/EWP5O2gW6sxyWd3R173sZ85xv
         h0EXufWb++ppBPLCMpjxl7yw0dLEUnn+ITUlEEy4DGTnImCoPjCN//cF5Izigvuafpuk
         8nHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u9ROz91xuBH6QrjqqF0E1q2Di/i7mALUiHHp8nW2VMk=;
        b=aJ0WmlY7KWilTPb/8RTd/cwtrn3C9Rk4hGdpqiFcIR9qVV8R5h8t7ulU1lym2Nb+m4
         XPED4KqJxvmtsL/HRC+/qLwj7DySnbkllWTiZT+ktFpGijpcWQUo1nyoC1mu+6HCZa7T
         jkcgbsnUiRDMmvBQAA68adJGSGnA4fTNz+6hkJqbZUM/0S4CY0QMOZjvUuLarOKku8HB
         X8Sa7wQIWxSdK/bShuLiql/X/40hjwB1oS4L/2OvRxzUQDbWleu9TxvKotOvYc2AZvCF
         Gu3f/ScQeF6ovfR3gi/HZK9TlXa36DE5f3APSRMshGSoo4uQkz9UkUWN9agK5oXIdbxZ
         JJcw==
X-Gm-Message-State: AOAM531zkw/XXK00FXxif/QWNBQWX4E0pUPTAWDBs2b5gkFWnjdfDD5d
        G1+IDYqJ2UUZJmdSrWtop2g=
X-Google-Smtp-Source: ABdhPJzViyc4mCiAajv6jBGzrAIkiyQnh2X1FUDiO84mrCc/TvAprXeZxL7s6pWLZraK+M1n3BtAUQ==
X-Received: by 2002:a63:b252:: with SMTP id t18mr22590781pgo.133.1590333991071;
        Sun, 24 May 2020 08:26:31 -0700 (PDT)
Received: from localhost.localdomain ([141.164.38.6])
        by smtp.gmail.com with ESMTPSA id o27sm9981987pgd.18.2020.05.24.08.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 08:26:30 -0700 (PDT)
From:   Qi Zheng <arch0.zheng@gmail.com>
To:     robh+dt@kernel.org, robh@kernel.org, frowand.list@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qi Zheng <arch0.zheng@gmail.com>
Subject: [PATCH] dt/platform: Fix comment in of_dev_lookup()
Date:   Sun, 24 May 2020 23:26:14 +0800
Message-Id: <20200524152614.69393-1-arch0.zheng@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code is using of_dev_lookup() rather than of_devname_lookup().

Signed-off-by: Qi Zheng <arch0.zheng@gmail.com>
---
 drivers/of/platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 3371e4a06248..3627fee60215 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -291,7 +291,7 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
 #endif /* CONFIG_ARM_AMBA */
 
 /**
- * of_devname_lookup() - Given a device node, lookup the preferred Linux name
+ * of_dev_lookup() - Given a device node, lookup the preferred Linux name
  */
 static const struct of_dev_auxdata *of_dev_lookup(const struct of_dev_auxdata *lookup,
 				 struct device_node *np)
-- 
2.25.1

