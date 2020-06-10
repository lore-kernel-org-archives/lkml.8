Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F68C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 02:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FD582072E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 02:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WV6GjXmi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgFJCs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 22:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgFJCsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 22:48:55 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB824C05BD1E;
        Tue,  9 Jun 2020 19:48:53 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id m2so259836pjv.2;
        Tue, 09 Jun 2020 19:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ni+uilwqIRIkx0GVWsdF+2V5OEOG5mSA6hHta0XscrI=;
        b=WV6GjXmi3xDVr0iooWqxfkFsi2YLlF2jJQ4xaO7pOwUAcWVcagTG7kqzJ2+x/V3XoM
         cIUBrcTR3uVZeUNpYpHjXX5e9kMMOp4j2FuDpKpMBAEt0PTO/lcouwu1bFWKcllt9d71
         Js6qAtRGhR3qKem3Vu3Ojzm137CUgbB1GlWJbCvIXKAZJiUoC+FlQ3lVCaUTMEVaFptI
         rxfhcXghD6mf2dbOMAhTSjmnlBZMjvUPXQjZIi/SSetWPXJMAZoIYmhYaFFng7d4hjMG
         l1LcDfaG1wUEUCdgy+ttZ5mH5G09UlPw5qkBXoPrpxZcP9OP0RTuLgNSxQsQUvuUvS+9
         zV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ni+uilwqIRIkx0GVWsdF+2V5OEOG5mSA6hHta0XscrI=;
        b=TLJB8AdA+gjOKs7z0Yjbtkk0KfPYbAyZATBjrJNKA4CGlVD3QAskhDIK1EYXeEzKVj
         6wu9SDia47fPnpAQiJ5M6Uy9HjsOf/d+kn0JUCvmV9Urx2JRi8n+lnmxVg59USOgekmk
         pULusxH3RhorITVkMw+/wcvggh9Rz9PpJwm8JKcIIrmQF7b6QTnw3GN0WYXlb0vlqPp8
         h6GkX9G3et452iQRdQEWlPhbIiAzzW4/NXpzcC2OU8yfx8QSrIfZnsFNGkSMUsmUw72M
         tdVqyW+CzIYktV4PCZ87jV/p41AtzO1xDQiwXQWpNdEq9XgKDl+pY0z1LiDIbY9qUu6r
         T5Vg==
X-Gm-Message-State: AOAM533hLy3RIIUBX/GgbUw2Lr5zO/IA57uQzPkot9n3fnqyd5DZoQsX
        RCCHcDDzEt08GUfeir2s31M=
X-Google-Smtp-Source: ABdhPJz5nic88Ni981nDzwn6VCpEgoJdImropSho/Nef4OH7XPFOhCxtQv5w39tSDFvFbRzobDEReQ==
X-Received: by 2002:a17:90a:ae11:: with SMTP id t17mr868017pjq.157.1591757333075;
        Tue, 09 Jun 2020 19:48:53 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id r8sm2733607pgn.19.2020.06.09.19.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 19:48:52 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] USB: ohci-sm501: Add missed iounmap() in remove
Date:   Wed, 10 Jun 2020 10:48:44 +0800
Message-Id: <20200610024844.3628408-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver misses calling iounmap() in remove to undo the ioremap()
called in probe.
Add the missed call to fix it.

Fixes: f54aab6ebcec ("usb: ohci-sm501 driver")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/usb/host/ohci-sm501.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/ohci-sm501.c b/drivers/usb/host/ohci-sm501.c
index cff965240327..b91d50da6127 100644
--- a/drivers/usb/host/ohci-sm501.c
+++ b/drivers/usb/host/ohci-sm501.c
@@ -191,6 +191,7 @@ static int ohci_hcd_sm501_drv_remove(struct platform_device *pdev)
 	struct resource	*mem;
 
 	usb_remove_hcd(hcd);
+	iounmap(hcd->regs);
 	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
 	usb_put_hcd(hcd);
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-- 
2.26.2

