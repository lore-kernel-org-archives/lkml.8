Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D909C47258
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 04:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6801620721
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 04:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L9xooj06"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgEEEBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 00:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgEEEBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 00:01:00 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62A2C061A10
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 21:00:59 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id q124so430391pgq.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 21:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zXcNVzanMlcydlCFrB2r+HWplGTpnlRV6J+MdBaPrW0=;
        b=L9xooj06SkKYA1F/mM6gzkXw0XRoE4+PPOkuKWhil2K0egyXKdJzupiMsGnMwT0YZQ
         xGiwlJ5L/ot5yLd7/aWq+6s6xqhhn81GenquLvLfmVrAVCzRFE5iCEWnvH3ef9uQv72m
         Ixc8jb7K6KPUUbjSkttRV/P8Yde3shEwk7HKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zXcNVzanMlcydlCFrB2r+HWplGTpnlRV6J+MdBaPrW0=;
        b=Jlgn0Iz+kogtJe+St936Kt+xEd/HhwbOGg6uX7kj1mYHpha8o5euALQBnqU3oeFA4F
         0nZAz0LifRLtXiDYbnBKdmMsy6ZM4520p//BvHc41d5uH51vN/jePobj/QQSMahQoXvd
         IAGZo5blcvhFbHtCNKSyo9GuVmZ0aYpDEEsl79+rMxbi9BQ4/ia+kJUGONTqAi0F67kW
         SvZpvTZv0Wnq+hEeIgxadS2YUq6giZ1b4SKbhIuSAPwZ5IDBL2WzgIbrYYppPqPCAum5
         3VMqCPPpzJzwlTKgXPfqqS8AFi4tcA7XKeBbEqab4JZSGXYfXnG0gtAc1q5UGIGy1uhN
         ra8g==
X-Gm-Message-State: AGi0PubIecZu6ny68Jkq8d7Ivn0dlUyVimiODK+BpYOLY7bt1jgARAnC
        JfWVZoDkTbplxHqo8yBorBQ9NDUY5MQ=
X-Google-Smtp-Source: APiQypIp32k7wFgY1LdvBHBmqXAPISaNhBFaTPFmVLXNVlSrCu74vyD+6Dj1MKLOgE+L+DG1C5YGzw==
X-Received: by 2002:a63:1103:: with SMTP id g3mr1357965pgl.206.1588651258943;
        Mon, 04 May 2020 21:00:58 -0700 (PDT)
Received: from localhost ([2401:fa00:9:14:a92f:c47d:76a8:b09e])
        by smtp.gmail.com with ESMTPSA id c124sm585707pfb.187.2020.05.04.21.00.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 21:00:58 -0700 (PDT)
From:   Eizan Miyamoto <eizan@chromium.org>
X-Google-Original-From: Eizan Miyamoto <eizan@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Eizan Miyamoto <eizan@chromium.org>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v1 0/5] MTK MDP driver cleanups to prep for futher work
Date:   Tue,  5 May 2020 14:00:43 +1000
Message-Id: <20200505040048.132493-1-eizan@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eizan Miyamoto <eizan@chromium.org>


It most notably converts an array of MDP components to a list instead,
but also removes some unused fields.

This series of patches does some cleanup in preparation for futher work
so that hardware video decode works on 4.19 and later kernels. We are
planning on adding a dummy driver for the relevant MDP components that
will be bound together using the component framework, which will enable
calls to set up IOMMUs and LARBs, and make calls into pm_runtime.


Eizan Miyamoto (5):
  [media] mtk-mdp: remove mtk_mdp_comp.regs from mtk_mdp_comp.h
  [media] mtk-mdp: handle vb2_dma_contig_set_max_seg_size errors during
    probe
  [media] mtk-mdp: handle vpu_wdt_reg_handler() errors during probe
  [media] mtk-mdp: convert mtk_mdp_dev.comp array to list
  [media] mtk-mdp: Remove mtk_mdp_comp.id and supporting functionality

 drivers/media/platform/mtk-mdp/mtk_mdp_comp.c | 60 ++-------------
 drivers/media/platform/mtk-mdp/mtk_mdp_comp.h | 23 +-----
 drivers/media/platform/mtk-mdp/mtk_mdp_core.c | 74 ++++++++++++-------
 drivers/media/platform/mtk-mdp/mtk_mdp_core.h | 10 ++-
 4 files changed, 68 insertions(+), 99 deletions(-)

-- 
2.26.2.526.g744177e7f7-goog

