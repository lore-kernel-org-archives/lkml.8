Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C8DC2D0E9
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 07:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3DCF20733
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 07:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eV5iDvB4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbgC3HPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 03:15:54 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40059 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729378AbgC3HPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 03:15:54 -0400
Received: by mail-pl1-f193.google.com with SMTP id h11so6368778plk.7;
        Mon, 30 Mar 2020 00:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P17o/o6KDGfQbKxyp4xKSvOUOltk09+/u6dJLWY/AmM=;
        b=eV5iDvB4/wVu/ieSmEJS5YHxKJf+nypxOsfr7YSjTzQljVPeMrTyWkIUcBKOn7U+Jx
         zlGGa9afcUb0P7u52mIXSwyJFJ0iC8Z82EPVZVcij5sd11RzokXi8L4VQag63/dpzV6A
         JI7YYk8nWd+EMLp/qfiMf5Tickw+NNMfFPCcYSew8CD+xcYijMw1K4Wk7vk4OJquUDQW
         4jgdE8Ya+ofjImaz9h+VsfsssnKABWKFaK9SyatqyfJpodMJ0CyeylGtRJAatodIBVGq
         +wqf9vEjXG8UHqmgnKwBUyBrs074Xu+F8p7XYy7shLw2RdN1jlJmt6a9wPN0P93eNUSk
         GPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P17o/o6KDGfQbKxyp4xKSvOUOltk09+/u6dJLWY/AmM=;
        b=bjGTtJuPjAzg0thhfjNkZpVO1TevxwlXJCGD8rCKNJ4zl4gGnWLhTwwDbX6YxPJGwc
         nGPfPh/MqYHJ2HH/XDgGJo0jytB+QNv0j5P4sPnam0QU9s3R7W2GzdFAjDrnrFbibtj7
         RyHTj8hhLl7CHpx7w9n9KFtrPIWDZJyILxeN9h91mxfsEJQYdy82ee6Gcmf72rd0jcJF
         OZooUpWwbBut3yxsptgymWuC01633la1XjpdziQ54PZr44l6rIyGUu05oXsp8N7HULFu
         ILxRJ+sgt+zzkBjCYdyWVEpDxYkMe0lqMOKZSZ0f2IwWdsv4zlLCy6UkZu1ad/mXjyg/
         6W6Q==
X-Gm-Message-State: ANhLgQ3C0yy3VRf02eEqwucUBGWBLz/FSuR9ejP+Ks5OKzu5+U7j2YF8
        Hom5ITQNW/OdH+ysMDPEIrU=
X-Google-Smtp-Source: ADFU+vtw6SXrU5ABy/32XD9DW/HCRj5Rh9fsAfaDQxstmmiR63iCC76PcQow5vQOBlODpxuaNzbLIA==
X-Received: by 2002:a17:90a:c401:: with SMTP id i1mr14072421pjt.131.1585552552067;
        Mon, 30 Mar 2020 00:15:52 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id l1sm9490484pje.9.2020.03.30.00.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 00:15:51 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH 0/4] add mipi_csi_xx gate clocks for SC9863A
Date:   Mon, 30 Mar 2020 15:14:47 +0800
Message-Id: <20200330071451.7899-1-zhang.lyra@gmail.com>
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

Chunyan Zhang (4):
  clk: sprd: check its parent status before reading gate clock
  dt-bindings: clk: sprd: add mipi_csi_xx clocks for SC9863A
  clk: sprd: add dt-bindings include for mipi_csi_xx clocks
  clk: sprd: add mipi_csi_xx gate clocks

 .../bindings/clock/sprd,sc9863a-clk.yaml      |  1 +
 drivers/clk/sprd/gate.c                       |  8 +++++
 drivers/clk/sprd/gate.h                       |  9 ++++++
 drivers/clk/sprd/sc9863a-clk.c                | 32 +++++++++++++++++++
 include/dt-bindings/clock/sprd,sc9863a-clk.h  |  5 +++
 5 files changed, 55 insertions(+)

-- 
2.20.1

