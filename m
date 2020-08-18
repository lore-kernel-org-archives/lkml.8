Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D77EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A530207DE
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597762776;
	bh=/ZMRTZrQa0c+T88rblwGg7HAFBAxsLYq73aCjSOYgGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yjqFUi8GjR20spRNHrz8l85nhYTx9ao6iP8kk+43BwxBpI7v3ELQ8LbXBdnzo4erl
	 ElddCJuCphc99PAUfsIuIf89VPWCa5nq1alkRvxV2q3ft4nLnocSIsilqSUdp3MtkT
	 YRbQDjyh73g9PBPEg4+pK1ZV/qwIBCD4V9VWXiZk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgHRO7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:59:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:60458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726698AbgHRO7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:59:11 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F85A20885;
        Tue, 18 Aug 2020 14:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597762745;
        bh=/ZMRTZrQa0c+T88rblwGg7HAFBAxsLYq73aCjSOYgGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SEOVDQXNbBB5XhOROkJoWrFpZcO+pezPYaIjGY7sVTvndtmHTDFRWPt/IJPp0w+VP
         3u73CJmcrgfqe30xCSp/m2FLpeE18G70W6O3L1f2bBp/mMkMfSHHMpXbPpaybKwLDU
         MdIxGpTep66SRtBGAKJVILER9+ysXPSx5XzKQ6f0=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k834p-00EGAm-8E; Tue, 18 Aug 2020 16:59:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] MAINTAINERS: add an entry for HiSilicon 6421v600 drivers
Date:   Tue, 18 Aug 2020 16:58:58 +0200
Message-Id: <14b009ef0255d61eeaf4273e9c36dafdb1e5e12f.1597762400.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597762400.git.mchehab+huawei@kernel.org>
References: <cover.1597762400.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for the SPMI, MFD and PMIC parts of the
HiSilicon 6421v600 support.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 956ecd5ba426..2f497c7d659c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7824,6 +7824,12 @@ F:	drivers/crypto/hisilicon/sec2/sec_crypto.c
 F:	drivers/crypto/hisilicon/sec2/sec_crypto.h
 F:	drivers/crypto/hisilicon/sec2/sec_main.c
 
+HISILICON STAGING DRIVERS FOR HIKEY 960/970
+M:	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+L:	devel@driverdev.osuosl.org
+S:	Maintained
+F:	drivers/staging/hikey9xx/
+
 HISILICON TRUE RANDOM NUMBER GENERATOR V2 SUPPORT
 M:	Zaibo Xu <xuzaibo@huawei.com>
 S:	Maintained
-- 
2.26.2

