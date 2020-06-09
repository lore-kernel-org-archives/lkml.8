Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B897C433E3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 16:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 373A42072F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 16:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pGzihiN0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731106AbgFIQC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 12:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731044AbgFIQCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 12:02:48 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889AEC05BD1E;
        Tue,  9 Jun 2020 09:02:48 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x14so21924618wrp.2;
        Tue, 09 Jun 2020 09:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9BF0B66og3mKkYmP1R3gRfiA45BkaeDYJbhzrOGghEg=;
        b=pGzihiN0IbaQ5vVwczBJWn/D1/P4ShawaDUuAZAR8YrBw7OUF4AsFwN5W2tEqcjXvp
         YPm3MpXgEga2bOTd+FcE/OIRNjZAFSS5Ec6cgS7LZaw/I0QatUgE56OgqrRQhJYndNuA
         4bkiVr6ELkySZlSruLirD+IiVFRjEsq6r6Pj4zB+bonEzyO83BdBQDlwujjwIBrtZZ/i
         8QihvoRdOzR3G4xaYuV4TadvTHI9aaK2pJiaf2xh7wyHepjwwW3QLso5q3XRUu9cE63x
         LfPKPfnYP9+ZYaT/mU6ZZqRr0q7lwOSl5T/JRKC4Y3UQRTT5AvgCnH2Y3LmBn3bquvnt
         RjYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9BF0B66og3mKkYmP1R3gRfiA45BkaeDYJbhzrOGghEg=;
        b=PgX+7D8Q5RC2LeNHDC/10xZntt2axZT/jPoldNp/g5DJLSfNn6SkF0G1/3S3YWnSVL
         5fzjJnDPsjvafLI7qwGSAjgKIOTyZ+Nupcd0kEh4+xEfY+rgSWz00O8XkHOmT68W/Ys/
         i4Xzuipg1qchqhLpJioVnnU68znJF5/6JVt2t9z1KbURkDh3c3wqi4EyrZNNp408g7zK
         xsZ5u5vMYx1UQWztoNtyCqd6erTOkKhLB/UJdWhgy8OqWzStnVPvdHInF52UDrvWV18j
         6KpoThUr9mRS1AeaajikZ8kUVsOjqqEksNRBf6OR5vy/jF5e6E4Gi0l+Xp/NNnmpZ0VJ
         tFiQ==
X-Gm-Message-State: AOAM5324WxKtf+VfcKXvIgPLNQMHs6Sh8LLQnvGf2XTCoXVJK/QvKbfM
        2VIpGO68vO3TV7fc6hJO/xo=
X-Google-Smtp-Source: ABdhPJyUjjP0FIdAqdEI8G6GrVG+4oNcj0zVPzWuiugKPS0UgZHDwYDW2fGmfkbkFz2MYsj0Z/918A==
X-Received: by 2002:a5d:4e81:: with SMTP id e1mr5296601wru.83.1591718567211;
        Tue, 09 Jun 2020 09:02:47 -0700 (PDT)
Received: from skynet.lan (28.red-83-49-61.dynamicip.rima-tde.net. [83.49.61.28])
        by smtp.gmail.com with ESMTPSA id y14sm3341864wma.25.2020.06.09.09.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 09:02:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org,
        tsbogend@alpha.franken.de, f.fainelli@gmail.com,
        jonas.gorski@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v2 0/7] bmips: add bcm6345 reset controller support
Date:   Tue,  9 Jun 2020 18:02:37 +0200
Message-Id: <20200609160244.4139366-1-noltari@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200609134232.4084718-1-noltari@gmail.com>
References: <20200609134232.4084718-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BCM63xx SoCs have a reset controller for certain components.

v2: add compatibility to reset-simple instead of adding a new driver.

Álvaro Fernández Rojas (7):
  mips: bmips: select ARCH_HAS_RESET_CONTROLLER
  dt-bindings: reset: add BCM6345 reset controller bindings
  drivers: reset: simple: add BCM6345 reset support
  mips: bmips: dts: add BCM6328 reset controller support
  mips: bmips: dts: add BCM6358 reset controller support
  mips: bmips: dts: add BCM6362 reset controller support
  mips: bmips: dts: add BCM6368 reset controller support

 .../bindings/reset/brcm,bcm6345-reset.yaml    | 37 +++++++++++++++++++
 arch/mips/Kconfig                             |  1 +
 arch/mips/boot/dts/brcm/bcm6328.dtsi          |  6 +++
 arch/mips/boot/dts/brcm/bcm6358.dtsi          |  6 +++
 arch/mips/boot/dts/brcm/bcm6362.dtsi          |  6 +++
 arch/mips/boot/dts/brcm/bcm6368.dtsi          |  6 +++
 drivers/reset/Kconfig                         |  3 +-
 drivers/reset/reset-simple.c                  |  1 +
 8 files changed, 65 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/reset/brcm,bcm6345-reset.yaml

-- 
2.26.2

