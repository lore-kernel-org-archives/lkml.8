Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C14C3F2D8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 14:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B86207FD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 14:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kta2qzw1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgCEOgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 09:36:24 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53573 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgCEOgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 09:36:23 -0500
Received: by mail-wm1-f65.google.com with SMTP id g134so6572340wme.3;
        Thu, 05 Mar 2020 06:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uFpuBBMUDRGLySlw2LJfDDLm6H8b76IieodfF2vnzXM=;
        b=Kta2qzw1d1E8RvneBZj8HMEMVqounDkPjTu1e2EkWI3hjdVg+nSI/vQLcrDc+bsK25
         hpT8OWlYEh7M3lyAmx4iyVg1RUyJyQAYqvkIhYsqjUxrddniWhdn2c0wGNr5K2pIWsZV
         MXm3KAcY/SKN+i6GfwPeI+j0+rA1OvGRv/3tv3ZlFk3sZNajlYcgR0SleOPh6+gDWp7k
         OcFSjN8xHJVMMbazkB0XWWr5RwAcmX7B+PKmrpXoFyr1buGIzVo8ZhgeqiHmdk9NOc81
         rb+b/Q0CliAZ7VUoRLF+U9a6K1rI1kNWBmG1ZqVd1TNna6tnzJePbz0xS7glMqXTkon3
         Dnsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uFpuBBMUDRGLySlw2LJfDDLm6H8b76IieodfF2vnzXM=;
        b=aWGwsem2eQELgESBKq44/+jM9oF5t2oOclTCBNkm9Lh70afeRMusXRQhoDs9cR5Jb1
         5sDpekpBdzj/f+MPeMt5DdjlNrnmE4kHzjDzQ+roZVWXVHIx7PUR5mBqkU5TWRDK1eGL
         T3ODgwuxmeGBwo/MmxfBcecCMYVJYmtsSux82aW0+EKTd6tjKvBuh+bmnoZa+9+nIqz+
         7rx14XePqDMzWaVsDvYuPhJU1zQyU63bDYKMFutfo9oSFVKAvcu4bCD2pqJq3EU5RNLC
         P/p+EPfJUzSBKMLw5UDa8x8qlQmXALIsR5MKuVsg67+v4xB4/8xzAeGnlm11kkyeWgxr
         hQhA==
X-Gm-Message-State: ANhLgQ1+TgYE009YfTSNfRoBK3z/zM3wh6qKR3Z+SxA1IAdkOJ5MSZSH
        2v3X+5qmLAMQzVCrgHDmuBM=
X-Google-Smtp-Source: ADFU+vvsmmrg7ZLun9VSaqp5UjO/yXs+1arXJoFVq6y39FuhkgNuvHyEwjKoto903tolYaS7Zcpzxw==
X-Received: by 2002:a1c:9602:: with SMTP id y2mr9742694wmd.23.1583418981555;
        Thu, 05 Mar 2020 06:36:21 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id g201sm9365124wme.23.2020.03.05.06.36.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2020 06:36:20 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/5] dt-bindings: i2c: i2c-rk3x: add description for rk3036
Date:   Thu,  5 Mar 2020 15:36:08 +0100
Message-Id: <20200305143611.10733-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200305143611.10733-1-jbx6244@gmail.com>
References: <20200305143611.10733-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The description below is already in use for rk3036.dtsi,
but was somehow never added to a document, so add
"rockchip,rk3036-i2c", "rockchip,rk3288-i2c"
for i2c nodes on a rk3036 platform to i2c-rk3x.yaml.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml b/Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml
index 962aefb7d..0bba39998 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml
+++ b/Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml
@@ -28,6 +28,10 @@ properties:
       - const: rockchip,rk3399-i2c
       - items:
           - enum:
+            - rockchip,rk3036-i2c
+          - const: rockchip,rk3288-i2c
+      - items:
+          - enum:
             - rockchip,rk3328-i2c
           - const: rockchip,rk3399-i2c
 
-- 
2.11.0

