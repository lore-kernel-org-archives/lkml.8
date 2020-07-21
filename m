Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D180C433E7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1729720720
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="R46YDFvs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731170AbgGUVPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 17:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731134AbgGUVOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 17:14:51 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B628C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 14:14:51 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d1so10807038plr.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 14:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8Wwp/nTJzsUvhisUQ9+vaJpMJ0iH/g8jv6QNXb3X5ww=;
        b=R46YDFvsp892X1mA7UDmA3obkdoXFygn2SPRBg1p9ocvU8u0SvQaYmqpvYBXPRYiKU
         5+oz5AUctzTlpODshc8BvvGMEMSDeK5pEj6ZMB1D9fMQJEyMYhAR+DsyA1aNCtvRSIw6
         erNog0J6vUpi1vJN+bhGmlH+vJVn55lRxbVhxQmQN7jOF29tA9EEuYrg0UOnTWGqBH2H
         2HiBKtQiYtZI+SqoH7ikzMGaSA0XyGDFrBqO6LAeqme2Yn1INMnwWEhCzqfcl2u6iWiu
         CTd6FICWjWbzpHAlp3gBKmAYl6XAaNA6wAllYMnHTZSWElLDFQAVYOfO7XPPq8D4brqb
         BiEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Wwp/nTJzsUvhisUQ9+vaJpMJ0iH/g8jv6QNXb3X5ww=;
        b=oTH0yr6RQO/bZUg3BRmfNLAxaZjJhQnpsj8yOJ1tXnV4NgIcocFhbNOCaza6DtvKXj
         x62kGnIHjnxSJaLGiFL6YUTvzM8iYqrVGIkEPzL5TKHu9bLDfCdAF8yqSe1kkL/nRP5v
         tB89TgHiau30FFnB7hWyMbHDm9B5YvQFXGRigRLYw3Ayku0T9nfkRtKjZmiHSbx2A4yx
         N2mLWL2G763K8J+H7C0YmHLhZfYakMDOgT+FjeXAY/NeebsEZM+WP5iSPwSldgrj4OiM
         iT6Ln1aeFT+qoxHX1X5/WtAeKtKewdBugxkRuxgRc0lfsr/melrog6U2x81FhXCHwCQk
         bS1w==
X-Gm-Message-State: AOAM5321ZGkbJiWe/DGQKR1992l/puputGJen/HNdf6ER2rAWSYB704A
        TYA3Vx5T4OUSpmilKT3rcygEvw==
X-Google-Smtp-Source: ABdhPJzyJvqDGRK1A9FroF7bWZIj9yO99S+GpeI/v/ztl4Hj14ZjS1n14DHIrndS7G5OAKQTZkXClw==
X-Received: by 2002:a17:902:bd8a:: with SMTP id q10mr24858111pls.236.1595366090725;
        Tue, 21 Jul 2020 14:14:50 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id i196sm18903141pgc.55.2020.07.21.14.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 14:14:50 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/2] arm64: dts: meson: add support for WeTek Core 2
Date:   Tue, 21 Jul 2020 14:14:45 -0700
Message-Id: <159536607960.30777.1598266947126340920.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200719021421.7959-1-christianshewitt@gmail.com>
References: <20200719021421.7959-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jul 2020 02:14:19 +0000, Christian Hewitt wrote:
> This series adds support for the WeTek Core 2 which is a commercial box
> device based on the Amlogic Q200 reference design.
> 
> v3 changes - fix BT node (enable-gpios > shutdown-gpios)
> v2 changes - simplify ethernet disable
> 
> Christian Hewitt (2):
>   dt-bindings: arm: amlogic: add support for the WeTek Core 2
>   arm64: dts: meson: add support for the WeTek Core 2
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: amlogic: add support for the WeTek Core 2
      commit: 8b6f53d7b94b8d23860ae44a56b0af404a6c7e4c
[2/2] arm64: dts: meson: add support for the WeTek Core 2
      commit: ea232b9ccccf2f55fe231441f3908c31c7136c4f

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>
