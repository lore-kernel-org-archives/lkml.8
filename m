Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F31C47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 05:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41DB1206F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 05:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kAUBHaIn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgEFFuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 01:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725771AbgEFFuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 01:50:02 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A909DC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 22:50:00 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id w65so447626pfc.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 22:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yzL6cUEC8Sb9M0V1vJgMsz/nqVpMVfxLp+rf/lwsZKU=;
        b=kAUBHaIn2XglY81EN0TH5ycwufqdQH9VevoTUibsMR40E5b2pIhc6cR9QKtdpRt36a
         Tbc7Iftyur5i+FyD7I2vkmk3ZmM0uWNr41YIGEsZ70mj/JHi7UC1LnPWsJL8DGq9kez4
         vswVXvyYNPJBwPManb3stNUHuwpIIufgTSweQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yzL6cUEC8Sb9M0V1vJgMsz/nqVpMVfxLp+rf/lwsZKU=;
        b=eLkbKg7xmzIhFJsbci4h1y6+09NT62pTBvrL515gQnl1aGzP2A3GK0KgQPYblhqgqp
         rWc3D52dwLR9Ks2K29vHlDWTUJYzIQH6NesyCBdBGnVxOodg2tWNeFGDnRXrn4SB8Zik
         gkReFhYvgTTHkRR4Hu0h5yAxuArZ5mjE4+TeNG03g5YZONr9pw1hMHh8ibOunqNWPLaV
         +6eUnTYZxb7noW4l+3OU1UdCx6B26vOfai97LfPK05v+pYTvGyiCnz/uWr1koBoj9qBE
         U6eHkdFLaqy9Zbjy2Gpgf2eoKOzJwfYlUHJcc49dpx8Lm1ZeOMGe0HBJCJWT7wwCWTrr
         GX6Q==
X-Gm-Message-State: AGi0Pub2T95NBRY3SbfNzu4vKG+dpab0uvL6FxkO0fJPQXAlMmjwf+Yt
        YxZ9bu+eEh+u6ilMc2Cya2nRBAExMB4=
X-Google-Smtp-Source: APiQypL44xNcKeY9JS5dfmN3iPs0MNug++UkszcoF+ZJvAg0ou5lbnqsDADn1qqg9HVVdPkFsqBSJA==
X-Received: by 2002:aa7:9589:: with SMTP id z9mr6512255pfj.247.1588744199913;
        Tue, 05 May 2020 22:49:59 -0700 (PDT)
Received: from localhost ([2401:fa00:9:14:a92f:c47d:76a8:b09e])
        by smtp.gmail.com with ESMTPSA id t5sm729738pgp.80.2020.05.05.22.49.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 22:49:59 -0700 (PDT)
From:   Eizan Miyamoto <eizan@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Eizan Miyamoto <eizan@chromium.org>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 0/5] MTK MDP driver cleanups to prep for futher work
Date:   Wed,  6 May 2020 15:49:15 +1000
Message-Id: <20200506054920.109738-1-eizan@chromium.org>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


It most notably converts an array of MDP components to a list instead,
but also removes some unused fields.

This series of patches does some cleanup in preparation for futher work
so that hardware video decode works on 4.19 and later kernels. We are
planning on adding a dummy driver for the relevant MDP components that
will be bound together using the component framework, which will enable
calls to set up IOMMUs and LARBs, and make calls into pm_runtime.

Changes in v2:
- remove unnecessary error handling labels in favor of err_m2m_register
- rebase onto linux-next/master to pick up
  757570f11fa4b0ce5472a6583de6f06e996a8527

Eizan Miyamoto (5):
  [media] mtk-mdp: remove mtk_mdp_comp.regs from mtk_mdp_comp.h
  [media] mtk-mdp: handle vb2_dma_contig_set_max_seg_size errors during
    probe
  [media] mtk-mdp: handle vpu_wdt_reg_handler() errors during probe
  [media] mtk-mdp: convert mtk_mdp_dev.comp array to list
  [media] mtk-mdp: Remove mtk_mdp_comp.id and supporting functionality

 drivers/media/platform/mtk-mdp/mtk_mdp_comp.c | 60 ++--------------
 drivers/media/platform/mtk-mdp/mtk_mdp_comp.h | 23 ++----
 drivers/media/platform/mtk-mdp/mtk_mdp_core.c | 70 ++++++++++++-------
 drivers/media/platform/mtk-mdp/mtk_mdp_core.h | 10 ++-
 4 files changed, 64 insertions(+), 99 deletions(-)

-- 
2.26.2.526.g744177e7f7-goog

