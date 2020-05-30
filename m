Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B350C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 06:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39A1320776
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 06:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590821801;
	bh=SrcUjhOVnLeWo8E1a6KqVONGbOtrfL+Xa1tbucALTSQ=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=rfll1CuHvbOgo3TofR/7tnbgovVtabqXm6IpeYwF4X0BH6HI+uT7e8iy6PStZePfv
	 R2953dux0h8Qdk3EQaWx9YVV/7pG5Y00Hjw9DHc12KyvICXf4R8GV4t3TywLNaw0LZ
	 Al+ccTvA0yC7O0hlWhmwEEdfj5YIPNOG23deDvD0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgE3G4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 02:56:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:44956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728823AbgE3G4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 02:56:05 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 391F1214F1;
        Sat, 30 May 2020 06:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590821763;
        bh=SrcUjhOVnLeWo8E1a6KqVONGbOtrfL+Xa1tbucALTSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YSi36M86QavR+RBpDFiBCk0z79HcPbFKbgDEzniEPJwE+cBeHGMw/lqpSAb7xgakE
         QzzfQxSiNqfNdMrKCDMEb5YQmdmarUY3ODkYahbwooaD8/8XT7bRJ+wDVIAvzZkr7M
         pb7mBP/pXKGK3Y91sbiBoegR/VFvwuQmNPmon4zg=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jevPV-001hpJ-6N; Sat, 30 May 2020 08:56:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/41] media: atomisp: improve warning for IRQ enable function
Date:   Sat, 30 May 2020 08:55:33 +0200
Message-Id: <ab219f1d8f6983cb4f122b32e1754e817d45ef26.1590821410.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1590821410.git.mchehab+huawei@kernel.org>
References: <cover.1590821410.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If something gets wrong when enabling or disabling an IRQ,
we should know better about what happened.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/media/atomisp/pci/atomisp_compat_css20.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c b/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c
index f39b0ad85cfa..5718010a0bf6 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c
@@ -1042,7 +1042,9 @@ int atomisp_css_irq_enable(struct atomisp_device *isp,
 		__func__, info,
 		enable ? "enable" : "disable");
 	if (ia_css_irq_enable(info, enable) != IA_CSS_SUCCESS) {
-		dev_warn(isp->dev, "%s:Invalid irq info.\n", __func__);
+		dev_warn(isp->dev, "%s:Invalid irq info: 0x%08x when %s.\n",
+			 __func__, info,
+			 enable ? "enabling" : "disabling");
 		return -EINVAL;
 	}
 
-- 
2.26.2

