Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590A1C35677
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 02:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F56A206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 02:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dl3xLDMm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbgBXCI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 21:08:26 -0500
Received: from mail-vk1-f202.google.com ([209.85.221.202]:42690 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbgBXCIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 21:08:25 -0500
Received: by mail-vk1-f202.google.com with SMTP id i1so3868142vkn.9
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 18:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tfMKf34rzYmaH8xdI4hD1ENek/gjKmpNdihWWrIkihY=;
        b=dl3xLDMmDQHWYwGTPecBMrhl8cp1ubi79/y4uC7zvxw13x5kxR0hIrdzcb6mpDjnIR
         akn7tFOCzC75LJ2U9XJBX1yKrH60zz44P5XPslfmv7fJWnv+CjXCSxIC9H0Qj+eap13U
         b1797Qo5mdforvpT4UbfBeE3Kwe7zvdlEFiny/xDlpedod7j01y2vCVM9O1Wdm+DQDdY
         DdqUI16njA1pwpu3TGvZTWuiHMHMU4z/1vto4Gwv59MGXnZwoueBJu8V1lHvMMEwWG63
         3p9DXJ3CcgM+sXeYNC/XM9jp86gtz5/p+nNxrhXAKSgazBzSfBhHDwhZwBGiPwrwNWVE
         ydSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tfMKf34rzYmaH8xdI4hD1ENek/gjKmpNdihWWrIkihY=;
        b=LebG7Pfthbmz1zJoSWNOIS8SyJM6g0PrgjAHuiiQxKjIub2ZQElWOpOgS0P67qC6Bz
         tgQv0wvGbMmLuvkcJuEyNqWjq10Ab+I+0Il4Ja5MV7MvaglL90tLWCJw7g72rPt+jDjf
         1NQrBEc6ngEvdGvea5OnBpbQPeH0SpVTcKi9XdYI0G/hKIJyIvvitmSBubSlOuV2D2b7
         Lpaa6S734fpumEvAF91R+8ny01fVvSqCHtesifRos+6CZDHO4NFFwJytVvSNSAunYcvl
         EPt1w8xpJjaVaAOIm9O5QdbdzvbVZhOZWtU0ICndjKd9ugIGEdAQIfmLg/iGfQ5IssIZ
         83cg==
X-Gm-Message-State: APjAAAUXSSa70uFOvWNBDE3hEPD3eNcPboTKael07mVc3dj3BA4P9oyn
        gXi/WVGfgQBJsXBH4b05xz5vGQB6hp2Q5neCvFn/ykzVaBvt0PxNa1YQQ8EcjzIqw7YwT6dB1fZ
        sjnuQ3rMrQ+qditim/hvFZ9oXEcwPPsY29QWQicwFe+HYTEOY/AKCfZStupTx9rKqu18KEg==
X-Google-Smtp-Source: APXvYqwTsPEqq0vSJALIwRT24gVR2Zsdll9IQ6yQ0KfZKKmTVDr8mHQmzYKgR5Kxy/Fg4GEAIXU4VmCCVXc=
X-Received: by 2002:a67:89c4:: with SMTP id l187mr24451432vsd.31.1582510103411;
 Sun, 23 Feb 2020 18:08:23 -0800 (PST)
Date:   Sun, 23 Feb 2020 18:08:15 -0800
In-Reply-To: <20200224020815.139570-1-adelva@google.com>
Message-Id: <20200224020815.139570-3-adelva@google.com>
Mime-Version: 1.0
References: <20200224020815.139570-1-adelva@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v2 3/3] dt-bindings: pmem-region: Document memory-region
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
 .../devicetree/bindings/pmem/pmem-region.txt  | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/pmem/pmem-region.txt b/Documentation/devicetree/bindings/pmem/pmem-region.txt
index 5cfa4f016a00..0ec87bd034e0 100644
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
 
@@ -63,3 +75,20 @@ Examples:
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
-- 
2.25.0.265.gbab2e86ba0-goog

