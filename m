Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FECDC47247
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7C67206EB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AX78Sr74"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgEDXhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 19:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbgEDXhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 19:37:19 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD4CC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 16:37:19 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id f13so608812qkh.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 16:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NmqrdSZ/Y+Xlzg+pTvttDGGcls5kXFETDmxtubd/Tn4=;
        b=AX78Sr74SJPtCmCpchCi0Vy0CGa/qXrgkySuX3Vn2RbXjBREkDGVq66DpI2RVQOhLG
         7eQo5Gmwq8vasVDSn3RNtbBZZIQ3ggRTY6nL9Jyb/GoBkYPCDU/w4Fmstg+qa4S7gID1
         pUYImr5A2gk9lHyCnUOOxu0Tduyj9Q9x1s+aiwkzlP7KEt6yKzP5HGuhMsTEeOx9RQN7
         oLCPiugCud2XL3gjtOoXoamnUcxD8DxCRrh1YOyl0u3bcVcczMiFu3/+rRBOBDkjwLn+
         y8qQi3vsCR0MXBJb7fUP50rsy1eqf3THYGcZFWEusY+/twSOeL4GK3iWfEiF4nuWs6w0
         SgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NmqrdSZ/Y+Xlzg+pTvttDGGcls5kXFETDmxtubd/Tn4=;
        b=ObOKQ1r5+U5M6MbJu0eUAe9G5XSFwSWD6okMraysxPoG/jVUt6cG2bwWe9IghVv/mf
         czZBQmZwjxSr3ClNfQLzMGBFadl9yLct0YhFHC1tQimxCL0Q/2nlgadGWzkGERjFfosd
         Gh1zfeUIsjtWGnKgL4oBXN4rjx9PaRe2Fuw5Y8FZVr/fbyTYGh65H+cRoaFs7VAWpxsy
         MxJ/gQOF/Qmk6riBUPrdZd9gWHCauK53M36+JTBdYkIfph9dWd2yAhXDTGk8LIpij1+c
         QqFyo2DuYKHRB0wbHLuqeLJq44bVdXl25XO12ksMcU+/cvmN04mJAYA4q1TnEcW3+Yf6
         ZL9Q==
X-Gm-Message-State: AGi0Pub4xB8Z2Ym6FeKnJBnPl90i5ema6NAF27I4Kgjk/E1U3nAEnz+q
        DIvaUf0PeBsCDRSuBQkPm5cyPQ==
X-Google-Smtp-Source: APiQypK0SLqC2CJhBLQb6Fdd5dAWtZ6mjCZVTsYjO73iT5weowzygqvBPta38zbvIiVf1fIDASMPpw==
X-Received: by 2002:a37:a45:: with SMTP id 66mr831106qkk.395.1588635438396;
        Mon, 04 May 2020 16:37:18 -0700 (PDT)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id x125sm494311qke.34.2020.05.04.16.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 16:37:17 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/3] net: ipa: kill endpoint delay mode workaround
Date:   Mon,  4 May 2020 18:37:10 -0500
Message-Id: <20200504233713.16954-1-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A "delay mode" feature was put in place to work around a problem
where packets could passed to the modem before it was ready to
handle them.  That problem no longer exists, and we don't need the
workaround any more so get rid of it.

					-Alex

Alex Elder (3):
  net: ipa: have ipa_endpoint_init_ctrl() return previous state
  net: ipa: introduce ipa_endpoint_program_suspend()
  net: ipa: remove endpoint delay mode feature

 drivers/net/ipa/ipa_data-sdm845.c |  1 -
 drivers/net/ipa/ipa_data.h        |  6 ---
 drivers/net/ipa/ipa_endpoint.c    | 85 ++++++++++++++++++-------------
 3 files changed, 49 insertions(+), 43 deletions(-)

-- 
2.20.1

