Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B3DC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5D1920772
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597650658;
	bh=Eng7Rab1CaB7fvQEsIw3It6duxBOVMJf257zUEUX8q0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2lcbYdxp7df6EPxHCrx21s6MTQUbMTUaoCfYHw1JEn4Eb4qq+PebiAULgx3CKOHl9
	 PsDYbBc0pwgXjaZ5lnhA/lVzVeL5OV9idybm3pLSRCD0NypcFjzin9WrBdt8sewXtO
	 5AJY5UsE9kU5VHtp/IslenXM12nK4ctYYc+KCepE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgHQHum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 03:50:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:45574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726875AbgHQHu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:50:26 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88CE820888;
        Mon, 17 Aug 2020 07:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597650620;
        bh=Eng7Rab1CaB7fvQEsIw3It6duxBOVMJf257zUEUX8q0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HMx2k+eWk4esq5LLPnkPIavBRJGtn7ciA5X3g4tvSX7AFhbhUJA7jkXP82yLIUEFC
         Cp5+uICWDBGX/0DoCTE1AUSdeqZybTjqIbExJqigucOkCyG6RNUBqE5gRZDGGuuhTV
         iUqhiRpAx317cBZW3ADGQlf8LaGvyGpbpd2lyo/k=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k7ZuM-00BfcX-HX; Mon, 17 Aug 2020 09:50:18 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 15/16] dt: hi3670-hikey970.dts: load the SMMU driver on Hikey970
Date:   Mon, 17 Aug 2020 09:50:14 +0200
Message-Id: <cf6f6372366c7e705ddad73d274579f172ffdba1.1597650455.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597650455.git.mchehab+huawei@kernel.org>
References: <cover.1597650455.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those boards come with a system IOMMU, which are required
by certain drivers (DRM/KMS).

Add its dependency to Hikey970 device tree bindings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
index a9ad90e769ad..f632b1e0600d 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
@@ -53,6 +53,9 @@ wlan_en: wlan-en-1-8v {
 		startup-delay-us = <70000>;
 		enable-active-high;
 	};
+	smmu_lpae {
+		compatible = "hisilicon,smmu-lpae";
+	};
 };
 
 /*
-- 
2.26.2

