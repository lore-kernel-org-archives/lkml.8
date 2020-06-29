Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B80C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0E0320780
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 23:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dnyZODqa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbgF2XTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 19:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728864AbgF2XTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 19:19:50 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C4FC03E97A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 16:19:50 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id w2so8218623pgg.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 16:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DzWYtGd0GUCAUiTFuoYBXiTLrgADirz9J3COQ9mAmfQ=;
        b=dnyZODqa2RFPX9scaHO7AZPwV7FJNUC0SDuq354GBg9MqfTRu0zGRpxBGxs89JjSL2
         2o5BOJTwlmqmj52iJg5p6bC8XimTTgbqL8NZOXTCppKNq4hucwoej6UsvQgaANdWhdWr
         KsjZcK+gA4trK7iLq2WW9lT5iZ6sfnCwaHBi74Gf1gSVsAfijzvwsYB7PiCC4/RNF3ir
         5D+pIl/BYUPEvtrgPJVoY4pREyAQdZBjmjPfpSpBh4PtitTbpUFOCEgRKcBFjBbZsIyI
         hw4hyX0OVdlW5VaHmtUVs24UgoTwKDl1V7JwpP+iGBNYq0VBCUpV++vAOVCddrlrJXc5
         4Y5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DzWYtGd0GUCAUiTFuoYBXiTLrgADirz9J3COQ9mAmfQ=;
        b=llCQge4+G0ESXq0VUrobYzymMmJELGaJtq0fstVhEKDJk40iTocsyiPqoafL7s3/O1
         ItHfuR9uWYGozarQpVfaLLLZ0bMKcPGx3rII2tQnJCilzkHtUgbPr2QfzgBrhymkvF6H
         Vu9NMx1UHrdwMtB4EhCqCGNTSfRZks5uB6yZa44jTcsmIxiXFv+geAisY+g4zjr3T0rc
         mY1M1xSWHFHHNjE8JT6qNEvV/Jcqdb35rv3a+chTx9l2cDcnVIzL0H2DvH66W/hB2KLa
         B0BqAE94WKcpdldN0cJnh6FWv92Rr3gmKqjFmTQ9JAPQPjJQH7TLutYSVhwYFM4dVgdx
         9HQg==
X-Gm-Message-State: AOAM5339MULbfJ1Bxb8m+rKf2oP7CIwTaS+XS+7v0gaUb7Pz0F5m5C0u
        ZncMWnOv2ALUQPhbk4BSK2UiBA==
X-Google-Smtp-Source: ABdhPJxzD8uqDWOR2wszcjzJ+LO3CWIp9Ucq0ms/H6Ci8WVC4UmVHQPBsSroA68D2YrGibKGncqHbg==
X-Received: by 2002:a63:1c23:: with SMTP id c35mr11992013pgc.91.1593472789646;
        Mon, 29 Jun 2020 16:19:49 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id v28sm739336pgc.44.2020.06.29.16.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 16:19:49 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: meson-gxl-s805x: reduce initial Mali450 core frequency
Date:   Mon, 29 Jun 2020 16:19:46 -0700
Message-Id: <159347276726.1911.1703935618732893408.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200618132737.14243-1-narmstrong@baylibre.com>
References: <20200618132737.14243-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jun 2020 15:27:37 +0200, Neil Armstrong wrote:
> When starting at 744MHz, the Mali 450 core crashes on S805X based boards:
>  lima d00c0000.gpu: IRQ ppmmu3 not found
>  lima d00c0000.gpu: IRQ ppmmu4 not found
>  lima d00c0000.gpu: IRQ ppmmu5 not found
>  lima d00c0000.gpu: IRQ ppmmu6 not found
>  lima d00c0000.gpu: IRQ ppmmu7 not found
>  Internal error: synchronous external abort: 96000210 [#1] PREEMPT SMP
>  Modules linked in:
>  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.7.2+ #492
>  Hardware name: Libre Computer AML-S805X-AC (DT)
>  pstate: 40000005 (nZcv daif -PAN -UAO)
>  pc : lima_gp_init+0x28/0x188
>  ...
>  Call trace:
>   lima_gp_init+0x28/0x188
>   lima_device_init+0x334/0x534
>   lima_pdev_probe+0xa4/0xe4
>  ...
>  Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: meson-gxl-s805x: reduce initial Mali450 core frequency
      commit: b2037dafcf082cd24b88ae9283af628235df36e1

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>
