Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8153AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DF8E2078E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2I1ARx/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405707AbgFXRsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405546AbgFXRsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:48:03 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93BAC061573;
        Wed, 24 Jun 2020 10:48:02 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id w16so3326765ejj.5;
        Wed, 24 Jun 2020 10:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jZZKUF07v/nlA1jyQTW7KSPjbPs9IKRSHg41mjIxwpk=;
        b=N2I1ARx/dLm7sSUzcOK5T8mqTG5NefjiQcojWuL1WsHkjnyj7AhsY0PV6gAQwdHseM
         LdUX+UFsSxW4CtGt9ZR7+fAEllK5PJxq/6T80yo31RFjhcd8ecDDLFGMXw4GKerwnSdF
         aAcD42HXOic8v6HOooqMcWEd3ihwj2cF1qa0rCpthuGjvusFIgPP841SEPqxY8/lZiIb
         8weqCa9tcjDNTXThCaWvlr/NIlfQkNwUjfH2h9GC8P8n1nXnJ6x6UUd/n05nFUbe5QKb
         hWKo+kAbNvSvZqMmKBCq+X13lvRymFgymiV7Q97zh0W6PTVX2Pc50K8v3FFqEUXE35CD
         i8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jZZKUF07v/nlA1jyQTW7KSPjbPs9IKRSHg41mjIxwpk=;
        b=FjFPOED0V57aMcvM77oTsroQOyyy17rbqnEspjdNhw50WBzAfvgRYupq9+hTQuLEdL
         khC6NeXjYE4fCynUFIWYrT4C4eTve6M5ARM/ZLbslW2kcgpd0MX/l4W8X8lpqy4z8nIB
         rrYtBYg8c989EbudkuGotzy3ToCe6NDAwMJ/sbKv6g0RoE98MPxozKAVsemMXML7ryhO
         TR1T057638iIeQ5FNkjugy41ZuoYkrTI5ZMnXGnzeOjW4eUY9e+ij0kDbb7kRq+mfgaE
         QMKGe5g5rEgJ0YurGjQ6PesOr7sNU6sa+rmYTr8TIuTmqC/YLJEPU8BR1IewQIptdcSV
         TJBg==
X-Gm-Message-State: AOAM533fvbe12Z9pUyAV3ADKgN6WAoWGEEohUwW0myUTppUpCs3CkgB6
        GO4Cj8T/rz3NxNv7MfBEFBs=
X-Google-Smtp-Source: ABdhPJxpBJJj+r62B9B2JwGcdNNRsGArFpEmelEg/P6HHorrUxVbjyZ8z2BLXNHDGb3O7G+UQp8W0g==
X-Received: by 2002:a17:906:2cd5:: with SMTP id r21mr25227160ejr.20.1593020881524;
        Wed, 24 Jun 2020 10:48:01 -0700 (PDT)
Received: from localhost.localdomain ([188.24.137.55])
        by smtp.gmail.com with ESMTPSA id s14sm8044146edq.36.2020.06.24.10.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 10:48:01 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-actions@lists.infradead.org
Subject: [PATCH v2 1/6] clk: actions: Fix h_clk for Actions S500 SoC
Date:   Wed, 24 Jun 2020 20:47:52 +0300
Message-Id: <58c4bddaf178cb85d9930064af342190f6010e6e.1592941257.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1592941257.git.cristian.ciocaltea@gmail.com>
References: <cover.1592941257.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The h_clk clock in the Actions Semi S500 SoC clock driver has an
invalid parent. Replace with the correct one.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 drivers/clk/actions/owl-s500.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/actions/owl-s500.c b/drivers/clk/actions/owl-s500.c
index e2007ac4d235..0eb83a0b70bc 100644
--- a/drivers/clk/actions/owl-s500.c
+++ b/drivers/clk/actions/owl-s500.c
@@ -183,7 +183,7 @@ static OWL_GATE(timer_clk, "timer_clk", "hosc", CMU_DEVCLKEN1, 27, 0, 0);
 static OWL_GATE(hdmi_clk, "hdmi_clk", "hosc", CMU_DEVCLKEN1, 3, 0, 0);
 
 /* divider clocks */
-static OWL_DIVIDER(h_clk, "h_clk", "ahbprevdiv_clk", CMU_BUSCLK1, 12, 2, NULL, 0, 0);
+static OWL_DIVIDER(h_clk, "h_clk", "ahbprediv_clk", CMU_BUSCLK1, 12, 2, NULL, 0, 0);
 static OWL_DIVIDER(rmii_ref_clk, "rmii_ref_clk", "ethernet_pll_clk", CMU_ETHERNETPLL, 1, 1, rmii_ref_div_table, 0, 0);
 
 /* factor clocks */
-- 
2.27.0

