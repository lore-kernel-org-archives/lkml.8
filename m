Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB183C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 21:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 854A120CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 21:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578951920;
	bh=K/GCp52aBxJDCBb2BQQESHAGIL8tMelIf1ffkyxKX2o=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=CKcseF2E+VuKzukmhboA2smohGLP1KZS32NlJftDsA95I9Fn8oFpoMvDQrFaI1aq8
	 j1NGAVLHmBhZdnZClZKtKhX4bIo371o1MmR19qR9TgURWmTJXmrEDckfz/W4NH6WQj
	 MwbWX02egSF0ORuTH5fFk0+rMrktllekrf1HsDBk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgAMVpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 16:45:19 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41640 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgAMVpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 16:45:18 -0500
Received: by mail-ot1-f68.google.com with SMTP id r27so10465442otc.8;
        Mon, 13 Jan 2020 13:45:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mM3ffZ+uHzyjtSHfkWICeLClR/QcgekLlH0ni9dym2U=;
        b=rSbOcwPu9RQ3+j1eGnIoDD13eMTvZ1Ca4nmraAbozXIHgHT//h2x8Z1j29q1NR+L21
         Cd7G9UTBtK9weOxR9CcR43b1hccrUEqJKabHPbn5lXCOKE8uY9JibAw2ZU0ke+vJBPhn
         IDMtpr0BGPxtgqlKOHdHHNoSOZlLfHSQ78ORwk07HcS/GuO7iWAKniZzbVNMNP46/ag/
         j+OvJGP8zp6235+5/9ZnpgiwNAsPI6cBUP3GZsYQ7M8c0I8ql9sgyrI/rfC4XREfAmxq
         Cd2j3CYhqEEwdxxslBjrfheVq9SSKtWsGKZQR6wDcWljRQc8uxT2740lTXFMB+vtFwcV
         FCsQ==
X-Gm-Message-State: APjAAAWQsxk6ekgbmYqmEzh2L6BFB9RiDwYPBD9fZBz31w9oLAQ2XSv0
        2C+SAiggqDRWPQrqPoTyf26hl9Y=
X-Google-Smtp-Source: APXvYqxSkUU8Ax6vucMTH/cz2bwzZ2zHlHrusaP9gffchq7RL66o6JKJxO/ICmvv88ExEzAn0Uh2uQ==
X-Received: by 2002:a9d:12f1:: with SMTP id g104mr15261288otg.334.1578951917644;
        Mon, 13 Jan 2020 13:45:17 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u13sm3957422oic.2.2020.01.13.13.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 13:45:16 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH] dt-bindings: reset: intel,rcu-gw: Fix intel,global-reset schema
Date:   Mon, 13 Jan 2020 15:45:15 -0600
Message-Id: <20200113214515.3950-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The intel,rcu-gw binding example has an error:

Documentation/devicetree/bindings/reset/intel,rcu-gw.example.dt.yaml:
  reset-controller@e0000000: intel,global-reset: [[16, 30]] is too short

The error isn't really correct as the problem is in how the data is
encoded and the schema is not fixed up by the tooling correctly.
However, array properties should describe the elements in the array, so
lets do that which fixes the error in the process.

Fixes: b7ab0cb00d08 ("dt-bindings: reset: Add YAML schemas for the Intel Reset controller")
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Dilip Kota <eswara.kota@linux.intel.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml b/Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml
index 246dea8a2ec9..8ac437282659 100644
--- a/Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml
+++ b/Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml
@@ -23,7 +23,11 @@ properties:
     description: Global reset register offset and bit offset.
     allOf:
       - $ref: /schemas/types.yaml#/definitions/uint32-array
-      - maxItems: 2
+    items:
+      - description: Register offset
+      - description: Register bit offset
+        minimum: 0
+        maximum: 31
 
   "#reset-cells":
     minimum: 2
-- 
2.20.1

