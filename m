Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE77BC2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 04:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9A902075A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 04:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QDlbQsLa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgDXEyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 00:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgDXEyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 00:54:16 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BE0C09B045
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 21:54:16 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id fu13so2889916pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 21:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DS2FPMD3YMzAKYFv1x/mNpC8vA9XuETk984Pr8jq1Qo=;
        b=QDlbQsLaKMUfSTZ5pO8xAAr2Pasv5p5jH0ir4yKJNe9n+2ECWMPRfEFuWo//M5slaA
         Mu8JLghQ5HeKJc5i7h3PVr0scTh0vSnqaWvkeb5K9kTgo3IZyVBXCELyvt4dQp2DAUkC
         Y52F7BZ/pJna973IOr2SoWAtUHW3AzwtToikg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DS2FPMD3YMzAKYFv1x/mNpC8vA9XuETk984Pr8jq1Qo=;
        b=iQzPJxP4RJyczd2fpS5ITwLrpa1hzq64RmW8Ff2yNRYDPKcSLy2ysROvEJjMXbHXVn
         0gLJEgHoUXb1qzel1WpkzeVOPPn1Oiw5bjxMot0fgajVTD7LQ2dRqHZk+3lBxWWC48uD
         erbjvskGcUAv45DLCWx7FPosfR9uye2kxW9W83Rm47M7UwZ55LKftcqdgJWVOh14CGx2
         0U8M4NjxAzcnFWU3tlXnIXcN9Y8VTVweto2oF/uZJA+1eeZbDBcmBhMNZo0vEv5Bsg3w
         e6zlSCG3eFI29hUqJTOx8sSSgvPzd7MQcsZMkAmglboa8OwzkXeot1pqIpvfWuYdoLST
         7OgA==
X-Gm-Message-State: AGi0PuYuGQPmC5MjBSu770X4ETwFXFfD8jlVPLk+MVeRbaddU02wCZX1
        17xHxiJts9/F0rmMV2+B0pvS04Ci7sc=
X-Google-Smtp-Source: APiQypIFOSReBrQ4/Z/rzt3TzSNnjk20vyx/Hu/4+mktapPfyChqQV5oll6/kV9RTcEALK4FELfa0g==
X-Received: by 2002:a17:90b:155:: with SMTP id em21mr4241129pjb.59.1587704055512;
        Thu, 23 Apr 2020 21:54:15 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 62sm4344680pfu.181.2020.04.23.21.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 21:54:15 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Maulik Shah <mkshah@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 0/3] Even moar rpmh cleanups
Date:   Thu, 23 Apr 2020 21:54:11 -0700
Message-Id: <20200424045414.133381-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patches based on Doug's latest series[1] on top of linux-next. We remove
the tcs_is_free() API and then do super micro optimizations on the irq
handler. I haven't tested anything here so most likely there's a bug!

Stephen Boyd (3):
  soc: qcom: rpmh-rsc: Remove tcs_is_free() API
  soc: qcom: rpmh-rsc: Loop over less bits in irq handler
  soc: qcom: rpmh-rsc: Fold WARN_ON() into if condition

 drivers/soc/qcom/rpmh-rsc.c | 64 ++++++++++++-------------------------
 1 file changed, 20 insertions(+), 44 deletions(-)

Cc: Maulik Shah <mkshah@codeaurora.org>
Cc: Douglas Anderson <dianders@chromium.org>

[1] https://lore.kernel.org/r/20200422145408.v4.1.Ic7096b3b9b7828cdd41cd5469a6dee5eb6abf549@changeid

base-commit: 02d8ecc18b8f392389ac9e7b785b0230ecb80833
prerequisite-patch-id: 0d383ea46ef52ab4044886a7d88d85c3c506f4ed
prerequisite-patch-id: a02b0b018404d1a0c79270ab567051656f123b23
prerequisite-patch-id: e59d990462b004a9f8335e87c2d0d747afec49ea
prerequisite-patch-id: 00d26aeb99c48521f74b32d3a6c57919d82ac1b1
prerequisite-patch-id: bb479b9adbe28c58b3ac8f363a306de80b6dcb74
-- 
Sent by a computer, using git, on the internet

