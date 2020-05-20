Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F295FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0DB520826
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Gqo34c3m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbgETAHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 20:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728375AbgETAHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 20:07:53 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A7FC061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 17:07:53 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z1so705128pfn.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 17:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nLMfwQbrlF1iv4LcSoROIabrcfKs0/jUzCRJPsjpM/g=;
        b=Gqo34c3m0MlNoFL+YXBmISvMCjL1uAr1dCIk+C2xcHpi/NSgJAkMkbIB54SVo3iPr2
         HaZgzNyTF1lmEeD7MvMTZmyASk+yYU+KRNjjuLz/gkNyajNTTMpy+westprggwgYHgeu
         H18O/XFDeMrrZ83+TekriuOSfUOKTYo0bQjBP5XEEJhAzPLW0eDyNm1lAycXCLgPH4my
         5OkzNS9XRiDor39MYDWxeHHIJeNebLJIzM8O/UVe8sZHS6hWPl2jBe+/MjLVYqVeFwWD
         C1Qm8oJgZQMAeE32cJMZ0614HbLkp4WCrD4CJKa70EWir5uchhrv0+WONADhNEGNEUXk
         QOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nLMfwQbrlF1iv4LcSoROIabrcfKs0/jUzCRJPsjpM/g=;
        b=NyJFCWnqLhJldjvyr6HdrhtL+8pKX66cH547IVYfR+1XiBB8Vd7pbSmMdQGWErKYyK
         38V051OD4mfSbJDO4jC6nm9JjPRu6umFhdQtHO/nIdRVJMvlkLb2sJQbYyGpOO4vuYb7
         +KCh69ZCPG0cEKp2CvolUyZkMLRoINaI44Nt//cS81jJj95zrOVHebIUrB8GN0QOirFu
         CcsWo2Yy3P998nqcWkNPhiCSK3QpZPQxaCURMlJeBt2IVS6WHYO+4aesR9n9D9i8E7tg
         xLnM0ITnXiACLWLmyryMvlDcgFkx0bZvh8rb3Uniisrn6o615Xg4G97MeF1CjKnE5K9m
         8jhQ==
X-Gm-Message-State: AOAM53030Zw+XO6lJ9Fq661VtM7SDhj8GhJSklF5u4jQ0iNtBkty/Nz5
        o6XWoBrn/aGxb1S85/w3qLpcEmP//x2Qzw==
X-Google-Smtp-Source: ABdhPJzsFZRQ9C+8oILR+S4MtBFIKYd2qCmva0PiBVlgTEiaWCLW5r8plQBhSkfJpMmL9SFle7gCyA==
X-Received: by 2002:a63:7519:: with SMTP id q25mr1555590pgc.224.1589933272730;
        Tue, 19 May 2020 17:07:52 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id go14sm504705pjb.42.2020.05.19.17.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 17:07:52 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     linux-amlogic@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     andrew@lunn.ch, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] ARM: dts: meson8b/m2: RGMII improvements
Date:   Tue, 19 May 2020 17:07:46 -0700
Message-Id: <158993320300.34448.6005768486014716103.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200512215148.540322-1-martin.blumenstingl@googlemail.com>
References: <20200512215148.540322-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 May 2020 23:51:46 +0200, Martin Blumenstingl wrote:
> the fist patch in this series connects FCLK_DIV2 to the PRG_ETH
> "additional" registers for the dwmac Ethernet controller.
> Now that we know how RGMII and FCLK_DIV2 are connected we can
> add this dependency to get rid of CLK_IS_CRITICAL for FCLK_DIV2
> at some point.
> 
> The second patch fixes the RX and TX delay. The 4ns TX delay which
> we have used so far is incorrect and only worked because we were
> using an unsupported clock divider in the PRG_ETH registers. That
> divider has been fixed with commit bd6f48546b9c ("net: stmmac:
> dwmac-meson8b: Fix the RGMII TX delay on Meson8b/8m2 SoCs").
> Instead of "just" fixing the TX delay we can even do better and
> switch to phy-mode = "rgmii-id" to let the PHY generate the RX
> and TX delay. However, previously we didn't know that there was
> an RX delay applied by the MAC on these boards. Only the additional
> information from Jianxin in the other series [0] made us aware
> of this. Without the other series there will be a 4ns RX delay
> (2ns from the MAC and additional 2ns from the PHY). Due to this
> dependency I did not add a Fixes tag, because backporting these
> .dts patches without their runtime dependency will break stable
> kernels.
> 
> [...]

Applied, thanks!

[1/2] ARM: dts: meson: Add the Ethernet "timing-adjustment" clock
      commit: b632506c5af22a9a7c63674fc605d24cf94d585b
[2/2] ARM: dts: meson: Switch existing boards with RGMII PHY to "rgmii-id"
      commit: 005231128e9e97461e81fa32421957a7664317ca

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>
