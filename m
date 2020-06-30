Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D4DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5BD820722
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qktvBjuh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732503AbgF3NdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729087AbgF3NdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:33:08 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A726C03E979
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:33:08 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id m81so21004945ioa.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=50y5RQTNSL9sGJxIm/QKoG33zZOanVkfX/t52b35bno=;
        b=qktvBjuhjsXrXaxT1UWyNtEj7NsfssmCv0H1cJJ64FiwxL0If+RW7MWCWKvqcvT3dY
         r6fuhkedTU+k1K4iP/Oxn1E+qSGfq8djM9I3uaqN7wJCVJjsim7tIVYs8CQ7liTRkU6r
         Fj9zxbZfvugIDi/pPaVkGvpEmmvQ9OyI4wJoiGAR+CZ3ATuLkq/EnQbIixSrHhfcvfyb
         kq2q5fb75w9+4bWw5K6eVcx8HRiYlqb6rp0B0umvxlbZOCqgXgmgODgle76CwKl2tpL3
         Ttl/bV9hHa7ByC9rrNJHsf1YU3nUkUemkFIiohtxmjjjMRTptldiJEMVe2FWRIWon4nP
         /hhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=50y5RQTNSL9sGJxIm/QKoG33zZOanVkfX/t52b35bno=;
        b=gsKr+k3ZedyqTxs3ufWmiz+AqHqg9EUJRpTbKlxGGKHmiw9iyEkXDBu/0OWkxbH77X
         RHlrjX2V6juY5EOL9SnN0cQs41BDj8JmuQ7kHf1peiHWzXXTHuedYPSbBGlKWwVRHzEC
         L5VSt6xN2ihOP9ZaYEBPl3rUGoTtnc9NKDnRhTXfcXNKviOvoRDx2vqcftk0fw4QiSaS
         uCCXfdtbWnNgha0MDM+z7rotglDW48zy6HzatK3kteysnwpdEsx1+SPRDE/9L38ovOnh
         Fk6YORexRoI0aUgYiLEDJfpq2AIULf4mL3k0Nxl/lrl/zS3Md2n0mkyKhCiMxabJWbM5
         OkKw==
X-Gm-Message-State: AOAM533GBfT2y9hK0a+LUnlBHN65G3AhfSq1vgJ2RrrYbzCozXX4pFNT
        8xGdwYg8fGqKgcrtcVWiADvL8g==
X-Google-Smtp-Source: ABdhPJyZuzdgZoGfAXgUwB/VLEozOD8GKSaRVs5bPny9vwWqpUnzr6p31/KGAzqtkctc8DrWMkGL9A==
X-Received: by 2002:a6b:bc41:: with SMTP id m62mr6829591iof.95.1593523987716;
        Tue, 30 Jun 2020 06:33:07 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id u15sm1538776iog.18.2020.06.30.06.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:33:06 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/5] net: ipa: endpoint configuration updates
Date:   Tue, 30 Jun 2020 08:32:59 -0500
Message-Id: <20200630133304.1331058-1-elder@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series updates code that configures IPA endpoints.  The changes
made mainly affect access to registers that are valid only for RX, or
only for TX endpoints.

The first three patches avoid writing endpoint registers if they are
not defined to be valid.  The fourth patch slightly modifies the
parameters for the offset macros used for these endpoint registers,
to make it explicit when only some endpoints are valid.

The last patch just tweaks one line of code so it uses a convention
used everywhere else in the driver.

Version 2 of this series eliminates some of the "assert()" comments
that Jakub inquired about.  The ones removed will actually go away
in an upcoming (not-yet-posted) patch series anyway.

					-Alex

Alex Elder (5):
  net: ipa: head-of-line block registers are RX only
  net: ipa: metadata_mask register is RX only
  net: ipa: mode register is TX only
  net: ipa: clarify endpoint register macro constraints
  net: ipa: HOL_BLOCK_EN_FMASK is a 1-bit mask

 drivers/net/ipa/ipa_endpoint.c | 14 +++++------
 drivers/net/ipa/ipa_reg.h      | 43 ++++++++++++++++++++--------------
 2 files changed, 32 insertions(+), 25 deletions(-)

-- 
2.25.1

