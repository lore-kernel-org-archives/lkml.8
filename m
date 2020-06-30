Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40E5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 12:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7864B20780
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 12:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GmuZE7TV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387848AbgF3Mou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 08:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387834AbgF3Mos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 08:44:48 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FB9C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 05:44:48 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id v6so7110954iob.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 05:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b0Qug6jhcczxjVenUp7X4KAwgvvTxVc+J2oudLK16OE=;
        b=GmuZE7TVcNTtE02ICiPc8MOgbiCVEaUlJaGhANqsATTiNLE3ez86zpcik4vMXOV5il
         KEAq36panVyu7+0GtxhXIaZT+T9BhXketVaTwSmTJRRtSrxKQv/WCUmyrhZ3CSYS29N7
         +qNz6G3XLs0dGwSaXTczUy/33cjgrlKmhEi9c7EipHXlmvRhWmuyUPTkcwDD1/6OGu1i
         Kc3GNFSMd30GYSc1MDNz76L/ufjAGY90K8wh5aUT0hOvJbieJwQLwXiAGdOJtkcm+qGH
         NJqH5AgbvgS6y0CYPJAAT5KRqugLCb+9bU3/Ivz12hW7lI+wnli9/xGAtD4HJYgoV5HZ
         2Svg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b0Qug6jhcczxjVenUp7X4KAwgvvTxVc+J2oudLK16OE=;
        b=rtqqCLwFUTFdCCj8GQP5UKg9xBrdQ9LMMKluSJWZOkc605NWNHq+FcbEkTz60Pcjtm
         MPLcXhx5zeW25lgcpPI9PqhOsRn6DqbjHSKwWdQTCRDwv9klv42TsuTHXBQHSMwT5uli
         EwERfITODXBP2xmNGbN6h5S3vf2geSYWCPl8vkOXygAGsZ6xP5TCjzUPkFAG17bKBtno
         SHztp6aU0OrGluhNGlArvZTUWmxYx5SBOu6TWqgZYp7exBJIdj4YYkePOddWm2QfaJ0s
         Vj+H4o4SdVFsDBhIoAW+iBZbpy+xoRs3Y5wkLZnIC4ixFUzY+dTKkYRAaNk76a2jn7O3
         9T7g==
X-Gm-Message-State: AOAM531EeRW9axFpdmvZD15wwPjve0aFBBYu8n8r6UImLCqcA+6lSKNc
        XLFQ0nV8dyNfLuwd+BA02/zgAg==
X-Google-Smtp-Source: ABdhPJzbMB6YN2qrnMFfnuWVN3o9Qbc4Z5zSlE8lD2VmkFISTbPUk/aZIGANuOERNVrSUn02WcVhPQ==
X-Received: by 2002:a05:6638:236:: with SMTP id f22mr22745582jaq.18.1593521087853;
        Tue, 30 Jun 2020 05:44:47 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id t83sm1697536ilb.47.2020.06.30.05.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 05:44:47 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net v2 0/3] net: ipa: three bug fixes
Date:   Tue, 30 Jun 2020 07:44:41 -0500
Message-Id: <20200630124444.1240107-1-elder@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains three bug fixes for the Qualcomm IPA driver.
In practice these bugs are unlikke.y to be harmful, but they do
represent incorrect code.

Version 2 adds "Fixes" tags to two of the patches and fixes a typo
in one (found by checkpatch.pl).

					-Alex

Alex Elder (3):
  net: ipa: always check for stopped channel
  net: ipa: no checksum offload for SDM845 LAN RX
  net: ipa: introduce ipa_cmd_tag_process()

 drivers/net/ipa/gsi.c             | 16 +++++++---------
 drivers/net/ipa/ipa_cmd.c         | 15 +++++++++++++++
 drivers/net/ipa/ipa_cmd.h         |  8 ++++++++
 drivers/net/ipa/ipa_data-sdm845.c |  1 -
 drivers/net/ipa/ipa_endpoint.c    |  2 ++
 5 files changed, 32 insertions(+), 10 deletions(-)

-- 
2.25.1

