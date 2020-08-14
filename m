Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E13EC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C94420829
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A2CVs4qx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbgHNLjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 07:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbgHNLjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 07:39:45 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCE1C061387
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 04:39:44 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c15so8037209wrs.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 04:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hkxne9wZTlAVbAAYNmpFWLXf7r4C/SN/Gq+uNhys7UA=;
        b=A2CVs4qxFTnXi4JQ4bVs4AIscTO7tdyd0Y7OF/MjFR4l5/KzuytVtCzuwG0uMy1YhR
         DUCeyZjBaqB/vwjoz0z1VSI/Px1LMQmWIwfl6jpcAFavd+m4XCXkwdeQ7HwjDQPDG9bO
         GY+fqeWNegJlFO86lIvjBLHy5oIc1tgzzJKq361YEBP8mdl1S0+yOdkr07LRGXMD9Ssk
         gAGj8iYy3g5kWrBJ+xDi/RPn0IhOgFVIFMb/1cJgruW1nOHYdRx2KCASsrSSR2oA3c6h
         LgYnaHN4GtwF8UBmS8EksivSmqKxeJ9rQ1H9ZlXQWhp9s63+0+sUmC3NRrynKgnKzMs7
         4v/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hkxne9wZTlAVbAAYNmpFWLXf7r4C/SN/Gq+uNhys7UA=;
        b=AdHDDB0LkmCdEqy7lB2JRHZCaEYXbJFT0n/zybipbP10FVMJR5Yq0bB9DAqMgtT2tC
         nsx2/5kBk8Wzq89+HXjL0qwsjciljMPW2w7xHKGXY5NXdOgrHSkJihwrhCG4KMYDncl2
         hM4YSHoQr+EJZYWC2bjcbinuQFCVGdSByVo1RNs2E1WsmFwZVakZcFYzwyeu2g344dDS
         KFI0+dGGrmIvIZM/eBB4agSk2TAYq3f3FzMzvZA4m0SWI374NsRthLVPnF4xVur2ZmYG
         RTmdn9In62XSsnEoTVybnSYevYDnNY17kMj45vp3hIYVHcQ8X6jspr4iDAIPSHy3en4q
         DPNg==
X-Gm-Message-State: AOAM533B+BoaXTPBkLeiCDlRBjgwo9FoLPVbYnKXYVKrPaK1ke7JL5sr
        2dfkFTf1dPq0saUJiGRRufF2qQ==
X-Google-Smtp-Source: ABdhPJwLmOXhCjKwnbD4sN+QT/fUjAaEM4Cn4FQbAWshbJyzZUGynsmCSNUg5tiuz3J2GoPw9JFdQQ==
X-Received: by 2002:a5d:6a09:: with SMTP id m9mr470749wru.383.1597405183375;
        Fri, 14 Aug 2020 04:39:43 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id 32sm16409129wrh.18.2020.08.14.04.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 04:39:42 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Shannon Nelson <snelson@pensando.io>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Martin Habets <mhabets@solarflare.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Donald Becker <becker@scyld.com>,
        David Hinds <dahinds@users.sourceforge.net>,
        netdev@vger.kernel.org
Subject: [PATCH 03/30] net: ethernet: 3com: 3c574_cs: Remove set but unused variables 'tx' and 'rx'
Date:   Fri, 14 Aug 2020 12:39:06 +0100
Message-Id: <20200814113933.1903438-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814113933.1903438-1-lee.jones@linaro.org>
References: <20200814113933.1903438-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/ethernet/3com/3c574_cs.c: In function ‘update_stats’:
 drivers/net/ethernet/3com/3c574_cs.c:954:9: warning: variable ‘tx’ set but not used [-Wunused-but-set-variable]
 954 | u8 rx, tx, up;
 | ^~
 drivers/net/ethernet/3com/3c574_cs.c:954:5: warning: variable ‘rx’ set but not used [-Wunused-but-set-variable]
 954 | u8 rx, tx, up;
 | ^~

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Shannon Nelson <snelson@pensando.io>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Martin Habets <mhabets@solarflare.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Donald Becker <becker@scyld.com>
Cc: David Hinds <dahinds@users.sourceforge.net>
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/ethernet/3com/3c574_cs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/3com/3c574_cs.c b/drivers/net/ethernet/3com/3c574_cs.c
index ef1c3151fbb24..bd0ada4e81b0f 100644
--- a/drivers/net/ethernet/3com/3c574_cs.c
+++ b/drivers/net/ethernet/3com/3c574_cs.c
@@ -951,7 +951,7 @@ static struct net_device_stats *el3_get_stats(struct net_device *dev)
 static void update_stats(struct net_device *dev)
 {
 	unsigned int ioaddr = dev->base_addr;
-	u8 rx, tx, up;
+	u8 up;
 
 	pr_debug("%s: updating the statistics.\n", dev->name);
 
@@ -972,8 +972,8 @@ static void update_stats(struct net_device *dev)
 	dev->stats.tx_packets			+= (up&0x30) << 4;
 	/* Rx packets   */			   inb(ioaddr + 7);
 	/* Tx deferrals */			   inb(ioaddr + 8);
-	rx		 			 = inw(ioaddr + 10);
-	tx					 = inw(ioaddr + 12);
+	/* rx */				   inw(ioaddr + 10);
+	/* tx */				   inw(ioaddr + 12);
 
 	EL3WINDOW(4);
 	/* BadSSD */				   inb(ioaddr + 12);
-- 
2.25.1

