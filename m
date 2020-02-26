Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082A5C4BA21
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA01E21D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rNT0rnkk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbgBZWFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 17:05:54 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41954 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbgBZWFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 17:05:54 -0500
Received: by mail-ed1-f68.google.com with SMTP id c26so675114eds.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 14:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=lO560Vd8elu0vLfNr74TQ8Ij17BoVsrrt1XDoaTrIfo=;
        b=rNT0rnkki86MGc7psiszoA+k+IW0ye6YKaizU3CWPXfEJpDHUWiryx4VkbCgKD7WPU
         9X+mSaA7BTsjsf7lVOGkcdPgs2Q9OJnyHrqleAYDTwad9qLI/qLAyayYiamlCEH9rvM5
         ORlI/QdlLw6qv/uPANIfbRmtea5ZaJZYGoABVmwdFwt/mz+eqvo/4Oi7r998eTRy9yr/
         7eI9UF7wPUPh7BZwCFVSbgP86VRPKT0dscpTNz8SqEYvMJAgiCbdnNWAdva5E5SXpTS5
         5n0XyTvN9qw/TWqQkdb2M1nnO5h6Qqr0jZvY/lVcdlpq+bWpfo1G1d3wwbz3L6b7CVIl
         UZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=lO560Vd8elu0vLfNr74TQ8Ij17BoVsrrt1XDoaTrIfo=;
        b=rYQ9NIMHtkm6FoB60b44sAow2OmKLEZwIyH+nhvvXRDDiYLOSQfKu22ZqAMpAXGRqa
         dwcIp71CrW8ibKC9gnPIud1LWNTqsgczsUg3BrUnJeIjgZXNZNSTkZQ4HKrxTkTQI0Pa
         5cFdH1cbHG5KiTC71UYziIuwsdvKTHPYS4Wc4CLjwmTvixN7ne6rinfmqE3rtLNJEExn
         7w3OgURhUZxB5bVFM/tU1SmJopWz8B2+A3BaKoMapA7JHSIdj1c+ekbEA0FrR1Pdob7T
         fQPr1saYur3qP0MVf6GVwD0n8RiiOr7IDz0Z96gvTU8y2CM5a9ZLExefRVq5vSGMA6D0
         JgTA==
X-Gm-Message-State: APjAAAVLebvWJmNp46/UzIsBDt6FlhjBPhYJnLE5N3jVREpHnSKepUuS
        vPCvdcAVT+5jv8DdiZeVRLU=
X-Google-Smtp-Source: APXvYqw9rSLuNZaNiBI9qVmvO8rn/PoXC4JpYq8qWrjWaBXkn8OsgbaEEjuR3EvkUqWsVsyra9NafQ==
X-Received: by 2002:a17:906:785:: with SMTP id l5mr718781ejc.311.1582754752412;
        Wed, 26 Feb 2020 14:05:52 -0800 (PST)
Received: from smtp.gmail.com ([2001:818:e238:a000:51c6:2c09:a768:9c37])
        by smtp.gmail.com with ESMTPSA id u9sm240590edt.91.2020.02.26.14.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 14:05:51 -0800 (PST)
Date:   Wed, 26 Feb 2020 19:05:43 -0300
From:   Melissa Wen <melissa.srw@gmail.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian Konig <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] drm/amd/display: dc_link: cleaning up some code style
 issues
Message-ID: <cover.1582752490.git.melissa.srw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset solves some coding style issues on dc_link for readability
and cleaning up warnings. Change suggested by checkpatch.pl. 

Melissa Wen (2):
  drm/amd/display: dc_link: code clean up on enable_link_dp function
  drm/amd/display: dc_link: code clean up on detect_dp function

 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 67 +++++++++----------
 1 file changed, 32 insertions(+), 35 deletions(-)

-- 
2.25.0

