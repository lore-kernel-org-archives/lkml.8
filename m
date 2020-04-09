Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A625C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 01:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 254272084D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 01:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aurabindo.in header.i=@aurabindo.in header.b="N5VA5PzW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgDIB2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 21:28:21 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]:38209 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgDIB2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 21:28:21 -0400
Received: by mail-qk1-f179.google.com with SMTP id h14so2454554qke.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 18:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aurabindo.in; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W+2Y0Xi530M87fNTrtIwP1pMSm7GqwPkRfMOed11GCs=;
        b=N5VA5PzWygwcF51uf54k+ipqv7JgkBJdnFyoVNkSZM2Y5Bl7CGNj1MEyoXmsSDXGiV
         tGmSgTfxguxY7RCreRX1mU1o7GwN2vzb8xJIQgiHGtvLCgqt/fvNs71MJR6ZKjMHhA4R
         lt+IQNlGF0X/xUSNtXAXNNVICu97RIexts3lt+IaZLSfr5FtJjFlTi1gWyvJ/7b1k14k
         zgWwfyNLYfNfUiCDTFwhJoWNEyszdYTyWtjsMtTPvFJm2VL/IxwXxox+6hgRy02EQlRv
         sGfEuGn3eDWrOKwKq2r/XI4vPkjlB0p8ZdV7huJhorql6JWRl/I6WjMUdNgDnu9XFblg
         nwng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W+2Y0Xi530M87fNTrtIwP1pMSm7GqwPkRfMOed11GCs=;
        b=n15fkLR/iX6wYTPiXfIzPY4sSERFKIl/p7FUBbLoVcP+bStO4X1S8TyDDvUqfjUIbZ
         f1Q810Z8QO93Ixm8lVJvRKIJe91ZdZVaFPpjZ0CmPNmnQLJmX16sPYV9p9mL8EAoOtAw
         dzb358z+1wopdnK9EqGKL9PzMjPobYuJfoHo95RbiEYC2XVuKb83g9rlpEPChSs1Mghb
         V/uyZL2M3dIlpgQwefVMats+pG77csILX3eymnvPqu6PoxkZ+6+SNsoZKOZdOe7Zm3Iq
         fT7SY29+391x5wa1nhMvADkXpUeIXKg8RcB/5sW6W7OwTYhnpSDnYqh5Enw+aDeoEhiO
         SHgA==
X-Gm-Message-State: AGi0PuZhSLtbwJXS2GsdGYB7Ek3MU8xL5hlfIB7sQJpvIUY5MgIXugz3
        F/poS84JhxRP4z8ttHd8KTDpUOM6eFKvLvd4kMI=
X-Google-Smtp-Source: APiQypIcnFZuNeQsehdaKyuMo95ePmC43hl4IAy8auSxxePTv47MMvGLLjTgt/bXZQrCEEnI0SdLgA==
X-Received: by 2002:a05:620a:15d1:: with SMTP id o17mr10479294qkm.457.1586395698825;
        Wed, 08 Apr 2020 18:28:18 -0700 (PDT)
Received: from localhost.localdomain (135-23-249-169.cpe.pppoe.ca. [135.23.249.169])
        by smtp.gmail.com with ESMTPSA id h13sm11710186qkj.21.2020.04.08.18.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 18:28:18 -0700 (PDT)
From:   Aurabindo Pillai <mail@aurabindo.in>
To:     christian.koenig@amd.com, alexander.deucher@amd.com,
        David1.Zhou@amd.com
Cc:     airlied@linux.ie, daniel@ffwll.ch, Felix.Kuehling@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] drm/amd/amdgpu: Add print format prefix
Date:   Wed,  8 Apr 2020 21:28:12 -0400
Message-Id: <20200409012815.22309-1-mail@aurabindo.in>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2

* Add dev_fmt format prefix
* Removed hardcoded module names in pr_* and dev_* prints

Aurabindo Pillai (3):
  drm/amd/amdgpu: add prefix for pr_* prints
  drm/amd/amdgpu: add print prefix for dev_* variants
  drm/amd/amdgpu: remove hardcoded module name in prints

 drivers/gpu/drm/amd/amdgpu/amdgpu.h              | 12 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |  6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c          |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c            |  2 +-
 7 files changed, 21 insertions(+), 9 deletions(-)

-- 
2.26.0

