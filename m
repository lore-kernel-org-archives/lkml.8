Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC09C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C34422B40
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="sEILnmsV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgHXVQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 17:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHXVQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 17:16:51 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77CEC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 14:16:49 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mt12so90673pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 14:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FQ557hoZ2m6wPs+B8z3gsPGHazVrjeepyEdR7xdhh1I=;
        b=sEILnmsVGJYQIQ1kZjL/bfYE6J3X18O5MGpTQhrCsvBCO/eh5FRRNd4X5eJm+hUi3d
         hcG4S+Xz+aHuZoTy2u5/rhdpujpa0JYImftVXFwVt3/JCxIWbNeUtg9Z73MK+aiNSqoU
         eFb2n1qsRJXSm83KAHCqerzbmJ4cuBdkDMJnLyNUM0Ju2eps4dVXlM8HR3LTkRXcI3DH
         y9HFTwLJpOKM87CFndS57VCIO6dI0NOSWSwRtpgTqn8b9wbo7ZOtq7jetjazIMwy/KGE
         1VOrLqQJ8KjBEIeS5Q24VWoFUwIljijZh66GL+a+Yac2YeUR+hQOMYKsTCbp4ZMW+IGQ
         ef0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FQ557hoZ2m6wPs+B8z3gsPGHazVrjeepyEdR7xdhh1I=;
        b=Ao0B/O8UOrwLUU14i/h4ZKcMa89RYfKpmYFUvV2rdvZYz8+wjzxgmYgoe3USKmWpjS
         YX1zjRMtdxgBWh9hVl1Wp98dQOF9HGzZp/kgSc2u64o+7qwK6Czb/VSAB6HqGCXmKZxz
         zlMoMVsT46GwbD69YTcaC6WO6aiiwnYnBcVNErQoGE3PJuE/siHyzm1RjCDbZleyTB6n
         6wvP1WqmpgTj9BrsqkuX+6owWGMyRidgBCBzqmtS071SZXXMH5Pe/gAsPb5tmVlOwoaf
         UBDNnFtBQIjyLkiSl0SAXVKGn4XsKEXm6UDeVrtbQH6shIIcN3vHp19n1IryShJhFdeR
         CIJw==
X-Gm-Message-State: AOAM530TAcUWTqocumIoB+rzLwiEV3TV6+HGMdujKNG+n4utuv7AxKN4
        DYR2e7Jr3avawfewimq/ECdfrfTF3rHneKWQ
X-Google-Smtp-Source: ABdhPJxWXFWTTayf1UP+I8dQBt7qackDj95OuguDZWI865z8URWvIVg736s7YibH3MRh/uNbiHVDcQ==
X-Received: by 2002:a17:90a:6301:: with SMTP id e1mr889487pjj.5.1598303809377;
        Mon, 24 Aug 2020 14:16:49 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id o192sm13596290pfg.81.2020.08.24.14.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 14:16:48 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     linux-amlogic@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Graichen <thomas.graichen@gmail.com>
Subject: Re: [PATCH RESEND v1] ARM: dts: meson8: remove two invalid interrupt lines from the GPU node
Date:   Mon, 24 Aug 2020 14:16:47 -0700
Message-Id: <159830380185.24712.3464811968459073992.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200815181957.408649-1-martin.blumenstingl@googlemail.com>
References: <20200815181957.408649-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Aug 2020 20:19:57 +0200, Martin Blumenstingl wrote:
> The 3.10 vendor kernel defines the following GPU 20 interrupt lines:
>   #define INT_MALI_GP                 AM_IRQ(160)
>   #define INT_MALI_GP_MMU             AM_IRQ(161)
>   #define INT_MALI_PP                 AM_IRQ(162)
>   #define INT_MALI_PMU                AM_IRQ(163)
>   #define INT_MALI_PP0                AM_IRQ(164)
>   #define INT_MALI_PP0_MMU            AM_IRQ(165)
>   #define INT_MALI_PP1                AM_IRQ(166)
>   #define INT_MALI_PP1_MMU            AM_IRQ(167)
>   #define INT_MALI_PP2                AM_IRQ(168)
>   #define INT_MALI_PP2_MMU            AM_IRQ(169)
>   #define INT_MALI_PP3                AM_IRQ(170)
>   #define INT_MALI_PP3_MMU            AM_IRQ(171)
>   #define INT_MALI_PP4                AM_IRQ(172)
>   #define INT_MALI_PP4_MMU            AM_IRQ(173)
>   #define INT_MALI_PP5                AM_IRQ(174)
>   #define INT_MALI_PP5_MMU            AM_IRQ(175)
>   #define INT_MALI_PP6                AM_IRQ(176)
>   #define INT_MALI_PP6_MMU            AM_IRQ(177)
>   #define INT_MALI_PP7                AM_IRQ(178)
>   #define INT_MALI_PP7_MMU            AM_IRQ(179)
> 
> [...]

Applied, thanks!

[1/1] ARM: dts: meson8: remove two invalid interrupt lines from the GPU node
      commit: b468412409c0e5752ad3396b147cac563ff8dd3b

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>
