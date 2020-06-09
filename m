Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24F9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 11:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEE2C20812
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 11:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsdiY8jl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbgFILbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 07:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbgFILaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 07:30:55 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B97AC05BD1E;
        Tue,  9 Jun 2020 04:30:54 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k26so2752289wmi.4;
        Tue, 09 Jun 2020 04:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3F1gyxKHBurPb/9ok1v4N24kKX2n+9TWOucrfqchLWY=;
        b=ZsdiY8jl9Jpr1ldvwxYtPVPzIrdk/uVXvx/XPB+EuuPnl0iddkOfSg0IUeV5UH8eoo
         NmfYAGbAplHnt+r3whiyBk9EOsX9cxEoE8cTAJ2hTKrTuqTY8W7jH0LF9lR+DuBpBD92
         ld1KYmLUXdkiG5wGYIwCherT87jGlh49f/3U2Ssz4kags6S8WZ/YLo+aA1BLb/26lY55
         38VUTBcFJ7IEqwxRSv9Lw0EhFZusZmL3Tj3nSBO5BiOVvvOgsbOYz3+PlUY9P4NZF6AD
         YkfgPixw3NQ5Fs8dz4Qt8eDrEPJdIdi1iWzyMC0rNuHpFRbp5QAXkloDKTv2EwDL3oJt
         Zn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3F1gyxKHBurPb/9ok1v4N24kKX2n+9TWOucrfqchLWY=;
        b=j8yq7MrdBXQqsnyNTaJA/4z3Q6R63Ke12IuyWxgT2a35uLkPWQlwbU4kkJHpo0xd8u
         m1TpIdE6/qpUOphJ2jfe2XrXKOEEyoz9WAhvMI4pJzMvY+tt+t2jKcP2OWkGAtXWvgsp
         ofSjpP0yl0m0qNIibmTXGaVYZRqqnn7L5EsL8/fyVLf+r6SzAb2lwfY61NQl/bCVplUU
         n8BOUyCt0aeN8IliKC/suGnbE/1uD3Oqj17TtfbiqiyuqQryu7T1+bMXezjyEysoyChg
         XC0VPqyDVlFGUfnwwtwMUBbadPKN9y+tEIctN7nVyY5pUefWV+NSsuLPo5Wx5K7LgZ2m
         5aNQ==
X-Gm-Message-State: AOAM530kTIwURjIt0qs71t1pNrBdmJCWguJC1cld+oNEGC+7RX1CkWSW
        Koh/po3NqIpHRFdytbuDifM=
X-Google-Smtp-Source: ABdhPJzB5erSGFbNCwsaeqvVH5GDJoZV986EhUW8/5DtXC+UWnt8VGsHXea24ldhT44j5dfcYPiKgg==
X-Received: by 2002:a1c:7305:: with SMTP id d5mr3634968wmb.85.1591702252324;
        Tue, 09 Jun 2020 04:30:52 -0700 (PDT)
Received: from skynet.lan (28.red-83-49-61.dynamicip.rima-tde.net. [83.49.61.28])
        by smtp.gmail.com with ESMTPSA id l17sm2609877wmi.16.2020.06.09.04.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 04:30:51 -0700 (PDT)
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
Subject: [PATCH 0/2] clk: bcm63xx-gate: add BCM6318 support
Date:   Tue,  9 Jun 2020 13:30:47 +0200
Message-Id: <20200609113049.4035426-1-noltari@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the gated clock controllers found on the BCM6318.

Álvaro Fernández Rojas (2):
  dt-bindings: clock: bcm63xx: add 6318 gated clock bindings
  clk: bcm63xx-gate: add BCM6318 support

 .../bindings/clock/brcm,bcm63xx-clocks.txt    |  2 +
 drivers/clk/bcm/clk-bcm63xx-gate.c            | 44 +++++++++++++++++++
 2 files changed, 46 insertions(+)

-- 
2.26.2

