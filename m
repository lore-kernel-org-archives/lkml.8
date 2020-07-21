Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182F7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 07:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E990420792
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 07:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YxKBrfQ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgGUHre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 03:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgGUHrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 03:47:33 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41200C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 00:47:33 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id q4so23086129lji.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 00:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=u3nXJRiSdppGTtPj2ppffsfRJMywt07Ft1M0Vjk21zc=;
        b=YxKBrfQ1VUCxq106/ImDl/osIy9f5cCVJPpaJSz6duopNcJ5cMjnp3+7ajb8vE06Fb
         oSfrS/y0P+KgjEEVnhaPqrBToNHJTSNfK/Ej8ZqGbNrSjvURVqcdwVVINTfvDNp9pbya
         d0ni5oGuM0QpweP64/dk/1phaqWFIVSiQ+iaibeJa3sfumYFAfL1X7Z0dSGyy2nNz+1A
         Km1kp1bQrupLOacS1kdRMnTT7ueOin38M5b5tYuJoWU0wPoTjEzSVUZXazuXt6etedV+
         9VxW9/mksXP7zR04PmR0EbpYdvsXHWofyAgc9AVHV2vL6G525qOuLB2UVy2jRYS5mcr/
         N8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=u3nXJRiSdppGTtPj2ppffsfRJMywt07Ft1M0Vjk21zc=;
        b=CDXfR/5g3lZV5rR7SuXp+vX5Iuq9iAH4tKvRZ1+zpu6kb7njWBftNVaJijBnklEQxz
         TyDvkkYFm7ens5LrqfT8BUGZYSvvIlNMmew4Z04vOMzCrxixHI7zU6bWCJqhuX7Nt4go
         gTHa4AvTGnjRWlrPPiWF2EDU/0L2yrx0mTWInKXzdVjWgBvEhDQTf+P860P/ZLPkOmIB
         BtPXL02v9eUPoFY17mrpGWPec4dwsLkPxvDxWhQUXdtOo+yICkyjqoY2GWdlOEZqzLMi
         MSa0TJm93Pn17Zif6L8xJMmqs/13qHLkV79BfWANGNw6yTcxdFp6fyEeOxe98x8if10t
         RpoA==
X-Gm-Message-State: AOAM533c9vaXRrQxfwSHOdR2h/IEawkpB+ed7DpXu8ZDJAr5/7yGqhfA
        uG3i5IUJBAzdpLNl1xU4YKTuz/k+dsE=
X-Google-Smtp-Source: ABdhPJxdoABtefVextDp7MWon7gvzta5PmjzgLS7mmgtJCLxMrSAj2wajyrHjBe6DdsCmTmyIw7qlw==
X-Received: by 2002:a05:651c:50d:: with SMTP id o13mr13083297ljp.181.1595317651371;
        Tue, 21 Jul 2020 00:47:31 -0700 (PDT)
Received: from localhost.localdomain ([195.24.90.54])
        by smtp.gmail.com with ESMTPSA id d2sm4045334ljg.6.2020.07.21.00.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 00:47:30 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kamil Debski <kamil@wypas.org>,
        Jeongtae Park <jtp.park@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Maheshwar Ajja <majja@codeaurora.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v2 0/6] Add new controls for CQ and Frame-skip
Date:   Tue, 21 Jul 2020 10:45:32 +0300
Message-Id: <20200721074538.505-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is v2 with following changes:

 * 3/6 Added references for VBV size and h264 CPB size - requested by Nicolas
 * 4/6 Fixed compile warning

Previous version can be found at [1].

regards,
Stan

[1] https://lkml.org/lkml/2020/7/20/619

Maheshwar Ajja (1):
  media: v4l2-ctrls: Add encoder constant quality control

Stanimir Varbanov (5):
  venus: venc: Add support for constant quality control
  media: v4l2-ctrl: Add frame-skip std encoder control
  venus: venc: Add support for frame-skip mode v4l2 control
  media: s5p-mfc: Use standard frame skip mode control
  media: docs: Deprecate mfc frame skip control

 .../media/v4l/ext-ctrls-codec.rst             | 53 +++++++++++++++++++
 drivers/media/platform/qcom/venus/core.h      |  2 +
 drivers/media/platform/qcom/venus/hfi_cmds.c  | 37 ++++++++++++-
 .../media/platform/qcom/venus/hfi_helper.h    | 10 +++-
 drivers/media/platform/qcom/venus/venc.c      | 20 +++++--
 .../media/platform/qcom/venus/venc_ctrls.c    | 18 ++++++-
 drivers/media/platform/s5p-mfc/s5p_mfc_enc.c  |  6 +++
 drivers/media/v4l2-core/v4l2-ctrls.c          | 12 +++++
 include/uapi/linux/v4l2-controls.h            |  8 +++
 9 files changed, 160 insertions(+), 6 deletions(-)

-- 
2.17.1

