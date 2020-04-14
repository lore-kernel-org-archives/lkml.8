Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25D2C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 03:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A152520644
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 03:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F03OGL1N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404767AbgDNDdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 23:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404756AbgDNDdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 23:33:35 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B890BC0A3BDC;
        Mon, 13 Apr 2020 20:33:33 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id x26so4233139pgc.10;
        Mon, 13 Apr 2020 20:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e1I6YF+VJ57pEb1USvw1okp6yWunIg/IfHp9i2omTR0=;
        b=F03OGL1NGLi1sgHbYBhEZNMP48siZFUj5XoT+Gyy9eeLJUCt7IjIoBFDkuohdy9um6
         Z+eIV1Nnhl5f/Rnlh5TPju7t9FiEA9CEwSMr0fUw7T8C08qLMecp5YHhmb+q+y1NcCHu
         S/50B+TqnCtl8F7vQ+Fv8B5iYXiD7en+BS0d+++VodBkLe/CUE3TEtGoXMqt6gToago6
         Zdz2Xew+u5bc1tPNyd+sa8quuu+h2oOjv3uE5/VP5LOWd3PraeYiwvvTU1NHYusGc9wU
         3yrJ0nFClaPnXsKw8GHk4nD7XG3iPHXOYCQdm8+g2xPiy7M3IK+QwJXW0Zg68INKG+OR
         KvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e1I6YF+VJ57pEb1USvw1okp6yWunIg/IfHp9i2omTR0=;
        b=g+GGFCZXEPEoV4Y9UtAlwPJOBBkMGI0mZaKcLXqvp/68jHo7EvWL8KyM5PHaZ2bz+X
         4ippF3SjZuTz25RLq1ywEuKLGduqLIOFm4LKDC1tkoNGxu0LbjfUiV3nO59VnHo+/ggd
         iUDtuuAR34sNNhBmuCwbRqN/ppBKUEu7FUm6n5Ls93h2U9n+Fxl/AqoJ+imKHRHmqC92
         nJKbX7sfVS4zof/4yMi9OEBHUNPkslUPaZKmg99hhdFwlPxL3qp/nl8m2paXJbJggWd7
         r8rep5+3Gy+f0mh9no8DgZ0Zw8fdUADXHDEoTaq9R+n2pFW5chi+vJvsQ4kP6YZ9yRqb
         60ig==
X-Gm-Message-State: AGi0PuZy9b7TlOOIqsf83itlWGQveakEmKbBVkb4/g6IiwgQo9lCql0o
        /MEveZhQ865IlK0VaNqP1Lc=
X-Google-Smtp-Source: APiQypIFuvcgiaYOp3jBFttcXV/yqL76ouid7CoBnHHhWLQBwaNNFqlAJAiN6wOhME3K7vZQuxGJWw==
X-Received: by 2002:aa7:9f0e:: with SMTP id g14mr297123pfr.75.1586835213326;
        Mon, 13 Apr 2020 20:33:33 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 140sm5612440pge.49.2020.04.13.20.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 20:33:32 -0700 (PDT)
From:   zhang.lyra@gmail.com
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH v2 0/4] add mipi_csi_xx gate clocks for SC9863A
Date:   Tue, 14 Apr 2020 11:33:21 +0800
Message-Id: <20200414033325.26536-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

mipi_csi_xx clocks are used by camera sensors. These clocks cannot be
accessed (even read) if their parent gate clock is disabled. So this
patchset also add a check to parent clocks when reading these gate
clocks which marked with the specific flag (SPRD_GATE_NON_AON).

changes from v1:
* added Rob's acked-by;

Chunyan Zhang (4):
  clk: sprd: check its parent status before reading gate clock
  dt-bindings: clk: sprd: add mipi_csi_xx clocks for SC9863A
  clk: sprd: add dt-bindings include for mipi_csi_xx clocks
  clk: sprd: add mipi_csi_xx gate clocks

 .../bindings/clock/sprd,sc9863a-clk.yaml      |  1 +
 drivers/clk/sprd/gate.c                       |  7 ++++
 drivers/clk/sprd/gate.h                       |  9 ++++++
 drivers/clk/sprd/sc9863a-clk.c                | 32 +++++++++++++++++++
 include/dt-bindings/clock/sprd,sc9863a-clk.h  |  5 +++
 5 files changed, 54 insertions(+)

-- 
2.20.1

