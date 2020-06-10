Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1612EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 14:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBC302067B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 14:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/cyVJ4Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbgFJOJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 10:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgFJOJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 10:09:06 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F766C03E96B;
        Wed, 10 Jun 2020 07:09:05 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l26so1962896wme.3;
        Wed, 10 Jun 2020 07:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pMPJ8f8LChSPkdPooyh4RsFj9EOeSp3oUeZluBwwX8c=;
        b=T/cyVJ4Z2J50EBzY3piRR2JqYaGO+5YMzh5JukaRwmj9/vmde+DoUG7gkz7Jw6e89d
         hEp6lCrhFrTbgWGfgLYuPG3Pu61wYIKuYKX+8MkHnZeEx1ieZtuTamv0jO3V+Ctj+sg8
         ubstY9R7nS4O10MPmgmJGXWHCph6Mvtk2+Ab3ybVCG0BH5s6gNIE7SbJBa87qIq00gH+
         QZaP/lZNYc+HT1UnCKE04k69sU6xBUFsQ+h/4h9856nFZEv48GoT+0ywtCbUtJTkTkoB
         MYttsTl88DQ5kthn05LG1cb0rRu7lnHXfWxtIMm1AIu6ZLmrn8mdWt3jLcx6WqtSv+pu
         mTqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pMPJ8f8LChSPkdPooyh4RsFj9EOeSp3oUeZluBwwX8c=;
        b=uTgofD7evn8XoGAwg7Q9prgz4LPxXW/1Ha31B1SjzhcX4ROECBdb4WFhFZTgdSDYar
         g8bXeYo7fsk24WXpvAiCcqjT4wMYO0xwuVO7PnVTtIS+XP9M0k6/AgneGTvQ6mbm7gC4
         HfcXD4dU5p7Z0mVgqZt8bpYlr60cxGT56cv6BeSO8ynaopYQBjsqs/8GqVESJxcZB7et
         F/pOKwMDxmQz6RFH6GcLp13EgyXNPcPbhjbi5QF8oULiQV6hzYUYuRggNaFkpPI6YkJ2
         ui9YXImXhDaVSvQBMbLqd5kYvAhe+B98qvmnZzEysmIRJl6Nxg5XUJK+V45LBRXigH3v
         iP3A==
X-Gm-Message-State: AOAM533gzOc8L9J+cZ3LXMKYol16yhzw2K9qjtVPyvbtN5VzDfClpDpl
        6CPEW8eFFy/xk2zQhog5qiA=
X-Google-Smtp-Source: ABdhPJwMPKaGnz6FcYNR7C26Og4qDAnCm7k4AKe7Nx63tf1BbhLfiMQ+osnTYL4ccoQwwbt71W+pLg==
X-Received: by 2002:a1c:5683:: with SMTP id k125mr3574271wmb.55.1591798143407;
        Wed, 10 Jun 2020 07:09:03 -0700 (PDT)
Received: from skynet.lan (28.red-83-49-61.dynamicip.rima-tde.net. [83.49.61.28])
        by smtp.gmail.com with ESMTPSA id r5sm8565883wrq.0.2020.06.10.07.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 07:09:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        julia.lawall@lip6.fr, f4bug@amsat.org, jonas.gorski@gmail.com,
        lkp@intel.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: clock: bcm63xx: add 6318 gated clock bindings
Date:   Wed, 10 Jun 2020 16:08:57 +0200
Message-Id: <20200610140858.207329-2-noltari@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610140858.207329-1-noltari@gmail.com>
References: <20200609113049.4035426-1-noltari@gmail.com>
 <20200610140858.207329-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add BCM6318 to the binding documentation for the gated clock controllers found
on BCM63xx SoCs.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
 v2: no changes.

 Documentation/devicetree/bindings/clock/brcm,bcm63xx-clocks.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/brcm,bcm63xx-clocks.txt b/Documentation/devicetree/bindings/clock/brcm,bcm63xx-clocks.txt
index 3041657e2f96..3e7ca5530775 100644
--- a/Documentation/devicetree/bindings/clock/brcm,bcm63xx-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/brcm,bcm63xx-clocks.txt
@@ -3,6 +3,8 @@ Gated Clock Controller Bindings for MIPS based BCM63XX SoCs
 Required properties:
 - compatible: must be one of:
 	 "brcm,bcm3368-clocks"
+	 "brcm,bcm6318-clocks"
+	 "brcm,bcm6318-ubus-clocks"
 	 "brcm,bcm6328-clocks"
 	 "brcm,bcm6358-clocks"
 	 "brcm,bcm6362-clocks"
-- 
2.26.2

