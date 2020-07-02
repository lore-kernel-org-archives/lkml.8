Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE04CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 00:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D44A2085B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 00:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IRRN360y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgGBApe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 20:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbgGBApd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 20:45:33 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC0AC08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 17:45:33 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id k71so8163932pje.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 17:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PF6PVg6Qk3aczs+/e1HWRyzHNDndSGQClfFztHhcrJA=;
        b=IRRN360yDKEMQxG9gT3EO16qJfg/TcpVShQcjRB9jTaTvchyHFTq4oTBH0DuMRu0L/
         DxZN8IBFt5WiQaBOohCA3SM0pCeDKhTQvwGElidlfN1JBrTftIKRZ2qvUbF7dSX31Ovl
         unSwAWVPVUgZe91Kk8wFDpHNz8uN3oouD+ZyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PF6PVg6Qk3aczs+/e1HWRyzHNDndSGQClfFztHhcrJA=;
        b=jF+hwoPqSUS2o5Cp4KmCBTn++uXXyMhJEwq9dmAmviY/fKnK/umGOVgQOajfcpRltE
         KLGGupbe8RCdvjyihvzy5UvluDMn3YvVwCDo22nV2kaFIVdt4lgdMg+ZIR3TxpQszB60
         xpSn07teZYUcLMP0B5vTFRV0GBrBasmdl9pnssOVzpL8CD4l5MhIlQAMRtKWWcVBS1pB
         EQrtHt0rJKvFRulspUhMkxjhBnO52/D6W/awt7lr0HXiubtJDBD9uuT0Inzwv9TBa92V
         oSVdBh93PA55hJ5TkI0wbT/yl6U65grpohD5Ob4ljUoGEilc37Yclic3qZjZyZqYlE8u
         e5Pg==
X-Gm-Message-State: AOAM532ewOYBIIGVY/MI0W3knSF1okGgEqQNd9uMHNcHEHOLi3Tor92T
        6Q6PXfYcsmzbXsXrw0TuZi4Tag==
X-Google-Smtp-Source: ABdhPJzPPKTtbw7LrsBUf0ic/Ijm1Yz9qx+hzC3WuV8qdS19siqcooPzbKzryXVcyy89dAYTRcTVbg==
X-Received: by 2002:a17:902:7896:: with SMTP id q22mr25007062pll.237.1593650732668;
        Wed, 01 Jul 2020 17:45:32 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id w4sm6966212pfd.39.2020.07.01.17.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 17:45:32 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     akashast@codeaurora.org, linux-arm-msm@vger.kernel.org,
        mkshah@codeaurora.org, swboyd@chromium.org,
        georgi.djakov@linaro.org, ctheegal@codeaurora.org,
        mka@chromium.org, Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH 0/3] spi: spi-geni-qcom: Avoid a bunch of per-transfer overhead
Date:   Wed,  1 Jul 2020 17:45:06 -0700
Message-Id: <20200702004509.2333554-1-dianders@chromium.org>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series tries to reduce a whole bunch of overhead in each SPI
transfer.  Much of this overhead is new with the recent interconnect
changes, but even without those changes we still had some overhead
that we could avoid.  Let's avoid all of it.

These changes are atop the Qualcomm tree to avoid merge conflicts.  If
they look good, the most expedient way to land them is probably to get
Ack's from Mark and land then via the Qualcomm tree.

Most testing was done on the Chrome OS 5.4 tree, but sanity check was
done on mainline.


Douglas Anderson (3):
  spi: spi-geni-qcom: Avoid clock setting if not needed
  spi: spi-geni-qcom: Set an autosuspend delay of 250 ms
  spi: spi-geni-qcom: Get rid of most overhead in prepare_message()

 drivers/spi/spi-geni-qcom.c | 67 ++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 35 deletions(-)

-- 
2.27.0.383.g050319c2ae-goog

