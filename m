Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302C9C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 23:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F24CF2187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 23:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tI2NiClZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgBNXi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:38:59 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38454 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbgBNXi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 18:38:58 -0500
Received: by mail-pg1-f193.google.com with SMTP id d6so5696479pgn.5;
        Fri, 14 Feb 2020 15:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ansE9BXniVnGIxcikhhDRkhuN4JIqkypt/Fdru6j3lQ=;
        b=tI2NiClZdUk3FpABSDtrdlK2Jl14In0WGJb7aFnC8fUSaOyKVHaV6vqZQM4tjo7djd
         X+aIaqYHOTHk+hOFna22b4YgYG0l1/z/JWl2H/IlNWK5b8/89J6QgJFuK338USRR2szt
         0pGh+xXAFnvG4gjBfsTLKY+QDT3fr/Uu7Vm5LiKCNMx4sb4mgNw1DJmmZtD306Fxc5Dj
         owssEufCuTeuRn0RA9laCpl+7yldoQQ75HCee2JUANhJzojns4mPppBfc9kTVxqWfsrE
         6NYlygJkk+E+3mgUPyu24eOHSgn/QTK0JsZ/SRGIXJMROf5FX4gTIw8e6Kp73a6cDaWf
         wh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ansE9BXniVnGIxcikhhDRkhuN4JIqkypt/Fdru6j3lQ=;
        b=udLXBdbcl463dadtpAJw6hcgfAUEemE/SkhOqpe8870nfa/KpZASqxBM0L4YEFSoo/
         cddVXm0secM51Pwx08kRbhiL9G9E3AKX9RCe2b79kT7yWnXIf0f3F+3FEJWter96ArY+
         9Ro6rPFdoy4/TkhRXef48dT4MmJiKnGXiLg9FTuPvk2GJ04jLoSjFn4Ls/Op/oHHkdrg
         f8e+IlMYPTkuRipoz40U0xq9l80cFy2EM03uKHbal7sriVrs2qGl/9vsFSXsdGfgG6zj
         kGrZJgTOGrFdVSo+wHxq92LH/MneTM1/3FHPTUWZBLssdivuo1njeLSIURQo13AWNcBj
         Ez+w==
X-Gm-Message-State: APjAAAUWmr4pDRiv+FZfp9epoj8udaac+SSVb+HnV2SgbW/sxgeUi596
        S9E8C2GQJiXsFAEfahUOhAB9M3YD
X-Google-Smtp-Source: APXvYqzzH8SHC3RFw/m8MQP6AlU42vxHlYTyVH8Uw870bMOqos51gKvBiwqHRV9mnk6b/n2NobIaNg==
X-Received: by 2002:a63:d041:: with SMTP id s1mr5964200pgi.363.1581723537830;
        Fri, 14 Feb 2020 15:38:57 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id p17sm7797397pfn.31.2020.02.14.15.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 15:38:57 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 0/3] net: phy: Better support for BCM54810
Date:   Fri, 14 Feb 2020 15:38:50 -0800
Message-Id: <20200214233853.27217-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David, Andrew, Heiner,

This patch series updates the broadcom PHY driver to better support the
BCM54810 and allow it to make use of the exiting
bcm54xx_adjust_rxrefclk() as well as fix suspend/resume for it.

Florian Fainelli (3):
  net: phy: broadcom: Allow BCM54810 to use bcm54xx_adjust_rxrefclk()
  net: phy: broadcom: Have bcm54xx_adjust_rxrefclk() check for flags
  net: phy: broadcom: Wire suspend/resume for BCM54810

 drivers/net/phy/broadcom.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

-- 
2.17.1

