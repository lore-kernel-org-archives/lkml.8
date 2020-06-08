Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E4EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 20:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F28B8206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 20:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="I8PjRrly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgFHUpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 16:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbgFHUoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 16:44:12 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B8BC08C5C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 13:44:12 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id k22so15859060qtm.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 13:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u1ZoKjAu6rUCzvrD/I1LBfsHlqmIe5OQoQGQY8Je51A=;
        b=I8PjRrlyoZU3BAI3OzVNM91CimCbn5sysy/JXuJpUgNi+rH3UxEGFMWT+P9SkEyNQA
         0B961pHl7NbCPMPzFzaKK5EeKforKgWTezUP3mPPA0qrSArnRnRKJi6KqYpulKbZEfK7
         CKQmlYbwGBi74uxkm+ciYUQucEHhCNFN/rBNGhvPmO+cs/WJZ/D8ogMciUABKD19TrJv
         IEunkHo3srBabcdqelRt9vfhwlBLjbEo4k6ROv+FVd/dM1g2SJ4839WPGzkQbE9qm+8w
         Gi3wkCf1OhbND2TCM8qYgzlDzluKpHXTvUXpd5q2BttitRnJrV0KV0A618kDRpvxIHIB
         7D0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u1ZoKjAu6rUCzvrD/I1LBfsHlqmIe5OQoQGQY8Je51A=;
        b=A22pllSqd3+mXPK6vgfm8myLs9Yakst4le8VAItlRfNskMffm2Ie9WYKJImS6NGGq7
         pH1UkXszha4qFOXIY8f3tGd7UUdtsrngmTLnPdVb5zc2iodqFsujAENW4E2Ey6WoI6QH
         x74WM4oEELEpFGvdqTg6VAqNf9AV3tWI/YHb6KrO449IkScbquAxIJ/NMIQSxG61Pf2B
         pPhbEuRxUg4nNSIJC3YPG9Xv3wJ7SSR+NQF4jxlselDwrFL/SZ73dj7hq8wFzes8HvXQ
         zwkZiZWqajlKW1v4Lt8M1KqzZ7wZUS4UkwAYcGIVNYW3Sa1Wc9l1xrSU+d1Rws8DonUk
         VnbA==
X-Gm-Message-State: AOAM533XOSEPR4aIpj/P8NIGUAYwUCh71Qk6W02yv9e1jjb61ff0/bsH
        tom0EtygftewUKZbN+9hOEryHft3dMk=
X-Google-Smtp-Source: ABdhPJyNYZJ+80B0y31zjI9NpS6Sg0GULAYhl5LK6Q4WWLR0yFF5m1TPzUr/hk07+TKS0nHNjworXg==
X-Received: by 2002:ac8:1719:: with SMTP id w25mr26091041qtj.375.1591649051131;
        Mon, 08 Jun 2020 13:44:11 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id y16sm8895565qty.1.2020.06.08.13.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 13:44:10 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     alsa-devel@alsa-project.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        linux-kernel@vger.kernel.org (open list),
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 0/5] soundwire: qcom: add mmio support
Date:   Mon,  8 Jun 2020 16:43:41 -0400
Message-Id: <20200608204347.19685-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds initial support for soundwire device on sm8250.

Tested with the "wsa" sdw device, which is simpler than the others.

Jonathan Marek (5):
  soundwire: qcom: fix abh/ahb typo
  soundwire: qcom: add support for mmio soundwire devices
  soundwire: qcom: add v1.5.1 compatible
  soundwire: qcom: avoid dependency on CONFIG_SLIMBUS
  soundwire: qcom: enable CPU interrupts for mmio devices

 drivers/soundwire/Kconfig |  1 -
 drivers/soundwire/qcom.c  | 42 +++++++++++++++++++++++++++++++++++----
 2 files changed, 38 insertions(+), 5 deletions(-)

-- 
2.26.1

