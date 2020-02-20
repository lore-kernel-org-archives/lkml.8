Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F5FC11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD66208CD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tKINAgJ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbgBTPNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 10:13:55 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36850 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbgBTPNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:13:55 -0500
Received: by mail-pl1-f194.google.com with SMTP id a6so1675519plm.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 07:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=bMJUAglWaWbIZEErlVZ0yTCdWDkC7jYkZQda3XXE62Q=;
        b=tKINAgJ0p6sZD6U0O2h4bwxpfrupZWDIqr9wXBctvFse5GFxMsHnN02iA8U7YzBzri
         /KllxP2aOugr4N+X5pjCoQjP2YocZX6OwA16WqOdats8MmO9a9IWDCMdZdP+AhYQ7NwM
         GaG9S8eTwzFbK1QwJbi3HTEM1APmHUmOKdhycCPXRyIx8scR1bt1U6R4/ZxvfYmudeAn
         W/KzS4QLixLg08s30YcWaB+Lt1iTbaPgF9yTx2bcWq6Za35zBYLlXPETPRHzf5Lo1Gc4
         +j2wvjDhusuW52lJAQ4TIl72d+TV2koEEwWDXfOaWwXU29r0czUn/Yq6RtmK6U5BcGd2
         dyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bMJUAglWaWbIZEErlVZ0yTCdWDkC7jYkZQda3XXE62Q=;
        b=kFvG2vGZUy94rBe7VxkLmKi1VUKjjm3VpUe7At+Jg1MvZzyYGs1McBhORo/RdPddxC
         f4M6tzPVwOF0GgCn941n3cHewvGGXmaTO8Amfv/XTw2KZG8u5uN2dbJ0CKw9z9J4sbIN
         RDb864cAh/Be+BJD3rnJg/7fm+TDmG7dJLGWcnu1h9jqfPtYDqPEfpQO5+a8hUOUYf5i
         2y3C+FcLDloWW5UsdQ25frnHMFNjFos5weP41hAU+pmRAJl1saxJZd1cL9KLBup/5lJV
         E6QP6u0XZuQGbsByO/hW2JKCKqFalGzrQnrfTmZV8Izgo8ClsV/rYD9zSHFyXir99agM
         SRJw==
X-Gm-Message-State: APjAAAUs+PMQFlfPpb8r8h3Lpd85MtXyOpjbtz84D+GMuW4sxuWZJYbO
        wZQl8oM1nldFhht3aiplSo5O
X-Google-Smtp-Source: APXvYqzFGueZdfe/6uJyF21F4s62BQbhb3H52MtdFXDE0w3cedIOjDgSxh+cqOfTkyvv2VjV2nXIRw==
X-Received: by 2002:a17:902:59cd:: with SMTP id d13mr32010465plj.146.1582211634020;
        Thu, 20 Feb 2020 07:13:54 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:315:9501:8d83:d1eb:ead7:a798])
        by smtp.gmail.com with ESMTPSA id z16sm3865548pff.125.2020.02.20.07.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 07:13:53 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvalo@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/2] Migrate QRTR Nameservice to Kernel
Date:   Thu, 20 Feb 2020 20:43:25 +0530
Message-Id: <20200220151327.4823-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset migrates the Qualcomm IPC Router (QRTR) Nameservice from userspace
to kernel under net/qrtr.

The userspace implementation of it can be found here:
https://github.com/andersson/qrtr/blob/master/src/ns.c

This change is required for enabling the WiFi functionality of some Qualcomm
WLAN devices using ATH11K without any dependency on a userspace daemon. Since
the QRTR NS is not usually packed in most of the distros, users need to clone,
build and install it to get the WiFi working. It will become a hassle when the
user doesn't have any other source of network connectivity.

The original userspace code is published under BSD3 license. For migrating it
to Linux kernel, I have adapted Dual BSD/GPL license.

This patchset has been verified on Dragonboard410c and Intel NUC with QCA6390
WLAN device.

Thanks,
Mani

Changes in v2:

* Sorted the local variables in reverse XMAS tree order

Manivannan Sadhasivam (2):
  net: qrtr: Migrate nameservice to kernel from userspace
  net: qrtr: Fix the local node ID as 1

 net/qrtr/Makefile |   2 +-
 net/qrtr/ns.c     | 751 ++++++++++++++++++++++++++++++++++++++++++++++
 net/qrtr/qrtr.c   |  51 +---
 net/qrtr/qrtr.h   |   4 +
 4 files changed, 767 insertions(+), 41 deletions(-)
 create mode 100644 net/qrtr/ns.c

-- 
2.17.1

