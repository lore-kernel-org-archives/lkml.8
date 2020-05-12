Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8A0C2D0F8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 21:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0390B20731
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 21:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="UMQdEEEn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731398AbgELVv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 17:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728313AbgELVv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 17:51:57 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCF3C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 14:51:57 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y3so17907790wrt.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 14:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6CrrHw2+5KWDhy3iiVXXbeJ0AsJcDeTot0gYMePzQBM=;
        b=UMQdEEEnDl8gTCVzl+ax4sDJdZbejUYeFdm0NXpvGzq7TPcWLqKL4wwxVSMNDy2K0J
         lqcgQLDp3O8W+5koPS9FNU0VNuz+P2dCb/xLkljphQyq41BwKPQUXrrG11m/uOWaN2ye
         r1WgJP1ieZJ8jcvGNI8hK2HSTAf3U2kAwycdiHV8foPiJ1sbpD8CGPNRbCCaGuAJd4Mx
         kYbBI+4uDB0rTzrGAgqK4Jjk7l0NtWVAS4TU64hwZaqve2C6fTBPtSE+8ssXrq3s5IlC
         QKmsym87IKL+ZaeP5M6tfIjowxKhLqn5+ChRsuEu5OUZj/f0QhCPu3DYYZKQgXpLW24r
         j5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6CrrHw2+5KWDhy3iiVXXbeJ0AsJcDeTot0gYMePzQBM=;
        b=mdvNIglYIa8Rig0Hz3W6llRSQY6UWXcibKmk0wEiOIwX0e2qUwpG3JN9d01dp3R5rg
         iN6M20JqMjDOYH1QKnHm2lGTv2ac8960aNuy056ZCWs/CdtAp7nnDGjFWCuQh5HNISos
         03OSTGpzFJJ/x0010WvzJ2HYHhFoc1wSyiDavbe1fMuBHau/cwNdqIxYpsSBLpCZkl2R
         KvTkxELe9fEluKQiyCcYEt1zNLjdVGVtXjCi/CSNhz8VU0ANHNWwuw0oj4WTIKFc+Trs
         U1hI25eaZ1zwNrPf57S+CB6xxoEif4ZhVoiOgl18aPX9ZdxVPvajoovcp4dSKh0ArvVu
         P4qw==
X-Gm-Message-State: AGi0PuZYVmo+JCxQNtq8RlVPhy886+Wre0B3z7dhm033a/RNYIsGQCFx
        HsZcaGwuNCWP8lhMKGykonU=
X-Google-Smtp-Source: APiQypKNwrLxB/fB1Wzqappr40dMluVL/cCeENBj+MZBO20q6ZX7Q1C1L7w9YtBXmRqWpfe/dQ1kvA==
X-Received: by 2002:a5d:5710:: with SMTP id a16mr18085669wrv.209.1589320316098;
        Tue, 12 May 2020 14:51:56 -0700 (PDT)
Received: from localhost.localdomain (p200300F137132E00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3713:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id d9sm9154234wmd.10.2020.05.12.14.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 14:51:55 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        andrew@lunn.ch,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/2] ARM: dts: meson8b/m2: RGMII improvements
Date:   Tue, 12 May 2020 23:51:46 +0200
Message-Id: <20200512215148.540322-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

the fist patch in this series connects FCLK_DIV2 to the PRG_ETH
"additional" registers for the dwmac Ethernet controller.
Now that we know how RGMII and FCLK_DIV2 are connected we can
add this dependency to get rid of CLK_IS_CRITICAL for FCLK_DIV2
at some point.

The second patch fixes the RX and TX delay. The 4ns TX delay which
we have used so far is incorrect and only worked because we were
using an unsupported clock divider in the PRG_ETH registers. That
divider has been fixed with commit bd6f48546b9c ("net: stmmac:
dwmac-meson8b: Fix the RGMII TX delay on Meson8b/8m2 SoCs").
Instead of "just" fixing the TX delay we can even do better and
switch to phy-mode = "rgmii-id" to let the PHY generate the RX
and TX delay. However, previously we didn't know that there was
an RX delay applied by the MAC on these boards. Only the additional
information from Jianxin in the other series [0] made us aware
of this. Without the other series there will be a 4ns RX delay
(2ns from the MAC and additional 2ns from the PHY). Due to this
dependency I did not add a Fixes tag, because backporting these
.dts patches without their runtime dependency will break stable
kernels.

TL;DR:
Ethernet TX throughput on my Odroid-C1 improved from <200Mbit/s
to >700Mbit/s (measured with iperf3)


Dependencies:
This series has a runtime dependency on v7 of the series called
"dwmac-meson8b Ethernet RX delay configuration" [0]


[0] https://patchwork.kernel.org/cover/11543997/


Martin Blumenstingl (2):
  ARM: dts: meson: Add the Ethernet "timing-adjustment" clock
  ARM: dts: meson: Switch existing boards with RGMII PHY to "rgmii-id"

 arch/arm/boot/dts/meson8b-odroidc1.dts    | 3 +--
 arch/arm/boot/dts/meson8b.dtsi            | 5 +++--
 arch/arm/boot/dts/meson8m2-mxiii-plus.dts | 4 +---
 arch/arm/boot/dts/meson8m2.dtsi           | 5 +++--
 4 files changed, 8 insertions(+), 9 deletions(-)

-- 
2.26.2

