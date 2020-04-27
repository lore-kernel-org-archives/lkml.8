Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F508C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 13:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58F2D2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 13:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YY1jmVDb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgD0Nkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 09:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbgD0Nkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 09:40:49 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4D6C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 06:40:49 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b11so20592227wrs.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 06:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dbz02nTisvSMaCayZqy6zWjnsQ/x3RdNInN9mouDTIA=;
        b=YY1jmVDbUfGdSLdgSDdaKPBm2PF2JHjNumWTt1P1fphtHbOBXVXrXmgkZRwKvFFWuy
         iPNtnd4W98w9keMNLqki98aRtpIor43i8tQS4fA6gaBfqTC4p3RKL0PYNAnKtVWTexc0
         QPR2LSluUz8r+O4G0J4uF2+kDNX16Ys1vzdO9nDadgJr0X6A06TrI2jqOo+5wT2Oe3T3
         b4zUF+gdcXcl4IdHGNZXawehv5l0wahrHjg/HCKFtyRk+hrxx08BOgLXmeSTrx3/jIHN
         4ereEY9dqG04kMSsPza4yLlTPZcq+DYbR9CaAZg03+z3fQjRksMeO1WaEnN1MkfqQ9ZR
         uBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dbz02nTisvSMaCayZqy6zWjnsQ/x3RdNInN9mouDTIA=;
        b=hLrlyxLQqlQvuMjEXhGgvQ7ofjmrZdnBo9CATGsnNv1cTnZDCDz3ne/i+p8ceSEBKS
         GScdADqAafPzZtFTmm0RMR0nL1C601WQUniksj0e9J+Q7sev6AxREPoZk4TVHMgtTct7
         EczefUvPkJXyy++5x6KxtR7nYd74BFHhiiiyJwbtRghVeHEmkZO8gZM08PMwves+FbXd
         1s1FOY9OA9h/d74SOVvuUVBa1cryX7J5u2rz8a5p4VCu0a06scWSgt/t/9PTP1hJ9bxG
         R2Hq4pNPz+2lWa9QYe1KBEaqj/MziFFcjPWq1dAyXjVl+opw6DEtkCI5SW4mDgUoP1Xq
         xLww==
X-Gm-Message-State: AGi0PuYWIkexGurFmFiF3mRJoTD6Y2Y3D8nhZUnoIRldniLEK/sF4pa5
        26mBssDVhr6QTUtMYz1JgPU=
X-Google-Smtp-Source: APiQypIxshtgimAmWOuZWe0EuOq8ivAkmULsqGc6bzgsHFELdT4aMXsRp+/Q87EoLqOYY0pUnKLmBA==
X-Received: by 2002:adf:9d8d:: with SMTP id p13mr26794247wre.17.1587994848390;
        Mon, 27 Apr 2020 06:40:48 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-124.static.upc.ch. [31.10.206.124])
        by smtp.gmail.com with ESMTPSA id g186sm16290640wme.7.2020.04.27.06.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 06:40:47 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
X-Google-Original-From: Max Krummenacher <max.krummenacher@toradex.com>
List-Id: <soc.lore.kernel.org>
To:     Max Krummenacher <max.krummenacher@toradex.com>, soc@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Anson Huang <Anson.Huang@nxp.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Olof Johansson <olof@lixom.net>, Li Yang <leoyang.li@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v3 3/5] arm64: defconfig: ARCH_R8A7795: follow changed config symbol name
Date:   Mon, 27 Apr 2020 15:40:01 +0200
Message-Id: <20200427134003.45188-4-max.krummenacher@toradex.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200427134003.45188-1-max.krummenacher@toradex.com>
References: <20200427134003.45188-1-max.krummenacher@toradex.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Completes commit b925adfceb52 ("soc: renesas: Add ARCH_R8A7795[01] for
existing R-Car H3") and commit 361c5dbb446e ("arm64: dts: renesas:
Remove use of ARCH_R8A7795").

CONFIG_ARCH_R8A7795 was split in CONFIG_ARCH_R8A77950 and
CONFIG_ARCH_R8A77951.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

---

Changes in v3: None
Changes in v2: None

 arch/arm64/configs/defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 218aa4fa74734..b8259814065dc 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -853,7 +853,8 @@ CONFIG_QCOM_APR=m
 CONFIG_ARCH_R8A774A1=y
 CONFIG_ARCH_R8A774B1=y
 CONFIG_ARCH_R8A774C0=y
-CONFIG_ARCH_R8A7795=y
+CONFIG_ARCH_R8A77950=y
+CONFIG_ARCH_R8A77951=y
 CONFIG_ARCH_R8A77960=y
 CONFIG_ARCH_R8A77961=y
 CONFIG_ARCH_R8A77965=y
-- 
2.20.1

