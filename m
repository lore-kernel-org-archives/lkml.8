Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE84C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 03:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F35322072D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 03:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vTe4qnU9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgHTDjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 23:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgHTDjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 23:39:46 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4941C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 20:39:45 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id u20so390775pfn.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 20:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1Pl5M3ukYq8iQYrf+dpnwbhWHmgNw4KikJbcw2NDFaY=;
        b=vTe4qnU9syJCWAEG6DywC43aFT6u9KZAlrNQGmPhdjb381EGy/7CuoAm9utkz4bzrG
         4SG+ix3+/d12Nxe5oanUjOKPqMy5JQTG0Au7MQCx6D1b3h5hrYHptueFtC0w8E22GncH
         DB2Y7zUz/eoUKXh71v8MfxvstgAeMB+V62r5YgLgPyBICXwPYQHT/m3+h1M0Q2csztN0
         TCDTkwGAvRaH5KrhuFHXK1EGUaAK2H0SFsB9FNscx4D1VkVetzaiZddED0nXU/abKuOG
         Nx1wDsfslpX8BT0VVyTmT1fo8OBVjpFGcYyAarNIrOlWcuEFZHuQsf1Q6XNSoIPGiVFP
         4XNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1Pl5M3ukYq8iQYrf+dpnwbhWHmgNw4KikJbcw2NDFaY=;
        b=Zolci5iwDUxyYhArjJqkKlbINTTXZYc8BszlFiwFBsbra8h+fPFzoMM+xNw4uK1Jm7
         5dYwLX4C9ZZCJJfGcu+b65QpE6Q3rifvuHTIBadvrMf1cUQTluPOMwzBloYYLn8HG3sv
         YHA1u6tgDA2rqiXedtjruGPY3vzyar9TvsQ+i01xHJvQ0Vr8On2roy8sWL6lwlw6/QI7
         rYf9PBSwr7bVJSm0FlvW8q6HCzSocECBfYTwf8Njh26h+xBNmfzqaHDUGjBncxNEFYif
         /hZqpdhPYAQL4BKydWmFHUmdAVWM7O+/6/yrsl2Z6RU2kPDwOJ0f/c0RdqLCHVGUjPAJ
         ysgw==
X-Gm-Message-State: AOAM530mm2W6CyC8Z7iuj7Ml9QYe2kG3s+NqmMsvzXowrNgkYbrj8YsF
        tXo7+alaYV9eEH1cSunQDdm+ebGt0utzcA==
X-Google-Smtp-Source: ABdhPJw7+wbEcxeGvP6s6ZJ+K9s54oBWBNNce+Q9YhzT/XYIL8Tlrz5uMXzYbvij9iHIj3eAZ0TnWg==
X-Received: by 2002:a63:5a1e:: with SMTP id o30mr1131758pgb.62.1597894784312;
        Wed, 19 Aug 2020 20:39:44 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id h9sm803062pfq.18.2020.08.19.20.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 20:39:43 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Liwei Cai <cailiwei@hisilicon.com>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Chen Feng <puck.chen@hisilicon.com>
Subject: [PATCH 1/3] drm: hikey9xx: Fix inconsistent compat string
Date:   Thu, 20 Aug 2020 03:39:39 +0000
Message-Id: <20200820033939.127932-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1597833138.git.mchehab+huawei@kernel.org>
References: <cover.1597833138.git.mchehab+huawei@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is against Mauro's tree here:
https://gitlab.freedesktop.org/mchehab_kernel/hikey-970/-/commits/master/

A previous patch changed this string to be
"hisilicon,kirin960-dpe", but there are other place where the
code still expects "hisilicon,hi3660-dpe", so change it back.

Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Cc: Liwei Cai <cailiwei@hisilicon.com>
Cc: Xinliang Liu <xinliang.liu@linaro.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Chen Feng <puck.chen@hisilicon.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/staging/hikey9xx/gpu/kirin9xx_drm_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/hikey9xx/gpu/kirin9xx_drm_drv.c b/drivers/staging/hikey9xx/gpu/kirin9xx_drm_drv.c
index 18fec5a1b59d..efa5727612f5 100644
--- a/drivers/staging/hikey9xx/gpu/kirin9xx_drm_drv.c
+++ b/drivers/staging/hikey9xx/gpu/kirin9xx_drm_drv.c
@@ -339,7 +339,7 @@ static int kirin_drm_platform_resume(struct platform_device *pdev)
 }
 
 static const struct of_device_id kirin_drm_dt_ids[] = {
-	{ .compatible = "hisilicon,kirin960-dpe",
+	{ .compatible = "hisilicon,hi3660-dpe",
 	  .data = &kirin960_dss_dc_ops,
 	},
 	{ .compatible = "hisilicon,kirin970-dpe",
-- 
2.17.1

