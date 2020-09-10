Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F09C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 05:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95EA620756
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 05:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pn9wfWzQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgIJFra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 01:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgIJFqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 01:46:43 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B215C061756
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 22:46:43 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id b17so2497067pji.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 22:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uNzBaIddFg4BsU7/nCdz1Go6c2BgLxQ8YsDvHd2gerE=;
        b=Pn9wfWzQE8+ItwhIP7soVDKiDtcl5l5xGAcjYMIxuGR5mo0tWaO8GE7UdGB1k4pJG/
         odtC+dog/YuA+Zsr3QMxu+y3DyBDEqppg6v80aXXxlI4rAn+PPdAZT8ZLPovGMc055dk
         rvT4YrPDfDdYtRL5JWBkzTa5YkYrRHpipfkkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uNzBaIddFg4BsU7/nCdz1Go6c2BgLxQ8YsDvHd2gerE=;
        b=VXMCQvxVca69mRO7W4/rXnI8f+vNyQSOWjYEmijwVv/2iisuMhmUSeVAxv1aSD2oup
         29pUfMCXDIDPM2LcAYQ6Elfmfgciyn9zoi2m1rZmxIPLc5NpYL3H+6bJIjsK9ob5HRBi
         ImrXwL0tYHthWDcvrdsIrPurrK6ZpEY/BwA7Nxi1I6yp2WisUBeJUGhOn+wQ4efjVBHv
         j3EUD9yPfJ66vz5+iOZHKuk3zlVaa2dZUFxcMgXQkNqR7048cuI1CIAVaDgYFX/cCMDM
         BNgLcoOz9M+1xopSsbUwErDKwkD9BwnRIEoOe5H1kwkMKeL+K2mZm4+it6zy9DYF9M4r
         mF7w==
X-Gm-Message-State: AOAM531omQidM/hQSRn5ipELwhBny5CUNAy0hpYQyndOalF/TeTByELN
        RhJ3AAgAgHNSTbavC1nzw9mvlg==
X-Google-Smtp-Source: ABdhPJxsvHDFmBQT3hNQfRc0K4CNX75Rf7CfBpb5b7xGQHDqjr4jxVAld9lsUXWxQm430AApr2JTwQ==
X-Received: by 2002:a17:90b:e01:: with SMTP id ge1mr3645109pjb.187.1599716802305;
        Wed, 09 Sep 2020 22:46:42 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:1a60:24ff:fe89:3e93])
        by smtp.gmail.com with ESMTPSA id r6sm4598159pfq.11.2020.09.09.22.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 22:46:41 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-mediatek@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 1/2] arm64: dts: mt8173: elm: Set uart0 to mmio32 iotype
Date:   Thu, 10 Sep 2020 13:46:34 +0800
Message-Id: <20200910054635.3337487-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set uart0 iotype to mmio32 to make earlycon work with stdout-path.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
index a5a12b2599a4a..d54e62f72c65d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
@@ -1160,6 +1160,8 @@ &thermal {
 };
 
 &uart0 {
+	reg-io-width = <4>;
+	reg-shift = <2>;
 	status = "okay";
 };
 
-- 
2.28.0.526.ge36021eeef-goog

