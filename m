Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C360C47256
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 07:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B2A220721
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 07:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gTUcBPhX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbgEEHo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 03:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725915AbgEEHo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 03:44:58 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A960C061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 00:44:58 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id b6so446095plz.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 00:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O2pv13qx7VFGbbGCBI+M8Dk49yxcXbYowJJnWYcKPyA=;
        b=gTUcBPhXn7zwDJld52yMM64s04tMkXRJBQG1NWq/zYwXC6B1H01YZwAbf03E0N+d3a
         dsYVRX3mdZ9pP3VUEc1ki2liSb7gzB2RnSZzS39WlTfSWX5IENahsL6Ptt8mKz3pYpcg
         OyJfrpRgzQWKerlBIyhp3wbvemUv+0LOlwiCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O2pv13qx7VFGbbGCBI+M8Dk49yxcXbYowJJnWYcKPyA=;
        b=hMnrt2aKMxBu/kxs5+hxtlkqr9SAXWxcFoYC9pvtq46o8dbq3jJDYxhPBISAUPdQrT
         YIRgtHM8yTupF0BTTSYwLtlW03p4t00xJey/39mqjwPJXy+v8Tjv/n/8pFsouBgJC39U
         RLeC7X3EdDXDOP1G9vZnR0sdBf9hDJZemXeAuGzsA0OHhxk4rGY2tUIim61puQlifGTK
         nYMsEhlNrqxtoLXWP/3cGtt00HoKIDrjBHNtIoYt+LXOnF/674OaHHFfVfCyyZumOB0Z
         +rXYDKP1332g4Jqt8YsM7LJGNpMwVcEkOKLqYMgBbv2GG+OmHidM8eKUPFEqLLQPN62L
         3ktQ==
X-Gm-Message-State: AGi0PuZeNxz7BnBVl6RCI88bedmdKyjgq8AZWoUwBuU0cpgGMsQFbqFN
        f/DA9sH7USvMnWocntlrmOo2GZExBjg=
X-Google-Smtp-Source: APiQypKEj76sEkdrmamm6pACw3UuGZqt7SISdTgTQwe/a0f+om4l4A/EzQV+B3BPoL0Bs/K056M7Kg==
X-Received: by 2002:a17:902:8687:: with SMTP id g7mr1976063plo.59.1588664697580;
        Tue, 05 May 2020 00:44:57 -0700 (PDT)
Received: from localhost ([2401:fa00:9:14:a92f:c47d:76a8:b09e])
        by smtp.gmail.com with ESMTPSA id j5sm1205741pfh.58.2020.05.05.00.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 00:44:57 -0700 (PDT)
From:   Eizan Miyamoto <eizan@chromium.org>
X-Google-Original-From: Eizan Miyamoto <eizan@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Eizan Miyamoto <eizan@google.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v1 0/2] Refactor MDP driver and add dummy component driver
Date:   Tue,  5 May 2020 17:44:29 +1000
Message-Id: <20200505074431.242840-1-eizan@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series depends on changes in
https://patchwork.kernel.org/patch/11528171/

We are adding a dummy MDP component driver so that all the components
are properly configured with IOMMUs and LARBs. This is required for
us to get hardware video decode working in 4.19, and possibly newer
kernels.


Eizan Miyamoto (2):
  [media] mtk-mdp: add driver to probe mdp components
  [media] mtk-mdp: use pm_runtime in MDP component driver

 drivers/media/platform/mtk-mdp/mtk_mdp_comp.c | 186 +++++++++++++++---
 drivers/media/platform/mtk-mdp/mtk_mdp_comp.h |  33 +---
 drivers/media/platform/mtk-mdp/mtk_mdp_core.c | 177 ++++++++++++-----
 drivers/media/platform/mtk-mdp/mtk_mdp_core.h |   1 +
 4 files changed, 297 insertions(+), 100 deletions(-)

-- 
2.26.2.526.g744177e7f7-goog

