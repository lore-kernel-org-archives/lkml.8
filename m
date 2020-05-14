Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAE0C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B34C220575
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ZkLZSavx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgENIBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 04:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726203AbgENIAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 04:00:16 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F862C05BD0D
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 01:00:14 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f134so16974450wmf.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 01:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v4BoYkqJ2NsZ2nSSjChgUqJJCyqhbfFRrbuVJ3n7szg=;
        b=ZkLZSavxQRtaRZqyeN3NFITIp9a8YO30SCLrAOX1aUcrsNHL+prXkOix/ACHyjGgVw
         q2jd8BjkbRwT4oWyuOPZgk2WnU5xIg+ORja/yqRwPiv9GFywqNZ4ulkSaelZm736kYYR
         Fu8UY/ImjWaaMsyK66j0UQo5E47LwAU554W01yFA/2vENar3TWpS10oflMxQQSTySRW8
         JbHon+nwYkQtXYF5oGqOvwqCPI62pOAGKXEAfjeV2TQn8dABDV3myryZW1ABzae0dBqJ
         EIPQiClTLRuBE7bkT9QdySvB0BFZi0/0hgpZtmAk4favh17kUH2Elntgnab3OXB98Tn6
         1FKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v4BoYkqJ2NsZ2nSSjChgUqJJCyqhbfFRrbuVJ3n7szg=;
        b=e/w5tDGwNMbIzqqAqfLL8REy+9WqILgSbgHPyo56Ulzsj4uFl8yu45UD6cHgFRiCrw
         XbiROUZhX2ZJtWT9+DLxzoqiTo0A11VYpkrOd2VcqOpSFuKOSuBG3q94lomjiqg+7qFV
         j3g29GGowzTW64sZ45oDkM+wQy9joGBsa6lvt8e72b0b8WVyHRBQNn18fnwfew41VhAf
         y26UKM3FZ7P5cLBqcKiMvwU9xrM3HH81F6KG1djwCQftEpe3+SDbPg3xuH3QaHjuXoqL
         5Gua+7S7FxDgiNSBEbBExgIGjHPk8KAmO1Out3NwdrcMciWlvADdaJ4zhtGebscAnn+G
         Ul0g==
X-Gm-Message-State: AGi0PuZJg6Mw7naIoLNnuNbkYDQxu9K4EJUp+9nbPK128OG8bhQFpOFQ
        XzVcuqYZGjMEFPvdlp0VFS3VJw==
X-Google-Smtp-Source: APiQypJomtPT0QqK17VEMkCe8OZhQJx80jykT2rYty3mL5D0FV9hIY70uXGJUu6dWm6hAMRJlHfP1Q==
X-Received: by 2002:a1c:ab45:: with SMTP id u66mr46456934wme.152.1589443213276;
        Thu, 14 May 2020 01:00:13 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id 81sm23337446wme.16.2020.05.14.01.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 01:00:12 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabien Parent <fparent@baylibre.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Edwin Peer <edwin.peer@broadcom.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Andrew Perepech <andrew.perepech@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 06/15] Documentation: devres: add a missing section for networking helpers
Date:   Thu, 14 May 2020 09:59:33 +0200
Message-Id: <20200514075942.10136-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200514075942.10136-1-brgl@bgdev.pl>
References: <20200514075942.10136-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Add a new section for networking devres helpers to devres.rst and list
the two existing devm functions.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 Documentation/driver-api/driver-model/devres.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index 46c13780994c..50df28d20fa7 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -372,6 +372,10 @@ MUX
   devm_mux_chip_register()
   devm_mux_control_get()
 
+NET
+  devm_alloc_etherdev()
+  devm_alloc_etherdev_mqs()
+
 PER-CPU MEM
   devm_alloc_percpu()
   devm_free_percpu()
-- 
2.25.0

