Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48437C83006
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21D5E21D90
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FKjVRVJH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgD2SRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 14:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726456AbgD2SRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 14:17:37 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E255AC035493
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 11:17:36 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id g13so3690579wrb.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 11:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=6lfBNlbD4T5zHjO+6zb4aZNCWH8fCBIeJ2zjUEDU5Bc=;
        b=FKjVRVJHicGYD5WTdJMpWpXGtXFSDFjc3LSxc/83GGZ8OWLBuAvH48kbmhFmH5ZKHB
         d6KbAlikjeM2P79sOAnW/zi0L2TjWf6Cr6J/FSc9jNiv/XGitGeOwKbgrCuHv9ganP1U
         /fZeIlvVbQ1LF9LRihu8SJyJ4OHY0kVwWrIMT4nC0afpeRcj4PspcxUtSdELtnTvVhRv
         5rFC1BrK19UiqlmhPKi8ZsKVsvwJC4YuRI2YvtiSDgPHSiH0Qz01kzhtgLmpHjiY2U1K
         +LdAafAP9WKp1Z4p9nowV648/ClsicXciqHrLDPmj4I2kWcm5QXnh+y7IOgSx9nDF1lw
         AWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=6lfBNlbD4T5zHjO+6zb4aZNCWH8fCBIeJ2zjUEDU5Bc=;
        b=cf7s3MLuNzFoltfodBaceo5VPTT66d+slKaQ8/0EPDLDGZlDsHhURZ1gTcB4xVgAGr
         YSLw4E2LyHRjUQX1nGocd2jm9bcICUAE32G+77srecFnlcuQf3NJLQxePpiNV+QpxSjp
         PTJHpdbkSjhpK7gbGUpCGpgMPd2QXklgOJ28BYVw+Fs6fTb8z1G/wBN5GKauLMLeaH/7
         /JdO91uWlWRetd4kdvivSAggLAX+YwpoeZ5D2qef6a0SAzhJXfLdEMif5R74DC/1P6t1
         PNab7LOyKXA9PGm5yzwqSZtWMpHhjtXmhp9B4BoKXD1C2kVTJTa1OU+T4RnP8b2bMI0z
         PquA==
X-Gm-Message-State: AGi0PuaJ1Ea6+Tumu6En6AWfYl4QFa8r4N9Kf6WmvSldaL+r/Hv4EfEk
        02j9y13E1613l0SPrAYYbfKjng==
X-Google-Smtp-Source: APiQypKmIw7W+i+Z4WSURtf6yTrOuBc3eZpc5F2oz+HJ9/6IIKwwniMHrNOG570XslOxNrE5vDfyfA==
X-Received: by 2002:a5d:5081:: with SMTP id a1mr44188891wrt.81.1588184255519;
        Wed, 29 Apr 2020 11:17:35 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id a24sm8596897wmb.24.2020.04.29.11.17.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Apr 2020 11:17:34 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, kishon@ti.com,
        balbi@kernel.org, martin.blumenstingl@googlemail.com
Cc:     linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v2 10/14] arm64: dts: amlogic: use the new USB control driver for GXL and GXM
In-Reply-To: <20200326134507.4808-11-narmstrong@baylibre.com>
References: <20200326134507.4808-1-narmstrong@baylibre.com> <20200326134507.4808-11-narmstrong@baylibre.com>
Date:   Wed, 29 Apr 2020 11:17:31 -0700
Message-ID: <7hr1w6kvgk.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
> Add the correcly architectured USB Glue node and adapt all the Amlogic
> GXL and GXM board to the new organization.
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Queued for v5.8,

Kevin
