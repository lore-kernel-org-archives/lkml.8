Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C921C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 23:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D63620809
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 23:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Dr8ZTOpr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgESXK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 19:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgESXK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 19:10:28 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07525C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 16:10:27 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t7so546223plr.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 16:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YIhBgtFrqanZxaoDE99ayOKzut2GbNqr9j2tD0I6nAw=;
        b=Dr8ZTOprcAXuKEo3lno5QfSoo2JmOs9jR81zKjrpOBd/I/howaMAk9kD88lyo3RsFN
         GyXXxM8QdWWgKvp3tjNNhr3Ex3z1XDOCy8edrckMCu0yKDK7ZHP/qNSjoVg7f/hWm8Jo
         0CDbtZCE5WxNTMz50+iquyWVnM7OMwa1HkR+tKZol7nkDsNxubbJVt3EyCWinqPy5+rf
         40BVralUHrmDhSDDMFErcsxlHLFqsCsAYpJM8dQphqPaaZTXEU3W9+iNta7ATjjlWkYh
         iIVSUakYD+iG9nX4Ez1PA9K3XDCUAoEpO8Rs8LUWPrdNfXFqyo8IcSEE3C9qusTefyvT
         cJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YIhBgtFrqanZxaoDE99ayOKzut2GbNqr9j2tD0I6nAw=;
        b=FYG798D/aCQv+B+6zMH6TcQsYg8x9wywlQK6ZEUbzOjbpUaO1GJ6VL3x2Vgh1Dw1ai
         iPNvCuTGEKVXrMfL6m9xlykxiZYDPQvj2osk6ja9hijRQ19b+e0FbhzqQolp9Jy65wBR
         WzyMYA6Ne/ESyWJZJ8A2mNCVPjOzQ3cVz5uPFGIunuaNwFMYD/KP3JVp69q5jDDkAZb8
         qiCv/zojnspexUY1yvxP23jTp5w02nsXxxmIVnwrFmcqEaYfsac+v2P9wzLkUliJ5XGc
         u5yWDglwN1DhPN2IUD/ABpUomIW2q8b3AXF5jBLYOb1oV+feqshdKB4dkGgNtHlOGhcp
         jERA==
X-Gm-Message-State: AOAM531T1dbpRjc3epf9kBA7bXtWj1IgFjHCl/HZ0MT+EBrBDsq7qKHR
        dl29OpLIKG1rY5K50H9Lmsp9Iw==
X-Google-Smtp-Source: ABdhPJwBXr1mJnyNqJYn1wuy0/66dvQDSpj0yB5i/10Uf5tQtLlF1F1nIa3TamCG1/p9Wc7yiMkeEw==
X-Received: by 2002:a17:90a:a43:: with SMTP id o61mr1935891pjo.179.1589929827249;
        Tue, 19 May 2020 16:10:27 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id kr1sm454125pjb.26.2020.05.19.16.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 16:10:26 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 0/2] arm64: dts: meson-sm1: add thermal nodes
Date:   Tue, 19 May 2020 16:10:25 -0700
Message-Id: <158992977729.3767.17121497893810166214.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200512093916.19676-1-narmstrong@baylibre.com>
References: <20200512093916.19676-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 May 2020 11:39:14 +0200, Neil Armstrong wrote:
> SM1 Thermal is missing and broken since the G12A/G12B thermal enablement,
> fix this here by moving the g12b thermal nodes to meson-g12b.dtsi
> and adding the proper sm1 thermal nodes.
> 
> Neil Armstrong (2):
>   arm64: dts: meson-g12b: move G12B thermal nodes to meson-g12b.dtsi
>   arm64: dts: meson-sm1: add cpu thermal nodes
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: meson-g12b: move G12B thermal nodes to meson-g12b.dtsi
      commit: fef8ddfeaef8b7c91175e76bda7e4bd207b2d179
[2/2] arm64: dts: meson-sm1: add cpu thermal nodes
      commit: 410763ffbf629eee72f0257501dd448f861e3693

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>
