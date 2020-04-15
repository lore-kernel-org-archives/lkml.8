Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0883C38A29
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE6282078B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586962013;
	bh=vmjZxcRiYIn7FqbxC+RA+SUWBoUTUvQ7ocSvEou+wZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ABef/XpHXYopEZXobrfX27d20j3GCWT6rgwocZo66Pdiqo1lqlM/7KFpViIqwlrk9
	 Ln8nC85LmoWT48BuuSgfnHVw4yGIoInVS5V2zWYagK2tQxcy01oV5crknLXUZlAFtt
	 uDZ+F9RNCgHrU/wIu2Qf5o5kNeI4le3YR/Quy6Go=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370987AbgDOOqp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:46:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2636789AbgDOOpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:45:33 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 278D721744;
        Wed, 15 Apr 2020 14:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586961929;
        bh=vmjZxcRiYIn7FqbxC+RA+SUWBoUTUvQ7ocSvEou+wZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xEszWOL29mZL3aJ9sJbLQzKtT9HddfoTVBJRKWZwU0GgZ2UeyjR6A7F1RepYYmWbC
         zMZKbx+cFLDvovRhE+CtYngN1LmVPfo8xEwt0HfGrDkQ9Cznf4b3SHlPQ+JIVUaxtA
         f0p82mF2C/3dXV+n1hqndWfJuA9nxlDSTA7z3ElA=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOjI7-006kZk-CZ; Wed, 15 Apr 2020 16:45:27 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Frank Rowand <frowand.list@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v3 08/12] docs: dt: convert overlay-notes.txt to ReST format
Date:   Wed, 15 Apr 2020 16:45:22 +0200
Message-Id: <8d69f216ea22c38f5665c7782535837396804a24.1586961793.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586961793.git.mchehab+huawei@kernel.org>
References: <cover.1586961793.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add a SPDX header;
- Adjust document title;
- Some whitespace fixes and new line breaks;
- Mark literal blocks as such;
- Add it to devicetree/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/devicetree/index.rst            |   1 +
 .../{overlay-notes.txt => overlay-notes.rst}  | 141 +++++++++---------
 MAINTAINERS                                   |   2 +-
 3 files changed, 74 insertions(+), 70 deletions(-)
 rename Documentation/devicetree/{overlay-notes.txt => overlay-notes.rst} (56%)

diff --git a/Documentation/devicetree/index.rst b/Documentation/devicetree/index.rst
index ca83258fbba5..0669a53fc617 100644
--- a/Documentation/devicetree/index.rst
+++ b/Documentation/devicetree/index.rst
@@ -13,3 +13,4 @@ Open Firmware and Device Tree
    changesets
    dynamic-resolution-notes
    of_unittest
+   overlay-notes
diff --git a/Documentation/devicetree/overlay-notes.txt b/Documentation/devicetree/overlay-notes.rst
similarity index 56%
rename from Documentation/devicetree/overlay-notes.txt
rename to Documentation/devicetree/overlay-notes.rst
index 3f20a39e4bc2..7e8e568f64a8 100644
--- a/Documentation/devicetree/overlay-notes.txt
+++ b/Documentation/devicetree/overlay-notes.rst
@@ -1,5 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========================
 Device Tree Overlay Notes
--------------------------
+=========================
 
 This document describes the implementation of the in-kernel
 device tree overlay functionality residing in drivers/of/overlay.c and is a
@@ -15,68 +18,68 @@ Since the kernel mainly deals with devices, any new device node that result
 in an active device should have it created while if the device node is either
 disabled or removed all together, the affected device should be deregistered.
 
-Lets take an example where we have a foo board with the following base tree:
-
----- foo.dts -----------------------------------------------------------------
-	/* FOO platform */
-	/ {
-		compatible = "corp,foo";
-
-		/* shared resources */
-		res: res {
-		};
-
-		/* On chip peripherals */
-		ocp: ocp {
-			/* peripherals that are always instantiated */
-			peripheral1 { ... };
-		}
-	};
----- foo.dts -----------------------------------------------------------------
-
-The overlay bar.dts, when loaded (and resolved as described in [1]) should
-
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
-		};
-	};
-};
----- bar.dts -----------------------------------------------------------------
-
-result in foo+bar.dts
-
----- foo+bar.dts -------------------------------------------------------------
-	/* FOO platform + bar peripheral */
-	/ {
-		compatible = "corp,foo";
-
-		/* shared resources */
-		res: res {
-		};
-
-		/* On chip peripherals */
-		ocp: ocp {
-			/* peripherals that are always instantiated */
-			peripheral1 { ... };
-
-			/* bar peripheral */
-			bar {
-				compatible = "corp,bar";
-				... /* various properties and child nodes */
-			}
-		}
-	};
----- foo+bar.dts -------------------------------------------------------------
+Lets take an example where we have a foo board with the following base tree::
+
+    ---- foo.dts --------------------------------------------------------------
+	    /* FOO platform */
+	    / {
+		    compatible = "corp,foo";
+
+		    /* shared resources */
+		    res: res {
+		    };
+
+		    /* On chip peripherals */
+		    ocp: ocp {
+			    /* peripherals that are always instantiated */
+			    peripheral1 { ... };
+		    }
+	    };
+    ---- foo.dts --------------------------------------------------------------
+
+The overlay bar.dts, when loaded (and resolved as described in [1]) should::
+
+    ---- bar.dts --------------------------------------------------------------
+    /plugin/;	/* allow undefined label references and record them */
+    / {
+	    ....	/* various properties for loader use; i.e. part id etc. */
+	    fragment@0 {
+		    target = <&ocp>;
+		    __overlay__ {
+			    /* bar peripheral */
+			    bar {
+				    compatible = "corp,bar";
+				    ... /* various properties and child nodes */
+			    }
+		    };
+	    };
+    };
+    ---- bar.dts --------------------------------------------------------------
+
+result in foo+bar.dts::
+
+    ---- foo+bar.dts ----------------------------------------------------------
+	    /* FOO platform + bar peripheral */
+	    / {
+		    compatible = "corp,foo";
+
+		    /* shared resources */
+		    res: res {
+		    };
+
+		    /* On chip peripherals */
+		    ocp: ocp {
+			    /* peripherals that are always instantiated */
+			    peripheral1 { ... };
+
+			    /* bar peripheral */
+			    bar {
+				    compatible = "corp,bar";
+				    ... /* various properties and child nodes */
+			    }
+		    }
+	    };
+    ---- foo+bar.dts ----------------------------------------------------------
 
 As a result of the overlay, a new device node (bar) has been created
 so a bar platform device will be registered and if a matching device driver
@@ -88,11 +91,11 @@ Overlay in-kernel API
 The API is quite easy to use.
 
 1. Call of_overlay_fdt_apply() to create and apply an overlay changeset. The
-return value is an error or a cookie identifying this overlay.
+   return value is an error or a cookie identifying this overlay.
 
 2. Call of_overlay_remove() to remove and cleanup the overlay changeset
-previously created via the call to of_overlay_fdt_apply(). Removal of an
-overlay changeset that is stacked by another will not be permitted.
+   previously created via the call to of_overlay_fdt_apply(). Removal of an
+   overlay changeset that is stacked by another will not be permitted.
 
 Finally, if you need to remove all overlays in one-go, just call
 of_overlay_remove_all() which will remove every single one in the correct
@@ -109,9 +112,9 @@ respective node it received.
 Overlay DTS Format
 ------------------
 
-The DTS of an overlay should have the following format:
+The DTS of an overlay should have the following format::
 
-{
+    {
 	/* ignored properties by the overlay */
 
 	fragment@0 {	/* first child node */
@@ -131,7 +134,7 @@ The DTS of an overlay should have the following format:
 		...
 	};
 	/* more fragments follow */
-}
+    }
 
 Using the non-phandle based target method allows one to use a base DT which does
 not contain a __symbols__ node, i.e. it was not compiled with the -@ option.
diff --git a/MAINTAINERS b/MAINTAINERS
index 12fb85313e1b..4da583422186 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12554,7 +12554,7 @@ M:	Frank Rowand <frowand.list@gmail.com>
 L:	devicetree@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/dynamic-resolution-notes.rst
-F:	Documentation/devicetree/overlay-notes.txt
+F:	Documentation/devicetree/overlay-notes.rst
 F:	drivers/of/overlay.c
 F:	drivers/of/resolver.c
 K:	of_overlay_notifier_
-- 
2.25.2

