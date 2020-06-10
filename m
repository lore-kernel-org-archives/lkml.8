Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C94C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 01:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF738206C3
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 01:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PB9khcl3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgFJBTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 21:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgFJBTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 21:19:46 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D51C03E96B
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 18:19:44 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id z7so570601qve.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 18:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=R0j3hAls4jEjo7bHSwYBA2yiml0XoUddtxY5cTqmnDs=;
        b=PB9khcl37mQ3Oh/7W/t32l5zBNnvFkFmzWVXrSdrx6LThZst1lxg3O1ot2r/UaHOM0
         rVb7fP2sNPeIeWTi7c5voqdUxKolNaOZOP2iZYWPMz3mQohUaF2XBeAOjFt0mnDFBe57
         +FCZ8WqXBuMZfU5rMprUsKIZs1e3SoN032SwoMnfQ9U3f5yRYWR9NhPkXDQwCN1KDGi2
         ePfQHN15sObXPvc7TFAQ0fyILQClbmSJ3Tjvnmg0fpUGd8S4rUP6YyO+MDSwoiG/nPcg
         9Bk6usbysbrqCIe/22RJnKMdCdClkxUqBVKWkmSAZQGNt9ph+lWRd0T3r4QpGQi/BppL
         iFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=R0j3hAls4jEjo7bHSwYBA2yiml0XoUddtxY5cTqmnDs=;
        b=oXN9l6aMITy1h4rZEUEiBoP6nTLJvurlb/7NdQ/U6re1az+M1Beym0PthlbkvVqk14
         vkJrV43VHX+aIK/iemPEvvTMm8phPQhoCetFIo0rVvVvVrdeV6suCcxCc/e2R2Qie3T9
         yso2Le9U5pgDCdiORbSf0LAbYo/aYWFABVrJlFyqLje1c58CMzI5nojsoHsWlsApoFb4
         CK4++G0FLTJwhXbSLBo94Jsvkf2zRh2gB6Gi052Ojm8jGo0f08vlGL6zrLZXncIVVVvr
         sTZq1N33zKcDD96VLj2X19UvRmmthmE72NYYCiJkWIYO8ItSZEgzU8Ci48r0R4DGyAfj
         DwQg==
X-Gm-Message-State: AOAM5319/5zpVHX42WxBUSDFfGdAciL2Ho+VBKSEiYB88kfGh4VZItwg
        aiY1U+1TuLgRjB+QPu8ESSCeFUUIk2ysEa8=
X-Google-Smtp-Source: ABdhPJwl1nCl1Y6Kh6rR85VPn1StQqbCT/Ir4MjrnIPW30lJxnT4gdfNrKGZjCQjSD5cky6N6XDuzvJoWz+JU1g=
X-Received: by 2002:a0c:f494:: with SMTP id i20mr912808qvm.179.1591751983147;
 Tue, 09 Jun 2020 18:19:43 -0700 (PDT)
Date:   Tue,  9 Jun 2020 18:19:34 -0700
In-Reply-To: <20200610011934.49795-1-saravanak@google.com>
Message-Id: <20200610011934.49795-3-saravanak@google.com>
Mime-Version: 1.0
References: <20200610011934.49795-1-saravanak@google.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH v2 2/2] of: property: Improve cycle detection when one of the
 devices is never added
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consider this example where -> means LHS device is a consumer of RHS
device and indentation represents "child of" of the previous device.

Device A -> Device C

Device B -> Device A
	Device C

Without this commit:
1. Device A is added.
2. Device A is added to waiting for supplier list (Device C)
3. Device B is added
4. Device B is linked as a consumer to Device A
5. Device A doesn't probe because it's waiting for Device C to be added.
6. Device B doesn't probe because Device A hasn't probed.
7. Device C will never be added because it's parent hasn't probed.

So, Device A, B and C will be in a probe/add deadlock.

This commit detects this scenario and stops trying to create a device
link between Device A and Device C since doing so would create the
following cycle:
Device A -> Devic C -(parent)-> Device B -> Device A.

With this commit:
1. Device A is added.
3. Device B is added
4. Device B is linked as a consumer to Device A
5. Device A probes.
6. Device B probes because Device A has probed.
7. Device C is added and probed.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/property.c | 62 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 56 insertions(+), 6 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 1f2086f4e7ce..ef09e4372ce8 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1014,6 +1014,30 @@ static bool of_is_ancestor_of(struct device_node *test_ancestor,
 	return false;
 }
 
+/**
+ * of_get_next_parent_dev - Add device link to supplier from supplier phandle
+ * @np: device tree node
+ *
+ * Given a device tree node (@np), this function finds its closest ancestor
+ * device tree node that has a corresponding struct device.
+ *
+ * The caller of this function is expected to call put_device() on the returned
+ * device when they are done.
+ */
+static struct device *of_get_next_parent_dev(struct device_node *np)
+{
+	struct device *dev = NULL;
+
+	of_node_get(np);
+	do {
+		np = of_get_next_parent(np);
+		if (np)
+			dev = get_dev_from_fwnode(&np->fwnode);
+	} while (np && !dev);
+	of_node_put(np);
+	return dev;
+}
+
 /**
  * of_link_to_phandle - Add device link to supplier from supplier phandle
  * @dev: consumer device
@@ -1035,10 +1059,9 @@ static bool of_is_ancestor_of(struct device_node *test_ancestor,
 static int of_link_to_phandle(struct device *dev, struct device_node *sup_np,
 			      u32 dl_flags)
 {
-	struct device *sup_dev;
+	struct device *sup_dev, *sup_par_dev;
 	int ret = 0;
 	struct device_node *tmp_np = sup_np;
-	int is_populated;
 
 	of_node_get(sup_np);
 	/*
@@ -1075,16 +1098,43 @@ static int of_link_to_phandle(struct device *dev, struct device_node *sup_np,
 		return -EINVAL;
 	}
 	sup_dev = get_dev_from_fwnode(&sup_np->fwnode);
-	is_populated = of_node_check_flag(sup_np, OF_POPULATED);
-	of_node_put(sup_np);
-	if (!sup_dev && is_populated) {
+	if (!sup_dev && of_node_check_flag(sup_np, OF_POPULATED)) {
 		/* Early device without struct device. */
 		dev_dbg(dev, "Not linking to %pOFP - No struct device\n",
 			sup_np);
+		of_node_put(sup_np);
 		return -ENODEV;
 	} else if (!sup_dev) {
-		return -EAGAIN;
+		/*
+		 * DL_FLAG_SYNC_STATE_ONLY doesn't block probing and supports
+		 * cycles. So cycle detection isn't necessary and shouldn't be
+		 * done.
+		 */
+		if (dl_flags & DL_FLAG_SYNC_STATE_ONLY) {
+			of_node_put(sup_np);
+			return -EAGAIN;
+		}
+
+		sup_par_dev = of_get_next_parent_dev(sup_np);
+
+		if (sup_par_dev && device_is_dependent(dev, sup_par_dev)) {
+			/* Cyclic dependency detected, don't try to link */
+			dev_dbg(dev, "Not linking to %pOFP - cycle detected\n",
+				sup_np);
+			ret = -EINVAL;
+		} else {
+			/*
+			 * Can't check for cycles or no cycles. So let's try
+			 * again later.
+			 */
+			ret = -EAGAIN;
+		}
+
+		of_node_put(sup_np);
+		put_device(sup_par_dev);
+		return ret;
 	}
+	of_node_put(sup_np);
 	if (!device_link_add(dev, sup_dev, dl_flags))
 		ret = -EINVAL;
 	put_device(sup_dev);
-- 
2.27.0.278.ge193c7cf3a9-goog

