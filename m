Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EB7C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52DC82071C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hCZM12KQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgD3VfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 17:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726654AbgD3VfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 17:35:18 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF22C035495
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 14:35:18 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id g26so2559468qtv.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 14:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kTk6yYIRjy/yH5ibrsyY7pGPZXvpxpVJg89xhFWMhmk=;
        b=hCZM12KQKj8y4MNe9iAZBBNYgArVcqYoUEI68Jt/z3WihDy4Gc5BHnXtJK6ccvZLKv
         9ZZsCoOiK9R6wURBQzaL5G6J8JUezpP7EqESYydO04f0XpUa/s96DolKGo1EXz+SVL6r
         V9yDSVLpRPxlxVwTYUfSiVBBTohaC/gN6AQUpj3S6txzHAHNl9KJOraZQEBC1gS2nf9f
         WfyA0ipMZLis2ahlnZgvcks361qVkMgEVqCgn2hE6DWQg+PI92gAYCdjli/GnaEQ1zsx
         WSmB2gK1EaUqhtkV8DXB3ClABpJtRnVlix7IK9GdHjrS6BJ1c7bhJcxvxb9SOZX2JY+F
         0I1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kTk6yYIRjy/yH5ibrsyY7pGPZXvpxpVJg89xhFWMhmk=;
        b=t45FYJDktwit7Mt4OpSa/Pu9pmNqjQPJqcX5Yey9TOUk3IWa1LYgfQdOUIHmV6AqJi
         eY/tvJ0+jPbxAKKpOiBzJJ+ZlJbTWMD6tWT5q8iDCzifbCOw++0W9dtgktv6zMLMDF9C
         nXzpvNkpUMu9WCCNUHCT1DlF621YfnhZh1yXLfFHo3p7yt/c4KREInxKg4dTGRVUTh1J
         CCOIkuSi6/ql0kurEeq+Qz/kFvlsVMeiWvlNZ02FvfQYEyoONw2y236O0UI7E36sXKPU
         KRtD5uKxXuLvEa59xJNk37ygNt6BDyUwyxtlFCV6xOGTdhfwyczxmrd66a6NzV5v1RHS
         bo3A==
X-Gm-Message-State: AGi0PuYOgktkoFqgLey4eQTV9uNPCBc6a+yPn5iX5P+1y7PRAU2Ipvv+
        m6266XgFcyZ67HJ0ZTaLDBjtS0sJaps=
X-Google-Smtp-Source: APiQypJ3FPyDD5FI3mYL1dKJRNwwgoAXCHnFt27ymnOfL1Nj6ShzWU/D+bdUQ1zy/rRsbE49SFFklA==
X-Received: by 2002:ac8:27cb:: with SMTP id x11mr636252qtx.272.1588282517788;
        Thu, 30 Apr 2020 14:35:17 -0700 (PDT)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id s190sm1112543qkh.23.2020.04.30.14.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 14:35:16 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net
Cc:     evgreen@chromium.org.net, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 0/3] net: ipa: three bug fixes
Date:   Thu, 30 Apr 2020 16:35:09 -0500
Message-Id: <20200430213512.3434-1-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes three bugs in the Qualcomm IPA code.  The third
adds a missing error code initialization step.

					-Alex

Alex Elder (3):
  net: ipa: fix a bug in ipa_endpoint_stop()
  net: ipa: fix an error message in gsi_channel_init_one()
  net: ipa: zero return code before issuing generic EE command

 drivers/net/ipa/gsi.c          | 11 +++++++++--
 drivers/net/ipa/gsi_reg.h      |  2 ++
 drivers/net/ipa/ipa_endpoint.c |  7 ++-----
 3 files changed, 13 insertions(+), 7 deletions(-)

-- 
2.20.1

