Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90572C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 19:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 613282137B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 19:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="DjKfHKcm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgD2TNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 15:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726556AbgD2TNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 15:13:08 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7123C03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 12:13:07 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j2so3896851wrs.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 12:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=dBPvVeh4B3Pkp8y05ZAgo7oa/RchtRefHH929mBUTUM=;
        b=DjKfHKcmHilIVgCUK5X51Co+o9Ftn6s5rJpIiRxutAMxipgkkQMSHIrEDU/1K1uc7D
         nYf4R5rV04X64hq/TKznmte47dCCcp1LyW63Hqzy+A1A9M6kNz3kHPa7PDjAj9GyIypG
         VETKP3rQRpGmYj9MNkGTUSrYmkCDtrQM5vesFi4JAx68R2wa9NTTWXSJsdq01mT2EdK3
         vDokyL++kDlJMQK4ER6x00teDArM3pYHwlVO8ZwVuxf97WlhJ8C98n3rPNeAFvwM0okz
         MEEKGsqVnRinzjzyNUJHPt5i4QjEqTeXSQXe27yPGX/oZaTDm5x8xW57MMKIjLt6r3T/
         Ebrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=dBPvVeh4B3Pkp8y05ZAgo7oa/RchtRefHH929mBUTUM=;
        b=Vy7pWUErypKFOlXhzE6i0NBiMnp26ubR+Xmvc8DQRRS6OWZxEwGO4ZHjyLcLeetcPn
         zpmzzY1S+7dQOdbTR7H2Pftm1ueLHUWpDNIgzJUHjjhn86MoILtXJVecj7sysMV0E1em
         uqqk30uRQ9/8NpYgIYFieYq6er1GRAm5oy1KJ92tTlLad8ElCvcsvniGoJl7i+0vSTNS
         5Etft0pAvTxjMqXVVX+dv4UkxJAM9xbWQWnk64yoQDe9dKSQNwDaim7b52rbFFajLRl9
         rkPC35gZukY+eitKFrSmQo3k5Qd+09wlVU9MD3sdiRMJJlNqToGyHhlQxRcrstl//zmP
         I8+Q==
X-Gm-Message-State: AGi0Pua+3BSj4zVJZreQ3E3aqUiVYhHdebpamZbnoY8skC/PDO6Je2YD
        uA3BNPmD2QhGWfqaUTG9Jn9eKA==
X-Google-Smtp-Source: APiQypIR1jfJpeTlE1XZv1UDQSOR+s5JzcFUz9pw1jAN39lHEuG3B62yNnUgicDjKRZ5baII++iLrA==
X-Received: by 2002:adf:db4d:: with SMTP id f13mr38996289wrj.289.1588187586571;
        Wed, 29 Apr 2020 12:13:06 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id n25sm9039456wmk.9.2020.04.29.12.13.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Apr 2020 12:13:05 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH] arm64: dts: meson-g12: remove spurious blank line
In-Reply-To: <20200420080018.11607-1-narmstrong@baylibre.com>
References: <20200420080018.11607-1-narmstrong@baylibre.com>
Date:   Wed, 29 Apr 2020 12:13:03 -0700
Message-ID: <7ha72uksw0.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Remove spurious blank line introduced in f12a463d2f43 but was not part
> of the original patch at [1].
>
> [1] http://lore.kernel.org/r/20200313090713.15147-3-narmstrong@baylibre.com
>
> Fixes: f12a463d2f43 ("arm64: dts: meson-g12: add the SPIFC nodes")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Hmm, not sure what happened there as I've been using Konstantin's new
'b4' tool to apply patches.

Anyways, queued as a fix for v5.7-rc,

Thanks,

Kevin
