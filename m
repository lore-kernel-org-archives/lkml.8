Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB66BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 14:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9977820709
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 14:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyPFoilr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732560AbgGVOcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 10:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729642AbgGVOcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 10:32:24 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4B9C0619DC;
        Wed, 22 Jul 2020 07:32:24 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id by13so1792652edb.11;
        Wed, 22 Jul 2020 07:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nNsiEmPBIFOsf4DXkdZ3vPVnQQshUlVNTjBcCaHEnjc=;
        b=WyPFoilrQTeVYQlEYd2+AY6s3YGYTOtkfIdTJf10SyhWsDp0p6Q5F8jMvoEf3iYvDW
         3M0NMe+7evKE26xYarbHMs7tR7l5jQuvyLuz8VOr6b0ptn/PYccCuVDaZnQ/UGAzI5tB
         6WMPsVdlMGT5tbnAtJwjMQeMfANJR/pdGogSbm7afwizpZ6REx0w5ONFzSvd6ZiZ5ESP
         xDbX6Q1VtavVBSh0e2m/LL0LueaZfElQBrpPhIIGZgjRkQAOfIj+pHeYgWMpc6DOHQxl
         Qpc+FQ2r49gXsWDJ2yCqXmE1Wh66rOHJK7RDjoUF9BuWw4Yf0PDqNfpQBPqazvPtv69s
         XlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nNsiEmPBIFOsf4DXkdZ3vPVnQQshUlVNTjBcCaHEnjc=;
        b=pMCM53c2BrbqrFb4uFEAC05wfFQy+l57MsqqrydhwOoNkM9tJWzfgMFQWoP4PpoAjZ
         bp+ViElRIVwrP7yV6zlGXxgo4em9BDpv9M5AK2qir3WSY4Zd/BI6nE5xurwb0LTM+E9n
         +Yxl44QKyGejl3O39HEYsnorUepK0nYKI1MOnPx9EXXtoyQ0qx+yKlDC9J9+L9f3J89s
         KdK2n6EU/V7r9m+3g0HsiHnPsqyrE8hgvO5N84ceAqRCeSS1WZTDiE4DBpdRp7nOsAyx
         IqWo208VFEbo03aYv+LD9wDTwa1fXAwf6p7dYrdRvIQjdyI0rY38M8XhWJ1DR0/EY6MD
         g4vg==
X-Gm-Message-State: AOAM5336i7jUYD9Bslu9aIAngXSRzfXyP9jn/qIVEyiNkGEqgF6frs3p
        wkW09gWPaJGjyvAXZInSGA==
X-Google-Smtp-Source: ABdhPJyzBHlHSxcm1mOJz7RgitIEiI1G8AfPTeYo6CtxyU1gQlGLpJjlZgAjhrUFhDUTE5PfORqXKQ==
X-Received: by 2002:a05:6402:1d0a:: with SMTP id dg10mr29739748edb.110.1595428343163;
        Wed, 22 Jul 2020 07:32:23 -0700 (PDT)
Received: from localhost.localdomain ([2a02:810b:f40:e00:922b:34ff:fe38:6455])
        by smtp.googlemail.com with ESMTPSA id by20sm19750663ejc.119.2020.07.22.07.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 07:32:22 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     Alex Bee <knaerzche@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: rockchip: add CLK_IGNORE_UNUSED to RK3188 sclk_mac_lbtest
Date:   Wed, 22 Jul 2020 16:31:37 +0200
Message-Id: <20200722143137.863-1-knaerzche@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the loopbacktest clock is not exported and is not touched in the
driver, it needs the CLK_IGNORE_UNUSED flag in order to get the emac
working.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 drivers/clk/rockchip/clk-rk3188.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
index 77aebfb1d6d5..892b1edc3444 100644
--- a/drivers/clk/rockchip/clk-rk3188.c
+++ b/drivers/clk/rockchip/clk-rk3188.c
@@ -354,7 +354,7 @@ static struct rockchip_clk_branch common_clk_branches[] __initdata = {
 			RK2928_CLKGATE_CON(2), 5, GFLAGS),
 	MUX(SCLK_MAC, "sclk_macref", mux_sclk_macref_p, CLK_SET_RATE_PARENT,
 			RK2928_CLKSEL_CON(21), 4, 1, MFLAGS),
-	GATE(0, "sclk_mac_lbtest", "sclk_macref", 0,
+	GATE(0, "sclk_mac_lbtest", "sclk_macref", CLK_IGNORE_UNUSED,
 			RK2928_CLKGATE_CON(2), 12, GFLAGS),
 
 	COMPOSITE(0, "hsadc_src", mux_pll_src_gpll_cpll_p, 0,
-- 
2.17.1

