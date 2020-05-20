Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC452C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB6CD20823
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WVsgcgCN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgETAH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 20:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728380AbgETAHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 20:07:54 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BD2C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 17:07:54 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k19so580867pll.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 17:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2OA6qojCM4dL1ZDG6HQpUSV9SSGjjyRfMb9hw1jALO0=;
        b=WVsgcgCNQtJKJlbMEdp7w81j7Nm4YgeKnV3hBNnr2syOwz5DeApI1RIoXsQ59LoX63
         UY2V0GnOOpscuwrDUIKdjfOccPjKFYNBrx6WwinSe0uALV9xqI4hb32/gERjn6v03kT9
         88RMzTiz2P6Kc5j6b9eSUdiiITnenAyFko0xZuusJ9PKBv+22iSTpQwetNCnQ2mXLQrl
         gEcW6QAiB8RA+CWjieoN2uYCT65WXXbdXyjnLNVcWQCkulr5kwSMoopJ7fXaQkP4u97h
         bT2iGKpFMCaPXKBUV7vdESsycvExKYcPZijw21Lp42FW2IB3AC8AfUzMhIdMk7uGC54E
         TPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2OA6qojCM4dL1ZDG6HQpUSV9SSGjjyRfMb9hw1jALO0=;
        b=fPOzj2QIQIpWAjAuXtGgt2ZrxQ3+zaN/qV5b7+IYuexYD7/Nh7XtxkuCCGkxPF4Jqb
         I1sTERjhopgf+b7iwX0tlJLMXG1hJO9bgKpbwtMdWRV+jfHxyg2LLKMdTL+GpeYAJXyo
         ne96qXmVuo0lV45tM6Lyx2bSOvUoYBS6OmQuc2K6ea3HHQFETMSGphgv1XCSXJMh5+2G
         oz5HN/ydNapEmD73lOtX6UUjhSljjiAnltbwdtxhV+xe9Kz/PUQ3GNZ9xgCIf5iUx8Be
         Cvw2YbDSl2uvnOKFe5vj0STlhNkk2fF4z/SWuUOjCL+WUECrMfk+VXBBCO9Pp8cIahNM
         HT1Q==
X-Gm-Message-State: AOAM532whMrUcLhMcuj2/1mijhXkSYN+6hgAkraTdODQdxGwEwqpPzFG
        LjB/RfHVMavpEgtqnGZ2GzX3Cw==
X-Google-Smtp-Source: ABdhPJwtCswXSbkUSw9C97SOK8vFMtT5eKKDm0rsNrlGrcNSvzzkVB3d8v+6JdpLRZlhXKPaZGOWpg==
X-Received: by 2002:a17:90a:3201:: with SMTP id k1mr2111805pjb.202.1589933273730;
        Tue, 19 May 2020 17:07:53 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id w19sm490543pfc.95.2020.05.19.17.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 17:07:53 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     linux-amlogic@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH for-5.8 v1 1/1] ARM: dts: meson8m2: Use the Meson8m2 specific USB2 PHY compatible
Date:   Tue, 19 May 2020 17:07:47 -0700
Message-Id: <158993320300.34448.17484160743878386596.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515202520.1487514-1-martin.blumenstingl@googlemail.com>
References: <20200515202520.1487514-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 May 2020 22:25:20 +0200, Martin Blumenstingl wrote:
> Use the Meson8m2 specific USB2 PHY compatible string. The 3.10 vendor
> kernel has at least one known difference between Meson8 and Meson8m2:
> Meson8m2 sets the ACA_ENABLE bit while Meson8 doesn't.

Applied, thanks!

[1/1] ARM: dts: meson8m2: Use the Meson8m2 specific USB2 PHY compatible
      commit: f5a7382d6f176e29e4fd9d733b93d5b93771a7e4

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>
