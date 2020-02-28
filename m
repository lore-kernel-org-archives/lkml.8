Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E67C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79C9F20732
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsw4SLW5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgB1Qkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 11:40:35 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34663 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB1Qkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 11:40:35 -0500
Received: by mail-ed1-f66.google.com with SMTP id dm3so4098157edb.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 08:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=LBzqVgkSBMQoXRl/FnbNZpFHPZCwyHEtb7aUpugamR8=;
        b=gsw4SLW5qCHuoB7Q0zIyZ58tQGhNAJBs9d5H0Qn3wXzcqmGMfbyI21UdDwtf6PgQby
         ckO2iRD7WDVsQpPh2Ckqotcb6Ybl3zsePd3UwVf5c7GA0A3HRwwUAgHxuhtqDERguWZH
         MYMhHmCUAmggzDMoihqnF1EXIfkhyILA+vhuR6h16d4H3pfer/DS2BGaOWRM9Oci9Fui
         y6ScH2YNMQbExT6wFd51vyRpbwKYM1qv1qsp2op+eNFsoAeIWP/31CUxcUnDRi1l16Jm
         ddZKpMrkOTrhR7MjFmo+gJuna9y0sQJLo1tinoWdzktkiEnWmSa1jOzYP7e7nyKizuJo
         vrGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=LBzqVgkSBMQoXRl/FnbNZpFHPZCwyHEtb7aUpugamR8=;
        b=C+9+PzmVY5NX7LnAIZe/1GfvdOqkKLdL2N7/NiD9NYCSqbde4o9599M8r67jE6GDwP
         dxx/fhFGQgT1rCIurvAZdt4nAx14fSzcdsJsjbfBjYtRJdunu+g6rU/R1k7BY+QFqs/P
         gG7DaAOoHWFp8iu454psCXhkfQV4iv+bosi12gx5QQDla3Yh6HOns33qcOPJvarkDtcG
         /pI1K4OvCsGdpzXx7Z7ZEf8c8lWcTYyz61o+YBkIKKrBP9UB5J6Ghy/O5xdENeo4LMSm
         ggC5YKd6BsbEHwyShT8w4A81VXLhIB/2BdhAG9x+NCsJq3Rxu5yW4iGtljBH5tkOBLHD
         SUpA==
X-Gm-Message-State: APjAAAV/KEblmQv68S5l3mgopuMdjKy/FlxJ91psoDIjFuz69yWoNLWJ
        qxDuFLTjYyJMO+Y0IVJikbM=
X-Google-Smtp-Source: APXvYqx+jWTwk6LGNR0+pA91pM1SSnE6oXHjqXSaoPZBTrWH6xMCWtiZpQzRjCndL4ZT2Uqx+dLWcg==
X-Received: by 2002:a05:6402:cb7:: with SMTP id cn23mr5020041edb.72.1582908032490;
        Fri, 28 Feb 2020 08:40:32 -0800 (PST)
Received: from smtp.gmail.com (1.77.115.89.rev.vodafone.pt. [89.115.77.1])
        by smtp.gmail.com with ESMTPSA id r19sm104180eja.5.2020.02.28.08.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 08:40:31 -0800 (PST)
Date:   Fri, 28 Feb 2020 13:40:23 -0300
From:   Melissa Wen <melissa.srw@gmail.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian Konig <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] drm/amd/display: dc_link: cleaning up some code style
 issues
Message-ID: <cover.1582907436.git.melissa.srw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset solves some coding style issues on dc_link for readability
and cleaning up warnings. Change suggested by checkpatch.pl.

Changes in v2:
- Apply patches to the right amdgpu repository.
- Remove unnecessary {} added in the previous version.

Melissa Wen (2):
  drm/amd/display: dc_link: code clean up on enable_link_dp function
  drm/amd/display: dc_link: code clean up on detect_dp function

 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 64 +++++++++----------
 1 file changed, 30 insertions(+), 34 deletions(-)

-- 
2.25.0

