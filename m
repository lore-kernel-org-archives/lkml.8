Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0C8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 045DE20656
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="T+B1E+Rz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgHXVQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 17:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHXVQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 17:16:48 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6388C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 14:16:48 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o5so5262874pgb.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 14:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1Eh+uteV+YXh6NW/wHYILgWtTw3Qzt2lgpjXRMh+Xeo=;
        b=T+B1E+RzFIKGI57nelsravKdx4Mtf63eoq9LsPevTghYZdAGqDYmp3jskAGbm0ZaVJ
         EQt8htALeD4NUAmQzvo3L9jPRDgw50pv+BcjwJBiAWIiWC4587o0t7YuB/o3B7SIUp96
         9DVJBOzmOiMb3QNU0noVQwCLfVzggFh0rdpLH/vQqbcBzfWEGaFmFgJ9BuGg+TVYH1WE
         H0mn+8GVMs7zUdlooQFkFPyY6aqkFxRkmxVVuP5Tt+dOBoRkft75lgk6QiLjaVF/zKh+
         duluH7bVV8CbSXU4GvigxzgtueuJKebwaYo08poXD8RNf2PlgTBmsPMGOfCMm66+ALfT
         JSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Eh+uteV+YXh6NW/wHYILgWtTw3Qzt2lgpjXRMh+Xeo=;
        b=XstCqoA3AmmnzDgQ6Z9/p+VvS+KpZdoBYwtwdesFEKtMLiR1QtvxlIMdzxzgPh8Y5F
         pwtS35Z3RT8XuZELyfj2BEyyADVfBluRwRw2kc8/XuSQlgJhwVlO49U/LYDXQ/izJnVf
         Qe4o/UZVC56iWdg2GEKlgiHBkF5aXI8go9GpQKbK+RFh6shnBmAlnpdJILG78/t8trS5
         n3OuigaGbV/LaC+bFvsnI9EiskxX/AQBA9UnypgWzULXbzKxiU26Kcbgi8VnCqAV01Wg
         36Rc/DQuT+0DKMpZ4BjR4NsuyklOC4XI2MbyolgcPBREcBkdmqlWNiSyXgCgw0mLjgAW
         iJsg==
X-Gm-Message-State: AOAM533fva2zcbzGONK89pf06AUmiw1zPlyYLU7zoDgC4MLEQO3OUqEQ
        IoZ/bP4pV1KIlNdO151q0d16og==
X-Google-Smtp-Source: ABdhPJyPIu59TnqA/Q176FZebD9qoE8LwiQZH4RaV5fgeJVYf4RHk+iFZ3XGpFhrzUlEcvxYuZ7fHw==
X-Received: by 2002:aa7:84d1:: with SMTP id x17mr5270460pfn.87.1598303808314;
        Mon, 24 Aug 2020 14:16:48 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id m12sm401728pjd.35.2020.08.24.14.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 14:16:47 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     linux-amlogic@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: meson: move the L2 cache-controller inside the SoC node
Date:   Mon, 24 Aug 2020 14:16:46 -0700
Message-Id: <159830380185.24712.168426396989939347.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200815182223.408965-1-martin.blumenstingl@googlemail.com>
References: <20200815182223.408965-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Aug 2020 20:22:23 +0200, Martin Blumenstingl wrote:
> All IO mapped SoC peripherals should be within the "soc" node. Move the
> L2 cache-controller there as well since it's the only one not following
> this pattern.

Applied, thanks!

[1/1] ARM: dts: meson: move the L2 cache-controller inside the SoC node
      commit: 8bcbcdb7293cc24eb7b24b67ef2b29b3a45a49e0

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>
