Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F81C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A376F2076C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597160565;
	bh=FVeT+SHFe5lS+RwUe2cLk9QDPpG0XXVkDc+Zs7WLus8=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=1wep+BK+Jrpug5dD8ao7/5VrN+mGbG6ofWNrDcjun3dPMfXFLDKtsZ2vfE5WxpIda
	 ZsxByhZpob2ToGoZPsEV5cmyxHhXhnRljuruLKYcKC3NBrYi8hp4H/+2BK9Ti2MBgi
	 HvT5wNFvwxzqPQ6XCLViaUwi2afA1aRZ1IpXJWG0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgHKPmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 11:42:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729039AbgHKPmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:42:09 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5437822DFB;
        Tue, 11 Aug 2020 15:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597160524;
        bh=FVeT+SHFe5lS+RwUe2cLk9QDPpG0XXVkDc+Zs7WLus8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OPG1a0dnL/SyBRXcedf0zRFSfqkM3uCooC2hXxENu8kowkT/GxqE07F7uqrW/ddst
         EV2X3S4CmGK6/2AhAo8PXCdyBdl89wXSBHe0kZAYdeHrAFSO31wVf+NxpxJDwFzJco
         GLIdJjJFamV+v0vAgw8EJak4D9HzSZb5U4BRNJzM=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k5WPa-004bns-FO; Tue, 11 Aug 2020 17:42:02 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 33/33] MAINTAINERS: add an entry for HiSilicon 6421v600 drivers
Date:   Tue, 11 Aug 2020 17:41:59 +0200
Message-Id: <91a9fd5ae305750b3473d5826f71f8ab8673c44e.1597160086.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597160086.git.mchehab+huawei@kernel.org>
References: <cover.1597160086.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for the SPMI, MFD and PMIC parts of the
HiSilicon 6421v600 support.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 956ecd5ba426..6410df78e301 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7736,6 +7736,14 @@ F:	include/linux/hippidevice.h
 F:	include/uapi/linux/if_hippi.h
 F:	net/802/hippi.c
 
+HISILICON 6421v600 SPMI PMIC DRIVER
+M:	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	drivers/mfd/hi6421-spmi-pmic.c
+F:	drivers/regulator/hi6421v600-regulator.c
+F:	drivers/spmi/spmi.c
+
 HISILICON DMA DRIVER
 M:	Zhou Wang <wangzhou1@hisilicon.com>
 L:	dmaengine@vger.kernel.org
-- 
2.26.2

