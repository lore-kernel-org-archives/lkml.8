Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A837C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 14:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51F132078D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 14:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJizyAfV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbgGHOpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 10:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729941AbgGHOpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 10:45:38 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6739C061A0B;
        Wed,  8 Jul 2020 07:45:37 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id p20so50792680ejd.13;
        Wed, 08 Jul 2020 07:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RdfWn03vRZooKuWSX0Y9p+HO6KzHdtLgw16so87+iZE=;
        b=CJizyAfVuX2RfMehSevr1t4fopl7nciJWOw82DAWph6fURt2MSJlRryCIgFKrxgofB
         TP+8Ig45ia2G+Qs6xzxtGkaPr3oJjiJ+DoTytD306TbFHX59zXtHGJwsXH6gkMm0HEfu
         0y63873T1NCTzNjshTA3JXKgdijPdEIRUSMmGLBglOjioC50pXKOD9FHqZCVTOvGJNVo
         Odva0/dO225Iwhit4dqTqi3rGe1SMRZvY7ylOBSygSEwY0WHqwJWpXjbE0HNdWjo6/s+
         LjVJnMxYV6vuBlAewZeD+FXJvGGoJeEWdIxDydasNZpdyprVEEWxWSMoOC56B+iNJRdI
         Cd6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RdfWn03vRZooKuWSX0Y9p+HO6KzHdtLgw16so87+iZE=;
        b=fu0WKn+ue3DdJhxC0cBaaddCb3dAv3g8DTrHi5oq5+oRIDnKDJ5cTd6nnCe2leFBGF
         USS9uYef1/ql0vyfbA26P1fh3bwwEb0xYyRNHtKgwSVprYjON48d8hxie5Bi4Oohez//
         vw7j095Wf0hFxD/6xUMrNVc/YvFNVemiq2oFuidMaA/feZZdmAJiINmy8G2SvrZXI9vt
         2LJfERaagfn6FthULgzz5PZqGyE6zY9/eh9upd/9X/Wg6veH07dVhSa39j6TRWY5h1zF
         EsZDamhqKCDVcpqIOUunCJcSQtBN60V61BemP3Lizyz6iTD6PT66AY+wGE+5Fn2GwFgr
         OrOw==
X-Gm-Message-State: AOAM530p76uj3F+AF62bmneO+IuV2CiGQbqeTydHJSoLCyslWkeKsJId
        CWv6zpHMovhl2nnlRCJpUh6aFC77CSQ=
X-Google-Smtp-Source: ABdhPJzR2jRjEGYSUyaOrdtfGtwk7CFmfjsZiD2qcbvBmzFKFC6WC0lRLu5+lMT/azD/9cFsvxS7zw==
X-Received: by 2002:a17:907:9c6:: with SMTP id bx6mr52133016ejc.43.1594219536533;
        Wed, 08 Jul 2020 07:45:36 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id z22sm28545654edx.72.2020.07.08.07.45.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 07:45:35 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     zhangqing@rock-chips.com, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: rockchip: mark pclk_uart2 as critical on rk3328
Date:   Wed,  8 Jul 2020 16:45:28 +0200
Message-Id: <20200708144528.20465-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rk3328 uart2 port is used as boot console and to debug.
During the boot pclk_uart2 is disabled by a clk_disable_unused
initcall. Fix the uart2 function by marking pclk_uart2
as critical on rk3328. Also add sclk_uart2 as that is needed
for the same DT node.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/clk/rockchip/clk-rk3328.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/rockchip/clk-rk3328.c b/drivers/clk/rockchip/clk-rk3328.c
index c186a1985..cb7749cb7 100644
--- a/drivers/clk/rockchip/clk-rk3328.c
+++ b/drivers/clk/rockchip/clk-rk3328.c
@@ -875,6 +875,8 @@ static const char *const rk3328_critical_clocks[] __initconst = {
 	"aclk_gmac_niu",
 	"pclk_gmac_niu",
 	"pclk_phy_niu",
+	"pclk_uart2",
+	"sclk_uart2",
 };
 
 static void __init rk3328_clk_init(struct device_node *np)
-- 
2.11.0

