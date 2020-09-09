Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772DEC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E3E12087C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599670634;
	bh=ATKawdvCB71UvotVwExkRA/n8DtvhQrqGIQq/nxGV7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gCCzVChegvh4HgDQ2+Jrn0jSjIQwT6MfTton3/bBwqBwPhwhpoTFRM6n/Us7NOO/6
	 bE3ZeTBH9sinbTqLR7+d7w1f6rOl52o5vILOwwrSbkfM3kIOAqwPmg8w9hRbwZ9+cb
	 NUHIddY7JPWP5n+9KttbRzOVJz6q9sjYnnVaspfw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730869AbgIIQ5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:57:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730687AbgIIPvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:51:19 -0400
Received: from mail.kernel.org (ip5f5ad5d6.dynamic.kabel-deutschland.de [95.90.213.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CDCE221EB;
        Wed,  9 Sep 2020 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599660665;
        bh=ATKawdvCB71UvotVwExkRA/n8DtvhQrqGIQq/nxGV7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y51UL8ClYsVGkmT1YqO/ajQfhB3fZYfqQpG3Qie2xXkAml2cxKwHVnasK7wKt2vXJ
         ZX53JYyFIiIFWtxdr/XdxJJhE5sMCjCMXojbcjP6k2Fif/NAnWUYr+1x4Mlm3JOYGz
         mM3trgahSSLfbZiHL9ANO/EVZ66p4Z0/YPKXXGrk=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kG0oR-00DUWo-74; Wed, 09 Sep 2020 16:11:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/30] MAINTAINERS: fix location of qlogic/LICENSE.qla3xxx
Date:   Wed,  9 Sep 2020 16:10:38 +0200
Message-Id: <4260c56b52dd269716f78c5f4369a14994014480.1599660067.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599660067.git.mchehab+huawei@kernel.org>
References: <cover.1599660067.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ethernet/qlogic/LICENSE.qla3xxx -> qlogic/LICENSE.qla3xxx

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f3fee4140272..f9d044b6aa42 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14322,7 +14322,7 @@ QLOGIC QLA3XXX NETWORK DRIVER
 M:	GR-Linux-NIC-Dev@marvell.com
 L:	netdev@vger.kernel.org
 S:	Supported
-F:	Documentation/networking/device_drivers/ethernet/qlogic/LICENSE.qla3xxx
+F:	Documentation/networking/device_drivers/qlogic/LICENSE.qla3xxx
 F:	drivers/net/ethernet/qlogic/qla3xxx.*
 
 QLOGIC QLA4XXX iSCSI DRIVER
-- 
2.26.2

