Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB10C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 14:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 722C320820
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 14:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOLbRq1u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbgDHObI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 10:31:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54202 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728829AbgDHObB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 10:31:01 -0400
Received: by mail-wm1-f68.google.com with SMTP id d77so108903wmd.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 07:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ONmipAabLXhLmacX5u5HjoyUMJN6EG+/oCFGiL0N4tA=;
        b=YOLbRq1uKj6Qvu1dEuKm76Ws3dtcc9fTrkDcyKVKEsXPmzZRcnV9Y9A7jdVdgjyvN+
         t+F8y/p70omJKuFjVooQaYAjpQV70ucxA3AaVTwCNvSx3/0TFNumXAfyf/NSdbuwqb3o
         Dcn9VIjt6ArmzsMIB2lZ9d23T3F1N1r19T8N+W6eqLBuPUWlhHnuyREpWBUzU1rRjyp+
         eQirc435qRyDJjxdgE/9OBphtSqbp98604u7lyz+93sHvIVlC0WLkRVlnmeem5uwSnmq
         dE8mBNPrGOsOkxij8PcAy7hAnuhGOg8UbbUGSwRXqP1be+Z3RrUQ2QC8j0Vzmu8Wo+n3
         hSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ONmipAabLXhLmacX5u5HjoyUMJN6EG+/oCFGiL0N4tA=;
        b=QxgWKcYa8yE7FUhXGt4abj3M61MkuKooQlO7MURyrMLdSZyDj7kKGEKW+SZ7qZYDzb
         ND3w+r7oJ7zzHMc8q/vI//GDOQPNo7S1hx/qEcYAx19J/TEgYAgZVeCxHBODVO8oyDEC
         ZICtKygyae7jP1qckEFKHLzNjHwTdKkUZQgVOFJbDN51/CJ1fwbpSx2g24pkDX3I1uKm
         cCV/0OPogao/s+3YlCQ/MXsPqZFEWcgMCkVIzSn4yWMOzdYuw5AcFQHKusDwpHlOMKyH
         m5ZWQDUAOCREeE/YgT6VfIV8AJLfUMI3Q1d6/nCYWv1+HKBqXYvwvYu31JzmKTJqGUoV
         8xuQ==
X-Gm-Message-State: AGi0PuZw66d4LH1rGCwt4gimRGOnWXy3VYv29n1nFILWYZud62pZr1VC
        EypSOW6fRGAVyu/+78id+9E=
X-Google-Smtp-Source: APiQypLQAgnfKPromQs68QdsrIgESVtKzl4IrNXH+4yZyw1pfffbGmT0fK11SeQtWBwotYGy9vDdug==
X-Received: by 2002:a7b:c2a1:: with SMTP id c1mr4800795wmk.138.1586356258484;
        Wed, 08 Apr 2020 07:30:58 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-124.static.upc.ch. [31.10.206.124])
        by smtp.gmail.com with ESMTPSA id a10sm36268828wrm.87.2020.04.08.07.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 07:30:57 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
X-Google-Original-From: Max Krummenacher <max.krummenacher@toradex.com>
To:     Max Krummenacher <max.krummenacher@toradex.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Will Deacon <will@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
        Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org,
        Anson Huang <Anson.Huang@nxp.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v2 3/5] arm64: defconfig: PCIE_TEGRA194: follow changed config symbol name
Date:   Wed,  8 Apr 2020 16:30:38 +0200
Message-Id: <20200408143040.57458-4-max.krummenacher@toradex.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200408143040.57458-1-max.krummenacher@toradex.com>
References: <20200408143040.57458-1-max.krummenacher@toradex.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When adding PCIE EP functionality the config symbol name logic for
PCIE RC was also changed.

Fixes commit c57247f940e8e ("PCI: tegra: Add support for PCIe endpoint
mode in Tegra194")

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

---

Changes in v2: None

 arch/arm64/configs/defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d765a920a20b9..ac0dd3dbbbfb6 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -208,7 +208,7 @@ CONFIG_PCIE_QCOM=y
 CONFIG_PCIE_ARMADA_8K=y
 CONFIG_PCIE_KIRIN=y
 CONFIG_PCIE_HISI_STB=y
-CONFIG_PCIE_TEGRA194=m
+CONFIG_PCIE_TEGRA194_HOST=m
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_FW_LOADER_USER_HELPER=y
-- 
2.20.1

