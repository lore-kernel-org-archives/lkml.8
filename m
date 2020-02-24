Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0BCC35677
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 02:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A452067D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 02:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E+uXnhSN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbgBXCKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 21:10:40 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:54169 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbgBXCKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 21:10:38 -0500
Received: by mail-pf1-f202.google.com with SMTP id c17so5651494pfi.20
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 18:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=em6XcUN6Sgd77WYEtwG8AuT1olj7PL/gGgbDqoXx92w=;
        b=E+uXnhSNXf534z3GjUH2lwNEjBXcWXn9RZ44ynGBLyGFBh6B4SCJ3rTdzfHM+o+Bno
         VxKLCAHwsdkWJHskFoD9Vkuqmf8sv3ORr03b21RmM6sK4B1dNgs7kHUsncaBgQsK20aP
         fSSiL3sHi6ZuSaLSU/ac+vt4cTkZWsOgFrQbnhYdCv8sXcHJm4YWmse1gk9vJvta74Pz
         CtGwlNEpDNXJrKiIYC7aOyrG6lp7JHG+ot6FFt32MXr6s5mwt6uR9xa3rNnYf88dZifz
         0PMFwNS6V8oJBOtSVNut319Ez0TbFHLd2ElURqTOriDU/ubyPYQu44SBgjdg9OpeV/wF
         pVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=em6XcUN6Sgd77WYEtwG8AuT1olj7PL/gGgbDqoXx92w=;
        b=F/ttBhHZv7sHEXRn8rPxqwhK9KoATiEmsoywe9JFrCgfKZlAqxe/Xv86QGSo0FTjzb
         SD3dYOf5mJOwM4lJavcX+6dYF4ypt3eCd5fzhh93kg2uZtsGj7fkB2oaP+qTLBM4shEh
         YYoLt9glBeRDh51LJ0i5/GY3v64LJErrUoSe3sQcuHGljl898zJw9E0PwbS28F3raXoE
         XyOHTWDIlOBTUxnVKh62la8hUK7xZTPm37nBjqoRujDvIGofB7xsP7xVv9ED5I/IECx6
         71/bvNaEDRbhvW3E1vcdzCwc5yvb95Eb8pKKLqPnB8txj6x+bvitQW9nY3m7A75Joy2k
         oK2w==
X-Gm-Message-State: APjAAAWYbnYhzPq2bWc8gJvKGk8YwqI8vg4gRLKFH1WmSKYPF3dP/H4j
        9gKWCY7+vS+hRrsrTRhTPRxlbBneE67bYHFszf132aZFw64qCteNZfLG0UR9FzZDKAll6WXQ4qb
        DlZhxWX+/yR+BypdT8QBSXTaYbnomHNDm2AVixkZwJbS6iY7TlhH9siQFEC2UkFJb0MAjzw==
X-Google-Smtp-Source: APXvYqz6s2e3jF7ohEb8JyMCoEHwTugiFEQk/Az/WnyXRnhPy25meta77iWUNz38j1pNY9KX9r6A5JnI984=
X-Received: by 2002:a63:3407:: with SMTP id b7mr23541684pga.163.1582510236455;
 Sun, 23 Feb 2020 18:10:36 -0800 (PST)
Date:   Sun, 23 Feb 2020 18:10:29 -0800
In-Reply-To: <20200224021029.142701-1-adelva@google.com>
Message-Id: <20200224021029.142701-3-adelva@google.com>
Mime-Version: 1.0
References: <20200224021029.142701-1-adelva@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v3 3/3] dt-bindings: pmem-region: Document memory-region
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
[v3: adelva: remove duplicate "From:"]
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

