Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636DCC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 22:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FBB72073E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 22:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="adOmvN9N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgHJWSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 18:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgHJWSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 18:18:05 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FAFC061787
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 15:18:04 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id o13so5733442pgf.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 15:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9g8qtC2V4GxzmzZnkUZiLYQpHL1EZPwlKyzwefOemH0=;
        b=adOmvN9Nh5Suu6Rr0ep559QiIFKSh6WVwTDWFA3E5IPQ8JTo6c6V1S2hhqTL5YhKq6
         Fe1vLM4FdGV5u9+AJCiOEAJD/CSxl6aCXYP8Eee04JbdVZDFEIMPq3ax4n8SC8ngwA8S
         QfyOD8iUtD9AEPfY7GNfGTzbl8JmSHfWdaJmrtHbNoVuGd2A8GoyuZNM2kc/FcoUv2Tv
         ou2axvuOdArvKWxvENZ7Yhsad2M0LnkJ8/D0XMgxdoWsZAUJG6akoHYp37UZdovcSLAR
         BUU8LfAgcvd6j748HEVdAQriBB4tGKw2Ols9mMChzbTx0tBAoYt3E37Xvrivt9G+Dbbr
         RK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9g8qtC2V4GxzmzZnkUZiLYQpHL1EZPwlKyzwefOemH0=;
        b=m16jgsoc2onSg2Q20zWyCY3u6mFpS1sWrjRzKemsSLx1vRN/KiJWVaSA0ggB2HUUnX
         FAqejZ99oKP1sevkxBqmHwy8e5xuLSRRncglZ8Ut67CUcBw3atQtEoMlj4QW3YP086qc
         mDTv7x5nm3otqF/rZgIwdI+ogydPM+VMfd4HmD0BT5dVEhpab8omjWEdTwnoihD6mM0L
         yJeX0MNoeesHF0f7IrwG/7XcU51w9VzfV/9qFA2lhPGIED7ghmR/+JTBl/kqoPLLqMq1
         X22ojz6cPtDN+YtylqpuqgS4mGWgssxPMKzsWEf0B7wPllKgerVigCEiQ8U+DSEDRi6L
         u1Ug==
X-Gm-Message-State: AOAM531n3chj2339Ph9q3YvR7KBg4aQgnRnfEnG4UigrepI6uGufFqyI
        AZsZo3uOE89MJT8OywxMLUIlCg==
X-Google-Smtp-Source: ABdhPJx9lnuS7+qH12wiV7U1ngctEYmUJ4OoiBcArJNsL5iYq+ebYnx24jafb/3FYN+x5XD96Z5mXA==
X-Received: by 2002:a62:768e:: with SMTP id r136mr3295501pfc.187.1597097884004;
        Mon, 10 Aug 2020 15:18:04 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id r134sm23791051pfc.1.2020.08.10.15.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 15:18:03 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: meson: vim3: make sound card common to all variants
Date:   Mon, 10 Aug 2020 15:18:00 -0700
Message-Id: <159709786936.10576.5338765095406106083.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200803142158.173402-1-jbrunet@baylibre.com>
References: <20200803142158.173402-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Aug 2020 16:21:58 +0200, Jerome Brunet wrote:
> The vim3 sound card definition should be same all the vim3 variants
> Move the definition to the appropriate device tree file.

Applied, thanks!

[1/1] arm64: dts: meson: vim3: make sound card common to all variants
      (no commit info)

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>
