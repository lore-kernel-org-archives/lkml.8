Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AE5C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4E5D2184D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nEPB/kPU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbgEASUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 14:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729138AbgEASUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 14:20:50 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59ACC061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 11:20:50 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id z90so8553813qtd.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 11:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sDjIEM+eSzMwryve6HfF6tWEHpQ1YVsnKklV3y9mbGo=;
        b=nEPB/kPUVu64ALDJjlHG9rMKTiO65lpugPdBC30Nczov+tgzGXPn6wpmV85NOyxRh5
         3llmUpX+zBdGg9ao+A8Dyp3OnqDyGBYB6vqDjCxOxw5mjJPKQo6DB/cC07qH7cSXDWlk
         xT4JrOhmLTygWIPY4TatqdbFhJhSZImrg17m9LM8AKb8xkfmkMFcSYAOisggYpw2tOSK
         s3vV/30613M9nsClks7/z1Whk4BcpdM8wHMSt0GTIsR5+hRulh2NImOiBoJFW/rg1wOH
         inAEReWsuS05YfwJRAyPScaLj42vxYgfD6RLvZrbk1XcHFRCd2h2j5a1KLt7/kD3PyeZ
         vl9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sDjIEM+eSzMwryve6HfF6tWEHpQ1YVsnKklV3y9mbGo=;
        b=Uurp2fjQOQTjjarCTvwolMocv1amIUFGTDy6byrzqwlJeLGOXngtAMdlIefMad+O2v
         E71rLfVPRyqDxIE3jF9nZVzyzdlRPkUJr3l6UnoOQJwUFyV9e07Lmvdjq2Y5qAQvn/iJ
         nthAsVPJgQKjfE7VkY3rht5BFeDQKbdCdb+uRGISsURjdaqma1LRO2yhXZaPK7u47I0a
         5VPFMzoMvgn+ooYWnhh0BUtIW6K0VDWzne10NzplWe9XOFoaDl7E1NAqGMKErkJcBywc
         4LC8sR64nnYLVzkA7ovEgu6qS214sQrWKgHzAYWnsKTlTJZXfeGsOfm0P56qAf/+5bWr
         oUWg==
X-Gm-Message-State: AGi0PuYT8FESQs7YjvmH3KVLitmi4mpgvz177j75hNv+xxRXT6uv43ID
        ald0qzOxsJCAdHBBF1AUWNbAVg==
X-Google-Smtp-Source: APiQypLnto+0lS8NZSLIiaARckcdYZmXp5cRSri5MnUXK85RufiSt8ijYevAzNOi5g9Dq58iHtdy2g==
X-Received: by 2002:ac8:3254:: with SMTP id y20mr5176017qta.67.1588357249676;
        Fri, 01 May 2020 11:20:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id n92sm3048968qtd.68.2020.05.01.11.20.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 May 2020 11:20:49 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jUaHI-0006oH-Ci; Fri, 01 May 2020 15:20:48 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-mm@kvack.org, Ralph Campbell <rcampbell@nvidia.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        dri-devel@lists.freedesktop.org,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        intel-gfx@lists.freedesktop.org,
        =?utf-8?b?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org,
        Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        nouveau@lists.freedesktop.org, "Yang, Philip" <Philip.Yang@amd.com>
Subject: [PATCH hmm v2 0/5] Adjust hmm_range_fault() API
Date:   Fri,  1 May 2020 15:20:43 -0300
Message-Id: <0-v2-b4e84f444c7d+24f57-hmm_no_flags_jgg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

The API is a bit complicated for the uses we actually have, and
disucssions for simplifying have come up a number of times.

This small series removes the customizable pfn format and simplifies the
return code of hmm_range_fault()

All the drivers are adjusted to process in the simplified format.
I would appreciated tested-by's for the two drivers, thanks!

v2:
 - Move call chain to commit message
 - Fix typo of HMM_PFN_REQ_FAULT
 - Move nouveau_hmm_convert_pfn() to nouveau_svm.c
 - Add acks and tested-bys
v1: https://lore.kernel.org/r/0-v1-4eb72686de3c+5062-hmm_no_flags_jgg@mellanox.com

Cc: Christoph Hellwig <hch@lst.de>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Ben Skeggs <bskeggs@redhat.com>
To: Ralph Campbell <rcampbell@nvidia.com>
Cc: nouveau@lists.freedesktop.org
Cc: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
Cc: intel-gfx@lists.freedesktop.org
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: "Yang, Philip" <Philip.Yang@amd.com>
To: linux-mm@kvack.org

Jason Gunthorpe (5):
  mm/hmm: make CONFIG_DEVICE_PRIVATE into a select
  mm/hmm: make hmm_range_fault return 0 or -1
  drm/amdgpu: remove dead code after hmm_range_fault()
  mm/hmm: remove HMM_PFN_SPECIAL
  mm/hmm: remove the customizable pfn format from hmm_range_fault

 Documentation/vm/hmm.rst                |  28 ++--
 arch/powerpc/Kconfig                    |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  56 +++----
 drivers/gpu/drm/nouveau/Kconfig         |   2 +-
 drivers/gpu/drm/nouveau/nouveau_dmem.c  |  27 +---
 drivers/gpu/drm/nouveau/nouveau_dmem.h  |   3 +-
 drivers/gpu/drm/nouveau/nouveau_svm.c   |  94 ++++++++----
 include/linux/hmm.h                     | 109 +++++---------
 mm/Kconfig                              |   7 +-
 mm/hmm.c                                | 185 +++++++++++-------------
 10 files changed, 217 insertions(+), 296 deletions(-)

-- 
2.26.2

