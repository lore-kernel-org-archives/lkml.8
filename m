Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFAAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 09:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B99352076C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 09:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591609965;
	bh=MhdtjOT8vJ8wGIPgzA1MdSHTr2Zgs7Wy2HpBekbvcW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=it3g9U6K/kZjD7N8Rj+1J3Gj+RZPhYI7t7b/o2gj6MkKAvYfHcXPZStmnlxyzbMwA
	 Xpu7yofFaAU4+zMPl5+e2ej4ho0gL+kepOO+Zcl+RhoHbP4tFYEyCJlCSKuu0gqA9a
	 iQMoCXSGKY88WWsl79iOstvR9YFZYz974ZgfJx50=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgFHJwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 05:52:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729166AbgFHJwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 05:52:42 -0400
Received: from ziggy.de (unknown [213.195.114.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F69E2076A;
        Mon,  8 Jun 2020 09:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591609962;
        bh=MhdtjOT8vJ8wGIPgzA1MdSHTr2Zgs7Wy2HpBekbvcW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HWPp/s5iTdm6L6KOm4utxCkrIPBYP/FLz3Ifj6gektVxSUtN/2Y3UMrmPYhpN52Uw
         stZsuCl0f/k+o7PKOo33jtDlao1WZ0zJg+ew0/gbRE3QvgOIkN2K1ruiyA6Stb/wgP
         WihbBiOaNQsv+9Xb43Z2v60Tx8KbywvBq2kyfY4I=
From:   matthias.bgg@kernel.org
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, gene.chen.richtek@gmail.com,
        lee.jones@linaro.org, matthias.bgg@kernel.org,
        Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH 2/2] drivers: base: Convert to printk alias functions
Date:   Mon,  8 Jun 2020 11:52:17 +0200
Message-Id: <20200608095217.21162-2-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200608095217.21162-1-matthias.bgg@kernel.org>
References: <20200608095217.21162-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

The file mixes printk calls together with calls to pr_*().
Covert to printk alias functions to unify the code.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 drivers/base/driver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/driver.c b/drivers/base/driver.c
index 40fba959c140..aa3b3a226a02 100644
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -164,12 +164,12 @@ int driver_register(struct device_driver *drv)
 	if ((drv->bus->probe && drv->probe) ||
 	    (drv->bus->remove && drv->remove) ||
 	    (drv->bus->shutdown && drv->shutdown))
-		printk(KERN_WARNING "Driver '%s' needs updating - please use "
+		pr_warn("Driver '%s' needs updating - please use "
 			"bus_type methods\n", drv->name);
 
 	other = driver_find(drv->name, drv->bus);
 	if (other) {
-		printk(KERN_ERR "Error: Driver '%s' is already registered, "
+		pr_err("Error: Driver '%s' is already registered, "
 			"aborting...\n", drv->name);
 		return -EBUSY;
 	}
-- 
2.26.2

