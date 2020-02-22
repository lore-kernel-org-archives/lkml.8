Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF65EC35673
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 18:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE6E1206E2
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 18:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PgQzLg8q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgBVSaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 13:30:17 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:34451 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgBVSaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 13:30:17 -0500
Received: by mail-pg1-f201.google.com with SMTP id w5so3189407pgw.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 10:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LqkliWMqkbYqRIuupuOLJ6kzkCRKDL/XTv8pUZxzvKQ=;
        b=PgQzLg8qKzkyhPyxTmoaNbnjNiSyl7EAdKe9zlgr7TFwxMb8ScYriPIQUviohO4BSk
         nUR9tkQzOmQFjuXA1r1vnn/cKgcN9herEGiD+8RcQ5/kjryJFb1QCWQB68vGKhtmmgH/
         sDAHhKQrgYrgoL3KjmL3XDRC4b/vmMsjwr48xg6ZF82kNigCID53t8L0ht6mg+ro4qoc
         /WfCokur3PuPbHVzNIO3SE6niOinINt9R1b06lNInZVj1C5XUBd+v9ygMq3wQe/e/6p8
         8E+UZTx4ZMxQKRikHlAw/aYtrrZSsf7C++C1js0gybHMgS+8OWKW7jMi9NcWaOXrRPaX
         3bcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LqkliWMqkbYqRIuupuOLJ6kzkCRKDL/XTv8pUZxzvKQ=;
        b=kwxKvl7X46Uvs9eSGisNTU69Uc6wgx7z1MuznMC7MPNdecGL7yEwHVOBPsRqyhA3MJ
         6ocCYdW20EnrD4o3K5wrG+PAfhHIihBzbSArbPSy6YhdrgFLgNyfLFJpQ6SYW8YERB/E
         R+IzxNi7cHjOUrDAmB8dqIhwat8FDkE1mxSHR/gDUiImdIsLguZVCgh+edNHyLHlXYAX
         abBJjDtApdC4glHL2icbNTVg8JRUEvfZsIupueLof0ngxwD6FrLnclDFkqot+quqgLoW
         7U4c5ip9QQci8EKKw2GcYJq81gKHWVKtYtyuhdHYa65jealGes6AWjP51TOHKrSvnAzk
         bUMg==
X-Gm-Message-State: APjAAAVwHMFdYVuYxNxXqWZZBIcwNfu4jz4KzuaYgBBnMsznWh+sPURD
        erzIF4enFISpw++6s6X1ELgZsjjX/qEGhNRheCLet2DhJnCegLZHmzwyrQZ/5V0qjgJG2gZnJen
        85krNmgvn/kEOSfSsHGrv4du6F8653sVMdDC72cKqd2hmWVQqrKkuX0mVNBnmf3+nARXFqw==
X-Google-Smtp-Source: APXvYqzQdQgHQ6fWCJuIXWIAgYGxlrY2CrH849Fe3I+ATdbmceKERzMpxkHMUK63twO0nuNjfUKmQrh7v4U=
X-Received: by 2002:a63:120f:: with SMTP id h15mr46221489pgl.235.1582396216132;
 Sat, 22 Feb 2020 10:30:16 -0800 (PST)
Date:   Sat, 22 Feb 2020 10:30:10 -0800
In-Reply-To: <20200222183010.197844-1-adelva@google.com>
Message-Id: <20200222183010.197844-2-adelva@google.com>
Mime-Version: 1.0
References: <20200222183010.197844-1-adelva@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH 2/2] dt-bindings: pmem-region: Document memory-region
From:   Alistair Delva <adelva@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kenny Root <kroot@google.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, devicetree@vger.kernel.org,
        linux-nvdimm@lists.01.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kenny Root <kroot@google.com>

Add documentation and example for memory-region in pmem.

Signed-off-by: Kenny Root <kroot@google.com>
Signed-off-by: Alistair Delva <adelva@google.com>
Cc: "Oliver O'Halloran" <oohall@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: devicetree@vger.kernel.org
Cc: linux-nvdimm@lists.01.org
Cc: kernel-team@android.com
---
 .../devicetree/bindings/pmem/pmem-region.txt  | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/pmem/pmem-region.txt b/Documentation/devicetree/bindings/pmem/pmem-region.txt
index 5cfa4f016a00..851ffa71967e 100644
--- a/Documentation/devicetree/bindings/pmem/pmem-region.txt
+++ b/Documentation/devicetree/bindings/pmem/pmem-region.txt
@@ -29,6 +29,18 @@ Required properties:
 		in a separate device node. Having multiple address ranges in a
 		node implies no special relationship between the two ranges.
 
+		This property may be replaced or supplemented with a
+		memory-region property. Only one of reg or memory-region
+		properties is required.
+
+	- memory-region:
+		Reference to the reserved memory node. The reserved memory
+		node should be defined as per the bindings in
+		reserved-memory.txt
+
+		This property may be replaced or supplemented with a reg
+		property. Only one of reg or memory-region is required.
+
 Optional properties:
 	- Any relevant NUMA assocativity properties for the target platform.
 
@@ -63,3 +75,21 @@ Examples:
 		volatile;
 	};
 
+
+	/*
+	 * This example uses a reserved-memory entry instead of
+	 * specifying the memory region directly in the node.
+	 */
+
+	reserved-memory {
+		pmem_1: pmem@5000 {
+			no-map;
+			reg = <0x00005000 0x00001000>;
+		};
+	};
+
+	pmem@1 {
+		compatible = "pmem-region";
+		memory-region = <&pmem_1>;
+	};
+
-- 
2.25.0.265.gbab2e86ba0-goog

