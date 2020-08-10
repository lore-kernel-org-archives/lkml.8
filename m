Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537D4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 22:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1754E206DA
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 22:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="gpgI9nME"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgHJWSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 18:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgHJWSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 18:18:04 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D42C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 15:18:03 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id m8so6506314pfh.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 15:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JTpNTLZEF1YuYGMjvco22c5p9oj/9YQ3/7+kfvmutjo=;
        b=gpgI9nME6ebeu07iGuAbt98CnW9J3B4iRK7Mj6+5t3/n4TRwduP2BFOEfbdabewJrv
         vFBtqSEG773dbf0Im8KIRLjn6bFhIfdRl4kJ1bC9rY4hXRNtMZ8Qmg2/zDkoJ2RloT0q
         WnuqhWpQDC66pBsO/t9ub9tZKMDxZHCfepGlgybh7SePt1dPo/W5qGny9DAfblLjQF3N
         8htKX3/bP4ITeARNNi1SLNkujUvPMwVl631hDidyijKdWZ/INg/Ziks+zb+skyeZKRtT
         5U4FS0vb3o0T0ofCRgQABAxOPKXhLud3HhuBnyYVVFnkfqx+UJmX0Y+mk6cSbV22wcy6
         guGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JTpNTLZEF1YuYGMjvco22c5p9oj/9YQ3/7+kfvmutjo=;
        b=qhK8Q6G14iSsRQThHtdsoceLlJM/D6UAIQ/9Gbb8g9sGudjBlDxSJrLLggT/icIThr
         2M7khrhYHKuz4tkjGjMbX/B+/MYeHQEYZjRV03b9z5mqlTzAH2k/l4YwSVfBfaw00u0s
         mySv1pJN6eN63fZJuNyWka/3uuLp+lexyHm63oW71zPA0x3TJ0JHoUwsl0Trs4pw/tRZ
         SIwck8BUW4IDtNe3/YZ7zlSoPuRJQ8ugKP/cUy879/y8uAgb59L3svcd4Sdd45W+aC3E
         H6bzQHCQ3DmXkenJeL45tltND9i2ucZlULX4Np3WOmiiUiq4RqZg/yzFKIuwJRtnlKGz
         Ebyw==
X-Gm-Message-State: AOAM533nr+I0lklesAKQsDCJpDRosAFERukEn/k3GMgvC+8TurN4/UgM
        YvLHrLZvetxw7d326j1gMUfnbg==
X-Google-Smtp-Source: ABdhPJxBm7Zw256hy2vVGlHoSSzO0FkytWwFgr+sWfiGGyL+LjW9MEiZs0vZqABHDrIEDhVlZO9Jcg==
X-Received: by 2002:a63:485f:: with SMTP id x31mr23694566pgk.49.1597097882636;
        Mon, 10 Aug 2020 15:18:02 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id l63sm19147230pgl.24.2020.08.10.15.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 15:18:02 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: meson: vim3: correct led polarity
Date:   Mon, 10 Aug 2020 15:17:59 -0700
Message-Id: <159709786936.10576.18026946638295707275.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200803141850.172704-1-jbrunet@baylibre.com>
References: <20200803141850.172704-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Aug 2020 16:18:50 +0200, Jerome Brunet wrote:
> The LEDs on the vim3 are active when the gpio is high, not low.

Applied, thanks!

[1/1] arm64: dts: meson: vim3: correct led polarity
      (no commit info)

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>
