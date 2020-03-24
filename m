Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAE2C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA4C92070A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvEENzKw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbgCXMcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 08:32:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45188 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbgCXMcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 08:32:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id t7so16507748wrw.12;
        Tue, 24 Mar 2020 05:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q8xyTZiiURMuZz55C+lV5frFi0juzWLh763pjmleRTI=;
        b=XvEENzKw2wGFTbrDGRT3ml/i9ciXc0tz7Wabz9yXGUzdkYE4+jwsp4Oz1tZnNsOQCx
         RmPmOt4EITNYP6enElBEOeeXIbsROyVn/p1lqndCXnzohUIBGvGRb/tiN60CTc0I7iJD
         l/pmAsVQna4eQPy3zsl1/eAfMPmPFeItIjs13dfnfRxcuhygA1DmUnp6Vu6Qm9nrK95+
         C6KCyFvUph3EfIxZqM3ZoEDoFrelVWO3c2sdPswtZjzNRrhkihhX/2HLq+yNX0gom61J
         zOVQeIk0PYGQCuoLabwoEAX8SlcTWE0gGuPQKBMgrN383EZ+iVcL4ZkKcqHdJOK1Htk4
         62JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q8xyTZiiURMuZz55C+lV5frFi0juzWLh763pjmleRTI=;
        b=AAK3widtKlIUTnmkL22tI7SP9Oo+FjGss8REVcb+HMRXvqKtD0JlhEVjdinDBVE4N8
         Tqqu13QRXEpeWJO1zhXsMtG388YwT4Q6P69ioubALNtNm8HQ2Sl+JQuct5pLj0GSF+Ge
         51X0qlVch2QBXdsiCTE9BKjHdJQB7GAkX70S19xl4czV3acC3B+9N0G4bawywOELYZhN
         RfIeGml1ynIp1e8pzbIGUbeAm6h+H05dR+ezKdf+nP5iLYj92XTr+I/UYFAEWI5nap8z
         0kTpNYKeawXe9XsOBC5yvfKxcstf/BfDWBMNUGMaDVEqshTF/IwwI3joUY6dy9F3mGT+
         mD0w==
X-Gm-Message-State: ANhLgQ0NmgNrxwH9F7rKZ+DmdueMO8PDR5/hI2YnhBxVqA4RFbf+rMzh
        +wTGULpuZfMIHe19rFxbYX8=
X-Google-Smtp-Source: ADFU+vspS2iaiHICA89DEah3/meoLs+mzhJGZMZqXh2WzZtOitG+ZLB8tygXug0W+SCEjGmNzcIUmg==
X-Received: by 2002:adf:f892:: with SMTP id u18mr27024616wrp.367.1585053124710;
        Tue, 24 Mar 2020 05:32:04 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id k185sm4215029wmb.7.2020.03.24.05.32.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Mar 2020 05:32:04 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, heiko@sntech.de, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] dt-bindings: sound: rockchip-spdif: add power-domains property
Date:   Tue, 24 Mar 2020 13:31:55 +0100
Message-Id: <20200324123155.11858-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200324123155.11858-1-jbx6244@gmail.com>
References: <20200324123155.11858-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the old txt situation we add/describe only properties that are used
by the driver/hardware itself. With yaml it also filters things in a
node that are used by other drivers like 'power-domains' for rk3399,
so add it to 'rockchip-spdif.yaml'.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/sound/rockchip-spdif.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-spdif.yaml b/Documentation/devicetree/bindings/sound/rockchip-spdif.yaml
index 0546fd4cc..f79dbd153 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-spdif.yaml
+++ b/Documentation/devicetree/bindings/sound/rockchip-spdif.yaml
@@ -51,6 +51,9 @@ properties:
   dma-names:
     const: tx
 
+  power-domains:
+    maxItems: 1
+
   rockchip,grf:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
-- 
2.11.0

