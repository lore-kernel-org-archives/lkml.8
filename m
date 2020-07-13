Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39F7C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8709D2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K/YUcN3S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730291AbgGMOuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 10:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730217AbgGMOt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 10:49:58 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA95C061794
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:49:58 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z13so16874194wrw.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uKRsk38fGN1JQaMOEwt3q4K2iQCr73XGMAa+Q9xdB5Q=;
        b=K/YUcN3S/tmWmQag6LOp3T4Wg5FcOqEZ2W68vMLFZnK3d2+l3OM3sJbS1KNAwxvObA
         yhgx0ONPgbSIqN29/qTMXHszJo+yhnWHubNp4XhN/Y0Oh43t6VCWnvQqZAIET/tQ+0SZ
         oxMCUDvbWGHGL+WpFqB25XsXSsgB7tBgo/DIAxHg6rK9I+BNgxOjBAkIxXpyV7UNeYB7
         QwOcvXHkd+2h8aNEugFElcNM4xoYN3H8MAk2A689KKaO9ZPujjAjcGwMPgidWkRfMhjB
         +V1enrSSdKh7uQfFPqGYlTFLnQadmk+yy8A+RDLqeWd6K64kdG/9w67b0Fu1XZUZfazE
         kjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uKRsk38fGN1JQaMOEwt3q4K2iQCr73XGMAa+Q9xdB5Q=;
        b=AjCzA4YA7liCmuyX0euzR0BS4eGD3wK1pYpvTP5sVmlvhDkq9Fzg2ECFxdkvBP1Mf0
         3RFOpHmru0u4fHmZbzpWsm1GV6RnMKIHeW5YhBlKeflhSJPqPMb0RR6yddrXjUVcewon
         TOgjv9T9mfVPz+XYZMZSCDDzw/0rH+FpJjini7pO50uA1H6VmvwZJbod6LtLxyT1Brdj
         RIiVwmiaqJxzWeO+iyPbXe2CEa99LILmaKNypCMLb3HiBRcgWiCsglxdB8juauxkJ7PN
         WM62BtZ2OTeNo+aqUy7twZ/rk9K/16NH0FdrngSUg8ngxeevK0PrNfstBOittd05z5tU
         Bfxg==
X-Gm-Message-State: AOAM530lZz1O7s2UVBNEvBpufYqQq4hz/wUBGAiqn2g5pUWXF9eaeNEv
        huESl8OEs4K5HLryXomxUia7YyOls4o=
X-Google-Smtp-Source: ABdhPJwYqJX6ZuguLwM5+Ec2ZSKGU8tVwoL3QG+hSSQkxpib9RseQ+txAS/pJjRxq/vdPiCOcH8kxA==
X-Received: by 2002:adf:f608:: with SMTP id t8mr81988741wrp.308.1594651797153;
        Mon, 13 Jul 2020 07:49:57 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.6])
        by smtp.gmail.com with ESMTPSA id o29sm26207756wra.5.2020.07.13.07.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 07:49:56 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org
Subject: [PATCH 22/25] pinctrl: tegra: pinctrl-tegra194: Do not initialise field twice
Date:   Mon, 13 Jul 2020 15:49:27 +0100
Message-Id: <20200713144930.1034632-23-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200713144930.1034632-1-lee.jones@linaro.org>
References: <20200713144930.1034632-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both PIN_PINGROUP_ENTRY_Y() and DRV_PINGROUP_ENTRY_Y() macros are
called for each of the 2 pin groups defined here, and both of them
initialise 'drv_reg', causing the compiler to complain.

Only initialise 'drv_reg' once.

Fixes the following W=1 kernel build warning(s):

 drivers/pinctrl/tegra/pinctrl-tegra194.c:71:14: warning: initialized field overwritten [-Woverride-init]
 71 | .drv_reg = ((r)), | ^
 drivers/pinctrl/tegra/pinctrl-tegra194.c:105:2: note: in expansion of macro ‘DRV_PINGROUP_ENTRY_Y’
 105 | DRV_PINGROUP_ENTRY_Y(0x14004, 12, 5, 20, 5, -1, -1, -1, -1, 0)
 | ^~~~~~~~~~~~~~~~~~~~
 drivers/pinctrl/tegra/pinctrl-tegra194.c:124:3: note: in expansion of macro ‘drive_pex_l5_clkreq_n_pgg0’
 124 | drive_##pg_name, | ^~~~~~
 drivers/pinctrl/tegra/pinctrl-tegra194.c:128:2: note: in expansion of macro ‘PINGROUP’
 128 | PINGROUP(pex_l5_clkreq_n_pgg0, PE5, RSVD1, RSVD2, RSVD3, 0x14000, 0,
 | ^~~~~~~~
 drivers/pinctrl/tegra/pinctrl-tegra194.c:71:14: note: (near initialization for ‘tegra194_groups[0].drv_reg’)
 71 | .drv_reg = ((r)), | ^
 drivers/pinctrl/tegra/pinctrl-tegra194.c:105:2: note: in expansion of macro ‘DRV_PINGROUP_ENTRY_Y’
 105 | DRV_PINGROUP_ENTRY_Y(0x14004, 12, 5, 20, 5, -1, -1, -1, -1, 0)
 | ^~~~~~~~~~~~~~~~~~~~
 drivers/pinctrl/tegra/pinctrl-tegra194.c:124:3: note: in expansion of macro ‘drive_pex_l5_clkreq_n_pgg0’
 124 | drive_##pg_name, | ^~~~~~
 drivers/pinctrl/tegra/pinctrl-tegra194.c:128:2: note: in expansion of macro ‘PINGROUP’
 128 | PINGROUP(pex_l5_clkreq_n_pgg0, PE5, RSVD1, RSVD2, RSVD3, 0x14000, 0,
 | ^~~~~~~~
 drivers/pinctrl/tegra/pinctrl-tegra194.c:71:14: warning: initialized field overwritten [-Woverride-init]
 71 | .drv_reg = ((r)), | ^
 drivers/pinctrl/tegra/pinctrl-tegra194.c:107:2: note: in expansion of macro ‘DRV_PINGROUP_ENTRY_Y’
 107 | DRV_PINGROUP_ENTRY_Y(0x1400c, 12, 5, 20, 5, -1, -1, -1, -1, 0)
 | ^~~~~~~~~~~~~~~~~~~~
 drivers/pinctrl/tegra/pinctrl-tegra194.c:124:3: note: in expansion of macro ‘drive_pex_l5_rst_n_pgg1’
 124 | drive_##pg_name, | ^~~~~~
 drivers/pinctrl/tegra/pinctrl-tegra194.c:130:2: note: in expansion of macro ‘PINGROUP’
 130 | PINGROUP(pex_l5_rst_n_pgg1, PE5, RSVD1, RSVD2, RSVD3, 0x14008, 0,
 | ^~~~~~~~
 drivers/pinctrl/tegra/pinctrl-tegra194.c:71:14: note: (near initialization for ‘tegra194_groups[1].drv_reg’)
 71 | .drv_reg = ((r)), | ^
 drivers/pinctrl/tegra/pinctrl-tegra194.c:107:2: note: in expansion of macro ‘DRV_PINGROUP_ENTRY_Y’
 107 | DRV_PINGROUP_ENTRY_Y(0x1400c, 12, 5, 20, 5, -1, -1, -1, -1, 0)
 | ^~~~~~~~~~~~~~~~~~~~
 drivers/pinctrl/tegra/pinctrl-tegra194.c:124:3: note: in expansion of macro ‘drive_pex_l5_rst_n_pgg1’
 124 | drive_##pg_name, | ^~~~~~
 drivers/pinctrl/tegra/pinctrl-tegra194.c:130:2: note: in expansion of macro ‘PINGROUP’
 130 | PINGROUP(pex_l5_rst_n_pgg1, PE5, RSVD1, RSVD2, RSVD3, 0x14008, 0,
 | ^~~~~~~~

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pinctrl/tegra/pinctrl-tegra194.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pinctrl/tegra/pinctrl-tegra194.c b/drivers/pinctrl/tegra/pinctrl-tegra194.c
index 2e0b5f7bb095b..c94ba17243c87 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra194.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra194.c
@@ -98,7 +98,6 @@ static struct tegra_function tegra194_functions[] = {
 		.sfsel_bit = 10,				\
 		.schmitt_bit = schmitt_b,			\
 		.drvtype_bit = 13,				\
-		.drv_reg = -1,					\
 		.parked_bitmask = 0
 
 #define drive_pex_l5_clkreq_n_pgg0				\
-- 
2.25.1

