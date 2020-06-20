Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE565C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 16:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8142C20CC7
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 16:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="S0YC3KV8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgFTQKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 12:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgFTQKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 12:10:20 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66462C06174E
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 09:10:20 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id l27so13584523ejc.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 09:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P39RlTWkw0BHM8mvqJKNvOXDRAeGzZyejrciSa95gwM=;
        b=S0YC3KV8a2NBmYIMxO/n6t0meIE0bdqVX4U2CvoxhupjcRUtIFT2Kp3BoI81jxfcvn
         JCg9Z/PiBNwImI+ZyByV4vDaA9Yymz6kIxbJhF93pD6jfgDiXGdUvoMJ/DbRGVYo6ND3
         Eq2nz+Gncg+1hQf0e1Tav5JW/8Alvs1ooV1WaA4vH3PbubgzSwYsSPdM5bGCL1SiPXgc
         vkmjXdXS9WAxj/VFkiNjR1Ce7dBIlRsHIKddcDOledogCU09HkK6ueLorYD5JaQtSV0O
         YoDg8Tlxq57u1KPWzeiWUYVgAfD3ty98eXggAkO0zi7RVFsXKSJJvZ7Mn4NGa0SnUZjq
         XxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P39RlTWkw0BHM8mvqJKNvOXDRAeGzZyejrciSa95gwM=;
        b=Lbe3TJkkI5tpgHdxUC/Nmr1sBrw/rFgpagpuyjVToSTnGHII2VHZoASRmB5H/vyLYY
         FoqHtz/JPfiTU2oEdqeFUSlRcMPR7IobGGvptI9E4lqwL94NzKjN2oKJu6lyCP0g3TtN
         E9JnJjAVMTqjgupnl7VL3yjVRD2Ug1LW+cRR40zBt8ates7ASmenu1XAlW6EHXmqgxwk
         EoeUifQzZKc5EIecoX78NL9yKFilbuQ+DXIPKgGPHIg11sTUGcEY47gxTaacou8G6/8x
         HtRq2r5JJHF1w6wyf7FNkoMZake+C+JW5UU6wmvzmkXqIiCq/Pgg8Z6/a5T4i35nmLvQ
         KwBw==
X-Gm-Message-State: AOAM530kFx7D85A51uS/4lJKcJpVICpzrKwywuKjxkgo2RrCG/yisw3f
        bomzrlVeTaDYtyBlcZhYuuA=
X-Google-Smtp-Source: ABdhPJyy+F5IG38rKAwE7wgt+OOCiPnNkSne3o6MVgOnxyeTGTDzrvCAYL9G35mP5uc1iM6vLD3+sg==
X-Received: by 2002:a17:906:2a94:: with SMTP id l20mr8259553eje.224.1592669419143;
        Sat, 20 Jun 2020 09:10:19 -0700 (PDT)
Received: from localhost.localdomain (p200300f1371df700428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:371d:f700:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id a62sm8033207edf.38.2020.06.20.09.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 09:10:18 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/3] ARM: dts: wire up the power domains on Meson8/8b/8m2
Date:   Sat, 20 Jun 2020 18:10:07 +0200
Message-Id: <20200620161010.23171-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the meson-ee-pwrc driver has gained support for the power
domains on Meson8/Meson8b/Meson8m2 we can add it to the corresponding
.dtsi files.

So far this doesn't fix (or break) anything for me (probably because all
vendor u-boots are enabling the Ethernet power domains unconditionally).
But at least it's one preparation step which is needed for video output
in the future.


Martin Blumenstingl (3):
  ARM: dts: meson8: add power domain controller
  ARM: dts: meson8m2: add resets for the power domain controller
  ARM: dts: meson8b: add power domain controller

 arch/arm/boot/dts/meson8.dtsi   | 13 +++++++++++++
 arch/arm/boot/dts/meson8b.dtsi  | 27 +++++++++++++++++++++++++++
 arch/arm/boot/dts/meson8m2.dtsi | 19 +++++++++++++++++++
 3 files changed, 59 insertions(+)

-- 
2.27.0

