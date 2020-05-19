Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA9AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 07:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D39120709
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 07:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsmEzMAS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgESHc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 03:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgESHc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 03:32:29 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB57C061A0C;
        Tue, 19 May 2020 00:32:29 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k19so5250032pll.9;
        Tue, 19 May 2020 00:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pWX1G4tWEShSf5SKh14rOfDdQ9RRQZCXQI6jij52Ttg=;
        b=JsmEzMAS6LO4LvcW4zA7f78IImr0omcCJTEaIR1EN4hQFQFKlnZArVaZrPHuEugzNN
         NyCG/2XyodILh1L182S6d602lXHdP4jxf1Eo7egb+C6fXWfWDFN4Jcv/V2Pds2cVj51s
         cZM4TyGu7RaMr5Fado8GjUtTkpvbsNR3NykhRlFF/tYMYeXRFfTis/CzMfEfwoMXR323
         WNI5j17UWtveDghQDhts4l5vucNVVBmK6JryVXUXcF1A2OtT+HUMPyvpNfv3j0QuJ9Da
         YZmqw2zLl5kKQGpACVAOBlTz3Exp984Iu3uqfDb4VRrcbE4LYeImwg9C5A4LDo2x8jOU
         BdEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pWX1G4tWEShSf5SKh14rOfDdQ9RRQZCXQI6jij52Ttg=;
        b=fc2gs0ELkqZ1HE3X6J1Wrr4NiRafwIrZy/lTNxvnt0qvZ07A31Y9nVbVqqDJrWoOhc
         OFZoS+fSITzB9ZfFN6w0pa1ed1P1DyjMHuYtbTlkebeXvNFly1wMTgh693i0hopkBTsJ
         I54ApGf1ogQ9JnKpaTRWjjUDMhf2u/B5qcKJaVLdLQCUxRePbPhRQSW4pVwArt0uzAXU
         BRjjJPz8XR3pT1pqnJCkwpnyc/bvbnhaTZx6zQ9qf6lwkZNDb8+dqbPgWFvBZt6x66oC
         81bQ8mbGmq//hDJlAPX2LZeLBWMDYKHPejEWo1SSaNw7oaZBuEGN4XEAvjL03iaCe4Vr
         WKjw==
X-Gm-Message-State: AOAM530KOn+ywtp9cco4NNFL1aG15qttQcTW5DRuUfYHLfj3hD4eKVlg
        jWG5FZ1s99AIIm8MkHOageqsBIyhANw=
X-Google-Smtp-Source: ABdhPJxYQvFg0wsKLhP4JEWJ7TlPcYJSgxzfvOmYQnLlX7NYySQy5KZVJcq+300rYVFLUJM9Hl9SFQ==
X-Received: by 2002:a17:902:7402:: with SMTP id g2mr20402026pll.241.1589873548595;
        Tue, 19 May 2020 00:32:28 -0700 (PDT)
Received: from pr0gr4m-ubuntu.localdomain ([1.240.193.107])
        by smtp.googlemail.com with ESMTPSA id m9sm9377920pgd.1.2020.05.19.00.32.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2020 00:32:27 -0700 (PDT)
From:   Kangmin Park <l4stpr0gr4m@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: spi: ti_qspi.txt: fix unit address
Date:   Tue, 19 May 2020 16:32:21 +0900
Message-Id: <1589873541-5587-1-git-send-email-l4stpr0gr4m@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix unit address to match the first address specified in the reg
property of the node in example.

Signed-off-by: Kangmin Park <l4stpr0gr4m@gmail.com>
---
 Documentation/devicetree/bindings/spi/ti_qspi.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/ti_qspi.txt b/Documentation/devicetree/bindings/spi/ti_qspi.txt
index e65fde4..47b184b 100644
--- a/Documentation/devicetree/bindings/spi/ti_qspi.txt
+++ b/Documentation/devicetree/bindings/spi/ti_qspi.txt
@@ -29,7 +29,7 @@ modification to bootloader.
 Example:
 
 For am4372:
-qspi: qspi@4b300000 {
+qspi: qspi@47900000 {
 	compatible = "ti,am4372-qspi";
 	reg = <0x47900000 0x100>, <0x30000000 0x4000000>;
 	reg-names = "qspi_base", "qspi_mmap";
-- 
2.7.4

