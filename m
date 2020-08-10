Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F7FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 04:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F37A206B5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 04:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bN00W7kq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbgHJEkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 00:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgHJEkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 00:40:35 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F30AC061756;
        Sun,  9 Aug 2020 21:40:35 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id x69so7290895qkb.1;
        Sun, 09 Aug 2020 21:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cPds9HzkVUDwwmYzqeRQutg+bwybNljwD4ACV/nwwSk=;
        b=bN00W7kq8K9TmaWZXuTw6dNePzWjNRTgoZzQ18PkpamTZNcXUb3ZPIiiz6Dsv2w6rp
         zc0aKugBlQz2R5LoDusvHgVjvMqEPblxR/zA0vSZcNSXKuMThprTLCpc88r6hY7rKSkY
         S0loyiaVZW+HUk6dVlVaZ1PVP2CIfFF82ocFLmAT9THuLRnM6CFjcQOPcO7OmAMl5tLi
         302obDo5GVGpFlduTodqOJzdQA4M3rEXzvpxBQH/TyP0Lrsd+T15SPFDSLH0MjV2foSy
         BGfRQ4t42k4cfV6taDciFG+e3qkSofndTOXG0UVnE+8Koui+/GEC9lkzh7oBtiDuSevs
         Juuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cPds9HzkVUDwwmYzqeRQutg+bwybNljwD4ACV/nwwSk=;
        b=OXJHR1q76N+uFTX0C7nUY8GMlmt5cW2xSyPCaemlHXvJqr4rbFlV61Jw6u5hiVjwKg
         YZKWfIO130BlrUhe5qRiz2nZz4GnK1fpwlE17A5jMlKlJOPH799mMq0iVRwD9YhbKHkI
         ipoXONzIoASJmvHmlqLKC3MJQn2+IHwEvksVRNw360pLL5ADfJHY1FXXbP/ylxXntY2b
         Q+gYt1Cy6ddLYrUiPz3/JiPW3eKBjpqO1J0MDhhMfmZzJ25OZ/FzPpNm2DIj+pOy+ENg
         rx5sD9BfSMeqb+J+sPLhRM8sKTbTbGF3LjuAHc2oNX70XRce53Slk7U0ujaqpGpKrn/O
         8xrg==
X-Gm-Message-State: AOAM533lFvzsN5Oh26QTnynQlHoXzR2HWdwtLzLArZcW4nUVsF669uYl
        Z7rMRCt7b3D+j1Elbi/eeNCaKr7+
X-Google-Smtp-Source: ABdhPJxY3zxs2Ant+BaqLzC7XHeQJrChvgFX+/TFQ4dqxUX2ecSyT+XxQ1aBuxhafSOyH0NdTQIkQA==
X-Received: by 2002:a37:48c7:: with SMTP id v190mr23581106qka.153.1597034434113;
        Sun, 09 Aug 2020 21:40:34 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:45d1:2600::1])
        by smtp.gmail.com with ESMTPSA id d203sm13169026qkc.10.2020.08.09.21.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 21:40:33 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] clk: rockchip: Fix initialization of mux_pll_src_4plls_p
Date:   Sun,  9 Aug 2020 21:40:20 -0700
Message-Id: <20200810044020.2063350-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new warning in Clang points out that the initialization of
mux_pll_src_4plls_p appears incorrect:

../drivers/clk/rockchip/clk-rk3228.c:140:58: warning: suspicious
concatenation of string literals in an array initialization; did you
mean to separate the elements with a comma? [-Wstring-concatenation]
PNAME(mux_pll_src_4plls_p)      = { "cpll", "gpll", "hdmiphy" "usb480m" };
                                                              ^
                                                             ,
../drivers/clk/rockchip/clk-rk3228.c:140:48: note: place parentheses
around the string literal to silence warning
PNAME(mux_pll_src_4plls_p)      = { "cpll", "gpll", "hdmiphy" "usb480m" };
                                                    ^
1 warning generated.

Given the name of the variable and the same variable name in rv1108, it
seems that this should have been four distinct elements. Fix it up by
adding the comma as suggested.

Fixes: 307a2e9ac524 ("clk: rockchip: add clock controller for rk3228")
Link: https://github.com/ClangBuiltLinux/linux/issues/1123
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/clk/rockchip/clk-rk3228.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3228.c b/drivers/clk/rockchip/clk-rk3228.c
index d7243c09cc84..47d6482dda9d 100644
--- a/drivers/clk/rockchip/clk-rk3228.c
+++ b/drivers/clk/rockchip/clk-rk3228.c
@@ -137,7 +137,7 @@ PNAME(mux_usb480m_p)		= { "usb480m_phy", "xin24m" };
 PNAME(mux_hdmiphy_p)		= { "hdmiphy_phy", "xin24m" };
 PNAME(mux_aclk_cpu_src_p)	= { "cpll_aclk_cpu", "gpll_aclk_cpu", "hdmiphy_aclk_cpu" };
 
-PNAME(mux_pll_src_4plls_p)	= { "cpll", "gpll", "hdmiphy" "usb480m" };
+PNAME(mux_pll_src_4plls_p)	= { "cpll", "gpll", "hdmiphy", "usb480m" };
 PNAME(mux_pll_src_3plls_p)	= { "cpll", "gpll", "hdmiphy" };
 PNAME(mux_pll_src_2plls_p)	= { "cpll", "gpll" };
 PNAME(mux_sclk_hdmi_cec_p)	= { "cpll", "gpll", "xin24m" };
-- 
2.28.0

