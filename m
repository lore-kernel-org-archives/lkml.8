Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B53C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 03:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E7CA206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 03:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNIu/9N/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgE1DWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 23:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgE1DWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 23:22:05 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D149AC05BD1E;
        Wed, 27 May 2020 20:22:05 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id m7so10960107plt.5;
        Wed, 27 May 2020 20:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=21+Me/VGImYZvAALwMW/TlRDNY64Ktic0W6oplj176U=;
        b=YNIu/9N/tfoskQHsmB6WR4tDg5++XkGIeYn4LMAecJ/UC5uGv5AvM/7rJdUJ7H1uC5
         Q19eZsve1FzpA9wXXj/d5HRhd3Ef1vFZNlhC622wH/MEz6Ym3P0/Fh+UC6j/omD3j8XJ
         TUeefHsuAy7chQWpldHLWvS9v5BCRjDDxVyzKxcMjNFfhymNekcKx9AytuY1okxNOMP5
         HjLMKU2lEtVEHYtQHRU4/8g7KcMoiCuKZWoPPoMFsAuWAEnPsT2MqV/utLGf3Y6vgEgD
         9rHbp2IK+vwKaOb2PhzTK4P0cnEmgG8Sc0kZzohnso8wf0uuS0BgPLOuhPTZ8Pof41sL
         q9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=21+Me/VGImYZvAALwMW/TlRDNY64Ktic0W6oplj176U=;
        b=RTSRxNu8ELgx7NhV5FS81+6prEEP515ziA8WTOsju1p/qXU/5Y5I2Z62sdhT4BKkWD
         9A+jNw3OdlPZMOvao1N8clfnvzhGHU5UmFrc0PchMgVMwv8hito2kenjy4HoVQuv5CQm
         uMquqBqI/oy7fCrlZ77U0JvqRBYU/B1tAC+MTSHlDGq3zMRjkNnnWSELAkYjq8UWkZr5
         NOHMvaEx7pAzJBw2hairu62+S+kr0tgRvf5EK8bQFx18e7bkCBlkrApibpEx2toLGmVz
         RNZT8V01eFQYuR9OHp9S1qZgEGzltraQSo2pGzij8XkloS1Q39FWS+wx/Ka48lZZWKPH
         O7Dw==
X-Gm-Message-State: AOAM530qTNVhF/mbREvJ0BCOlbFE3Sp2BNOopl4Ul1Dykq6PlfhZHfob
        Xy57BDJE7+4T2bJTTd6EKes=
X-Google-Smtp-Source: ABdhPJzSq8wA/wENY7gATNyGJeWD59l0emfQGvVUCt7z4OeY+1ktUSoeybW9LN+GtPDL2trZe1rjhw==
X-Received: by 2002:a17:90a:1c81:: with SMTP id t1mr1560327pjt.177.1590636125124;
        Wed, 27 May 2020 20:22:05 -0700 (PDT)
Received: from shane-XPS-13-9380.hsd1.ca.comcast.net ([2601:646:8880:9ae0:48f8:e8e6:91bb:bdaa])
        by smtp.gmail.com with ESMTPSA id k3sm4050287pjc.38.2020.05.27.20.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 20:22:04 -0700 (PDT)
From:   Xie He <hexie3605@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        Xie He <hexie3605@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/net/wan/lapbether.c: Fixed kernel panic when used with AF_PACKET sockets
Date:   Wed, 27 May 2020 20:21:33 -0700
Message-Id: <20200528032134.13752-1-hexie3605@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we use "AF_PACKET" sockets to send data directly over LAPB over
Ethernet using this driver, the kernel will panic because of
insufficient header space allocated in the "sk_buff" struct.

The header space needs 18 bytes because:
  the lapbether driver will remove a pseudo header of 1 byte;
  the lapb module will prepend the LAPB header of 2 or 3 bytes;
  the lapbether driver will prepend a length field of 2 bytes and the
Ethernet header of 14 bytes.

So -1 + 3 + 16 = 18.

Signed-off-by: Xie He <hexie3605@gmail.com>
---
 drivers/net/wan/lapbether.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wan/lapbether.c b/drivers/net/wan/lapbether.c
index e30d91a38cfb..619413f5d432 100644
--- a/drivers/net/wan/lapbether.c
+++ b/drivers/net/wan/lapbether.c
@@ -303,7 +303,8 @@ static void lapbeth_setup(struct net_device *dev)
 	dev->netdev_ops	     = &lapbeth_netdev_ops;
 	dev->needs_free_netdev = true;
 	dev->type            = ARPHRD_X25;
-	dev->hard_header_len = 3;
+	/* 18 = -1 (lapbether) + 3 (lapb) + 16 (lapbether) */
+	dev->hard_header_len = 18;
 	dev->mtu             = 1000;
 	dev->addr_len        = 0;
 }
-- 
2.25.1

