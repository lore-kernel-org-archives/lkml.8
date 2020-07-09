Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1680FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 14:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0F98207D0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 14:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PC2Pot4K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgGIOv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 10:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbgGIOv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 10:51:59 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBFDC08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 07:51:58 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ls15so1229007pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 07:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cptIFOy+s35IOrGpxC/c61eH5jsSRhIdmTZLXFVPdjk=;
        b=PC2Pot4KmH1gr1NvXniHoKNf9m4dqGRv0CD328oaViqnSdYsE3pLmZtJ3y47G0suSm
         9qJxZvgzT0MZdQySNQeoiJRU8aPY85XmcaVva/OxIFY5WduhzCi4z7qa25i6TDC9x3IU
         KhUeZtBVvYKawhWzb+nIPPIQg0uPsKiWfmVSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cptIFOy+s35IOrGpxC/c61eH5jsSRhIdmTZLXFVPdjk=;
        b=Ff8+7ZCxbPHK89zoCZDmFoqtSf9UK+kvQJrQU6LEBOoqpFYdL1vy/GtsYpNT+Iuytr
         cHKEo8bIvb7kHXtZv1R/xv18zw7Kq25EW7LS45FqpJEQE7E5HrVk+G0QQ7K8pgOjEuJr
         AWF1StOvREzBr+eq3qSC1pxB9mBfcJSwYf8aljxYAnM4DE0xgQytGCe3CNBTlcHzOdzR
         BrEw6ZNBwnloZWYGeN5N6SIg93pjWBzQYA1TOUOi9RCkBixs+xciIVM7QNK9WiCg9Y82
         lrPy/PCtXzL0q6kjcoWAC6cNe2WCtOK+lB1VIRdcJZbRB9QnmOU8e3EvmOvrDb+ZVQGO
         p7kw==
X-Gm-Message-State: AOAM53106QRa8C38137aUJ807rmi0zYG+C+18Ab20WoW8SVTGvsif2IE
        fSxIlDbptWJpFZELW3p80apGnw==
X-Google-Smtp-Source: ABdhPJyn8dlt69y0gsG6wR+o/UXnjmbgFtRHWtdY8+d07kDxdHLobDPbTnYAeyYyMTxAPc9jYTsmYw==
X-Received: by 2002:a17:90b:3555:: with SMTP id lt21mr428742pjb.234.1594306318531;
        Thu, 09 Jul 2020 07:51:58 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id m1sm2791322pjy.0.2020.07.09.07.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 07:51:57 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     swboyd@chromium.org, linux-arm-msm@vger.kernel.org,
        ctheegal@codeaurora.org, mkshah@codeaurora.org, mka@chromium.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        akashast@codeaurora.org, georgi.djakov@linaro.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH v2 0/2] spi: spi-qcom-qspi: Avoid some per-transfer overhead
Date:   Thu,  9 Jul 2020 07:51:43 -0700
Message-Id: <20200709145145.4055619-1-dianders@chromium.org>
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

Changes in v2:
- Return error from runtime resume if dev_pm_opp_set_rate() fails.

Douglas Anderson (2):
  spi: spi-qcom-qspi: Avoid clock setting if not needed
  spi: spi-qcom-qspi: Set an autosuspend delay of 250 ms

 drivers/spi/spi-qcom-qspi.c | 43 ++++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 10 deletions(-)

-- 
2.27.0.383.g050319c2ae-goog

