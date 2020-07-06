Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B41C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA2D720715
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G1JoL1Da"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbgGFNgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729231AbgGFNdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:33:51 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB56EC08C5DF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 06:33:50 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r12so40879510wrj.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 06:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2vBJeRBU9C8xa/2tDAV3EYv6FtdJQoWad8hFtUeL0Ic=;
        b=G1JoL1Daorj+JI1ZRbOm0BsITxlYPCPhqAXR8booNKNusooKx24v80Dl9rC+dERNjZ
         1wDaFAseXrhBUGr/nbWDDAg/16r5MFQ9cICHpdVqoKiFiyiwWy/N6B6OmFsQ5NXGyjc9
         YYrEKmJpZh64Xww7sSEG5VmFi3dtB3DobR83PDYZV5cTCGpwS6PSwpL/XGycHcTpzTWc
         KSpxBlGnI3+pIfmjl4b1LGJvFxbn3iOWQV/oCNEbTR+EPdh+h7R8qux7lxvt8n7chmMt
         6dbFgzTJ0owILMLo/els7olUo+4e0lOaKULvAdId+iS9nhTGGBE4kGFBKvyANowDHPnf
         XWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2vBJeRBU9C8xa/2tDAV3EYv6FtdJQoWad8hFtUeL0Ic=;
        b=LrsRCbOGVQKGBGkSQQzpwDUHoR6logyD/Pr+iUAzvDTBJ3xdbBfUsX2P1mc+dQxW0Z
         gJNJnP2iHuvc4IO5Pjy4tVc5Uh/Grom8c0nAqSApB8JUESPv+UWqKS8hVZuTVG6L5H2t
         tE5PFD1kB/GP+nuT8/YfVSazIcXtjayPqc/ruCUTieUT+fCF4WYYLnlG4ckvC59dZgrR
         zkpB4E5M9SvvHUtSJmhgCyNjFVZWrf1cIbSpSRgInoY+ww6bK4NW8GJAOPAc2BwUyNsU
         hSAa2JMXxv29aPL0nMquc17Z8ac3BxZ0vZpQi9KtZaKJrpwid9KamfYqtNRUx8av9BoJ
         MFmQ==
X-Gm-Message-State: AOAM5305rlpKk6o3GkDFpZ1UF9qGzdqKlp2nngFuVZbt2mW+IVxHJXmH
        QP9WwCktd/WvyP2D80MnCrI1HQ==
X-Google-Smtp-Source: ABdhPJxwyl8nugjLp5ZVCs5jjXRLq7y1skE4cNELfOaMcl4PfNxE/98yrBxip9g69YujC40tpLTZeg==
X-Received: by 2002:a5d:5706:: with SMTP id a6mr13465102wrv.328.1594042429481;
        Mon, 06 Jul 2020 06:33:49 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id v18sm25416082wrv.49.2020.07.06.06.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 06:33:48 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Felipe Balbi <balbi@kernel.org>
Subject: [PATCH 04/32] usb: gadget: udc: amd5536udc_pci: Remove unused variable 'mod_desc'
Date:   Mon,  6 Jul 2020 14:33:13 +0100
Message-Id: <20200706133341.476881-5-lee.jones@linaro.org>
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

Fixes the following W=1 kernel build warning(s):

 drivers/usb/gadget/udc/amd5536udc_pci.c:52:19: warning: ‘mod_desc’ defined but not used [-Wunused-const-variable=]

Cc: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/gadget/udc/amd5536udc_pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/amd5536udc_pci.c b/drivers/usb/gadget/udc/amd5536udc_pci.c
index 80685e4306f31..56258d076abc4 100644
--- a/drivers/usb/gadget/udc/amd5536udc_pci.c
+++ b/drivers/usb/gadget/udc/amd5536udc_pci.c
@@ -49,7 +49,6 @@
 static struct udc *udc;
 
 /* description */
-static const char mod_desc[] = UDC_MOD_DESCRIPTION;
 static const char name[] = "amd5536udc-pci";
 
 /* Reset all pci context */
-- 
2.25.1

