Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD055C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9C4A206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gey87y3j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731795AbgF2Vi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731536AbgF2Vhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:37:43 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55A1C03E979
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:37:42 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id t27so10876743ill.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qO4ruJi3PkHIFqtk9SeCvrzbofsNNbj7BYEByAmu5bA=;
        b=Gey87y3jt6nWsaveT2OTLNBOEHZawnXKmUWQlevdIEUWRgf7sOubP1TcMEKCXTj9mV
         r2nQ2Sv2HcbBNenrKbZ1479H4nyPjZrjXMRmrzt++sVcPCB8WUAyE5kpthQ0y51XWQnC
         52YdiC9EC7f7tw+/ap9OBgWfnPJ41THUCNJjzBRPFyRR46bi0VOYecwH3M1IWfpDKKez
         pLXpYNsZLLfJuA0LEvIib0MhoG6GpTsg41hdSI6esuIkD/gUA+LuDlhMZF8DJ+nflAKA
         uJaSZpGRFCS1nw3Jt0JwxZb1jowvkIYE7pBQ0xGKE4GcGhdzfc/438Hkbt1Oq9ORh+nP
         wjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qO4ruJi3PkHIFqtk9SeCvrzbofsNNbj7BYEByAmu5bA=;
        b=KZLR3ZGb/F4bcF5u2eLUk1AC+wUvdusZ8Nav5ZJK//y2IEyzszooZfFtyoZVgdiehv
         1NBOtZptbTA5ljUDVgZOLIJjdk17niz4PBXzNs0z5oSZM4F4q0Q5FjHoaQNujRrSwDqf
         3fmyNqCsOVLZZSPYlhuaIW45V6VLegPJVKtsSZYnm+EelIBfWasIc43pRXryu9vBG2gs
         3odBPezAxSQGtVNrXhPskRwN+YC0ez2Kk1VMfxBxVUWH5Db8ZohwSuNMsCuTjKWdN7dU
         Es7wqJVF++E9vg3VQVyfP0n+O22vCSxxTVu7RVgeXcI2huo0maNk3Rdy6fWyT6WP3YYc
         H/Dw==
X-Gm-Message-State: AOAM531v7OX9d3whoMDAjioZ/3ADSWtH3ZcAJ1DJbyzmk8T2pABuPwug
        wbjfv3nL3lGuLyHcvfjTHYFGhHOiT+g=
X-Google-Smtp-Source: ABdhPJwm4KYV+HQnzhOwU7UoeEZy92fwTDCelEPfXe7+2jgZFqpJkhmsmTWJh970ZUwuXV2rqJv/Gg==
X-Received: by 2002:a92:bb91:: with SMTP id x17mr16714746ilk.156.1593466662318;
        Mon, 29 Jun 2020 14:37:42 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id u6sm571353ilg.32.2020.06.29.14.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 14:37:41 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/3] net: ipa: small improvements
Date:   Mon, 29 Jun 2020 16:37:35 -0500
Message-Id: <20200629213738.1180618-1-elder@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains two patches that improve the error output
that's reported when an error occurs while changing the state of a
GSI channel or event ring.  The first ensures all such error
conditions report an error, and the second simplifies the messages a
little and ensures they are all consistent.

A third (indepenedent) patch gets rid of an unused symbol in the
microcontroller code.

					-Alex

Alex Elder (3):
  net: ipa: always report GSI state errors
  net: ipa: standarize more GSI error messages
  net: ipa: kill IPA_MEM_UC_OFFSET

 drivers/net/ipa/gsi.c    | 111 +++++++++++++++++++++------------------
 drivers/net/ipa/ipa_uc.c |  10 ++--
 2 files changed, 63 insertions(+), 58 deletions(-)

-- 
2.25.1

