Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211DEC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 03:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00A962070A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 03:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVvmIcHl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgGTDuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 23:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgGTDuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 23:50:03 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3062C0619D2;
        Sun, 19 Jul 2020 20:50:03 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 207so8386007pfu.3;
        Sun, 19 Jul 2020 20:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YH5Ac89Q4DpBjkm7EXUDOjaAGjnjWFyt277PJmQDNsE=;
        b=MVvmIcHlT557Sh1XefG+9U5EDY6JttOiXXx+c63j17II7CM6Y+PAzyUO8+IGTFUY5d
         lo6RtCcJYZ92zo4Ca3q09+CEEkxTsmFy41RtujrjqkWrHLrva/+25xyHgQdpddxkHC7L
         5N2mtk9/d3F1oEk+GHY3ZRPBhvmpOOoqbkHEmHdBmid6hCafE8TibQVUvwSLf/3q4OOv
         Nx8h5h1u20IRLobl/y8W+ZRXJxM9Yj/6IVi5IslqDExclYwXuzuyNZ0VwxnF9OLzR/aF
         HqRJ7GspvgRmh8VKmM34BsnPveTVYePC+vyrUVoLYAnv8p1sDH458fX1x9eNmXefIF94
         UDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YH5Ac89Q4DpBjkm7EXUDOjaAGjnjWFyt277PJmQDNsE=;
        b=nUGcy4GrXZCs8i82JoZQNYOgWSGEn1PhIELid8kpCBzNXfevyBLxpGMRURe0GFrCXO
         o3p4QhMyWIEUcJP5CXiirO7XyaUQnbdLX0J1UQgk2VtqUaHQh4r4Gdyef+c3opW4wo9l
         1lpR7WiCBWRYrzmUKR0fXrCh2l8TEQuz6BdgvS8EfOLvN0jqRVnq4aEB8fDWyYFclvYu
         NOOGNn90/rCYFtcT4gjVRswmZdhYcWrr1yEqVQX2i/Yng00prfkYX04ZqZRlhuxotkyO
         vQrpRl7E32cizh1EygBPWZLifg8n4DOhPi9oiEN5f/eYwd7HC1VxE1iewUViQa02CkBu
         UIYw==
X-Gm-Message-State: AOAM533r6w1ZW2u+Kw+LkVq7o+TjeIHCi8auJ0R7Z3WS0BUpGboHjPJY
        t3FswAzDDMK13/TfJtrRY6Ufy5wt
X-Google-Smtp-Source: ABdhPJztFOPl178CyUsEQCSSbKiiOUseHDDiIXb7XQnCW15wuySTsJafHE8jrhNgkXBoareZuvgsjA==
X-Received: by 2002:a62:140e:: with SMTP id 14mr17284700pfu.196.1595217002470;
        Sun, 19 Jul 2020 20:50:02 -0700 (PDT)
Received: from localhost.localdomain (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id z11sm15183445pfj.104.2020.07.19.20.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 20:50:01 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Pirko <jiri@mellanox.com>,
        Eric Dumazet <edumazet@google.com>,
        Taehee Yoo <ap420073@gmail.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Maxim Mikityanskiy <maximmi@mellanox.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Michal Kubecek <mkubecek@suse.cz>,
        linux-kernel@vger.kernel.org (open list), olteanv@gmail.com
Subject: [PATCH net-next v2 1/4] net: Wrap ndo_do_ioctl() to prepare for DSA stacked ops
Date:   Sun, 19 Jul 2020 20:49:51 -0700
Message-Id: <20200720034954.66895-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200720034954.66895-1-f.fainelli@gmail.com>
References: <20200720034954.66895-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding another layer of call into a DSA stacked ops
singleton, wrap the ndo_do_ioctl() call into dev_do_ioctl().

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/core/dev_ioctl.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 547b587c1950..a213c703c90a 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -225,6 +225,22 @@ static int net_hwtstamp_validate(struct ifreq *ifr)
 	return 0;
 }
 
+static int dev_do_ioctl(struct net_device *dev,
+			struct ifreq *ifr, unsigned int cmd)
+{
+	const struct net_device_ops *ops = dev->netdev_ops;
+	int err = -EOPNOTSUPP;
+
+	if (ops->ndo_do_ioctl) {
+		if (netif_device_present(dev))
+			err = ops->ndo_do_ioctl(dev, ifr, cmd);
+		else
+			err = -ENODEV;
+	}
+
+	return err;
+}
+
 /*
  *	Perform the SIOCxIFxxx calls, inside rtnl_lock()
  */
@@ -323,13 +339,7 @@ static int dev_ifsioc(struct net *net, struct ifreq *ifr, unsigned int cmd)
 		    cmd == SIOCSHWTSTAMP ||
 		    cmd == SIOCGHWTSTAMP ||
 		    cmd == SIOCWANDEV) {
-			err = -EOPNOTSUPP;
-			if (ops->ndo_do_ioctl) {
-				if (netif_device_present(dev))
-					err = ops->ndo_do_ioctl(dev, ifr, cmd);
-				else
-					err = -ENODEV;
-			}
+			err = dev_do_ioctl(dev, ifr, cmd);
 		} else
 			err = -EINVAL;
 
-- 
2.25.1

