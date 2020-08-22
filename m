Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12ADDC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 20:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E369D2072D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 20:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADTs1/G9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgHVUML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 16:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727905AbgHVULl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 16:11:41 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C24FC061575;
        Sat, 22 Aug 2020 13:11:41 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d188so2788384pfd.2;
        Sat, 22 Aug 2020 13:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Um/WNPd91oiTBr33NTedUilUcqzUs/xSEC1UqKzBXT0=;
        b=ADTs1/G9cWNWRDKSvwLgAbYak3XiGpgCten0C3NSPrsJt2VG9vkAFZn1EDf95yUdpT
         QFujE4AbK6cfSZmmb61b9Mous3gyh9knDrdjDkJp+WzTCvXweYF8DP5JcppV/mS0+JJC
         d9kT4Kj7vCFY3hJK2mIL1WRnZI2zT+EogZ76paUsWF700l6yfjlj++WVPHjBlEjdf25Z
         AYxlx0/oX3zFdyRsrMAnXf1UWQC5+W8rY7rbdKK+G6KCyN4TZ8iViU74zKDhpkSHs73W
         mKvHFS0/b3wbyqpZrgKEdYuRRo5dJqqlc4inWbDRSOFJKW3uxyaI78f+FszprEFZ0as3
         bd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Um/WNPd91oiTBr33NTedUilUcqzUs/xSEC1UqKzBXT0=;
        b=ujEWdh8jzKt7SnL7HRhq6Z/VHPdFzctH9ckqxwZ6K0VA50h+Y9TueggjN/7sNxb5yf
         k5gLBrR4Tzt5aqkN9JlBsGTI/KCduhhyfMHvJL/eGNw7owfDmP5MVHJIoqPsETYBv8tT
         jqmi84JBMpC0ijjz8WSI5mu6ntkflZAv8gaer2BCSLiqUM3CvUQ7qSJY/lXR+C9NE4To
         wrSbQ876LWv3aYnlieBTgcP08TYFm0cLDNvDPhSNiokdboKtZ5l7+2rbPfN0dSzPQAVe
         3mfUi3hAJZifAUq74cdLTwFBM0zokVKexaCP8DlyH60dJNxacixkfABQcbCLxdDoofub
         3+Yw==
X-Gm-Message-State: AOAM531IUlCLjo98iYo9J6whsvkGv9bJluxAEhhiQMD07lulHcnked/n
        X6OmHa1f0gjNTtew2zwwgVhfJW2wf7Q=
X-Google-Smtp-Source: ABdhPJzqzGE1zF8BQVWftMIA1jNdH9sq3Rz2jHUl4u3GCr4FOcsIdPVcp3d2I90N+D2XhDvC5LKpuQ==
X-Received: by 2002:a63:2482:: with SMTP id k124mr6436326pgk.251.1598127100212;
        Sat, 22 Aug 2020 13:11:40 -0700 (PDT)
Received: from 1G5JKC2.lan (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id na16sm4678779pjb.30.2020.08.22.13.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2020 13:11:39 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-netdev@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH net-next 4/6] MAINTAINERS: GENET: Add UniMAC MDIO controller files
Date:   Sat, 22 Aug 2020 13:11:24 -0700
Message-Id: <20200822201126.8253-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200822201126.8253-1-f.fainelli@gmail.com>
References: <20200822201126.8253-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for removing myself from the PHYLIB entry, add the UniMAC
MDIO controller files (DT binding, driver and platform_data header) to
the GENET entry. The UniMAC MDIO controller is essential to the GENET
operation, therefore it makes sense to group them together.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5aeb00031182..4eb5b61d374a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3581,8 +3581,11 @@ L:	bcm-kernel-feedback-list@broadcom.com
 L:	netdev@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/net/brcm,bcmgenet.txt
+F:	Documentation/devicetree/bindings/net/brcm,unimac-mdio.txt
 F:	drivers/net/ethernet/broadcom/genet/
+F:	drivers/net/mdio/mdio-bcm-unimac.c
 F:	include/linux/platform_data/bcmgenet.h
+F:	include/linux/platform_data/mdio-bcm-unimac.h
 
 BROADCOM IPROC ARM ARCHITECTURE
 M:	Ray Jui <rjui@broadcom.com>
-- 
2.17.1

