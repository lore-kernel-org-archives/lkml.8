Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC181C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 19:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A116A217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 19:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pyD7oMxb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgAUTwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 14:52:23 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38211 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbgAUTwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 14:52:21 -0500
Received: by mail-wm1-f66.google.com with SMTP id u2so4540761wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 11:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=zxuX1UtB2iSvDZIxFVQFKZTyCjRelb+xJCXnYV6RwPY=;
        b=pyD7oMxb+h4jKCDHx8Zxqa3r8SpQmJ2Xi0xv8kpJVM4SCmmSXBcI+Z6rw5qTjx4OMx
         z/xAs+8vfuVthEGaOJ8rIWttOdK4Uz21k39epbl9VGqHZAEd8djy5bShH3OIl9Pyv3o8
         hT7lYK6/ARsKY+p3BiDduq4Nr2qio+HG+8JbHXOtaWhkyvT2tJmARM/6TJloPkJxjfEt
         vNInaIUlgP5GwGog2HwymKIsXXlAIvVUvL+OW2DCZYxDfWr4c/oj8uO4PY9Rkx3ac3za
         Px8ubbN0YxfyEEaiN3/DnmxizpwTA6dCqLh+7rSLrP8Gg9CcyoLrY0k2avYiuUaW1Go6
         yLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=zxuX1UtB2iSvDZIxFVQFKZTyCjRelb+xJCXnYV6RwPY=;
        b=q1DzGauVq6pYFkOpYAiPTkYCAxwO1S2vQONinUTJNUx5SmEV5U7zqLqQGwdOAqHsS9
         Vp3wLAgcUzXaz7B7Hixip1UrkzQacKwb6S7XYJstngA4Sb8SW0kHJn4WCSSSwb6ytBRI
         V1ir+HwDpnhdChfwtWmxPUHm8YNjbTDiw2rxEH9HT+CqOOq/8zsdqgtcrmSBNJZKeaZ3
         QVzDjZ2F1nLXY3Lgl6bafP1rgIqsUvzAdC3A8Q64gFW1Nko3J+AZR5q6mxuJ1OcxGIJs
         oM1gs86BRCvqp/k7y0y9UjtxyVZwxsF93VMTTMVG0aWuPpnZNvofJjtHt/toYWgzb/my
         IPcg==
X-Gm-Message-State: APjAAAWKBTap7ezvLFHCmkfDF3o/klPFiJHtD5o1j6dw6F+HHPCz2k4M
        p3c6BBrA0+RWbRo3duaCCG0NtzB1
X-Google-Smtp-Source: APXvYqx5Yx5lfcaSIVQJgA5csyaAkbauM0CYPILqYoYnpAt60f+UEz9SBSMVAtMbVmDNrGfVDa98NQ==
X-Received: by 2002:a05:600c:20f:: with SMTP id 15mr61254wmi.128.1579636339537;
        Tue, 21 Jan 2020 11:52:19 -0800 (PST)
Received: from linux ([2001:7c7:212a:d400:8c86:9345:7668:6b83])
        by smtp.gmail.com with ESMTPSA id s15sm50254070wrp.4.2020.01.21.11.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 11:52:19 -0800 (PST)
Date:   Tue, 21 Jan 2020 20:52:18 +0100
From:   Sandesh Kenjana Ashok <sandeshkenjanaashok@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: mt7621-pinctrl: Align code by cleanup long lines
Message-ID: <20200121195218.GA10666@SandeshPC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup lines over 80 characters in pinctrl-rt2880.c.
Issue found by checkpatch.pl

Signed-off-by: Sandesh Kenjana Ashok <sandeshkenjanaashok@gmail.com>
---
 drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
index d0f06790d38f..254d4eb88f5f 100644
--- a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
+++ b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
@@ -159,8 +159,8 @@ static int rt2880_pmx_group_enable(struct pinctrl_dev *pctrldev,
 }
 
 static int rt2880_pmx_group_gpio_request_enable(struct pinctrl_dev *pctrldev,
-						struct pinctrl_gpio_range *range,
-						unsigned int pin)
+					struct pinctrl_gpio_range *range,
+					unsigned int pin)
 {
 	struct rt2880_priv *p = pinctrl_dev_get_drvdata(pctrldev);
 
-- 
2.17.1

