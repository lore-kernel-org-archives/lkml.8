Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072D2C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 08:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAB93206D7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 08:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQEpnLJe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgFMIi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 04:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbgFMIiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 04:38:18 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45C9C03E96F;
        Sat, 13 Jun 2020 01:38:17 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t18so12172653wru.6;
        Sat, 13 Jun 2020 01:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KMwtoTNUI28nDU2ZNynxUBCVybVSXc4H+bikAufJJoI=;
        b=OQEpnLJeim+oYmKxADUZC5+zmj8cjqiDaA/Ta15Q44HnduM+tYEohwBrn3wS6qECWP
         KaNU3q9QCljnlvyeG0JqefNC6ZDDSI4kMsacYCHbkPyjol+EHtj0jQEB4NGbMdqZhgGU
         IA8XlLRl5UGwCEr4bl4/2WirKOPtHs+cWA+VeiWdxbvvAh7wWHKsR1ZNlEnp/DQJqtnK
         vkJzV7bWOqAizgCHQo3xj+6gOyAptFRakI25kktWl4k3GgfU/kD5Dslv2K03Oj5iWsVb
         jyFiYdpNapuiJYcGfWUU35ApImIFJwGBS2M/5RlcfPgH1aS/PjE7pWOuDNYklUPmDjWA
         CDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KMwtoTNUI28nDU2ZNynxUBCVybVSXc4H+bikAufJJoI=;
        b=bttGzsGi62z/pqJ6lCjKOnyzH+hpMn6aUtfm01pg1dYk7C7T1hZiRHJGG5IDrRILZK
         Uhg3gwvNif+HeBrKngO5W9d9OItmOUF5QWcVOJbOwq1RLWiUaljGCsHRegVRsuYJlnvn
         AtkXL27/Xzm7qcm4N63sbxS8xMtk5VNwwe819teC6zDFsf+6pBqHRNnSmh55cyHMkGkl
         lJlTWyM//Ui/spZK9bsw18cfy+zn+5zk7zPjoCzI1hgq7CejMGY1x9yiR9wyMO0OW7S9
         XaUduvig4uCtQcryDf0QN5uEfd/NV+qv09n2MA+mzg4ntLmA73UPCjGb/Ti2syGo4yii
         njEw==
X-Gm-Message-State: AOAM5301aOf3DWwy3j1IvbFNIgamvY15Hn9hCx2OvzmuuEmRW1ImoTRM
        WU/GRX1ap9QC/xf9IqJWL+o=
X-Google-Smtp-Source: ABdhPJyBz2rR60dS0eu3cpo5vlFxae8B4lUE53GJGvYuszlEXHDGMdrScL3Rn7sKzsRgRXLGyBF2fg==
X-Received: by 2002:a5d:604b:: with SMTP id j11mr18694000wrt.193.1592037496476;
        Sat, 13 Jun 2020 01:38:16 -0700 (PDT)
Received: from skynet.lan (168.red-88-20-188.staticip.rima-tde.net. [88.20.188.168])
        by smtp.gmail.com with ESMTPSA id l17sm11622704wmi.3.2020.06.13.01.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 01:38:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org,
        tsbogend@alpha.franken.de, f.fainelli@gmail.com,
        jonas.gorski@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v4 1/9] mips: bmips: select ARCH_HAS_RESET_CONTROLLER
Date:   Sat, 13 Jun 2020 10:38:05 +0200
Message-Id: <20200613083813.2027186-2-noltari@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200613083813.2027186-1-noltari@gmail.com>
References: <20200610172859.466334-1-noltari@gmail.com>
 <20200613083813.2027186-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows to add reset controllers support.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 v4: no changes
 v3: no changes
 v2: no changes

 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 26c63e8161f0..4721ec4e3408 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -227,6 +227,7 @@ config ATH79
 
 config BMIPS_GENERIC
 	bool "Broadcom Generic BMIPS kernel"
+	select ARCH_HAS_RESET_CONTROLLER
 	select ARCH_HAS_SYNC_DMA_FOR_CPU_ALL
 	select ARCH_HAS_PHYS_TO_DMA
 	select BOOT_RAW
-- 
2.27.0

