Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56898C2D0E8
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 10:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B6A820781
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 10:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ox/XyHOD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730656AbgCaKzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 06:55:10 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45466 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730439AbgCaKzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 06:55:10 -0400
Received: by mail-ed1-f67.google.com with SMTP id u59so24497925edc.12
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 03:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=lJ28otLGH/TA0UFRVyaAv3N2y3mbjSrHeAW7r1D9pqQ=;
        b=Ox/XyHODyaHFq5RQDXZmKlVHeUdUPDwHjUDHi8esLUsIw0rB3+3zGmrRd+Qy3P5G3L
         jryZy/jSRFidXNn4mnsqe/vAHuyNCdEpxIsrC0arPlsPOipvVXXsX5RDcCtJP9yoMZwx
         NIHLfam1/tknlph34PC3oWR+QUw5YxQoeTFHV5tJDwwJ2zgcVbiCD8S5FZq86S7cFsy/
         smiQMpxjVoXVxEJoGCcYQ/4w7zSTv8fSVhFQ8M0ae5gulBU8aHNOwbIzlJUKjZYJ0kMy
         zU5jVpZm3AStfZAYAzzJwOwgv4wBNuLbE5cyEpKvkgeWg7HyUeFLzZDz6Qzo+MRN7eo3
         5SQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=lJ28otLGH/TA0UFRVyaAv3N2y3mbjSrHeAW7r1D9pqQ=;
        b=r/6/4V7hSI4AQGUd8h4op0Tesuq9TuecVl6EssCmnkzZ42x9IS8KQ/rt7ZJUoFGOyP
         e3npE8RP5jqM3DhQq0IXPi3ZyZGBbbvQXkmRvwSEGuCqz64E7g6HY8QCq8IqS0AO147o
         3H8c30FQiPyOI9g28TcF+ZdYJbvLTrsWe16A6LNvplNw4HhckiXBxu5fXwfKxl8cfDoM
         4xmEmrRow/ebQS3luZ/YKbIW/pHANRvr8pV0tckO0N0Zwh+P3/bSuzbd5QfWr4f92IMh
         rawewPDWSS2jlMrPiRPh5yzHwnMmBB6Zwk08kkEsIu0SjektEE1aE0U5fDIIEBQmvGD1
         FiNg==
X-Gm-Message-State: ANhLgQ2Y6/QMhovv1thSp+YPVaQksLdHIMYhyEbnWuxJCLLi7vCDGscW
        gmyrwgU23T0PV3wMm3G9P6T4Ax47/c+FYA==
X-Google-Smtp-Source: ADFU+vuzYvhLkkf4P6xFXKXPnbxRp15lh/5fGfPH88RWrj0e6JgwXYjh+iwsAu82EDqgRUCBvDi1rw==
X-Received: by 2002:a50:ec08:: with SMTP id g8mr15100184edr.321.1585652108744;
        Tue, 31 Mar 2020 03:55:08 -0700 (PDT)
Received: from smtp.gmail.com ([2001:818:e238:a000:51c6:2c09:a768:9c37])
        by smtp.gmail.com with ESMTPSA id pj22sm2144956ejb.79.2020.03.31.03.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 03:55:08 -0700 (PDT)
Date:   Tue, 31 Mar 2020 07:55:00 -0300
From:   Melissa Wen <melissa.srw@gmail.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian Konig <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Rodrigo.Siqueira@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] drm/amd/display: more code cleanup in the dc_link file
Message-ID: <cover.1585651869.git.melissa.srw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches address many code style issues on dc_link for readability
and cleaning up warnings. Change suggested by checkpatch.pl.
Some issues remain and need some minor code refactoring for proper handling. 

Melissa Wen (4):
  drm/amd/display: cleanup codestyle type BLOCK_COMMENT_STYLE on dc_link
  drm/amd/display: codestyle cleanup on dc_link file until detect_dp
    func
  drm/amd/display: code cleanup on dc_link from is_same_edid to
    get_ddc_line
  drm/amd/display: code cleanup of dc_link file on func
    dc_link_construct

 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 358 +++++++++---------
 1 file changed, 176 insertions(+), 182 deletions(-)

-- 
2.25.1

