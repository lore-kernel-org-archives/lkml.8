Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEB6C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EB1121D90
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bulmF0iA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgD2SZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 14:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726456AbgD2SZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 14:25:51 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE14DC035493
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 11:25:50 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id e26so3122482wmk.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 11:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=aylaGgHoNCdro4aj1kReOF/0XJzfw3lt+cTfiwLLy4k=;
        b=bulmF0iAYytHO8GfkiMTz2/wrjQa81ycOghM4qrGUqY/D2OA5I3QqpJenlHxHGHOGN
         3TRI0k44FcE5kAoqkdT2qqpyYNEVFsteAbGuKJHzaBddtfXUZ92wKIX6oVcIhsjRNqAO
         tFd4Hdrq70tmRP08i3Cpp8t9YbXNTj3RRgbgqYFtGaOvXGvxH4G2Q0JS3HduP/sJwx3u
         J0NI4q/KAv+HCiS0m+IiycnPRi3/y4l6TBWHhMfdzqlEBZddW+HKVU/IE4nfdRUQPgXf
         fQX1XkJIGD5oWKQe2rqdrZ1Er/Pg9VPJFostro/Oy+FqQb6uN/hTy0CcN/QOxn25d9KV
         StEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=aylaGgHoNCdro4aj1kReOF/0XJzfw3lt+cTfiwLLy4k=;
        b=nwqVLa4XFPGyzQAUi93yd7gqx8Bkor/vJSJdhoMCOMNPjVlmmkvXgH5RSF5oht5IrB
         tEDoR0A/IXb4tNOd4WLcRdaWmG0840Rw6/Psh8+dx7VD7DtWAtm4jMmuwM8LJPnI5v4g
         PTDw1B8UxUEHXZJ8hJlC9EgJM+XGvJlj2wVkUX5VTFgTEyi+hxNzFgH17ipyVNJsMcgL
         exHHTbITA1JGre4Vw6Co3XPCh0TLt1x4jiDo6UiSru3/Wdkuy1W3dSAvx4mAIAeo7XS0
         u/E0FfQqmV0X+hTEaWvmK6QfrZORRsFf0+z1upC+/j4slMREapv4H4tWMAmE0pHTJRJu
         ySUg==
X-Gm-Message-State: AGi0PuY5boyCecFtFJLkgjyTWxSab+CPB++7WnBYZ8ALEEckr9RJmw/K
        xLWC/JKY+h7rJVI5Ggv4SxDffA==
X-Google-Smtp-Source: APiQypKGElxZbwfebnwRtc9YXDqH2ejFiotLM25eOrvcSV/EZexT3pOur5i5ZAGDz25bVOxo6Su9eQ==
X-Received: by 2002:a1c:bad4:: with SMTP id k203mr4587804wmf.15.1588184749038;
        Wed, 29 Apr 2020 11:25:49 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id g25sm8741435wmh.24.2020.04.29.11.25.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Apr 2020 11:25:48 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/5] arm64: dts: meson: dtbs_checks fixups
In-Reply-To: <20200326165958.19274-1-narmstrong@baylibre.com>
References: <20200326165958.19274-1-narmstrong@baylibre.com>
Date:   Wed, 29 Apr 2020 11:25:45 -0700
Message-ID: <7hk11ykv2u.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Another round of DT fixups of dtbs_checks on Amlogic DT files.
>
> Neil Armstrong (5):
>   dt-bindings: sram: Add Amlogic SCP SRAM compatibles
>   arm64: dts: meson: fixup SCP sram nodes
>   arm64: dts: meson-g12b-ugoos-am6: fix board compatible
>   arm64: dts: meson-gxbb-kii-pro: fix board compatible
>   arm64: dts: meson: fix leds subnodes name

All the non-binding patches queued for v5.8,

Kevin
