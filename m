Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C595C2D0F9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 20:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E8F820769
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 20:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589316347;
	bh=Lh87sBVirmETvaVLhodSRgK38hbyc/iavSjxAunQF04=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=qCzJ6Tg9kG1ZpxYE+ZqYZby4I+EbTs+Tt2opkDY/8AOjyxA4a425xh8ZpK4ZD+UVN
	 pxMm1QLmcFH2g+Z7Ea8Y2gBtv+ONOFdFykjPuxJFGE1Ab6lq+fJdPVfM33WS1VfCQj
	 VSSjRP1UgO9eAKDoy7hYsjSQx7+GhxYuoZl5zlAc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731142AbgELUpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 16:45:46 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40815 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgELUpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 16:45:46 -0400
Received: by mail-oi1-f193.google.com with SMTP id v128so2652597oia.7;
        Tue, 12 May 2020 13:45:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bZ3SlC6IjAo3rRznak2yB2vjG0WklLB9HsgMaXr/3G8=;
        b=ZepMXdQ/WnfBObbFd/B6M9to3Ob8Ol7WtpC39VYHjN4V7bsZEZexDAhDER0b0BbVTw
         tHVIlA39IsnB5NgjrHBUtMO85bLadeGNJ4FD4BVDr3seuP6HkbG6qt0/JuaNw9bc6U3V
         14bnQ3rB3FFAXvXNz+1w1xMAL4ZDecKlbC2kD7RCam5xRcl8EZUzdZVG8zKrF9Ut3IY6
         f3UjfUTRBHiCNtKr1+/xYvz8LBGG0hBoOvHSNj+M+DqAOIBWCpGQLlWZFTw0JjGAsG7z
         AchaYC9Vfh1f2EJvfZ5I/xPuOZgQ2dB0AbqHwAksFuXVQvO88t2A3u98QBDH4ELTptvS
         CcQA==
X-Gm-Message-State: AGi0Pubs2xELuMteQV/fKsLd2nq1GMHPAlCwpsuMhU1J6KxhvSJjv6j3
        QVfU0NFWduUSdidFOv8PvOeuOQBqUA==
X-Google-Smtp-Source: APiQypKV6dUHk4u2TZZM9pj4FNgtVQv7pL7PiPyGyXG2CpXKT8zCVpKHis+rnBPSF2vegPnG8W7f6g==
X-Received: by 2002:aca:488c:: with SMTP id v134mr12366530oia.103.1589316344975;
        Tue, 12 May 2020 13:45:44 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id k8sm3943792ood.24.2020.05.12.13.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 13:45:44 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-clk@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
Subject: [PATCH 1/5] spi: dt-bindings: sifive: Add missing 2nd register region
Date:   Tue, 12 May 2020 15:45:39 -0500
Message-Id: <20200512204543.22090-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'reg' description and example have a 2nd register region for memory
mapped flash, but the schema says there is only 1 region. Fix this.

Cc: Mark Brown <broonie@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: linux-spi@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please ack, dependency for patch 5.

 Documentation/devicetree/bindings/spi/spi-sifive.yaml | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-sifive.yaml b/Documentation/devicetree/bindings/spi/spi-sifive.yaml
index 28040598bfae..fb583e57c1f2 100644
--- a/Documentation/devicetree/bindings/spi/spi-sifive.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-sifive.yaml
@@ -32,11 +32,10 @@ properties:
       https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/spi
 
   reg:
-    maxItems: 1
-
-    description:
-      Physical base address and size of SPI registers map
-      A second (optional) range can indicate memory mapped flash
+    minItems: 1
+    items:
+      - description: SPI registers region
+      - description: Memory mapped flash region
 
   interrupts:
     maxItems: 1
-- 
2.20.1

