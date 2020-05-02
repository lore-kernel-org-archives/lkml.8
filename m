Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3F4C47254
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 15:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 660942072E
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 15:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=footclan-ninja.20150623.gappssmtp.com header.i=@footclan-ninja.20150623.gappssmtp.com header.b="eF5aD3eQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgEBPxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 11:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728296AbgEBPxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 11:53:15 -0400
Received: from mail-ot1-x364.google.com (mail-ot1-x364.google.com [IPv6:2607:f8b0:4864:20::364])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5041C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  2 May 2020 08:53:13 -0700 (PDT)
Received: by mail-ot1-x364.google.com with SMTP id m13so5061406otf.6
        for <linux-kernel@vger.kernel.org>; Sat, 02 May 2020 08:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=footclan-ninja.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I4lpNAVGaRE4y7I/DvtIkD9a+y/AhW0J4S2h5DhYWcU=;
        b=eF5aD3eQaFLfSaCVSzr+hsdnGLLWDBRrM29f9WnbpPXgHpR2R6Ys6VFcEv0SBbxBvC
         x5Jv9QgJr3RkEQcfR5d/jj6FfoXtu04CqWn4Avfc31kN6ZsFTIlAlrkEzkS9gl7/uD5p
         x8BuxDibkPaQCKj7uYWINuxRlPyydfS2D13tqLVoOt0mxd8CBTYuEneCgUO2iBXkfWoV
         kbNz2UWUVIpjJNRG35DaN7LfnbBACeC/GooxLCR+lBA1z0vw+EbsJjAXHsU+29XQdfNn
         kTzOskiZX4hF/9nwq5eH70LH4QkAI5Scj8mhnps4NkM2Bf7vs5ZMJgXhe6YZjuF+dR08
         f+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I4lpNAVGaRE4y7I/DvtIkD9a+y/AhW0J4S2h5DhYWcU=;
        b=gBP53xC28VMD2XOytoFq3Bz6AhUkKw5amlnw+Uiu8lmmjsVz15yiuD5zBArQL83Mfb
         /Csn22DSIKi3JwPPrDVOnjy9WRH2PaSgoZXbqkNhr2Ma4mrIvgcZmmuc093k/zdnGLCl
         8D/X17qbHfsLTY3Qb2jrrtwSxu9llBMsD+iHQCAPAB/1R9YS7SCK61xXMjBgkNJdRtod
         uEIsxk14TIdxr/xhj9xeR8cvJn+GoXtPvN6Wg12ffsv/TFmYIUbqdW0ZA2U6vWq21km1
         rm1BlVuMshaiI6XWGy/Rdy1KsLa5dBROXxR9s+ncB35YnY+MFQahpDajazPSR4S27zjs
         jqJg==
X-Gm-Message-State: AGi0PuZkCN8xKgXI9+4RSLffkXJHqfRgJ9nzUNrfMGmqebr4nMFWbLXc
        W5skNIA8mdiBjjMGxzKI7twpRJ7u+sgjGsq8iE/sM9CY3HNYVA==
X-Google-Smtp-Source: APiQypL9yBY5YBqEJi0A9Ktx/4u1HlE+pywv0Z0JzNnbdkLEwmpTGIlJUcteGVidiB8KwK8fbcW90uO15gFy
X-Received: by 2002:a9d:7d91:: with SMTP id j17mr7742822otn.342.1588434792936;
        Sat, 02 May 2020 08:53:12 -0700 (PDT)
Received: from localhost.localdomain (pa49-195-101-57.pa.nsw.optusnet.com.au. [49.195.101.57])
        by smtp-relay.gmail.com with ESMTPS id s12sm702441oou.7.2020.05.02.08.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2020 08:53:12 -0700 (PDT)
X-Relaying-Domain: footclan.ninja
From:   Matt Jolly <Kangie@footclan.ninja>
To:     =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Matt Jolly <Kangie@footclan.ninja>
Subject: [PATCH] net: usb: qmi_wwan: add support for DW5816e
Date:   Sun,  3 May 2020 01:52:28 +1000
Message-Id: <20200502155228.11535-1-Kangie@footclan.ninja>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Dell Wireless 5816e to drivers/net/usb/qmi_wwan.c

Signed-off-by: Matt Jolly <Kangie@footclan.ninja>
---
 drivers/net/usb/qmi_wwan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 6c738a271257..4bb8552a00d3 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1359,6 +1359,7 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x413c, 0x81b3, 8)},	/* Dell Wireless 5809e Gobi(TM) 4G LTE Mobile Broadband Card (rev3) */
 	{QMI_FIXED_INTF(0x413c, 0x81b6, 8)},	/* Dell Wireless 5811e */
 	{QMI_FIXED_INTF(0x413c, 0x81b6, 10)},	/* Dell Wireless 5811e */
+	{QMI_FIXED_INTF(0x413c, 0x81cc, 8)},	/* Dell Wireless 5816e */
 	{QMI_FIXED_INTF(0x413c, 0x81d7, 0)},	/* Dell Wireless 5821e */
 	{QMI_FIXED_INTF(0x413c, 0x81d7, 1)},	/* Dell Wireless 5821e preproduction config */
 	{QMI_FIXED_INTF(0x413c, 0x81e0, 0)},	/* Dell Wireless 5821e with eSIM support*/
-- 
2.26.2

