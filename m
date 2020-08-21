Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B541C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B3A0207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dWjxF9at"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgHUKZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 06:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728442AbgHUKZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 06:25:40 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88038C061385
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 03:25:39 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id d2so676077lfj.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 03:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=2N8c3OXNEzBTqLaVo87zY3CUmgiKJ+G+J6J7rbqIlbo=;
        b=dWjxF9atK4SA+a2BBicNZgWtD+gqRKIlSh+eCb9ZrWWWmny5I7dcFODj1k9M4BJzSE
         etCvGefxVNxefnJ1/rA/h+OPhvOlBEIFPkSYC2qV/wPFDgAhv2ndsSxen2CcE8VFHdna
         xD8cNdlR9bVDfDRQBzmfHaFUHcedQ44L+OgcIhfelTR1jc87aM7COGteuEHGwyXkgxNM
         VqAg9OhHOQydvhVu4ewZ+UcxuZDjwpT2Fru+Vz+lVrXUAoeTWEAIHUuhjk0DpeK9HXJR
         9gtq92Hi1VaEZcjY9rNkvpTyBFr9mXfTnqn4qoEBjw+7TByYYQzUnQMonyod4pxtHjgi
         dBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=2N8c3OXNEzBTqLaVo87zY3CUmgiKJ+G+J6J7rbqIlbo=;
        b=j6Nvg/a/2Ypo7ZF2CmGmxIxilK1JZOYXn3rofLHxYSBe531bhmtjg4kt5f82uVUf6y
         0DIG9B73MRQQixpiPPtgl1EQlqzBcdBeZxJ/vriMBtL7nERHxCnRVXdnyimC5wIHn87d
         Tc0fbPZKpfHUVrN/zHLWnQ6RKKj25pv4n2FwjGzv1TMFjEwS+TkrNCr8Ixk3z6EH5ij9
         5i5jMYZCwaHykZB320Sg4in+Arlf1TlFXzNbNuR2CS8WaolLOFc+qG7bv1ohvKv6fVRt
         9WEwzCLVvmtoJrKFp4WyLSrvPoPLCWcavAF0Ry98/B/mJv4Uj3R2YkJ82pMgLEPZXgyi
         N3zA==
X-Gm-Message-State: AOAM530CrXR9SGLe5+AHJ5ZCG6rX5OiWqMisZhYKRulvBJPU9mOARL+l
        XwQja7LPBTVwG6zdKSrSPV2mIw==
X-Google-Smtp-Source: ABdhPJzckqFfo4xbpPPPMFqKSoImgg9uAkXYhFGq/pnbZggdi9ScEbVsbzorv3kKCnMWNIBhDn/lTQ==
X-Received: by 2002:ac2:5e8a:: with SMTP id b10mr1180344lfq.14.1598005537801;
        Fri, 21 Aug 2020 03:25:37 -0700 (PDT)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id p8sm298370lfh.64.2020.08.21.03.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 03:25:37 -0700 (PDT)
Date:   Fri, 21 Aug 2020 12:25:35 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
List-Id: <soc.lore.kernel.org>
To:     rm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        op-tee@lists.trustedfirmware.org,
        Jerome Forissier <jerome@forissier.org>
Subject: [GIT PULL] tee memref null for v5.10
Message-ID: <20200821102535.GA1872111@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this patch enabling a TEE client to indicate a NULL pointer
instead of a valid buffer when invoking a Trusted Application.

Thanks,
Jens

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-memref-null-for-v5.10

for you to fetch changes up to ba171d3f0850003216fd1a85190d17b1feddb961:

  driver: tee: Handle NULL pointer indication from client (2020-08-21 08:55:13 +0200)

----------------------------------------------------------------
Handle NULL pointer indication from tee client

Adds support to indicate NULL pointers instead of a valid buffer when
querying the needed size of a buffer.

----------------------------------------------------------------
Cedric Neveux (1):
      driver: tee: Handle NULL pointer indication from client

 drivers/tee/optee/core.c      |  7 +++++++
 drivers/tee/optee/optee_smc.h |  3 +++
 drivers/tee/tee_core.c        | 49 +++++++++++++++++++++++++++----------------
 include/linux/tee_drv.h       |  3 +++
 include/uapi/linux/tee.h      | 13 ++++++++++++
 5 files changed, 57 insertions(+), 18 deletions(-)
