Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCEAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9271F206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o3GSUT29"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgHXSaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 14:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgHXSaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 14:30:07 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDADDC061573;
        Mon, 24 Aug 2020 11:30:07 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id 2so4743934pjx.5;
        Mon, 24 Aug 2020 11:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VTtbXipo5H4nLyDYTKcE4hPeblvL2h4pyUGSarWbxLM=;
        b=o3GSUT295NtYp3jigtP9n+oJuGGEDYcCd9nKF7XsOCafmopwVHslYgT8JtqzfUkFWw
         qemKksjqv0lEhagptQm3nOPucQPLLHoguebYNAJiN/QvL11c35czr7PQsgAMPHNb2BS6
         KMKUE0oim8iK06hUnSsAE1wCR96oMbbsQ9ZH1YTlQhah6NfZddP/YN61XjkzSMbDY14d
         q8WDFjFEFS0hP0KaNF22+Zz573quj/SBNIs00unVpUN1QqgTfhvAiLN/Tcubopq523/b
         oLVs1BmWncBewmKuOGfzP4veLDuCHMGlzcrT2kC5XQz5a//doi3TWYYjosbJRJFDV8kM
         0ImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VTtbXipo5H4nLyDYTKcE4hPeblvL2h4pyUGSarWbxLM=;
        b=BkL5U2y2hCtQLMRw6lo+9JCSIWKz1qUxGcZYCsA6+cqR0lYiNeX6LqaABa/bTkIE4O
         nAb51jjX/k1AZ9e3bsJLhZwYubPme/jPzJQAIs7uyfuRbtjeRjBiIfGaxJsTvEKa/1Nn
         5k7jT+7FMYsWBxL51eSFLEojMCYzYNP63KrnM4C7i+18HqelHkj78rrRM+wyqXrFDlYL
         FhtAz1vsVP1J2+Z1KJ2dG6vfspWm0Deihc7h0epiYxlklvtkugS8xujB5mH6faPc+xv0
         9UKv2TEIvQgZR3qv7uQXgyQZcryPDdE1VlY4Arv+6j5ApJ9IiYYepLkq6CSgBwTje1I+
         DBlQ==
X-Gm-Message-State: AOAM532bCMQU9+qnVxJS8RBxEfSAMGkBvIZfq3St4fcsklS+OH/uPAd/
        wcsb1f+DI7/dpNJdrcHNpGI=
X-Google-Smtp-Source: ABdhPJxQxip8b858OIV+lcoHjahNusQHsiE27qrNi7x4jNKo1SHhplSUttfpEhb7Kh7iTeXIfpQ0lQ==
X-Received: by 2002:a17:90a:5a01:: with SMTP id b1mr429154pjd.27.1598293807069;
        Mon, 24 Aug 2020 11:30:07 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id a66sm3920460pfa.176.2020.08.24.11.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 11:30:06 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH 0/2] ARM: dts: aspeed: wedge40: fix a few nits
Date:   Mon, 24 Aug 2020 11:29:53 -0700
Message-Id: <20200824182955.7988-1-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

This patch series fixes a few nits in wedge40 device tree.

Patch #1 updates FMC flash label so it's consistent with other Facebook
OpenBMC platforms.

Patch #2 updates UART4 pin settings for the purpose of RS485 software
emulation.

Tao Ren (2):
  ARM: dts: aspeed: wedge40: Update FMC flash0 label
  ARM: dts: aspeed: wedge40: Update UART4 pin settings

 arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.17.1

