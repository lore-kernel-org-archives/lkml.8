Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3E0C35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C292467A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dJVyfLjq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731652AbgBUIF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:05:29 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:42759 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731825AbgBUIF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:05:26 -0500
Received: by mail-pl1-f202.google.com with SMTP id k16so717892pls.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 00:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hX6qJIC5qM680N1df258UbOcDSBvx9+Fcc39I/4r9Sk=;
        b=dJVyfLjq1r/B0SzJJI4oXYBeOeSqsLZjzFs4BDIwY6lPshBldpldFrjP17QmaV/Kmn
         FbZEO/igqowqjVh9ae+SNd34ZpxE9edBqAn0fC3EcR2JpwHCYKNiTZ7pm8rnBZyCJmMQ
         g9CWwSE0czaWxQbUUFSjtRyleewMqqrf0fRK0zd5dnpqJzk7uuuwq6ds2iN2+2Cyk65o
         YlKxLW31mpD07083CRAghNZaqNidJaRevV2EAHyOcFDYcgUgaB/7eC/lTlL0C0pWDX3z
         Mpo4iUT7zKr5lpR2B/gr6F1H+gGEOQTMQ+BIDCdspIvj6bjy+CCJ8luCamTEjCqFKM8b
         wNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hX6qJIC5qM680N1df258UbOcDSBvx9+Fcc39I/4r9Sk=;
        b=JFJzmg/sS2eRmDAFcpE3ef3wQN2ZYcxVem1/Wkj9GeNW/uc+TNkTdpn8pPz6H4j50Y
         MRyx9hngHw++A6pduwQM+6oEqm6nC2aUyJJk/xbjg9Y6qudJ6NAZ49GkJpSCcWZ2+xvV
         8jOdVQfU3dWD5ZyjdLaSB3Tvx+VsfypGeGNrcaKafCl1IlU9GOzXR0/25+clG/oEuPIX
         i1oyNll42v6cp9hGovNTf8Ny0OALBN5z92SRqTAxgJy3trgC52mZkUuApG3KedzCvcHy
         4AEdDOLu50RDjRcBpwLVyy2H80muNeGD3GWO2bSqjGiD9Zwxosty8EgsizVVHqZNyHIs
         bKKg==
X-Gm-Message-State: APjAAAWaiVIG/Fhox45D9UxmD2eebC4fgFD2IZsdX4EiPx84Kr7Fwa7t
        H46oA6QR5nP9uiZQChLxETa7dcPzkntbX4c=
X-Google-Smtp-Source: APXvYqyw3jZKlWAxtf2Gr98o2q/kmmxDNoBiu53xpco2RyQmpm3ukfxrtaZc8J22Z4mhEyJufHlhVEGyhs31MxY=
X-Received: by 2002:a63:ba43:: with SMTP id l3mr38926340pgu.120.1582272325810;
 Fri, 21 Feb 2020 00:05:25 -0800 (PST)
Date:   Fri, 21 Feb 2020 00:05:10 -0800
In-Reply-To: <20200221080510.197337-1-saravanak@google.com>
Message-Id: <20200221080510.197337-4-saravanak@google.com>
Mime-Version: 1.0
References: <20200221080510.197337-1-saravanak@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v2 3/3] driver core: Skip unnecessary work when device doesn't
 have sync_state()
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A bunch of busy work is done for devices that don't have sync_state()
support. Stop doing the busy work.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 3306d5ae92a6..dbb0f9130f42 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -718,6 +718,8 @@ static void __device_links_queue_sync_state(struct device *dev,
 {
 	struct device_link *link;
 
+	if (!dev_has_sync_state(dev))
+		return;
 	if (dev->state_synced)
 		return;
 
@@ -819,7 +821,7 @@ late_initcall(sync_state_resume_initcall);
 
 static void __device_links_supplier_defer_sync(struct device *sup)
 {
-	if (list_empty(&sup->links.defer_sync))
+	if (list_empty(&sup->links.defer_sync) && dev_has_sync_state(sup))
 		list_add_tail(&sup->links.defer_sync, &deferred_sync);
 }
 
-- 
2.25.0.265.gbab2e86ba0-goog

