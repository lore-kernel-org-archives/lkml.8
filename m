Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907EAC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D7072068D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="n5TfYfHG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389715AbgE1MfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 08:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389714AbgE1MfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 08:35:13 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EB5C05BD1E
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 05:35:12 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l26so2957268wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 05:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BQJlUoiEpzky8o42erc/ysy+K0QjdQ5ysTv41onRRZM=;
        b=n5TfYfHGMNMD8D+8R6USQfibZj8hFE1+qAcYAnQl3Mw9twHILNshCqgYHbRv7HpuaL
         v4IklUmYcEW5niLRusiOXOTcnxRLlH+wYowKNR3lZLf5ItsR95+s8Hv++i4vO5dC4uPh
         n0p4wW94L1kDNBcKfipskEv7wfb7426RGlrPhn4PFoxf1I0YEsoJru8lwCrLv92WVLLy
         2hlwHISith+xluEzHWoEfPddgu3jBHMUjBzpgKrfubN75bsbjR1KjwAIJGSc6VeHYsh9
         WQfz5qvkacA722/Ou4Ec0yxL3tlfgeZ+5nX5+ECK9Hx0I9c1Wqnk3rOdrygNkRJdfAh9
         V4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BQJlUoiEpzky8o42erc/ysy+K0QjdQ5ysTv41onRRZM=;
        b=Hz7Ac5w1PStOLuzg//KsCqQOP3JuZcc6XUltt5V8Pjc9ATI3gkU8+UCpsWMWLWY/yN
         UABXmNYNvH+YviMW1xaMnaUE2q+iq1qDvljwCWQfXTFJOz+Fl77ZKYzDXAbU5x+NWaTq
         CuWGjQd5EuF+qVnizGcR6DWUo5Bppmz75AX/1i2S8PZqzcg/t6J0XHJG1+oywtqiIDIi
         yrcI/oNoTPbm72urqLQku5kSjKEPXbwgstlqq8zmQfQzOqq/4DZBTjlVZdHgi1rm9Gff
         foczTsHVzZN3HjSuD0UDA456mlOOeQxIofrAuZkg1eepycorFcElGm0gUw+SMcGrBzLh
         EcNg==
X-Gm-Message-State: AOAM530dPvzdfk8qKxqncdasSltLv2HKRiEjGDvAkQo6KQ3Xi19RLPjV
        KWwj4UJW0bCa/oRa41exY8KKgA==
X-Google-Smtp-Source: ABdhPJwkYFBW2TmPZeRXJcUrexQmKR4xdJmfkmnN7Oh42inb9Wtau1p7DRTwWhCZId+ogIBZ4nemzg==
X-Received: by 2002:a7b:ce01:: with SMTP id m1mr3261268wmc.116.1590669310774;
        Thu, 28 May 2020 05:35:10 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id c140sm6027306wmd.18.2020.05.28.05.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 05:35:10 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Andrew Perepech <andrew.perepech@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 0/2] regmap: provide simple bitops and use them in a driver
Date:   Thu, 28 May 2020 14:34:57 +0200
Message-Id: <20200528123459.21168-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Hi Mark,

I noticed that oftentimes I use regmap_update_bits() for simple bit
setting or clearing. In this case the fourth argument is superfluous as
it's always 0 or equal to the mask argument.

This series proposes to add simple bit operations for setting, clearing
and testing specific bits with regmap.

The second patch uses all three in a driver that got recently picked into
the net-next tree.

The patches obviously target different trees so - if you're ok with
the change itself - I propose you pick the first one into your regmap
tree for v5.8 and then I'll resend the second patch to add the first
user for these macros for v5.9.

Bartosz Golaszewski (2):
  regmap: provide helpers for simple bit operations
  net: ethernet: mtk-star-emac: use regmap bitops

 drivers/net/ethernet/mediatek/mtk_star_emac.c | 80 ++++++++-----------
 include/linux/regmap.h                        | 18 +++++
 2 files changed, 53 insertions(+), 45 deletions(-)

-- 
2.25.0

