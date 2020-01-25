Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDA9C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 17:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E0A92071E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 17:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B++NlONW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbgAYRJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 12:09:38 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45827 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgAYRJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 12:09:38 -0500
Received: by mail-pg1-f193.google.com with SMTP id b9so2836991pgk.12
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jan 2020 09:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=b6njYIG6ff8eY1VFaMmfpvx8PhOEu/k5+MjVDr3pN7U=;
        b=B++NlONWRWsNIZANd707V/YLH+WiK/uNB7UNheivQx7q29GhnFHLgKMeyQJFw2E1+g
         yCcrqPua/dRNSm7m03QQoUPh45oht9Qd8pFbnJ+oxSqXKOocoWzKKeXq7g3g4FqFztVI
         FZwbhxEYPlKzZPgZUb2TolYCOD0icD/etvjmGu94WoegsE3QfOQokQqTpqGeHyc7u/Iy
         dW5AJIVQ49LezGnat4UGOe42GXgHS53bzI9SNSuiP2uqZ+2MaZ9gS90nepNTTGzx96eR
         3+KyiQMiNgcLWuTSqWBt2ydXTjCZ88PTmikQIRgcCTGObuesYbYp7AaueGedDugmFmk0
         uxzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=b6njYIG6ff8eY1VFaMmfpvx8PhOEu/k5+MjVDr3pN7U=;
        b=E1lXsmgGKZPkWiOMVbtzvQyj0mYQq+GTkonul/SKyzk5NG3gLPLnB7kxQG9ML+sesM
         +Ms+UDTc1RAwh1WKD7vadhgEtsnwmuOypku0Ix4UjXlpgDol0zgN0AeXZsjFElx/fDCY
         ZkinuN5wiJMq8xDUNefO/AJYcQEhGCkwSvUCZ1dNdQcOJB/8bOO45icst8zOGO9zs8iJ
         h6k2wX5YFNGUljbxvgTMLRhW6fjWjh0LJnmhB3SmBr7H2eRXwywwXpQdi68TgdI+tu/X
         DaZ8NBn5wc2DZ7zGcTmdAvXrod4krdobSzw6uElyOFe9+c5VjcXQFXN4+wTYQMMlXKuf
         qgfw==
X-Gm-Message-State: APjAAAXK6tGA2vppPqkNkBycznSqy7tNKz7+nVZ8D2JJ5lHZVToCZ8DX
        MN0TabStZ1Qj6PT+aC4FkUo=
X-Google-Smtp-Source: APXvYqww1GWZAEpKI0hYdg/duDCDhypF8ADpRXtwQ4+BGmX/ggPSVC13d/Tx7TJMcc9V0CaFReRSkg==
X-Received: by 2002:a63:2a49:: with SMTP id q70mr10278060pgq.265.1579972177300;
        Sat, 25 Jan 2020 09:09:37 -0800 (PST)
Received: from google.com ([123.201.163.48])
        by smtp.gmail.com with ESMTPSA id a12sm10408176pga.11.2020.01.25.09.09.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 25 Jan 2020 09:09:36 -0800 (PST)
Date:   Sat, 25 Jan 2020 22:39:30 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     forest@alittletooquiet.net, gregkh@linuxfoundation.org,
        quentin.deslandes@itdev.co.uk, colin.king@canonical.com,
        saurav.girepunje@gmail.com, tvboxspy@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: vt6656: fix Unneeded variable: "ret"
Message-ID: <20200125170930.GA4809@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.6.2-neo (NetBSD/sparc64)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded variable "ret". Issues reported by coccicheck.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
  drivers/staging/vt6656/card.c | 3 +--
  1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/vt6656/card.c b/drivers/staging/vt6656/card.c
index 7958fc1..654cebc 100644
--- a/drivers/staging/vt6656/card.c
+++ b/drivers/staging/vt6656/card.c
@@ -719,7 +719,6 @@ int vnt_radio_power_off(struct vnt_private *priv)
   */
  int vnt_radio_power_on(struct vnt_private *priv)
  {
-	int ret = 0;
  
  	vnt_exit_deep_sleep(priv);
  
@@ -739,7 +738,7 @@ int vnt_radio_power_on(struct vnt_private *priv)
  
  	vnt_mac_reg_bits_off(priv, MAC_REG_GPIOCTL1, GPIO3_INTMD);
  
-	return ret;
+	return 0;
  }
  
  void vnt_set_bss_mode(struct vnt_private *priv)
-- 
1.9.1

