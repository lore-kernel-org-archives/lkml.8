Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C378DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D6B62075D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="zXTm3SG4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730171AbgFZPyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 11:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730101AbgFZPxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 11:53:49 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6296C03E97A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:53:49 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 17so9822277wmo.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3dhW1zpRJn6MuRyNGCR+XtNKordche0o+F/kMzuScM4=;
        b=zXTm3SG4EoOLmldH7ZgAjJ26q5anOcvWlaFRF800csm/wbDScWfDqVfZY2lEq+T/5Z
         AzitLOlzdCV50x2F3e/M8dqvwpbS9hQ6QGtNzOXcOuwvqyz2y1fEHn4t20kTYLR4ohb8
         yk0FUGDecRrzsTKtLZN1dtETEhB0HSezENWRlxgn16BA6ideO+8VXUVTyhl/tpSoYCwO
         sDMnoTJbJlk3Fs8Ikn0w9mqn/M+E6RLqFKj0oJqXr4bQsBJh4EIiImPPXdLKIe/dR8Hd
         6CcLr/fjTFvFVw7/M0vnWkLXpgAsSJrcEq3Vlt22Gd+pywTK0UCbaTBorxQ2G+W7+r+1
         Vg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3dhW1zpRJn6MuRyNGCR+XtNKordche0o+F/kMzuScM4=;
        b=EaZtUHObL5diciHe/aquSfQtPL55urCWH3QrehAzZaHoWh2dCBJt8l9sncD/bKB4is
         cNC9Ij/94rZCJq641K/78U2nRqJ7so27HMXt8u3WxXpJqeImDBgRjf98YDULnaA9Mjd6
         sx6SZm34rBEXUQHjDKZIJehBoeEvvJ+uf9KvxADWphtih9nyz9s5cJyxerILSonynLcI
         PE2fGPRztwitjrrXwSAOqm7tjpHtgfmW1F/Ee9k3Llgtudmb1bvIh/o2njv0F841hfSY
         3aJ3rFpBaQEtiLveTcZKWnnjOnUWcb/OG7yTECIDlgbvd5KYQyjfOAPzqk1Wz9ps6m6y
         qRFw==
X-Gm-Message-State: AOAM531bhrLLwxYAR4evh4JLVL/nzeDs7+98GTqEoocs4HLRzrm4c5QB
        nuprKSsRXNsE8UpXvJjy50n4wg==
X-Google-Smtp-Source: ABdhPJwG77d1JFYmn17Dsojx0FfCnFgXgA6Gd2Cbr/BKlfKTgWUJKL+qCHyGaeiNfaxBJ3DK7ckO4g==
X-Received: by 2002:a1c:80d3:: with SMTP id b202mr4226820wmd.111.1593186828506;
        Fri, 26 Jun 2020 08:53:48 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id h142sm8242791wme.3.2020.06.26.08.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 08:53:47 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 4/6] net: mdio: add a forward declaration for reset_control to mdio.h
Date:   Fri, 26 Jun 2020 17:53:23 +0200
Message-Id: <20200626155325.7021-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200626155325.7021-1-brgl@bgdev.pl>
References: <20200626155325.7021-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This header refers to struct reset_control but doesn't include any reset
header. The structure definition is probably somehow indirectly pulled in
since no warnings are reported but for the sake of correctness add the
forward declaration for struct reset_control.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 include/linux/mdio.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mdio.h b/include/linux/mdio.h
index 36d2e0673d03..898cbf00332a 100644
--- a/include/linux/mdio.h
+++ b/include/linux/mdio.h
@@ -18,6 +18,7 @@
 
 struct gpio_desc;
 struct mii_bus;
+struct reset_control;
 
 /* Multiple levels of nesting are possible. However typically this is
  * limited to nested DSA like layer, a MUX layer, and the normal
-- 
2.26.1

