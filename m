Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881C5C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 20:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 672EC2168B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 20:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E6u2N0HY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgGGURG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 16:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728280AbgGGURF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 16:17:05 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC19C08C5E1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 13:17:05 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t6so20541065pgq.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 13:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+tCTrAKWMJVuvZolCuiw6Qi11c7jBp2RNevhFxrSgmw=;
        b=E6u2N0HYkyZVbrcS7ao7VcNmPRODfcTSo5b48Ee/6vAd9W9rpK0paNN4aQa7kt0+Eh
         FQ8CicLr0gT3aNjl55yudIDJhD0s8RFnBOej527WhdNsRZ8oCSVW5+DM09j1WPG1fKjS
         ZWYm0gHt/x//SFsaQLOs3DOaPV3EeL2NDZjEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+tCTrAKWMJVuvZolCuiw6Qi11c7jBp2RNevhFxrSgmw=;
        b=IggCqczxjR2yjEI0NhTPmD6D0KwNs8FUGhe7rV38poBehSDrmggcAv8aTcco8KoaUl
         8XAujKfR1dxzmHm+EwrrrM0KpL5C37xynrBcVH6lY0gJXyB8DwFB1FGtaw7oPRgS+xwO
         Y7zMnogSRNDjlbfnq8aGGt17s1Qf+kWpewOKa2b9JoO+iXgLO9vKycnN0qnxHF3/aXdg
         sU1/uPByLWCWv0HTbkQI2mVkBbXDye/wgxpR++idUFrIEKWOvw77PPp+RGue9Vxg2aaA
         RJ6SPZH5Mecl6FtfS20/X3FYRjDVIuiul0d8dCXJpn0ExRjI5jQ3QpwwA41LOJjSFYFt
         EjDQ==
X-Gm-Message-State: AOAM533E8+wBCrwqZejPEDSHT/QaPVpvl0GPu0DT7/l4nQ00h2KeZ7kH
        oBYGItJ4ceutEj9QHpd0nnk28g==
X-Google-Smtp-Source: ABdhPJwM9b7JDIXP5Gb8t7awJr/QovUJ/0MYE1YMo1UtvqZOuw+GkOunu2GJuNn9V2rWbH1RVw8M8A==
X-Received: by 2002:a62:84d5:: with SMTP id k204mr47316805pfd.66.1594153024963;
        Tue, 07 Jul 2020 13:17:04 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id i23sm7166097pfq.206.2020.07.07.13.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 13:17:04 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     mka@chromium.org, Akash Asthana <akashast@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, swboyd@chromium.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org,
        ctheegal@codeaurora.org, mkshah@codeaurora.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH 0/2] spi: spi-qcom-qspi: Avoid some per-transfer overhead
Date:   Tue,  7 Jul 2020 13:16:39 -0700
Message-Id: <20200707201641.2030532-1-dianders@chromium.org>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Not to be confused with the similar series I posed for the _other_
Qualcomm SPI controller (spi-geni-qcom) [1], this one avoids the
overhead on the Quad SPI controller.

It's based atop the current Qualcomm tree including Rajendra's ("spi:
spi-qcom-qspi: Use OPP API to set clk/perf state").  As discussed in
individual patches, these could ideally land through the Qualcomm tree
with Mark's Ack.

Measuring:
* Before OPP / Interconnect patches reading all flash takes: ~3.4 seconds
* After OPP / Interconnect patches reading all flash takes: ~4.7 seconds
* After this patch reading all flash takes: ~3.3 seconds

[1] https://lore.kernel.org/r/20200702004509.2333554-1-dianders@chromium.org
[2] https://lore.kernel.org/r/1593769293-6354-2-git-send-email-rnayak@codeaurora.org


Douglas Anderson (2):
  spi: spi-qcom-qspi: Avoid clock setting if not needed
  spi: spi-qcom-qspi: Set an autosuspend delay of 250 ms

 drivers/spi/spi-qcom-qspi.c | 45 ++++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 10 deletions(-)

-- 
2.27.0.383.g050319c2ae-goog

