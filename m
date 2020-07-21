Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBAFC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A38C720729
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="c/mV4KGi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731164AbgGUVOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 17:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731145AbgGUVOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 17:14:52 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7634DC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 14:14:52 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id w2so43636pgg.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 14:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Mj6y7SpdNvDf6DkVOLENUdvlRqS8Z/NC8haKO/C3F8=;
        b=c/mV4KGi1aIfY5IlbtJjjCefNaJrsbEvvqK9NOIvwQ7QSax22F3MLnozNmRI1GtGDC
         6WOx1Yc8T07VvG7dNcxLYW6kAXze4sWKvIoXXjTMn6aboTZHelK0g4J5UtymI9qDBWc3
         Y7l+Wxek4YdBh4BGSzsJ3bGkx7FItIPf74ga1U6lDfHQNOA/kE0KXI3yjp1SaK5xFKsv
         akchu0o0VG+OVH5pP4lgrjsMEPHyiddyylS8qmfQkSCsC1FNmN9eNGxubgYWi+cA1ePP
         Mf9vaYbt3IdLFWFkHQ2V3a380ZVNdIkxM+kpTa8lM4lIQaO8Vrwd2MA7TjDFK/oJHDcJ
         vzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Mj6y7SpdNvDf6DkVOLENUdvlRqS8Z/NC8haKO/C3F8=;
        b=CRDl11tRflIvftUAhy7bGGk1hNS5diYFLf11Sv+3syhyc7ISgdhcJuHNqfEVvo+23B
         8bVQWyh6zIrBwPnzKc5kxeIillPc+azKavdf2oSsygdKGdqT5p2ELBVBdiOiiyStnjqg
         RYG5yRZaRdVZ9ushJVApVcDrrJm4J6MGBUb+mnTIU9SfF3LAIxuq7HeN2oIS3FqjnMdQ
         oa8jdQETo491+tMaLcs06y/nNWfrfy0wgXgSei4gqUkSwsYokteF+SsqwegAGREmd87H
         Pnq8TQtoe1z34RCntdPk/ZSPeJzVoVvSz0mISnorLlRAdxgx3MJR7+564FCLx6w+kt12
         L6fg==
X-Gm-Message-State: AOAM532eMDyYYoQzuYYdyTVbPkAzeMrJ//LbpLDLeDPLlUXMoj15z9iH
        dhYidbjEet6Sc4PWyi3oqLjRvA==
X-Google-Smtp-Source: ABdhPJz1PqGZETkshE/A+1/sajBkQw7tyu3KeqdkwhOxqabRkKhYh2WCIXwbVfN5GRPhQ7aZkt35xg==
X-Received: by 2002:aa7:8648:: with SMTP id a8mr25835447pfo.222.1595366091969;
        Tue, 21 Jul 2020 14:14:51 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id y7sm4130549pjy.54.2020.07.21.14.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 14:14:51 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     linux-amlogic@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     narmstrong@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] GPU DVFS for Meson GXBB/GXL/GXM/G12A/G12B/SM1
Date:   Tue, 21 Jul 2020 14:14:46 -0700
Message-Id: <159536607960.30777.14967661305847327487.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200719173213.639540-1-martin.blumenstingl@googlemail.com>
References: <20200719173213.639540-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jul 2020 19:32:10 +0200, Martin Blumenstingl wrote:
> Now that we have GPU DVFS support in lima [0] (in Linux 5.7) and
> panfrost we can make it work on Amlogic SoCs.
> 
> I decided to remove code duplication for the Mali-450 GPU on GXBB and
> GXL so it will be easier to maintain this. This refactoring is part of
> patch #1. Patches #2 (GXM) and #3 (G12A, G12B, SM1) are straight
> forward; it replaces the hardcoded clock settings with the the GPU OPP
> table.
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: amlogic: meson-gx: add the Mali-450 OPP table and use DVFS
      commit: 46ffadc7e658277d7559899d7f641f14a3cfae8c
[2/3] arm64: dts: amlogic: meson-gxm: add the Mali OPP table and use DVFS
      commit: 8f16cfabbc0a6c52b114eca2ff8e95bb07949741
[3/3] arm64: dts: amlogic: meson-g12: add the Mali OPP table and use DVFS
      commit: 916a0edc43f03f86b13fbc9943e5dc936671ea6e

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>
