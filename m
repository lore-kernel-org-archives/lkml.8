Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB00C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF63E20746
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XPPT51l7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730717AbgEDR7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 13:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730534AbgEDR7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:59:08 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72C5C061A41
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 10:59:07 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id n14so439439qke.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 10:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vqdw6T961NjpBgRT/XhyOu+dO0BOx3bSC8VPzWsBaf8=;
        b=XPPT51l7YVLzCOVDR8nXFLo0ll/gEhC+LGvA/j0yhs3ZktWvl0sAm3ZbfhvqTH3C/D
         ob0L3coYcB9BRxc3fZvibyxEE6yc6am6tRF7VR6G/N80RmcfUkKm+Dd3eVNcBoKTMkYj
         /Hq0E1m9fqBgPbBFdnr9j8qfc7mSf2egge2V/mVAOykoiw9QwObUn4IH9jPEYLFjSs+F
         TupT1A+dCMnVbX7hmJwpGXfzxkIaHlq8cT/EMPi48gSWtAUo8RDuh1Gq1v1dNMDgmiMv
         gUKFA1YpWXOqPL9yC3HmH5uy8dWiuR3v0/g78gPbreQidnKadkgNDdii6O0dTF8GoWXW
         e/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vqdw6T961NjpBgRT/XhyOu+dO0BOx3bSC8VPzWsBaf8=;
        b=jHYu78O6Kzx4DkEoX8Cj5h4AFqC6hL5uWcjV641kj2+RHnrK7dErg1p4Y3aCcZtbhH
         fvyFV/Y5M/OADwEVrPaJrZfTLjnt5Qr8sf+LrZK6mJ8lPd9Ymd8uyBWkBlGUhlIFqhlf
         O+5v+x65pFb5VU4ZssH9ub2IBL/7LfwejQ6hljNIPJN7QYII8MVNXLEUCKbIe/saVvUf
         x2qYDRmJK6VwrOzwYLdl5D8XG+RjKnoGoLxaA0lRrYO7UjU5r4CTcrMsS0grDFu95tEe
         EXarCssVT9zNIC1kQlhHZLom2UgqbZoyMGmENgkiLxD2j/bQ0EZmCv123Tt0LMiTbTGX
         95DA==
X-Gm-Message-State: AGi0Pub13edjd3KGQfxt+8TC5z6n/6PUzme4bfXoJV8cJqlvNORitJdp
        KPfMEOhO3UL4yIHDgwZlCmi6Fg==
X-Google-Smtp-Source: APiQypJJ+e8/no9p4zo1oA/7S8B1GlIpY1L/RkCv9O30uXiNL1i8dlLjNyWlL/9UZ7G1xUcxb/aAwA==
X-Received: by 2002:a37:8346:: with SMTP id f67mr367493qkd.283.1588615146701;
        Mon, 04 May 2020 10:59:06 -0700 (PDT)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id h19sm11271088qtk.78.2020.05.04.10.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 10:59:05 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        agross@kernel.org, robh+dt@kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/4] net: ipa: I/O map SMEM and IMEM
Date:   Mon,  4 May 2020 12:58:55 -0500
Message-Id: <20200504175859.22606-1-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the definition of two memory regions that must be
mapped for IPA to access through an SMMU.  It requires the SMMU to
be defined in the IPA node in the SoC's Device Tree file.

There is no change since version 1 to the content of the code in
these patches, *however* this time the first patch is an update to
the binding definition rather than an update to a DTS file.

					-Alex

Alex Elder (4):
  dt-bindings: net: add IPA iommus property
  net: ipa: redefine struct ipa_mem_data
  net: ipa: define IMEM memory region for IPA
  net: ipa: define SMEM memory region for IPA

 .../devicetree/bindings/net/qcom,ipa.yaml     |  10 +-
 drivers/net/ipa/ipa.h                         |  10 +
 drivers/net/ipa/ipa_data-sc7180.c             |  14 +-
 drivers/net/ipa/ipa_data-sdm845.c             |  14 +-
 drivers/net/ipa/ipa_data.h                    |  23 +-
 drivers/net/ipa/ipa_main.c                    |   2 +-
 drivers/net/ipa/ipa_mem.c                     | 209 +++++++++++++++++-
 drivers/net/ipa/ipa_mem.h                     |   3 +-
 8 files changed, 263 insertions(+), 22 deletions(-)

-- 
2.20.1

