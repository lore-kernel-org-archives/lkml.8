Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77843C33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 23:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F5224681
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 23:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ledhDGdq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgA0X4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 18:56:36 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:35455 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgA0X4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 18:56:36 -0500
Received: by mail-yb1-f195.google.com with SMTP id q190so5905462ybq.2;
        Mon, 27 Jan 2020 15:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BbohHbPT3bp1cePkEaEp/tGrf8OZp6KeuqWXwyj4C5Q=;
        b=ledhDGdq7AOO9tErja6p6iaC3YwVObmwwdwO5LYmlz//llafN5v9dEif2vS/H1kWXE
         gg43Iqpp8r8e0AhXe6B1CRP2xamhoWAZI1gONw2hpVpGcWNFvzX+ZoeOaOiW9wFValRN
         8/VshsLsKJgG1xrE/491jaee9Oh4n/ps5cS5prpMXotH77i6F86C6Mc03z5RMLqJ3wvF
         VhljXAUJJqikgH9b1Cno+7ip9/crVvZk6EfWzSb2z6IR6Jpqxs8GpBui4ujStz6+JBOw
         CnUx25GJfZWs9m4OphdwO48AxkxyskzHI85U+gzvjhWnTurJCVMmKd80Vt8jLquu+ZZz
         +XbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BbohHbPT3bp1cePkEaEp/tGrf8OZp6KeuqWXwyj4C5Q=;
        b=qKQN0RkxvvdlUJ3VevsfefipQG0kgRb0h0qhELiBBalGM0tgN0S8wq2CxUO5VAXTeC
         juU5Iyn52vc6sCU8tQ9idGRi/TjdUiBj9z6IT8/ww++MybRLRGnfhYYNdqfCJRqPxq2/
         pypDKrrEr+9J+lyJvvQA0Scbmrolx5ykDkWjY1mCXBEal7Ef7aYdYesQ8lWuRd7IZoz0
         doCQKJrGqHx089v2sBDF74QhUAFOMbJ4VZgS9YrYFgc1eia42kpZdX/uaBcnzd2cNPuW
         CrY3bG1dHu9A/injlZwPLklP34eAHkpeBAWG/MA83xD8uwgAyh1iGOMqU2aYloG9D509
         Esbw==
X-Gm-Message-State: APjAAAU9e5WfuFvtNgduf68nP1dsGbjXOQKWaWhOD+8uT0fOfUC5XCvG
        urC1SEqpbUsK6PTjK3IRgIK9JKrn
X-Google-Smtp-Source: APXvYqw2kE5E5v/ut6jhjitLBbeok9KX8Ecd4mXw7F1Cs/Zkwecw9QcboVLF84d/lBOy3ndf0snr5g==
X-Received: by 2002:a25:1254:: with SMTP id 81mr14482226ybs.510.1580169394346;
        Mon, 27 Jan 2020 15:56:34 -0800 (PST)
Received: from localhost.localdomain (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id a12sm7500989ywa.95.2020.01.27.15.56.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jan 2020 15:56:34 -0800 (PST)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alan Tull <atull@kernel.org>
Subject: [PATCH] of: Documentation: change overlay example to use current syntax
Date:   Mon, 27 Jan 2020 17:55:24 -0600
Message-Id: <1580169324-1447-1-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

The overlay implemenntation details in the compiled (DTB) file are
now properly implemented by the dtc compiler and should no longer
be hard coded in the source file.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 Documentation/devicetree/overlay-notes.txt | 85 ++++++++++++------------------
 1 file changed, 35 insertions(+), 50 deletions(-)

diff --git a/Documentation/devicetree/overlay-notes.txt b/Documentation/devicetree/overlay-notes.txt
index 725fb8d255c1..fddc63da7dba 100644
--- a/Documentation/devicetree/overlay-notes.txt
+++ b/Documentation/devicetree/overlay-notes.txt
@@ -19,6 +19,7 @@ Lets take an example where we have a foo board with the following base tree:
 
 ---- foo.dts -----------------------------------------------------------------
 	/* FOO platform */
+	/dts-v1/;
 	/ {
 		compatible = "corp,foo";
 
@@ -30,30 +31,25 @@ Lets take an example where we have a foo board with the following base tree:
 		ocp: ocp {
 			/* peripherals that are always instantiated */
 			peripheral1 { ... };
-		}
+		};
 	};
 ---- foo.dts -----------------------------------------------------------------
 
-The overlay bar.dts, when loaded (and resolved as described in [1]) should
+The overlay bar.dts,
 
----- bar.dts -----------------------------------------------------------------
-/plugin/;	/* allow undefined label references and record them */
-/ {
-	....	/* various properties for loader use; i.e. part id etc. */
-	fragment@0 {
-		target = <&ocp>;
-		__overlay__ {
-			/* bar peripheral */
-			bar {
-				compatible = "corp,bar";
-				... /* various properties and child nodes */
-			}
+---- bar.dts - overlay target location by label ------------------------------
+	/dts-v1/;
+	/plugin/;
+	&ocp {
+		/* bar peripheral */
+		bar {
+			compatible = "corp,bar";
+			... /* various properties and child nodes */
 		};
 	};
-};
 ---- bar.dts -----------------------------------------------------------------
 
-result in foo+bar.dts
+when loaded (and resolved as described in [1]) should result in foo+bar.dts
 
 ---- foo+bar.dts -------------------------------------------------------------
 	/* FOO platform + bar peripheral */
@@ -73,8 +69,8 @@ result in foo+bar.dts
 			bar {
 				compatible = "corp,bar";
 				... /* various properties and child nodes */
-			}
-		}
+			};
+		};
 	};
 ---- foo+bar.dts -------------------------------------------------------------
 
@@ -82,6 +78,27 @@ As a result of the overlay, a new device node (bar) has been created
 so a bar platform device will be registered and if a matching device driver
 is loaded the device will be created as expected.
 
+If the base DT was not compiled with the -@ option then the "&ocp" label
+will not be available to resolve the overlay node(s) to the proper location
+in the base DT. In this case, the target path can be provided. The target
+location by label syntax is preferred because the overlay can be applied to
+any base DT containing the label, no matter where the label occurs in the DT.
+
+The above bar.dts example modified to use target path syntax is:
+
+---- bar.dts - overlay target location by explicit path ----------------------
+	/dts-v1/;
+	/plugin/;
+	&{/ocp} {
+		/* bar peripheral */
+		bar {
+			compatible = "corp,bar";
+			... /* various properties and child nodes */
+		}
+	};
+---- bar.dts -----------------------------------------------------------------
+
+
 Overlay in-kernel API
 --------------------------------
 
@@ -105,35 +122,3 @@ enum of_overlay_notify_action for details.
 Note that a notifier callback is not supposed to store pointers to a device
 tree node or its content beyond OF_OVERLAY_POST_REMOVE corresponding to the
 respective node it received.
-
-Overlay DTS Format
-------------------
-
-The DTS of an overlay should have the following format:
-
-{
-	/* ignored properties by the overlay */
-
-	fragment@0 {	/* first child node */
-
-		target=<phandle>;	/* phandle target of the overlay */
-	or
-		target-path="/path";	/* target path of the overlay */
-
-		__overlay__ {
-			property-a;	/* add property-a to the target */
-			node-a {	/* add to an existing, or create a node-a */
-				...
-			};
-		};
-	}
-	fragment@1 {	/* second child node */
-		...
-	};
-	/* more fragments follow */
-}
-
-Using the non-phandle based target method allows one to use a base DT which does
-not contain a __symbols__ node, i.e. it was not compiled with the -@ option.
-The __symbols__ node is only required for the target=<phandle> method, since it
-contains the information required to map from a phandle to a tree location.
-- 
Frank Rowand <frank.rowand@sony.com>

