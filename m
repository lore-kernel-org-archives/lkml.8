Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E880C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 04:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4861620CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 04:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qpBa2Lee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgFSEsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 00:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgFSEsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 00:48:11 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBA6C06174E;
        Thu, 18 Jun 2020 21:48:11 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id o26so6585630edq.0;
        Thu, 18 Jun 2020 21:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Ig2R/GH+geDbBcQc05MQOh9FfNnoXhYYjeBjy90BgIs=;
        b=qpBa2Leew5PV1KT37qWkid+SvbFBEMIIWf+oK559wigtq//I3dJq8D6Of9TqJq9bsR
         PxmtEJ4dxXTfMVdHf9jjMsATC6Q9gH7pxNqsWROrCbxnUIzb+gOXshOHIiFXIGUzsJM6
         9nVGjzGVbK9FLT1SGWrgAbe7Pjq0M1YxQ4juq1tJevon74O4j/Tm9+IZbp5hYmpSuBM4
         nAd5oxWyhdCm0BcunM6RRNp2bSojAWAPtmNpwQS/Rz8kbzMD3hrbmdMswgAbPNk0+n6S
         Wcwm3wwxmRFlVZ9BEww5t0NZlJD/vdnywvIPJP3zN7wLoiFgzojFkinT22Wg7NvpyXho
         IaGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ig2R/GH+geDbBcQc05MQOh9FfNnoXhYYjeBjy90BgIs=;
        b=jCPgkfDmnEHtjYbIjqxnYBK0BTgYGhRpxEGlfYPDNXjZJeZZkDfETZQX8JKLnVHF2f
         e5kmxISQLILYiKrpyBzVankRmn0oYrDttPO9i8J6nOP/Q+Y3P41YSxtAxdvARepMIxZZ
         G89NZ1yRBwaA2qIeRf4lRH2rjvw105b7u0Uu+rmgkRE83OXnJNj13Pgla8B2baMeUoM3
         Ks69cvIWMZEN2U+/3OjL4ctbW2ETv1u7ykMjpwmJHlg84t1esmDQcfABUhUWdJZV1XVW
         XlF0Uo1xYI8MyWZFYGY8jQ8iJ7WYTDbEAqIwiLtXpOIZbmpaj16Dvlcn2qhRtdTQxYKl
         yGig==
X-Gm-Message-State: AOAM530QCgwtKRxyGcsUJDnKJVNb3ujTTenDW1vhxGFWGwAvK+edm7tD
        XxIHM6AOhKfU0KwQKUx6UG3sp/NY
X-Google-Smtp-Source: ABdhPJyvIze5msj6fBLxxtN9Z1WwMo1aOjRf1c8HWUd/t+O8n/Ns7PDTwrOwSsemhrVbI2V5ihOKZA==
X-Received: by 2002:a05:6402:3c1:: with SMTP id t1mr1512789edw.350.1592542089518;
        Thu, 18 Jun 2020 21:48:09 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id ew9sm3867852ejb.121.2020.06.18.21.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 21:48:08 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Dajun Jin <adajunjin@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org (open list),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE)
Subject: [PATCH net 0/2] net: phy: MDIO bus scanning fixes
Date:   Thu, 18 Jun 2020 21:47:57 -0700
Message-Id: <20200619044759.11387-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series fixes two problems with the current MDIO bus scanning
logic which was identified while moving from 4.9 to 5.4 on devices that
do rely on scanning the MDIO bus at runtime because they use pluggable
cards.

Florian Fainelli (2):
  of: of_mdio: Correct loop scanning logic
  net: phy: Check harder for errors in get_phy_id()

 drivers/net/phy/phy_device.c | 6 ++++--
 drivers/of/of_mdio.c         | 5 +++--
 2 files changed, 7 insertions(+), 4 deletions(-)

-- 
2.17.1

