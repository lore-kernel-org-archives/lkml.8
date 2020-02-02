Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC337C3524B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 21:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0CD420838
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 21:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ry5sjD1L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgBBVTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 16:19:12 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42789 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbgBBVTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 16:19:07 -0500
Received: by mail-pf1-f193.google.com with SMTP id 4so6462102pfz.9;
        Sun, 02 Feb 2020 13:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cLNIp7PhbQluM+POzy592n9tV10I9FW4qXHr+ace/0o=;
        b=ry5sjD1L5SWWSxiszhSYKOJe3zcYfWegJDPhnA4gdDOnQqfvHPpwtdd6hcUx/L1NtJ
         K/z/1wv0N6xLazRKhcauNDxKBsbvhb7fPo96DoV1ZC7LLGFO8hqcASm9IJwkntCbr66e
         JqYgA3aV69TyKP7LALziFFb+ZFDl2IWDoglcCE6LRumZ1kZGx6vxTUqwk99zX3QEHMlA
         VCjfCZoeHIrEJhhzywxDYJlCf33sB6aP2l5BQ3NA8NciKDGJVvpSBP9wSD7JxYtenqtG
         qtrbdnkPxfcWZ8opEdCU/V6UKRB1zP9o6pKwGKTtIax1eDBjG5XiXRVCbIszFUk/uaEt
         mt2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cLNIp7PhbQluM+POzy592n9tV10I9FW4qXHr+ace/0o=;
        b=YsE7pqsCbiIzosIs4IZ2k1YdpWME/2BmYjywtJRYYjiVDpxKEbuKJLPtnFiD7PbRcI
         1lEu3WpvBtuOkKCgZeshTX+Ecn4++Os0I+ep2qaEa6+Dm/KVPSnvm0L1NubNYNMyOrnF
         YvO1ow1enJDLAKBNMzwnw9nDZcWSeInNVDm7E/GRJlZI4pC0zxRXttpAV6A77PlTzyKk
         LNIQKBMNy4VMDM9grr1CFSGNpsYmsF/5wR4mf7iyat4vVy2/pqrsrIUJ3L0LBf6jwoQC
         BYQnx071DAoRjPbC+zhO7pVYfXITN8KdeHKksvY61n2QboYxp5EFF2fBBmyFV5ybrV0Q
         3vUA==
X-Gm-Message-State: APjAAAW3BpVl1JkxYwnCsvfaZQMpO/4gu17fgp1zbvW68mMglu9KD4Yr
        axmoedH7rqFZ4cCw7OlLcPFe71T9
X-Google-Smtp-Source: APXvYqwrkI357eRs0qOJv+iVUPF/RoVjanzj2RJmPd1gxl+n4lOhSsmQZ6FZzFooY9j35ZJi4460Hg==
X-Received: by 2002:a63:744f:: with SMTP id e15mr23111913pgn.344.1580678345992;
        Sun, 02 Feb 2020 13:19:05 -0800 (PST)
Received: from localhost.localdomain (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id y24sm8755639pge.72.2020.02.02.13.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 13:19:05 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM IPROC ARM
        ARCHITECTURE), Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Sugaya Taichi <sugaya.taichi@socionext.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Jeffery <andrew@aj.id.au>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Maxime Ripard <mripard@kernel.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM IPROC ARM
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE)
Subject: [PATCH 05/12] dt-bindings: arm: bcm: Convert Stingray to YAML
Date:   Sun,  2 Feb 2020 13:18:20 -0800
Message-Id: <20200202211827.27682-6-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200202211827.27682-1-f.fainelli@gmail.com>
References: <20200202211827.27682-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the Broadcom Stingray SoC binding document for boards/SoCs to use
YAML. Verified with dt_binding_check and dtbs_check.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../bindings/arm/bcm/brcm,stingray.txt        | 12 ---------
 .../bindings/arm/bcm/brcm,stingray.yaml       | 26 +++++++++++++++++++
 2 files changed, 26 insertions(+), 12 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,stingray.txt
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,stingray.yaml

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,stingray.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,stingray.txt
deleted file mode 100644
index 23a02178dd44..000000000000
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,stingray.txt
+++ /dev/null
@@ -1,12 +0,0 @@
-Broadcom Stingray device tree bindings
-------------------------------------------------
-
-Boards with Stingray shall have the following properties:
-
-Required root node property:
-
-Stingray Combo SVK board
-compatible = "brcm,bcm958742k", "brcm,stingray";
-
-Stingray SST100 board
-compatible = "brcm,bcm958742t", "brcm,stingray";
diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,stingray.yaml b/Documentation/devicetree/bindings/arm/bcm/brcm,stingray.yaml
new file mode 100644
index 000000000000..b58307086cf2
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,stingray.yaml
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/bcm/brcm,stingray.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom Stingray device tree bindings
+
+maintainers:
+  - Ray Jui <rjui@broadcom.com>
+  - Scott Branden <sbranden@broadcom.com>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: Broadcom Stingray based boards
+        items:
+          - enum:
+              - brcm,bcm958742k
+              - brcm,bcm958742t
+              - brcm,bcm958802a802x
+          - const: brcm,stingray
+
+...
-- 
2.17.1

