Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4E6C34031
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 00:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E10624670
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 00:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="K3W9i1XB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgBSAVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 19:21:07 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:42514 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726847AbgBSAUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 19:20:51 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 27B98C00A1;
        Wed, 19 Feb 2020 00:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1582071650; bh=5BSmiW9SFB6AJj8MBxrfazTpkHfyo3zqP3n71iT8md0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=K3W9i1XB1w1pVvZU5vgWa2mbXpM1XNjph3+TAupOSd3ZJl69q6UtHUQf4XmEOruDo
         U4eRU58xBZS0xGrfW8MOmerKnXTbu0oQB2XJas7ACSWB3k/nxQl7XBzncTFTsbG25Q
         p2ZVtvner1olIMelw3RLkM0D0Zx9XsJNq7O3YLONLJJHAeFFUSszOFsa8JDAdcok9q
         UTzDne+t5fQaDJZN04c+ZNGTcWPYjcRklHcZcBjMKgh1PvGubVsml3GT18+1ACb3DA
         gfzIpaViRoMRq05B1psGAWTEPT2/K10tPlroex90nFmUyANCu1usfWYHz6kUXKITZR
         RVDnDWunA6iXA==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 2778BA005E;
        Wed, 19 Feb 2020 00:20:47 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 156EC3D248;
        Wed, 19 Feb 2020 01:20:47 +0100 (CET)
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org
Cc:     Joao.Pinto@synopsys.com, Jose.Abreu@synopsys.com,
        bbrezillon@kernel.org, gregkh@linuxfoundation.org,
        wsa@the-dreams.de, arnd@arndb.de, broonie@kernel.org,
        corbet@lwn.net, Vitor Soares <Vitor.Soares@synopsys.com>
Subject: [PATCH v3 2/5] i3c: master: export i3c_bus_type symbol
Date:   Wed, 19 Feb 2020 01:20:40 +0100
Message-Id: <449db711a8174934e078f90b21c31b683d11da8c.1582069402.git.vitor.soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1582069402.git.vitor.soares@synopsys.com>
References: <cover.1582069402.git.vitor.soares@synopsys.com>
In-Reply-To: <cover.1582069402.git.vitor.soares@synopsys.com>
References: <cover.1582069402.git.vitor.soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export i3c_bus_type symbol so i3cdev can register a notifier chain for
i3c bus.

Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
---
 drivers/i3c/master.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 8a0ba34..21c4372 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -321,6 +321,7 @@ struct bus_type i3c_bus_type = {
 	.probe = i3c_device_probe,
 	.remove = i3c_device_remove,
 };
+EXPORT_SYMBOL_GPL(i3c_bus_type);
 
 static enum i3c_addr_slot_status
 i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
-- 
2.7.4

