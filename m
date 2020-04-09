Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F28C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 20:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C56F2082D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 20:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586463921;
	bh=8SJkx8N21llHOyD7xn6lLJPniYQK0j/NupG+z8JapQ0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=iw58KtuY9jeoQJXM4cv55i7M/mI56WlmX+1GW/LwWwAcGSQcv7D/w9XVnaXVcNJ4/
	 +pXmjnvfUQjI4dIlcFYnGsJEpXpxH9UPSrSwxLwkFCdYPs0lthPx8d9OgtUyQxFvQA
	 C3W+nmS8XZlFPNgVs10Y6DznKdo653vw6GGPJZDY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgDIUZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 16:25:20 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:40858 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgDIUZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 16:25:19 -0400
Received: by mail-il1-f196.google.com with SMTP id o11so966341ilq.7;
        Thu, 09 Apr 2020 13:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qql7LMZDN/GlsmtXFLbpmj2338yu7zQz69wHu+w3jzc=;
        b=L2grPdJSvKIzdI43JUEr27HQBgIIkXKLmHiRvkIi3LBDVpIRtAQZctay1/wgddkp4h
         w8GqXM0f58HlpcU+GQuFUbotYI1aAja0p+jlgB0SULG3VURtO3kJ263ci5/Gkyu7Pshl
         t8A8QnWM9UtW4pCW+YDJqdoMcc+/EIxp3zyRdfbD9WwsEnJW/ddBLGIvHp2ReKigLrjO
         mflaN/Ri3bFmMx4XAFEAvxvP42GS5jL4NKLiuKXL0BWYgC9eNyL8rkcRzL9jQVLUH+f0
         C6Vj8yAKd4ZjUH6xzk5JGUuxHfe71uVGnVApDm8rPQKPcpM8WvdFlYFA7W7lTceI9iD+
         MqfQ==
X-Gm-Message-State: AGi0Pua2VDPPRVUghRqYHp4WAEM74pQdsrQQ/tOlLQ0wq3RdsiqpyaA4
        E6nQg2n5qAAXcgdzpbTWW6xQ0vU=
X-Google-Smtp-Source: APiQypIFT8rqGvjqADkH8en1FLZx6WHUeR1Segx7uCrAwUPEqXOjwNZMSvlbLghQDdSTnV3uisyFwA==
X-Received: by 2002:a92:8316:: with SMTP id f22mr1686531ild.169.1586463917475;
        Thu, 09 Apr 2020 13:25:17 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
        by smtp.googlemail.com with ESMTPSA id j2sm4724567ioq.13.2020.04.09.13.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 13:25:16 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: [PATCH] dt-bindings: hwmon: Fix incorrect $id paths
Date:   Thu,  9 Apr 2020 14:25:15 -0600
Message-Id: <20200409202516.25282-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the path warnings in the adi,axi-fan-control and adt7475 bindings:

Documentation/devicetree/bindings/hwmon/adt7475.yaml: $id:
  relative path/filename doesn't match actual path or filename
  expected: http://devicetree.org/schemas/hwmon/adt7475.yaml#
Documentation/devicetree/bindings/hwmon/adi,axi-fan-control.yaml: $id:
  relative path/filename doesn't match actual path or filename
  expected: http://devicetree.org/schemas/hwmon/adi,axi-fan-control.yaml#

Cc: "Nuno Sá" <nuno.sa@analog.com>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Will take this via the DT tree.

Rob

 .../devicetree/bindings/hwmon/adi,axi-fan-control.yaml          | 2 +-
 Documentation/devicetree/bindings/hwmon/adt7475.yaml            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/adi,axi-fan-control.yaml b/Documentation/devicetree/bindings/hwmon/adi,axi-fan-control.yaml
index 29bb2c778c59..7db78767c02d 100644
--- a/Documentation/devicetree/bindings/hwmon/adi,axi-fan-control.yaml
+++ b/Documentation/devicetree/bindings/hwmon/adi,axi-fan-control.yaml
@@ -2,7 +2,7 @@
 # Copyright 2019 Analog Devices Inc.
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/bindings/hwmon/adi,axi-fan-control.yaml#
+$id: http://devicetree.org/schemas/hwmon/adi,axi-fan-control.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Analog Devices AXI FAN Control Device Tree Bindings
diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.yaml b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
index 76985034ea73..46c441574f98 100644
--- a/Documentation/devicetree/bindings/hwmon/adt7475.yaml
+++ b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/adt7475.yaml#
+$id: http://devicetree.org/schemas/hwmon/adt7475.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: ADT7475 hwmon sensor
-- 
2.20.1

