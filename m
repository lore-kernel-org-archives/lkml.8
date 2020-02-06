Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C16DC2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 09:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F23AA20720
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 09:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEgvmMY0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgBFJAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 04:00:23 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34988 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbgBFJAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 04:00:21 -0500
Received: by mail-wr1-f68.google.com with SMTP id w12so6154230wrt.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 01:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5sjD6GtO1nvqtNeYaVu2dXjJztVUp4Fza3UUVcyBdz8=;
        b=KEgvmMY0VVAzsbcYvvd8l/IJyE67uBYksdurk5Z+hLfI7yKBMxt8ZcjhQgwfmagTU7
         6Bl7/TISBXJCyg4ACPHz0hQKNYBkl6pA9aoDSru0VSU6TKdrcDuBpf+Ub4M2l/22QxNX
         sGoH+UXoIf1zC8atlmWJfcZ12zAZhxp+hQh5EFfOlI4qYz+z8XkjEoZjnhGz/2g8r+aF
         Rj4H5jwM+qkWQxLItakxsOzCHv5uAcviM0TzGSgWly9tj+SO2QlcEoTVpNy8OAe5cnDp
         5iKabE3REKNFAbpC4oSM0//1nAO302/8lm4IZPX4E6BeEbkDDDBwW57S+RyS1EMIzio2
         z7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5sjD6GtO1nvqtNeYaVu2dXjJztVUp4Fza3UUVcyBdz8=;
        b=pDJtAceryTEh3wCx58vegZOEukHwaQe3c2GvdOOFqHuQ5aCad1Ad3yQ39RQqLemr4P
         pqvrpvmF/cyKX61xHZYjMYshuEBBe5qUOcUP5Xp8Zq0awX1mEyQBIs+lopbzRcdO1BX4
         xm9F088RgYJ9/D7+oRaA3xagQvBYEpaAcbVVCpbHrOKdGQmVbGd+EIByyUuY1qjyRGY+
         oqJE3XIAsRpsbVKcFoiQ4ny7XS8cEGLdqbMNyu/BG/jcduiq6UHb32UtQpPp2o5j81ns
         6kc5x2a7TJyi+G9DjgeuEIXNsSG8BY3VIm3JglK/iEwFb3tjgIwoZGU9CjWEN29cJPWu
         It7A==
X-Gm-Message-State: APjAAAUQ2h2MGLNXnEIUq8VbE68QAZfz30JDK4iksa7p6QDHGLsRMlBW
        vjtKW+s9vtqvW32VimUgHoUlCBcP
X-Google-Smtp-Source: APXvYqx52RcTP7S2d83VL5HqhwxlPbWiXJuL6simw07NUcqrVTjxHyZm0Gjh39mbBaQSGy0ZRFTGDQ==
X-Received: by 2002:adf:f103:: with SMTP id r3mr2622273wro.295.1580979620535;
        Thu, 06 Feb 2020 01:00:20 -0800 (PST)
Received: from localhost.localdomain (dslb-002-204-143-014.002.204.pools.vodafone-ip.de. [2.204.143.14])
        by smtp.gmail.com with ESMTPSA id u8sm2816393wmm.15.2020.02.06.01.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 01:00:20 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: remove unnecessary RETURN label
Date:   Thu,  6 Feb 2020 09:59:24 +0100
Message-Id: <20200206085924.21531-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary RETURN label and use return directly instead. Since
the return type of rtw_free_netdev() is void, remove the return at the
end of the function.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/os_dep/osdep_service.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/osdep_service.c b/drivers/staging/rtl8188eu/os_dep/osdep_service.c
index 69d4b1d66b6f..4ba2378a1bb8 100644
--- a/drivers/staging/rtl8188eu/os_dep/osdep_service.c
+++ b/drivers/staging/rtl8188eu/os_dep/osdep_service.c
@@ -31,12 +31,11 @@ struct net_device *rtw_alloc_etherdev_with_old_priv(void *old_priv)
 
 	pnetdev = alloc_etherdev_mq(sizeof(struct rtw_netdev_priv_indicator), 4);
 	if (!pnetdev)
-		goto RETURN;
+		return NULL;
 
 	pnpi = netdev_priv(pnetdev);
 	pnpi->priv = old_priv;
 
-RETURN:
 	return pnetdev;
 }
 
@@ -45,18 +44,15 @@ void rtw_free_netdev(struct net_device *netdev)
 	struct rtw_netdev_priv_indicator *pnpi;
 
 	if (!netdev)
-		goto RETURN;
+		return;
 
 	pnpi = netdev_priv(netdev);
 
 	if (!pnpi->priv)
-		goto RETURN;
+		return;
 
 	vfree(pnpi->priv);
 	free_netdev(netdev);
-
-RETURN:
-	return;
 }
 
 void rtw_buf_free(u8 **buf, u32 *buf_len)
-- 
2.25.0

