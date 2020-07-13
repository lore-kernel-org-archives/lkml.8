Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44906C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DF3D206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="vYg1QXkr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbgGMN3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 09:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729900AbgGMN3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 09:29:48 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD75C08C5EE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 06:29:46 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 22so13325582wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 06:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QLryLftXHujJqlJtPMVgQIevZpScR7URaSYQFGMf70Q=;
        b=vYg1QXkrPB4tKtY/J12E9irR+rl+St7VpoMQvDD3sdENXMl7hNUJoPpt8dxHHq4WCv
         CPijOiC7QDFUo0WPLzm60ANpKUHRHimoQHRyGV2FnQkxistFnE06weWgWLjXG8XGGMHj
         dG1ZX6gvm6vEw/AvTlp9uA8XCGaTY/njfpK4Kbk2wSNX3f265/o4CZU6jDHdlR3C44BI
         6zBENnKs7WkMIOMrj2G1f+c5wSXtSsS9WMRMvLthCkuEK/OIn3Eurh3UR2a1v+1JRBdL
         v7klvlMmYrodM7wovd181BU/5/LoemsCXV6INeUtFdZReHYpsjXRdysQa3qJZr5XGP4q
         gXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QLryLftXHujJqlJtPMVgQIevZpScR7URaSYQFGMf70Q=;
        b=GQon1LOeLXi32g5JVmmaOeJwp/zeIstQRgX6LYN5GXMP64ZQHFwHoScOfIq2xPcn6p
         g+u23ow2eWYb8PCQPDsvXdlwYD1U67tx+mkImQHrHO6FQOD6WqfDSjG+WZ9MN/eZpxGM
         rBxcNZyL5e07TRbfNitIY4oVKi7tIKoR0i8XlihJh0ndkM9J7AWq8Qg1jlOpDPWO1EkT
         LzkLxd0x8vQSBMaLqAUjFoiFW5HRqY4c6FiT4BtCxn9q9TJzBhHClFxGm4VUdz2OWR1z
         BnYgH7CnNeOM7eCra4RaVFmx1zzDUHQyuCzfDNu0mDc9x4Qn5EMHyfqITe/2oM57LwtL
         bsIw==
X-Gm-Message-State: AOAM530dvhhIppOzCt+8fNKclWV8eWuFcni/1NLbICkmD6KVIbmWwacT
        nQdUBmCSy2cQxw8Dz6qxCfrizw==
X-Google-Smtp-Source: ABdhPJxtI2aU9Tn4XMAVUn0tMxGni2Keg7oC3cwRrzpDovC4u7fv3y7dpujSmm3QsvKjFxQHR93NsQ==
X-Received: by 2002:a1c:48c5:: with SMTP id v188mr25055wma.58.1594646985632;
        Mon, 13 Jul 2020 06:29:45 -0700 (PDT)
Received: from linux.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id j14sm23896642wrs.75.2020.07.13.06.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 06:29:45 -0700 (PDT)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH 5/6] remoteproc: mtk_apu: Don't try to use the APU local RAM
Date:   Mon, 13 Jul 2020 15:29:26 +0200
Message-Id: <20200713132927.24925-6-abailon@baylibre.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200713132927.24925-1-abailon@baylibre.com>
References: <20200713132927.24925-1-abailon@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, this local RAM is not accessible from the CPU.
If the CPU tries to access it, then the CPU will hang.

Remoteproc may try to use it when it load a firmware
that has some sections in the local RAM.
This workarounds the issue by skiping this section.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 drivers/remoteproc/mtk_apu_rproc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/remoteproc/mtk_apu_rproc.c b/drivers/remoteproc/mtk_apu_rproc.c
index 565b3adca5de..e16d3258a785 100644
--- a/drivers/remoteproc/mtk_apu_rproc.c
+++ b/drivers/remoteproc/mtk_apu_rproc.c
@@ -57,6 +57,9 @@
 #define CORE_DEFAULT2_SPIDEN			BIT(0)
 #define CORE_XTENSA_ALTRESETVEC			(0x000001F8)
 
+#define DRAM0_START				(0x7ff00000)
+#define IRAM0_END				(0x7ff80000)
+
 struct mtk_vpu_rproc {
 	struct device *dev;
 	struct rproc *rproc;
@@ -139,6 +142,7 @@ static void mtk_vpu_rproc_kick(struct rproc *rproc, int vqid)
 
 int mtk_vpu_elf_sanity_check(struct rproc *rproc, const struct firmware *fw)
 {
+	struct mtk_vpu_rproc *vpu_rproc = rproc->priv;
 	const u8 *elf_data = fw->data;
 	struct elf32_hdr *ehdr;
 	struct elf32_phdr *phdr;
@@ -156,6 +160,16 @@ int mtk_vpu_elf_sanity_check(struct rproc *rproc, const struct firmware *fw)
 		/* Remove empty PT_LOAD section */
 		if (phdr->p_type == PT_LOAD && !phdr->p_paddr)
 			phdr->p_type = PT_NULL;
+		/*
+		 * Workaround: Currently, the CPU can't access to the APU
+		 * local RAM. This removes the local RAM section from the
+		 * firmware. Please note that may cause some issues.
+		 */
+		if (phdr->p_paddr >= DRAM0_START && phdr->p_paddr < IRAM0_END) {
+			dev_warn_once(vpu_rproc->dev,
+				      "Skipping the APU local RAM section\n");
+			phdr->p_type = PT_NULL;
+		}
 	}
 
 	return 0;
-- 
2.26.2

