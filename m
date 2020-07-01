Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A08C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 190662067D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wbqk8Ph9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbgGAJqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 05:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729564AbgGAJqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 05:46:04 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF33C03E979
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 02:46:03 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id f7so20099091wrw.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 02:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WsaJCqMmyft0xsDXaDX0E0lFydjZ70ccL/4pSLdMeMc=;
        b=wbqk8Ph9l/AGhRL3xUbGbNhLrunVeFNmXALYi0Gg56El/K1rrk3zzHtIf/sL1VdR3D
         b3pBroqn4YTxTHIIg1cvze/q+fzpvAhGEZDjCHSYCcq3D5LN9cY+N8oqtoWmi3wp1Zi/
         /2XzsEcLLsPKDqNJ0Iv8Pt5nWZ6zDwps1akv3mKqrH2Cy82IA0v1BCdPm4SgSazw/GwS
         nlL23SjmZepHaJdtV+jbzGPq7hH9hZaEBSgS1gTZjMW3gva2JtXqB+uVIkeRsrWE8+iR
         53WDNdZ+PSHEoUKREoeFk7IeT7n9qSzJiWpx1Q/aBY/EIKHhYk8bNIF+wmeGtkT/lul2
         P7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WsaJCqMmyft0xsDXaDX0E0lFydjZ70ccL/4pSLdMeMc=;
        b=EKgmxmPDV/X6q1SFDxIgJEqlrs1vOYb8NcHNaWxEhbhrBBQR/6QPLcF/RzuhIaHpRK
         IDNOIRH2kzxSk3VuTt+Py4YhMIiMGwe7V71JPWx7/1D2yffISwlegXZoQLC428wF3o8U
         ARjMFP2zkgL8jgo9lhuB6rOfHFR2vXDknJA97HaUP7pSPS7uaTZBneOSYoZ4Hww53pzN
         x0ZMO599sWdbHAeQZuO5yvpanxy7htGPW11JWlICS23oJhRXCitkbeVqoLRtCNf8cAAC
         +JqByjcq1nJF0db/F13txygKP/tm7m6PMkqenAsV2HiD0sAY5/1Ir5Ghz0YPsl65X3l4
         xy8w==
X-Gm-Message-State: AOAM5316P+Z0GlgyAmv9I+Jjz9odZNE3GRPMRTDOyuhJfqMDEyqxwK0W
        gejW/8WH+mJSjDB7kllgG/VFpw==
X-Google-Smtp-Source: ABdhPJxK5vIN7UeAUbYNFQLTvAZEkw2V7bkjRvhqNfHoOiZLWbl8nRVLfm7/OR/9iJN3Dm6TZLb17Q==
X-Received: by 2002:a5d:4f8b:: with SMTP id d11mr2853363wru.147.1593596762403;
        Wed, 01 Jul 2020 02:46:02 -0700 (PDT)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id f13sm6270472wmb.33.2020.07.01.02.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 02:46:01 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] arm64: dts: meson: odroid-n2: update sound card
Date:   Wed,  1 Jul 2020 11:45:54 +0200
Message-Id: <20200701094556.194498-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds the support for the TDM loopback and audio on the jack
output using the internal codec.

Jerome Brunet (2):
  arm64: dts: meson: odroid-n2: enable audio loopback
  arm64: dts: meson: odroid-n2: add jack audio output support

 .../boot/dts/amlogic/meson-g12b-odroid-n2.dts | 136 +++++++++++++++++-
 1 file changed, 131 insertions(+), 5 deletions(-)

-- 
2.25.4

