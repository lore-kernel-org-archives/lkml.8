Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AFFC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ADC82068E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tDXanxAu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbgEDXaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 19:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbgEDXaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 19:30:16 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DFFC061A0F
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 16:30:15 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b6so527384qkh.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 16:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZBc+PcefEfR4/vKXm3LERVOyhVmQ3WDeB0fuysL9Yg8=;
        b=tDXanxAudaCjvCTkpg/BK6/fix93BEE/+gnqN29tge5PNAJgwX3rrfcZX2o1TDtEpL
         5q3C8VjsFMSkOZt6qxTlZg0Z8gS6jdqvTrYFceAmqyaEP4zGacyqhMkU6wAjHl+wsb0Q
         07MloAwFlkW0zarJyPx8bxIqCC/E5rniRaSCoKHv00FjgKF92T09xmojwVUSXlo/WGJI
         PfvA7A3pBeZkXN28BvOBNlSPhAZYHOMmitau8Tm2GhHybMlQihBU8/V2Yf2Ame7RZz6c
         tGCxKLZhYFtkLIsxHIwyRn6BxQr/+SteGgo/GtXQ8eGibHclStiHQAUpCEXE4NBLvC92
         8hzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZBc+PcefEfR4/vKXm3LERVOyhVmQ3WDeB0fuysL9Yg8=;
        b=G635J52EvQpEQ0vaGd8nEEdgtrsveD6aT9goS2UJqLNDjvSLlLO8ZqS5P/1cnbfm+t
         Ev3yw5WCi/S4eHw7c5qmCQKVyjM4wwqIX6dGFXY/9IeuQSsCTOmO7z2yGNu8sfGXwv1U
         lsH+csu9jIwntfK//CiShh9caiTYd1YcKnupfl9MznuasX6nAi6+97wZ7pK40077ojpF
         mnlnOL3b1zAcAt3m49mw9q2eaal/vym72ZCHqNIz9RqDP25c0jmCZtdAfJ6tKnXbPJ20
         iKcVrPs9zJu7Af8aia+cYAe/RnVxm7ss8FZQ6QExy5j4nzfflsf638tyW+TWWlEPDr8g
         7JZw==
X-Gm-Message-State: AGi0PuZhw3USZeZvTpLRx0DrQXG+1/Cnzd3NvwgaapPWOiRoz44O10dW
        96O0ohXcF45l6tYMUlOgRVcCE7vHfpc=
X-Google-Smtp-Source: APiQypKkOFL6XLk3UlAyGUKU5tlTZOJIL57K9M6UeUc/14P66LocB7Chg+CxagnIfeA1KcajoS/HkA==
X-Received: by 2002:a05:620a:490:: with SMTP id 16mr826721qkr.203.1588635014981;
        Mon, 04 May 2020 16:30:14 -0700 (PDT)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id c41sm253033qta.96.2020.05.04.16.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 16:30:14 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] net: ipa: limit special reset handling
Date:   Mon,  4 May 2020 18:30:01 -0500
Message-Id: <20200504233003.16670-1-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some special handling done during channel reset should only be done
for IPA hardare version 3.5.1.  This series generalizes the meaning
of a flag passed to indicate special behavior, then has the special
handling be used only when appropriate.

					-Alex

Alex Elder (2):
  net: ipa: rename db_enable flag
  net: ipa: only reset channel twice for IPA v3.5.1

 drivers/net/ipa/gsi.c          | 20 ++++++++++----------
 drivers/net/ipa/gsi.h          | 12 ++++++------
 drivers/net/ipa/ipa_endpoint.c | 12 ++++++------
 drivers/net/ipa/ipa_main.c     |  2 +-
 4 files changed, 23 insertions(+), 23 deletions(-)

-- 
2.20.1

