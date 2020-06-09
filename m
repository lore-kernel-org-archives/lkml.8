Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A55C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 11:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1100D206A4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 11:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azF6Vfnh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbgFILbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 07:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728751AbgFILaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 07:30:55 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314A5C03E97C;
        Tue,  9 Jun 2020 04:30:54 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id d128so2766457wmc.1;
        Tue, 09 Jun 2020 04:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yy4JjAM/LNQUkdhG6q2NqktsnyMuS7R2bxPf6ltadH8=;
        b=azF6VfnhsJHJT1e35i7AmkkR1X2cDfTKd6MHcFYqf/qUjeev+9u82kcN9eawn8jiiF
         q/Is5S6qXNBren7aTwal86Gf7L1zXFP28946on9rlvWl3ogAqmdhGxa8bHGMxhNvSXxl
         jX1oDNxlVK4oKte7FVO7RGbrXSpDfrWdyyCS4C3UU9FHOd7NhOez8HMHVfIVvsai2wR3
         jC9A2DY8DxTGoPqxO2HcJSnZmYcPWu4C7/JoVXl1lHUM0/+y0nbDiDucKZtB1IDTjw2b
         ZkWRYx8nM79zA7me3G2dhgE2WRoJYzkcc9Wm10gVr45e6eLwC1p2MYDWiindGsq8NByu
         a5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yy4JjAM/LNQUkdhG6q2NqktsnyMuS7R2bxPf6ltadH8=;
        b=SfJGOz5k0U9nfH1bn5y/AeE1FAMHfENJZe34HekMKKtvmKJeoKYRollVv73e1jQTm3
         uVVXpt/S/qX1q2Dscv/rnVVmiKbbW+GvaG5mmsOnDl3ojArmIyS1o3iv5oWNdCwKstrM
         W419pKuZwRrwNLzkYDb78umPCwoUutq35RYZ3FVsBgGjxC/tBuqMe7JGTKJNvP0onh6P
         IjOg20/923M35Sgy6Gl0+ze0Lzi4CI1OYQp5HiW7WFBWvOpaQpjzZMtgnn24lGTT9ZpD
         eij8IfKs0cH39Qt8sqN53kr6UOu+MB+OzhBGdiJhyCUH8DXmPWG6gkXoVfuTNcQxFBHv
         s4vQ==
X-Gm-Message-State: AOAM530btvs/dQlMzBvT2oF8v0EcIY7+fcMIhH9X96leumeP5imToFib
        4R2HAFrYB+3HtYrKSJ3EyRc=
X-Google-Smtp-Source: ABdhPJwgOwYWVxCRIFZyDVpp/3Ltf1xyv6s08mDUomBXORtNf6+789YJJr+23ZBxBu5gy5UoNBXKXA==
X-Received: by 2002:a1c:a5ce:: with SMTP id o197mr3640140wme.85.1591702253380;
        Tue, 09 Jun 2020 04:30:53 -0700 (PDT)
Received: from skynet.lan (28.red-83-49-61.dynamicip.rima-tde.net. [83.49.61.28])
        by smtp.gmail.com with ESMTPSA id l17sm2609877wmi.16.2020.06.09.04.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 04:30:52 -0700 (PDT)
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
Subject: [PATCH 1/2] dt-bindings: clock: bcm63xx: add 6318 gated clock bindings
Date:   Tue,  9 Jun 2020 13:30:48 +0200
Message-Id: <20200609113049.4035426-2-noltari@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200609113049.4035426-1-noltari@gmail.com>
References: <20200609113049.4035426-1-noltari@gmail.com>
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
---
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

