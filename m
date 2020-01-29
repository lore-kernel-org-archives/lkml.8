Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DACC33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 12:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E93A20716
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 12:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="CPsUPWMz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgA2MRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 07:17:42 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:40408 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726186AbgA2MRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 07:17:41 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5153840815;
        Wed, 29 Jan 2020 12:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1580300261; bh=K88LGp8ZZ8Fu0cHBIBDPPK01UKDCYDHLXwJ/DHIVegI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=CPsUPWMzXwUCZ5BpimbxVuDIa5IbLBRG2JCEYZUgrTghqH6NIk3fgOFyAQeHvAPga
         1vVEu2O6Qawai4ovM36+9tplsguQIdbbiRzVib0YFlERPQxwCUsn7I+AoCF/HlvIUN
         igmkP7F+cMVLfmkBBlEWj3OngIzpG2j28uIKD+x/40uT1AEaI0UxwoQTGAj7Trw8SB
         52WhAH52s8rMXza62ZSo36pKArspgHsPoR5zwIer1wSPzQ8661EgmkXWJOdJt4KZ/J
         +De2rDAe2DAJLFPsKCsaTaPg2AyxTh2N1b+R4sEq2o1X/eX0dmSqdxuXmKs+u0v94b
         WJ4grjOBWcKdQ==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 5DF3AA0074;
        Wed, 29 Jan 2020 12:17:38 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 447653F039;
        Wed, 29 Jan 2020 13:17:38 +0100 (CET)
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org
Cc:     Joao.Pinto@synopsys.com, Jose.Abreu@synopsys.com,
        bbrezillon@kernel.org, gregkh@linuxfoundation.org,
        wsa@the-dreams.de, arnd@arndb.de, broonie@kernel.org,
        Vitor Soares <Vitor.Soares@synopsys.com>
Subject: [RFC v2 2/4] i3c: master: export i3c_bus_type symbol
Date:   Wed, 29 Jan 2020 13:17:33 +0100
Message-Id: <449db711a8174934e078f90b21c31b683d11da8c.1580299067.git.vitor.soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1580299067.git.vitor.soares@synopsys.com>
References: <cover.1580299067.git.vitor.soares@synopsys.com>
In-Reply-To: <cover.1580299067.git.vitor.soares@synopsys.com>
References: <cover.1580299067.git.vitor.soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export i3c_bus_type symbol so i3cdev can register a notifier chain
for i3c bus.

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

