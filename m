Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DC4C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 19:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 397192067D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 19:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="05j+Bnjl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgGMTDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 15:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgGMTDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 15:03:34 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D45BC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 12:03:34 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a24so805815pfc.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 12:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sHxhQAK9LuDavbBz6xN+mD6z/1m9f7zdjELv2spH1pY=;
        b=05j+BnjlorcJPySlCT/ivZ5MViO89ApDtowq3wqQUo8El1N6cvn570cw125ycyN3kK
         5yJQIbQPS10yRu4LAFau/igdow96BuAsVDc/wZbjNeZnm/kZg4D87bNXyaNrHGLYZBPz
         AT98bVgUq2M60/W2D5wyUkj4A+OIsjd0hAlDHNf9I0b6mxmBppiahxTVyhCI6574WoiB
         1WnQ8TZWliQquHmGXSvIc8D4WeCQeovAzbCEqOYX+kyhPxVHtYmD9L/+jjSGrr70txh8
         xAD9DTup1vHxJhl7hC+OYsvtxX7ZVyQoqT70TdB23XeCVsHLmjN2dEZ+YvkvYB50ioKH
         DPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sHxhQAK9LuDavbBz6xN+mD6z/1m9f7zdjELv2spH1pY=;
        b=L7jcrWl7GzA1DkBQTWGVm9BA/pZO9eCn2aeWH5bG2Le9Y/z1kk8HiYuJ79132iKgXY
         RDITbBguO20IajvIHGvCrgfiCB2ljPSAzEpqM/zbUvajSj1Jpm8dFgX81cBaSiRKVd5d
         RnGYh/J4VkqfVzAIwHwEHkBgs88uxWKqaEOusXAlTxE/lwA9Z6PNTJDvkBKYRPEg6zlJ
         hCGItcdgbQKYVe9ac7irdwNDZe/geA966j9kyPg1D1PkYTxt1GWcWP2rPynyPEdTVMdw
         /szxP2egtFUW7LMB8wdH3NIKA/Y5kvtJaZPTGhboP9+L8vvNXBU3u+YPFSQGj7D1XelA
         fE2Q==
X-Gm-Message-State: AOAM530Kh6+k6tDeMkAa65Is3tZx6wSzEsIS16aWUMiaeHNfL5jkXhC4
        AZNYrRDWlJqQOll4uF4O5wOt7A==
X-Google-Smtp-Source: ABdhPJwOT5rZ1S0GznDd+GMpG7ahpacIwFQXvwa4kPwp5tRxMqgDkXigFS7p16td6wzZcb4YnUbiCg==
X-Received: by 2002:a62:3582:: with SMTP id c124mr1144852pfa.288.1594667013653;
        Mon, 13 Jul 2020 12:03:33 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id k8sm16551380pfu.68.2020.07.13.12.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 12:03:32 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     linux-amlogic@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] ARM: dts: use the SDHC MMC controller for eMMC
Date:   Mon, 13 Jul 2020 12:03:29 -0700
Message-Id: <159466696386.22745.6301055317421562776.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200620163654.37207-1-martin.blumenstingl@googlemail.com>
References: <20200620163654.37207-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Jun 2020 18:36:51 +0200, Martin Blumenstingl wrote:
> Amlogic Meson6/8/8b/8m2 SoCs have two built-in MMC controllers:
> - SDIO (which is supported on mainline for a long time now but is
>   limited to ~40MHz bus frequency)
> - SDHC (which supports up to HS-200 modes at ~100MHz bus frequency but
>   for which we didn't have a driver)
> 
> Boards with NAND flash will now be able to use the SDIO controller for
> SDIO based wifi cards and the SDHC controller for the SD card slot.
> Boards with eMMC, SD card and SDIO wifi can only use two out of three
> MMC based devices for now until the MMC core and Meson SDIO driver gain
> support for multiple "mmc-slots" per controller.
> 
> [...]

Applied, thanks!

[1/3] ARM: dts: meson: add the SDHC MMC controller
      commit: 73106f75bf9498ff5d50f1052ad3cf03730d806d
[2/3] ARM: dts: meson8b: ec100: enable the SDHC controller
      commit: 73501b890a6f15460613878b463319d0e0cd1632
[3/3] ARM: dts: meson8b: odroidc1: enable the SDHC controller
      commit: d6a3873c7be6d58914ea5584dc7875f2045d6721

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>
