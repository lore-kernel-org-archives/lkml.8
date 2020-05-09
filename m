Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3139C54E49
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 14:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83A9021473
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 14:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a5RZD77/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgEIOQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 10:16:49 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50500 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727840AbgEIOQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 10:16:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589033805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rHjTn2dsi89n+bmwnI8/mn+rjn6MipnID9zbEJHvSgc=;
        b=a5RZD77/NAZ8Q8l6Zkn1DUyovcl7PUvfR1mU+q7l05Luvd8ckSqnesD3hidcU5toh6ZRBa
        ozvOU43mZffyTZHl7DnzcJaG7qmU390rMFdDUzAB7wS28Q3P3fwPIX5+NgvQLss6s49GM7
        atWmnPoq8Yay0p8WRO1pLx7djXeL2JM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-60U6vMm0O5uXEmafB0cVfg-1; Sat, 09 May 2020 10:16:40 -0400
X-MC-Unique: 60U6vMm0O5uXEmafB0cVfg-1
Received: by mail-wr1-f71.google.com with SMTP id 30so2432132wrq.15
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 07:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rHjTn2dsi89n+bmwnI8/mn+rjn6MipnID9zbEJHvSgc=;
        b=PJzNZ8Lk9oyXmfSjiTgRtFoJ8bNygu//F+DVG9VnZUXrArBQOT4Lqxr4SKsRL+P+Z8
         Qxzz5gQogmYtC0pY4ZzywP3fZHC1Ls1DGrNKLZ4po8hSl40HuPjLoIITV8gFDE1GO+U6
         LfG4YO4hR8hoLt19UXW537louwfngzyXjqurY1mNPl5iKltwwOuswCxMKhmiPQMUlGvq
         S4j3FZRlAuqKIJoqE/yUQTvlhvUO6dEqtzI8uB5rwupDj5u3RUedAH/+kBogqrElufr+
         jGF5pHd3pSZZYMEwSJkSQb0hdtrthNLZ412/HQLUUHrgcc2p4kW8Jtp8FXKA8dR4pAD2
         s3nA==
X-Gm-Message-State: AGi0PuZYeNbDzSq33tWHw5BeOaGufqKV4ZpAQJx0t60wyfM2El3qkzOa
        O+DkZu3BPLyslWNWtBa7jMUz2pH7F7Z4QMgKs3VTK4/iPWuTItppoeWMPY10g0QVGoYGqpsNE5/
        lJUc/U7nCcYDt3sajDa9H9Z6P
X-Received: by 2002:a1c:7f86:: with SMTP id a128mr21548978wmd.95.1589033798884;
        Sat, 09 May 2020 07:16:38 -0700 (PDT)
X-Google-Smtp-Source: APiQypKREsLCLIr+USziB/WduDKj8G7m2OP44M3QbttWguPUKJjf4TtfLBWVR5wkFGD4Q6idIx3zhw==
X-Received: by 2002:a1c:7f86:: with SMTP id a128mr21548958wmd.95.1589033798686;
        Sat, 09 May 2020 07:16:38 -0700 (PDT)
Received: from turbo.teknoraver.net (net-2-44-90-75.cust.vodafonedsl.it. [2.44.90.75])
        by smtp.gmail.com with ESMTPSA id p23sm12668665wmj.37.2020.05.09.07.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2020 07:16:38 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Stefan Chulski <stefanc@marvell.com>
Subject: [PATCH net] mvpp2: enable rxhash only on the first port
Date:   Sat,  9 May 2020 16:15:46 +0200
Message-Id: <20200509141546.5750-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently rxhash only works on the first port of the CP (Communication
Processor). Enabling it on other ports completely blocks packet reception.
This patch only adds rxhash as supported feature to the first port,
so rxhash can't be enabled on other ports:

	# ethtool -K eth0 rxhash on
	# ethtool -K eth1 rxhash on
	# ethtool -K eth2 rxhash on
	Cannot change receive-hashing
	Could not change any device features
	# ethtool -K eth3 rxhash on
	Cannot change receive-hashing
	Could not change any device features

Fixes: 895586d5dc32 ("net: mvpp2: cls: Use RSS contexts to handle RSS tables")
Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 2b5dad2ec650..ba71583c7ae3 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -5423,7 +5423,8 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 			    NETIF_F_HW_VLAN_CTAG_FILTER;
 
 	if (mvpp22_rss_is_supported()) {
-		dev->hw_features |= NETIF_F_RXHASH;
+		if (port->id == 0)
+			dev->hw_features |= NETIF_F_RXHASH;
 		dev->features |= NETIF_F_NTUPLE;
 	}
 
-- 
2.26.2

