Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC407C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 12:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E81920720
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 12:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="HeGuhWKA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgA2MR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 07:17:57 -0500
Received: from sv2-smtprelay2.synopsys.com ([149.117.73.133]:40402 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726145AbgA2MRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 07:17:42 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6230A40829;
        Wed, 29 Jan 2020 12:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1580300261; bh=EWznO/7FCN3HQvpSq9KAAmnQZlA5wLD6bU4uUlvRy1Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=HeGuhWKA79xkjv8P+Gup8W5OG9GV4gOdWlHYCFsUYIhx0FsBO+jeqN+oIO4Y3vjhN
         hVULQnS2Cj/HQPSKbAcBQxnt74tHZX0/uVLwqz7DbJwwL9Ha8wFSM4tqqAfLzGsB+k
         qcgFrkkiaHWlvY8X7Hcuf4FTYLQGH0QRU3DizlEi+Tt4kDiqCWM7XfPqNC2nZqmKxD
         owpywKt4gmhVfCb7o9wNJYGel7/Uj3ZH5kfBrnnXEtQ5JMZ5hOOaLWnAUsgykyLXex
         W43U6rX4FRL0fjf5V80R4zy8Cp6Zua6RYumW29jmIu522nRUq6+zLxpJb9C3q+BDJc
         M+ZmB7A809n1g==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 5C76FA0072;
        Wed, 29 Jan 2020 12:17:38 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 2BE1F3F035;
        Wed, 29 Jan 2020 13:17:38 +0100 (CET)
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org
Cc:     Joao.Pinto@synopsys.com, Jose.Abreu@synopsys.com,
        bbrezillon@kernel.org, gregkh@linuxfoundation.org,
        wsa@the-dreams.de, arnd@arndb.de, broonie@kernel.org,
        Vitor Soares <Vitor.Soares@synopsys.com>
Subject: [RFC v2 1/4] i3c: master: export i3c_masterdev_type
Date:   Wed, 29 Jan 2020 13:17:32 +0100
Message-Id: <7c742fba6c488b29f6fb15a5b910e799d50c5051.1580299067.git.vitor.soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1580299067.git.vitor.soares@synopsys.com>
References: <cover.1580299067.git.vitor.soares@synopsys.com>
In-Reply-To: <cover.1580299067.git.vitor.soares@synopsys.com>
References: <cover.1580299067.git.vitor.soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exporte i3c_masterdev_type so i3cdev module can verify if an i3c device
is a master.

Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
---
 drivers/i3c/internals.h | 1 +
 drivers/i3c/master.c    | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
index 86b7b44..bc062e8 100644
--- a/drivers/i3c/internals.h
+++ b/drivers/i3c/internals.h
@@ -11,6 +11,7 @@
 #include <linux/i3c/master.h>
 
 extern struct bus_type i3c_bus_type;
+extern const struct device_type i3c_masterdev_type;
 
 void i3c_bus_normaluse_lock(struct i3c_bus *bus);
 void i3c_bus_normaluse_unlock(struct i3c_bus *bus);
diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 7f8f896..8a0ba34 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -523,9 +523,10 @@ static void i3c_masterdev_release(struct device *dev)
 	of_node_put(dev->of_node);
 }
 
-static const struct device_type i3c_masterdev_type = {
+const struct device_type i3c_masterdev_type = {
 	.groups	= i3c_masterdev_groups,
 };
+EXPORT_SYMBOL_GPL(i3c_masterdev_type);
 
 static int i3c_bus_set_mode(struct i3c_bus *i3cbus, enum i3c_bus_mode mode,
 			    unsigned long max_i2c_scl_rate)
-- 
2.7.4

