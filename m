Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA42EC433E8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2A1C20787
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e6LcB+3p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbgGPOBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729154AbgGPN7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:59:52 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97175C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:59:52 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o8so10402817wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UrH3kHLe+dExzck//Xs9WC4y12BnMG39PRZDgQtY4y0=;
        b=e6LcB+3pAZokM37jcPJ93LQeC/I0DhPbBDogTHulpprvOqEfVf//SPgEydAg3NXncF
         kwIfObXF5wnxkCMdvqg6xSHqaIZ0Emf8L/Q5YPPSB9SrpdsGo7hfFc5zvsOJBodpl7it
         LNub4EOvVQ6m6R5nmNVMx85hf00jH6o1yhlnfGpvhQz/ycvC+k64ZjN2OerS8I2h5RD9
         IVM6pfM0ncc1lKjy07LgeJ25/vLSijE51CBZdL4AbM8l1+SYpyBJUD58O14yEOSAKwGF
         /lw9NT7IcLZeqFGH7cceRbcVE/KeiLXdtBGAm+yoDaSItjNPWxnBZ04yBjVJXDorQHPK
         RdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UrH3kHLe+dExzck//Xs9WC4y12BnMG39PRZDgQtY4y0=;
        b=oAWFCPmlVnbRivxpNMn/ZJODtYdB7varXdl/xuB6hheqVO1YKqktoqEBoz4ngWnKHk
         1n57gjPI4SxIzLCC8s5j/4ySNUy3kijvIUjnDPdM+pMTMBouFyVxzXlrMvIQ3aXIifDO
         Jy+w9KrxERKJUAwnuLH2SIRC3ILkM3+jAhW5EtDJ+J4+rut4d73Q5grUJgbB6A5kl14b
         V1aI+2owkHEFwgYLHWTiUejHNZVhZIBoQvdTs8cD6Wa3cHrKNRs/QYoFAE6pj6B/CIGn
         sAHa/VXa03qGwe5heNSf0WH0i6V/ygJg+upTsSoV7pSOTLoH4OkP06ygfSuMTFPbbx2c
         eRoQ==
X-Gm-Message-State: AOAM530xFnJCXL7wwv3CITe9/dBLU8QfyxlZ23nJ4/acj0vtLQ3rQP6r
        l0vTP8Fmywf22eSSb2Z03B85Mg==
X-Google-Smtp-Source: ABdhPJxuAnC+YGPWsxb+HKSvBTdc0WVR0l7V3uIrjXGnax3Yqf58atXa+3JP5r7A1VqoflQxuZgvPQ==
X-Received: by 2002:a1c:4d05:: with SMTP id o5mr4456320wmh.130.1594907991365;
        Thu, 16 Jul 2020 06:59:51 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm9351001wrq.13.2020.07.16.06.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:59:50 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH 16/30] iio: adc: ad7887: Demote seemingly unintentional kerneldoc header
Date:   Thu, 16 Jul 2020 14:59:14 +0100
Message-Id: <20200716135928.1456727-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716135928.1456727-1-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the only use of function related kerneldoc in the sourcefile
and no descriptions are provided.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/adc/ad7887.c:119: warning: Function parameter or member 'irq' not described in 'ad7887_trigger_handler'
 drivers/iio/adc/ad7887.c:119: warning: Function parameter or member 'p' not described in 'ad7887_trigger_handler'

Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/adc/ad7887.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
index c6a3428e950a9..bbaa0a3daea3c 100644
--- a/drivers/iio/adc/ad7887.c
+++ b/drivers/iio/adc/ad7887.c
@@ -109,7 +109,7 @@ static int ad7887_ring_postdisable(struct iio_dev *indio_dev)
 	return spi_sync(st->spi, &st->msg[AD7887_CH0]);
 }
 
-/**
+/*
  * ad7887_trigger_handler() bh of trigger launched polling to ring buffer
  *
  * Currently there is no option in this driver to disable the saving of
-- 
2.25.1

