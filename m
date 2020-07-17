Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BC1C4345B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8023120737
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gXP1A1aP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgGQQ5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 12:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727940AbgGQQ41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 12:56:27 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521A2C0619D5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 09:56:27 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z2so11928064wrp.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 09:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IXd86YlqxBtW7UZeHgyTcDp4G0PhvbjWGBrB0jc0maI=;
        b=gXP1A1aPqfzAOvdHNbPtLs+jIhv54GQIbTAccgxgr1wt1kn9EpupuLOyas02qh3Fc4
         aAXKauKVOUBG3l+VRgo/RdfDeZ1G42tkVR3s4aIDxL5dUHdbg/5/xQN5dZahRXDmPmkt
         xLwL3x7xHoSEQo3Jxl84dEa2RWgcLgAZxPwEl2aOD7W00BdoLQ+h1AAIEcGGPCS2LYR0
         y0igGQBBnKCGKDevvhCzrkAAkKfKwxwsWq6rybKHU6asMYRQPgysnadd/5iHvMcqn9dJ
         KIAQPpOk464Eu5Jl1xNAEjwKkq9Q/MpFYoWxHU25xXjFhMdHwjM8IDe51XIF8biw6Cde
         c7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IXd86YlqxBtW7UZeHgyTcDp4G0PhvbjWGBrB0jc0maI=;
        b=Or5y8OOk2bVwrlhF1+0kWe/kKGq0sdOjMnfTBZp4oGAfSnHS4Lj0zbrqLuO+DPkIx7
         /EIs1LABWmTA8XDmd+pw78kmOvBBh8fY47qtzY7sDbyMMFTh6zoJSyBJHkXgpG0m4U0s
         Zsiz+tlfTPaYYqPvmMx/k+bHSp0CuYqtR9+hnVhC/Q03VS82mBKTczPS17dj6TU76J0h
         MTJhr4a86ZH+G/0glBxyUmN3n11hdrGcbwpaGG8rZvMbzGCZM2BoTpacf6iok/15epu2
         +EjRy8vz9JiZsZAyAW1fGEUziViF39TEg3Iwh1sGjiHSLpnIGtttkjQwGKJ1IIJKlCIW
         qJRA==
X-Gm-Message-State: AOAM533c8WfCgW9wSYki5Qx3of5iiOjquaXmhtxTuWpWQO4q+XEFQ2Zk
        0Vg6xX6aSiOTBM7Sxnu5/63EDg==
X-Google-Smtp-Source: ABdhPJxhKbEduZnoaaEhkBeqsaOavVhq+n3Sa8BgaDFiVmZt2/qoLy17eSHZ1GVMU3+BfR0KoDuf9w==
X-Received: by 2002:a5d:630c:: with SMTP id i12mr12304154wru.158.1595004986049;
        Fri, 17 Jul 2020 09:56:26 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id k4sm14941516wrp.86.2020.07.17.09.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 09:56:25 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 25/30] iio: imu: inv_mpu6050: inv_mpu_ring: Demote seemingly unintentional kerneldoc header
Date:   Fri, 17 Jul 2020 17:55:33 +0100
Message-Id: <20200717165538.3275050-26-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717165538.3275050-1-lee.jones@linaro.org>
References: <20200717165538.3275050-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the only use of kerneldoc in the source file and no
descriptions are provided.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c:118: warning: Function parameter or member 'irq' not described in 'inv_mpu6050_read_fifo'
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c:118: warning: Function parameter or member 'p' not described in 'inv_mpu6050_read_fifo'

Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index 9511e4715e2c1..b533fa2dad0ab 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -111,7 +111,7 @@ static int inv_reset_fifo(struct iio_dev *indio_dev)
 	return result;
 }
 
-/**
+/*
  * inv_mpu6050_read_fifo() - Transfer data from hardware FIFO to KFIFO.
  */
 irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
-- 
2.25.1

