Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B8FC07548
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33FEB20795
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="WiRGqWfo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgIJTHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbgIJTFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 15:05:18 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C0EC061757
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 12:05:18 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id r184so4232271qka.21
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 12:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=YeYgC+wnXE5WPKMChfHCba+wXVDxaxMd+TOtN5nzHHE=;
        b=WiRGqWfov9kwUNINermxnB/QkSIn7D6S9ynHb2Eiorv6y6o9z/BlDahZQqsoNbGQpg
         FoD4bsTSCoNWWTBknJhkroB7vgWaepGwpAVDBVo8oe5CbE46YWCejcwAiwC1/lbC+XaP
         OG3bYfhUU1aBUNTRrRhRGmOfMFENRYQe8UeMZgnbmrZUHiTt+BkTgQjdTFVaztUpQ7II
         jjdLJestf2kzGG1A8BYbdABs0uMR+g0DLvvsYaxLrptVWnoFCvqLOjOeBkUataSAH6ti
         ZEp3WQxE/gUHmPrZGhKQW3j7IZJFcyS9c/YiLglrl0FloEs0tjFg3y8qP6mxeWhRF0p+
         lW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=YeYgC+wnXE5WPKMChfHCba+wXVDxaxMd+TOtN5nzHHE=;
        b=b+Za1QxRaOl7rbsCzUudpwYIZ0osK6DXev87WgQiqUcsd5hY6SS0r/rWNDc2/+oUXO
         lyCBwiYD1y2RC3SD6ULzliDgajWPotsVEuHToZjrbZkQ5DzFd/Xt7+3DLmGIqXAs0KQW
         zWaDDjHU+2qORbDkvbKrvV2+a1Zd91AWbhx4+qhttPyklluVSFyHp0BG7Vj2r9C648rH
         N3fOOeGhln04Z2k6eSV5pONt6nKERX4P6CLTElbyTXvsIrorh6fRzczm8gBOZCsmoHoK
         JdyNYJNV2+J3SkYIsBpMk14vc8Bw53RkfZ7vCxsvZCIuAjcFBy16C7V3RIPSjK9oSaD1
         CopQ==
X-Gm-Message-State: AOAM532x6MRnBGxU34JCzP3qSxCIon7Xbyi6PS95Iq9TG8iAijalDRGL
        2QDOkPk2xhoYbQHzJ6+lISVx/xZyRurQ
X-Google-Smtp-Source: ABdhPJx/B5q6d8zO08WfVKwINiALJEH/HQ/qTEaXeiRZTxgl6xgQI4S3QhFJYeUzQlQv37OVfDwAYHQGL5IZ
X-Received: from lucyyan-linux.svl.corp.google.com ([2620:15c:2c5:3:1ea0:b8ff:fe73:6d39])
 (user=lucyyan job=sendgmr) by 2002:a0c:d848:: with SMTP id
 i8mr9890275qvj.31.1599764716606; Thu, 10 Sep 2020 12:05:16 -0700 (PDT)
Date:   Thu, 10 Sep 2020 12:05:09 -0700
Message-Id: <20200910190509.81755-1-lucyyan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH net] net: dec: de2104x: Increase receive ring size for Tulip
From:   Lucy Yan <lucyyan@google.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Moritz Fischer <mdf@kernel.org>,
        Lucy Yan <lucyyan@google.com>,
        Leon Romanovsky <leon@kernel.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        netdev@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increase Rx ring size to address issue where hardware is reaching
the receive work limit.

Before:

[  102.223342] de2104x 0000:17:00.0 eth0: rx work limit reached
[  102.245695] de2104x 0000:17:00.0 eth0: rx work limit reached
[  102.251387] de2104x 0000:17:00.0 eth0: rx work limit reached
[  102.267444] de2104x 0000:17:00.0 eth0: rx work limit reached

Signed-off-by: Lucy Yan <lucyyan@google.com>
---
 drivers/net/ethernet/dec/tulip/de2104x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/dec/tulip/de2104x.c b/drivers/net/ethernet/dec/tulip/de2104x.c
index cb116b530f5e..2610efe4f873 100644
--- a/drivers/net/ethernet/dec/tulip/de2104x.c
+++ b/drivers/net/ethernet/dec/tulip/de2104x.c
@@ -85,7 +85,7 @@ MODULE_PARM_DESC (rx_copybreak, "de2104x Breakpoint at which Rx packets are copi
 #define DSL			CONFIG_DE2104X_DSL
 #endif
 
-#define DE_RX_RING_SIZE		64
+#define DE_RX_RING_SIZE		128
 #define DE_TX_RING_SIZE		64
 #define DE_RING_BYTES		\
 		((sizeof(struct de_desc) * DE_RX_RING_SIZE) +	\
-- 
2.28.0.526.ge36021eeef-goog

