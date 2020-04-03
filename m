Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD25EC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEBB62076E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PL9jGfm+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbgDCS4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 14:56:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34324 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbgDCS4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 14:56:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id 65so9781946wrl.1;
        Fri, 03 Apr 2020 11:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WN4/jCtzPm+7C+qudC8fEtUB4dRRg3a7mKBc47Kr92A=;
        b=PL9jGfm+3PgzH3RF0dRp4rFmgTMiYSPfgwz4e5BqgjHW+EO2nX9Oo+wOCKDwDZTB/Z
         iSld0T0vX/W2g2aYes6GQnQBCH/HUoyfXo/JystKlpi7+QhEx/RJAZWH3DVN3URS2R2R
         gwibtsB06Al/jKi/Sif6SZYepRO4zwT0HntSy4J2saWbNrTUHRwv8Mk539+OJymRHSm5
         r8QiFAa7PKEgeVJ5NwNBdsbKtDvPZeynN8Oe1jyJGCcKHgSZmVtm5RnxxQ11kQsL6Ygi
         TMoSDQEhOLTTPmH8RCR16a/vDt5ypGDMUluFC3XBKQYv+9zb4DFn4FII1CrhIRWz+oeV
         QfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WN4/jCtzPm+7C+qudC8fEtUB4dRRg3a7mKBc47Kr92A=;
        b=bdR9tPV8qYrrpqG+cMCVRYUQo4/ctwcpdl90LS6yJXKwh/ogLuxilpE5aTiko1mhD8
         qM3PBY0hdtAw24mv3YUF6zPJsd98JAxJqqfZEF4tfqPXyB8N9bJ7KBLyHNK54v+zaP8V
         IqydPwK0q7bqadyJRvqtho3vB73N46TsUz8jXzL7KEdFPUJoss1qgbVy0FG7BePRXX34
         s51k6zqd8MU2d/d9Zqzy3aFFrUTophTOvlUkRFVPRKvdgxLuNw3MjbSmRve4Nv6MtM73
         GEyO+6x8Y0HzrxbkcILNiY51XcpB0FywkH6bp+G8Xd5cAFClaDt8uyaV4PBnqV0Sxtgc
         GI3w==
X-Gm-Message-State: AGi0PubAHxLBHnZo+JmBjP++5tZnb2zDzXEUUakImHiANYg8q9P/bOiK
        /nBSVB3Aqt2AgLJ8smZI1LI=
X-Google-Smtp-Source: APiQypLa+GhsQe3++u3DaF8/Zf6KUXk6hx1v6j12VqUL73PRXvAP5E8KHQZznoynihi2QsM73D5OSg==
X-Received: by 2002:a05:6000:10e:: with SMTP id o14mr10090863wrx.231.1585940208106;
        Fri, 03 Apr 2020 11:56:48 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id z3sm12019692wma.22.2020.04.03.11.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 11:56:47 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: reserved-memory: Introduce memory-region{s,-names}
Date:   Fri,  3 Apr 2020 20:56:37 +0200
Message-Id: <20200403185640.118569-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200403185640.118569-1-thierry.reding@gmail.com>
References: <20200403185640.118569-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

In order to make the reserved-memory bindings more consistent with other
existing bindings, add a memory-region-names property that contains an
array of strings that name the entries of the memory-region property and
allows these regions to be looked up by name.

Also add the memory-regions property as an alias for the existing
memory-region property. This is again for consistency with other similar
bindings and makes it clearer that this property can take multiple
<phandle, specifier> pairs.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../bindings/reserved-memory/reserved-memory.txt     | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
index bac4afa3b197..823e619cfca3 100644
--- a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
+++ b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
@@ -76,7 +76,11 @@ Device node references to reserved memory
 Regions in the /reserved-memory node may be referenced by other device
 nodes by adding a memory-region property to the device node.
 
-memory-region (optional) - phandle, specifier pairs to children of /reserved-memory
+memory-regions (optional) - phandle, specifier pairs to children of /reserved-memory
+memory-region-names (optional) - a list of names, one for each corresponding
+  entry in the memory-regions property
+
+memory-region (optional) - alias for memory-regions
 
 Example
 -------
@@ -120,17 +124,17 @@ one for multimedia processing (named multimedia-memory@77000000, 64MiB).
 	/* ... */
 
 	fb0: video@12300000 {
-		memory-region = <&display_reserved>;
+		memory-regions = <&display_reserved>;
 		/* ... */
 	};
 
 	scaler: scaler@12500000 {
-		memory-region = <&multimedia_reserved>;
+		memory-regions = <&multimedia_reserved>;
 		/* ... */
 	};
 
 	codec: codec@12600000 {
-		memory-region = <&multimedia_reserved>;
+		memory-regions = <&multimedia_reserved>;
 		/* ... */
 	};
 };
-- 
2.24.1

