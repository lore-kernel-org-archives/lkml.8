Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A39C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 23:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 625AE20674
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 23:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="vTfMJ8Pt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgESXmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 19:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgESXmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 19:42:42 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CEDC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 16:42:41 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id w7so1199569wre.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 16:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:date:message-id:mime-version;
        bh=MmIqjO1PtTVd+rdNu9nNb4mADvKA71b2ZrcUks1uRJo=;
        b=vTfMJ8PtHJc/TjzQRTrRhPNVRyHHYycwdoNu7rn6SwqPvWLZ6+03X7Pq1xlTAqKfbq
         pSkz8erEmZbl5NEC7ffg1vjDBeV91vWIi/UpMblVVUXG7fICkxan3TIDYjBEiTzCKrUw
         qVb0ilGsCIYZu/z62LoRz/O/WEvNJUKhVB5XjQyTGwvbc4x6bXh9Iqiq500D+DFFVuBw
         XiFkgIHC3IELUdOO7nHfyfTiYvRDM/6Gaj0O0ZJynaFsDQR93goRr1Ox957iafchATMC
         74fwNFO/J48rEQSFBTg7/aNrT89cUvNxZYrb076WOjRmwcY4hot6ljnVFsjINyEJnk9s
         Q7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:date:message-id
         :mime-version;
        bh=MmIqjO1PtTVd+rdNu9nNb4mADvKA71b2ZrcUks1uRJo=;
        b=THZrWGPf/5xXFDCZBTivRPTfUVcDDWBc7YwJAVjP0TGOSoSRFTx5uuiRlNXW9rbzzI
         1HNLdgEr6OQFUElx1J6+ueeoc5zF4g3Dzw2A3mDfWoME1ta2XyV4PTMtWGk7rXgkdGrS
         aqyzhhmMNDw+bwO5hFKHlRvdettJf0h6k0v3PM+b125roZWnVWP/WeHOs/QYmb+v03hD
         8rcGb1unhct2KgFCBz2iYf/Bzh0ztPuexU018ZmM9qWHMb0zmGFejWskulGXfZGKUm2n
         ru9v1IDiYBbfDkrP/U5YVXZJh/M7iGbJFdQdtROtT/5XxncarKKKGZ7LLYXwmNwwteNO
         1Yqw==
X-Gm-Message-State: AOAM5310boWJ+CZyOZ6GIVcOCYcHLCvs44971ddT/WU/oJwnhXmHF2Pw
        qhJ+AStO3Uy6pd/vL7WBFgWXwA==
X-Google-Smtp-Source: ABdhPJzYYXY2GYO9fXGwE5+SEib2GsKVQjkMTferPikSHMR/G5SF/9GqcN7uN6IzDDLc5LOSCjL3Dw==
X-Received: by 2002:adf:f102:: with SMTP id r2mr1249229wro.376.1589931759860;
        Tue, 19 May 2020 16:42:39 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id n17sm1010174wrr.42.2020.05.19.16.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 16:42:39 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: Re: [PATCH v3 0/5] arm64: dts: meson: add W400 dtsi and GT-King/Pro devices
In-Reply-To: <20200518023404.15166-1-christianshewitt@gmail.com>
Date:   Tue, 19 May 2020 16:42:36 -0700
Message-ID: <7hmu63trtf.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

Christian Hewitt <christianshewitt@gmail.com> writes:

> This series combines patch 2 from [1] which converts the existing Ugoos
> AM6 device-tree to a common W400 dtsi and dts, and then reworks the
> Beelink GT-King/GT-King Pro serries from [2] to use the dtsi, but this
> time without the offending common audio dtsi approach. I've carried
> forwards acks on bindings from Rob as these did not change.

This looks good to me, thank you very much for reworking into a
w400-based include.

Unfortunately, it no longer applies on top of all the other stuff I have
queued for v5.8.

Could you please do a rebase on top of my v5.8/dt64 branch[1], and I'll
queue for v5.8.

Thanks,

Kevin

> v3 - amend author full-name on bindings patch
>
> [1] https://patchwork.kernel.org/patch/11497105/
> [2] https://patchwork.kernel.org/project/linux-amlogic/list/?series=273483
>
> Christian Hewitt (5):
>   arm64: dts: meson: convert ugoos-am6 to common w400 dtsi
>   dt-bindings: arm: amlogic: add support for the Beelink GT-King
>   arm64: dts: meson-g12b-gtking: add initial device-tree
>   dt-bindings: arm: amlogic: add support for the Beelink GT-King Pro
>   arm64: dts: meson-g12b-gtking-pro: add initial device-tree
>
>  .../devicetree/bindings/arm/amlogic.yaml      |   2 +
>  arch/arm64/boot/dts/amlogic/Makefile          |   2 +
>  .../dts/amlogic/meson-g12b-gtking-pro.dts     | 125 ++++++
>  .../boot/dts/amlogic/meson-g12b-gtking.dts    | 145 ++++++
>  .../boot/dts/amlogic/meson-g12b-ugoos-am6.dts | 410 +----------------
>  .../boot/dts/amlogic/meson-g12b-w400.dtsi     | 423 ++++++++++++++++++
>  6 files changed, 698 insertions(+), 409 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi
>
> -- 
> 2.17.1
