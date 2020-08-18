Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704D9C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F9F6207D3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597766699;
	bh=JQMlO7auLphrvo+GHxhM6ajlxYAtFXnfBAzfdybNcsc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=DlNm3qqOJ70oDJ2VpAv672acNinNJUWGPST0hWdCL+7if9GELV3A03iVrUxRf9vwb
	 NXg90iOa0abAZeJ5/r2mGo6Yb2f+0BywCGCGPqACVl1LMpGOSO3andVqo553bqoaTA
	 nP/XIrsE4Hqp8fG/yiq6gcLyp0wNYF9NX3s8RnVY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgHRQE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:04:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:44518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbgHRQEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:04:53 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 139E120639;
        Tue, 18 Aug 2020 16:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597766693;
        bh=JQMlO7auLphrvo+GHxhM6ajlxYAtFXnfBAzfdybNcsc=;
        h=From:To:Cc:Subject:Date:From;
        b=jVpeGVOvf0t+V30+wrohVoCs3zrKpcBtcBtM7+IPfN1FYsX7Axz44A6ZXMwUmRMuk
         bAut3mnosTkO4R/iV7lwsfjmqHxt5BnC4oAzSg52IPglNJncg3ByORYBxE9SIaEX5p
         rutfp36QKy3wuugTktJhomJTcg1uBnTwrYPZAORo=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k846U-00EIfH-Sh; Tue, 18 Aug 2020 18:04:50 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: hikey9xx: Kconfig: add regulator dependency
Date:   Tue, 18 Aug 2020 18:04:48 +0200
Message-Id: <a287238bd0141aa68aae7d4cec4c1174a43b3e53.1597766680.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regulator driver needs it, as otherwise it will produce
errors when creating vmlinux.

Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/hikey9xx/Kconfig b/drivers/staging/hikey9xx/Kconfig
index a004839e8fa9..0e97b5b9a56a 100644
--- a/drivers/staging/hikey9xx/Kconfig
+++ b/drivers/staging/hikey9xx/Kconfig
@@ -31,6 +31,7 @@ config MFD_HI6421_SPMI
 config REGULATOR_HI6421V600
 	tristate "HiSilicon Hi6421v600 PMIC voltage regulator support"
 	depends on MFD_HI6421_SPMI && OF
+	depends on REGULATOR
 	help
 	  This driver provides support for the voltage regulators on
 	  HiSilicon Hi6421v600 PMU / Codec IC.
-- 
2.26.2

