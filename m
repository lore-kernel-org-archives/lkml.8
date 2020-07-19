Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7BCC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 02:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAD8B22BEB
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 02:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEksNnty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgGSCO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 22:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbgGSCO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 22:14:28 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFADC0619D2;
        Sat, 18 Jul 2020 19:14:27 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z13so14624281wrw.5;
        Sat, 18 Jul 2020 19:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GQcRfWfKvTiTGWJVDo12RjwKZPjrWsIntIaVCQbrSC8=;
        b=EEksNntyCoEPwQY3xYrBZWIzhKc83N3cgeGCMmSy6lWgOpmtTyaqdbZ8uSFaT8DMqS
         khuFZdI898/PNOK8pJvkJQgiGUDR4XJ/X9GcJyMqU5pDViSBJjVueJUBzq5+WnzeYg2Z
         EMeH3br7cED0PvsH8G3qdYz1OGlEW1oXeMFXiUYKd49x3TYDoqWj/CC6wYyl7ioFlbGY
         wA0XqXKZvGynUrcGiDKkxmjmCSPxM3iabJ0P9TyZrRUrayzt+aMNYzBAZfAQE0qDNYX5
         RzSLcUokWHaXGdhNApEBmvyuYP82CraQBm3fMR6oNuBhcnBJUWYiKFI1gXsCN2OsWAH9
         d5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GQcRfWfKvTiTGWJVDo12RjwKZPjrWsIntIaVCQbrSC8=;
        b=rOsx0FPFgrTwJcAYcSajGw1XhfgZ46aeSk7psV1PPJ9m1SMCJca9QwWLVP+m7/fP9b
         5fjZ2rZfnVIWBe6Wcu6DO2kKuwUMOsmRAMTx7Mg5e/Nin6elS6FheObilSim7eown7zj
         3URTChPn3jE/SZ/mkWG41UoeVqhwAWstVSYSJb0Zp3XXA8OrBEaclnTYc3Ji3R5eI/hH
         vmb9hALdChUBsK00cc/5na2wz8YKWVxgRrqxeVsozj+K7ESEpQieY/vPtpoekUwbpUpH
         bInpzlxd7NQvv5Li8ub+ee9i4/iusMME/xdyK3GlKfClvhrrYCLwHPaWenexKYU7Kz4I
         RX+A==
X-Gm-Message-State: AOAM5324V/cXTHUdx3tANxXhA4xmw+yj6OZzGHu4pUx0SNTAmVPVqciq
        M2FG4VslyYl+Dfh0VaqJMko=
X-Google-Smtp-Source: ABdhPJywyrLKgJdRmHbXz3zHbMTBO4eBr791eYA8Ju6itSElwwx3fccwDoLOJ7ETLMkFW7guWQR+oQ==
X-Received: by 2002:adf:f18c:: with SMTP id h12mr15744657wro.375.1595124866592;
        Sat, 18 Jul 2020 19:14:26 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id v15sm22078103wmh.24.2020.07.18.19.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 19:14:26 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v3 0/2] arm64: dts: meson: add support for WeTek Core 2
Date:   Sun, 19 Jul 2020 02:14:19 +0000
Message-Id: <20200719021421.7959-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chewitt <christianshewitt@gmail.com>

This series adds support for the WeTek Core 2 which is a commercial box
device based on the Amlogic Q200 reference design.

v3 changes - fix BT node (enable-gpios > shutdown-gpios)
v2 changes - simplify ethernet disable

Christian Hewitt (2):
  dt-bindings: arm: amlogic: add support for the WeTek Core 2
  arm64: dts: meson: add support for the WeTek Core 2

 .../devicetree/bindings/arm/amlogic.yaml      |  1 +
 arch/arm64/boot/dts/amlogic/Makefile          |  1 +
 .../dts/amlogic/meson-gxm-wetek-core2.dts     | 87 +++++++++++++++++++
 3 files changed, 89 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxm-wetek-core2.dts

-- 
2.17.1

