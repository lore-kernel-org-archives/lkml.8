Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F5BC3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 08:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 076D3246A8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 08:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgB1Ikh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 03:40:37 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:59945 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725877AbgB1Ikh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 03:40:37 -0500
Received: from [109.168.11.45] (port=51130 helo=pc-ceresoli.dev.aim)
        by hostingweb31.netsons.net with esmtpa (Exim 4.92)
        (envelope-from <luca@lucaceresoli.net>)
        id 1j7bCE-000aM0-Va; Fri, 28 Feb 2020 09:40:35 +0100
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     devicetree@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Luca Ceresoli <luca@lucaceresoli.net>
Subject: [PATCH v3] of: overlay: log the error cause on resolver failure
Date:   Fri, 28 Feb 2020 09:40:27 +0100
Message-Id: <20200228084027.10797-1-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a DT overlay has a node label that is not present in the live
devicetree symbols table, this error is printed:

  OF: resolver: overlay phandle fixup failed: -22
  create_overlay: Failed to create overlay (err=-22)

which does not help much in finding the node label that caused the problem
and fix the overlay source.

Add an error message with the name of the node label that caused the
error. The new output is:

  OF: resolver: node label 'gpio9' not found in live devicetree symbols table
  OF: resolver: overlay phandle fixup failed: -22
  create_overlay: Failed to create overlay (err=-22)

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

---

Changed in v3:
 - add only the message from v1, but as reworded by Frank

Changed in v2:
 - add a message for each error path that does not have one yet
---
 drivers/of/resolver.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/of/resolver.c b/drivers/of/resolver.c
index 83c766233181..b278ab4338ce 100644
--- a/drivers/of/resolver.c
+++ b/drivers/of/resolver.c
@@ -321,8 +321,11 @@ int of_resolve_phandles(struct device_node *overlay)
 
 		err = of_property_read_string(tree_symbols,
 				prop->name, &refpath);
-		if (err)
+		if (err) {
+			pr_err("node label '%s' not found in live devicetree symbols table\n",
+			       prop->name);
 			goto out;
+		}
 
 		refnode = of_find_node_by_path(refpath);
 		if (!refnode) {
-- 
2.25.1

