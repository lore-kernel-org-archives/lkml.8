Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0864FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 10:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1105C22B45
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 10:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbgHDKSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 06:18:18 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44461 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728743AbgHDKSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 06:18:15 -0400
Received: from mail-pj1-f69.google.com ([209.85.216.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1k2u1N-0006ZZ-Df
        for linux-kernel@vger.kernel.org; Tue, 04 Aug 2020 10:18:13 +0000
Received: by mail-pj1-f69.google.com with SMTP id a6so189467pjd.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 03:18:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lztI+52PEieuECGw0yo1p950jYaSkaNvNIxQ6AqqJrE=;
        b=S48cHqWJcLNxYwS2t20BJ7tllcI1bLOx2ZuCzgGT8r70X4t7qpgeFibXAkm+KV6icO
         AdDzYGjXJEw/vUgprbdRw93hHaxl07dMAuZx0jXDS5lxxCuVI9dA+TgPFuyti6fM49Gg
         LH6gXModtNNkXM9tZ2F72QQHIPfMRIW5lN8awGjOZDbTLRfppnG4zAiB6v2vI6G0svHq
         LimnKTpOxkMR12Peg/NrNv7SUdop/Tw+n4wT0i5XFJq1M3uvo7kcOuBKL7C6XXnTw9fj
         FGkuVbfVDJdyj+BpMWNNZHNdIx2phL6a+hsnYk6ji0GCNXxeFhelqJEYnvKFEBU6RU3Q
         QuJQ==
X-Gm-Message-State: AOAM530zSPCHbJQA1nY7psEFT9oHBK6IzwUj2McT5UwqAyxiKyoE9Oci
        ZcY/kbrct2Z+t526296sgFh8J4EY5Bw/bXC+48XI9x1y8YzL7aSJGP5uPOIoqKQJatWkQ9Lsccd
        4WUYTmacguMyDCx/wNG82yzBNmhtrdlL/cjRhTDjE
X-Received: by 2002:a63:fe0a:: with SMTP id p10mr18203113pgh.255.1596536292071;
        Tue, 04 Aug 2020 03:18:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIHL8sYbPiRAjs0p3Qdwl8e3TgS6Y0hi0jCRXOqp6aBTdO0DvtzFLybPtMSrdBKmAqvym13g==
X-Received: by 2002:a63:fe0a:: with SMTP id p10mr18203102pgh.255.1596536291745;
        Tue, 04 Aug 2020 03:18:11 -0700 (PDT)
Received: from localhost.localdomain (111-71-32-223.emome-ip.hinet.net. [111.71.32.223])
        by smtp.gmail.com with ESMTPSA id g15sm15578674pfh.70.2020.08.04.03.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 03:18:10 -0700 (PDT)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     davem@davemloft.net, kuba@kernel.org, skhan@linuxfoundation.org
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] selftests: rtnetlink: Fix for false-negative return values
Date:   Tue,  4 Aug 2020 18:18:01 +0800
Message-Id: <20200804101803.23062-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset will address the false-negative return value issue
caused by the following:
  1. The return value "ret" in this script will be reset to 0 from
     the beginning of each sub-test in rtnetlink.sh, therefore this
     rtnetlink test will always pass if the last sub-test has passed.
  2. The test result from two sub-tests in kci_test_encap() were not
     being processed, thus they will not affect the final test result
     of this test.


Po-Hsu Lin (2):
  selftests: rtnetlink: correct the final return value for the test
  selftests: rtnetlink: make kci_test_encap() return sub-test result

 tools/testing/selftests/net/rtnetlink.sh | 68 +++++++++++++++++++++-----------
 1 file changed, 46 insertions(+), 22 deletions(-)

-- 
2.7.4

