Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09A0C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 09:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6DCE20716
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 09:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyBKbaOR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgHAJm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 05:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbgHAJm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 05:42:27 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F858C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 Aug 2020 02:42:27 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id q7so34821799ljm.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Aug 2020 02:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Geux1n7ky2eH1Y8p9KzQaNhv3N4zS3YhRr+vtlh2v1k=;
        b=RyBKbaORrd7Ioae/J9LKl0aWf3Te5dKlH704lW5I7OPuFRkCis2LsMYTYPnuieKnPN
         YktxMvwrjlpTrgj0Uaz+QDKbcYuxuMEzwKbTzt0iTUk5YbKKbMm7o+2vXYS8ItpF1vFm
         F0chhUDF1xN4ua+hXhf/oTYN0rn75z1h1Fr4xHBGSc7gI6SPw4ffIL21eGEkZ/+ac9q2
         dzTFH8HvjiscMxOR2s1rGPnqlE3csaLJ0dWuY4yaJcoCFm4OSDT9wXkjkZRIq1Yca81W
         neJo0bsS+WH7/6yD6bCi5wxlQQ6W/W0xvOlY5N6Gv6djAPqH4qkojjHyFkYDH9Lz6Djm
         3KIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Geux1n7ky2eH1Y8p9KzQaNhv3N4zS3YhRr+vtlh2v1k=;
        b=iAGPXU5ypQRUyTAlymlF+KIwsXgOZzbnyW7YmdEHS0LmnnTSZ82uLhXee/80nqhsiZ
         ufxVblUqUwSnt/D4UfIRT0JrbNh/sTbxz3uOQbNYo35Dtf3ztaRfl1ocgEVQgGZxfLYB
         0yeytGuEaXq34vnoX1Zddt3Z5FSnArDV41xX0NzagS5KLtualNaOAm+u/BDs5UewwKWa
         qyi4TjmG26PX/ozT/Q9l08sp7lJ/uBTxTzbaZOO1AZqbUivwaP/wKBmIhMej6hc8w128
         TvGCcax61hUU0O2s5HqBxRk6TW1dQTLcnnFIhyp+KiOlv+xIpku9eY31Bhbx1yjG6k1/
         rfHQ==
X-Gm-Message-State: AOAM530rbbA2jec4ZumKJfRDZoW6CySOMGG7VTzqm0S2hxsNgw14mQNy
        TGEuGrjewLzfyj0YNRDPHXIjX5lk
X-Google-Smtp-Source: ABdhPJwdS0XFEcLSlBLi6ME2sayBQ4pLwGM9u5UnUzt5guHcN/wvVR4+5Rm/hBZ2SyTNlBX2lOBclA==
X-Received: by 2002:a2e:320c:: with SMTP id y12mr3485354ljy.399.1596274945927;
        Sat, 01 Aug 2020 02:42:25 -0700 (PDT)
Received: from alpha (10.177.smarthome.spb.ru. [109.71.177.10])
        by smtp.gmail.com with ESMTPSA id q29sm2573932lfb.94.2020.08.01.02.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 02:42:25 -0700 (PDT)
Received: (nullmailer pid 13495 invoked by uid 1000);
        Sat, 01 Aug 2020 09:47:20 -0000
From:   Ivan Safonov <insafonov@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        B K Karthik <bkkarthik@pesu.pes.edu>,
        Michael Straube <straube.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ivan Safonov <insafonov@gmail.com>
Subject: [PATCH] staging: r8188eu: replace rtw_netdev_priv define with inline function
Date:   Sat,  1 Aug 2020 12:47:07 +0300
Message-Id: <20200801094707.13449-1-insafonov@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function guarantees type checking of arguments and return value.

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
 drivers/staging/rtl8188eu/include/osdep_service.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/osdep_service.h b/drivers/staging/rtl8188eu/include/osdep_service.h
index 31d897f1d21f..e0ccafdea9cd 100644
--- a/drivers/staging/rtl8188eu/include/osdep_service.h
+++ b/drivers/staging/rtl8188eu/include/osdep_service.h
@@ -71,8 +71,10 @@ struct rtw_netdev_priv_indicator {
 };
 struct net_device *rtw_alloc_etherdev_with_old_priv(void *old_priv);
 
-#define rtw_netdev_priv(netdev)					\
-	(((struct rtw_netdev_priv_indicator *)netdev_priv(netdev))->priv)
+static inline struct adapter *rtw_netdev_priv(struct net_device *dev)
+{
+	return (((struct rtw_netdev_priv_indicator *)netdev_priv(dev))->priv);
+}
 void rtw_free_netdev(struct net_device *netdev);
 
 #define FUNC_NDEV_FMT "%s(%s)"
-- 
2.26.2

