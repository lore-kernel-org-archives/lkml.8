Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F19AC35E0C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 16:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 817992051A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 16:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731212AbgBYQpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 11:45:55 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:41069 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731203AbgBYQpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 11:45:54 -0500
Received: from [109.168.11.45] (port=37076 helo=pc-ceresoli.dev.aim)
        by hostingweb31.netsons.net with esmtpa (Exim 4.92)
        (envelope-from <luca@lucaceresoli.net>)
        id 1j6dLD-00DPYO-Q0; Tue, 25 Feb 2020 17:45:51 +0100
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2] of: overlay: log the error cause on resolver failure
Date:   Tue, 25 Feb 2020 17:45:40 +0100
Message-Id: <20200225164540.4520-1-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.25.0
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

For some of its error paths, of_resolve_phandles() only logs a very generic
error which does not help much in finding the origin of the problem:

  OF: resolver: overlay phandle fixup failed: -22

Add error messages for all the error paths that don't have one. Now a
specific message is always emitted, thus also remove the generic catch-all
message emitted before returning.

For example, in case a DT overlay has a fixup node that is not present in
the base DT __symbols__, this error is now logged:

  OF: resolver: node gpio9 not found in base DT, fixup failed

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
---

I don't know in detail the meaning of the adjust_local_phandle_references()
and update_usages_of_a_phandle_reference() error paths, thus I have put
pretty generic messages. Any suggestion on better wording would be welcome.

Changed in v2:

 - add a message for each error path that does not have one yet
---
 drivers/of/resolver.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/of/resolver.c b/drivers/of/resolver.c
index 83c766233181..a80d673621bc 100644
--- a/drivers/of/resolver.c
+++ b/drivers/of/resolver.c
@@ -291,8 +291,10 @@ int of_resolve_phandles(struct device_node *overlay)
 			break;
 
 	err = adjust_local_phandle_references(local_fixups, overlay, phandle_delta);
-	if (err)
+	if (err) {
+		pr_err("cannot adjust local phandle references\n");
 		goto out;
+	}
 
 	overlay_fixups = NULL;
 
@@ -321,11 +323,15 @@ int of_resolve_phandles(struct device_node *overlay)
 
 		err = of_property_read_string(tree_symbols,
 				prop->name, &refpath);
-		if (err)
+		if (err) {
+			pr_err("node %s not found in base DT, fixup failed\n",
+			       prop->name);
 			goto out;
+		}
 
 		refnode = of_find_node_by_path(refpath);
 		if (!refnode) {
+			pr_err("cannot find node for %s\n", refpath);
 			err = -ENOENT;
 			goto out;
 		}
@@ -334,13 +340,14 @@ int of_resolve_phandles(struct device_node *overlay)
 		of_node_put(refnode);
 
 		err = update_usages_of_a_phandle_reference(overlay, prop, phandle);
-		if (err)
+		if (err) {
+			pr_err("cannot update usages of a phandle reference (%s)\n",
+				prop->name);
 			break;
+		}
 	}
 
 out:
-	if (err)
-		pr_err("overlay phandle fixup failed: %d\n", err);
 	of_node_put(tree_symbols);
 
 	return err;
-- 
2.25.0

