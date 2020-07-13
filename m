Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527E7C433EB
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 19:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A73D2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 19:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="gUbj2a+J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgGMTDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 15:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbgGMTDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 15:03:36 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6078DC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 12:03:36 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ch3so317146pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 12:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=58Sm2O2hHu+C0rc7GOoPvmu+vxdu19cgV8dD6kLpfog=;
        b=gUbj2a+JCElYxBW38cLTTiCiXs4W4q03nssgQlX9sQlGhAPeEyfJh93d7Oy8nLwV/+
         OKI8tSS27cFqos1/8/cVXb0xIrFtM8ZZsrSa/hA6ttfIS5Kk1ITyy9ki4gwiUHP1TrcL
         OnJOiP45kqgHqVzgEHRDNbf7I0pYuci1ClzgKs8xKVbBvLCP5Z56fHZcnlqpEECYRjU0
         WkQTqGfHYJMB10CfEiy+Nh3sm/zh+a7bzoUFRdEu9HAM8E3q7/1+Z28tIZNjTJ6I9KvW
         3PbvdbP7L/4539cZen3VIUjXHrD6oPAXNtQEnrR/gDyKRwFmnVmswobLyHxvgOYK+mks
         aXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=58Sm2O2hHu+C0rc7GOoPvmu+vxdu19cgV8dD6kLpfog=;
        b=B4FTMv04l3aw1yFVZ6PkMcN20oqmYK5fxs79+tfRGvbT6upR1B/nhZ3XAZvwMU7T6n
         4+THf7BLSt9+mHWArRAPMVW3ewmLiSQM5Kp1ro3jTfsS93P6b6dKKjljtgagV3WPtpBV
         Vm2n2BZ5OYrj/PJHj3vy7GWIcp632g8HjbE6F9bvLOppjwaPafHqFr/cqfRFrCSrfifA
         qytRR8hC/TGLmVy7OPMNo/7z8rwHmS1HF++MuL9PYmI4o9H9tTUgXXKb1a+qJ5XU+xQ2
         Vg+XZ2Oq5N6K89g1gmKh4SLLSObxNLmo3rAGlRE8/KjZAejTkOmE8se60hkAyufsj73w
         Og0Q==
X-Gm-Message-State: AOAM533ogjSKUTrwzyO+8UTf+QdPHRtKPDfx92nev4jy0Ar6BsfNqyaW
        gSkNBqXNOkv+moPAdlxBogSrzA==
X-Google-Smtp-Source: ABdhPJwlkPw/RyxHqA4cDR/H70xi7S73C28/JZUf6LrZpRMbhY/g6FDcPU6wddN0hon3fnX5VuNGng==
X-Received: by 2002:a17:902:c697:: with SMTP id r23mr919008plx.35.1594667015905;
        Mon, 13 Jul 2020 12:03:35 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id r6sm15373443pfl.142.2020.07.13.12.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 12:03:35 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     linux-amlogic@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        narmstrong@baylibre.com
Subject: Re: [PATCH] arm64: dts: meson-gx: Switch to the meson-ee-pwrc bindings
Date:   Mon, 13 Jul 2020 12:03:31 -0700
Message-Id: <159466696386.22745.8204362310491348134.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200620161211.23685-1-martin.blumenstingl@googlemail.com>
References: <20200620161211.23685-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Jun 2020 18:12:11 +0200, Martin Blumenstingl wrote:
> The "amlogic,meson-gx-pwrc-vpu" binding only supports the VPU power
> domain, while actually there are more power domains behind that set of
> registers. Switch to the new bindings so we can add more power domains
> as needed.

Applied, thanks!

[1/1] arm64: dts: meson-gx: Switch to the meson-ee-pwrc bindings
      (no commit info)

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>
