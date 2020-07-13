Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17EDC433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 22:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D16E42065F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 22:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="phQ3z4XM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgGMWzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 18:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgGMWzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 18:55:13 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DF4C061794
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 15:55:13 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id h17so6641873qvr.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 15:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UB04SDsGtdgD9O0BAxZlC5pe+7E+tV+tVdZ5syl+8GE=;
        b=phQ3z4XM879Mg4TOckIPk5Dk89byIXjH5l1Ueod4hxvsspSvQrbYmrKa7jp6giCzjC
         aG0WR8fPrx31wi2pKkzaMt+biVC5PTTZ/BNVEZS86DXTtH1kfAIhUOr/DWnYf1BCxIm+
         XpOeTsFUeut8tBwi4ZyJLjOZi67wtb5RC8Kx41AENk5ZtijKl1JZQOCiOV7bdURhCSTw
         V8NVyPwGqRSChiWgc7qbgDEgMWZTq0oRPnViI9jeuNaLhxTOR0kpbFalWfjZfsLgvDb8
         mC2I2McVH3RcGEM6p+MvTn8iy4xl61VJhjF+5+h7wKlRystzel3ka5+gm+2exuDs93z1
         EJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UB04SDsGtdgD9O0BAxZlC5pe+7E+tV+tVdZ5syl+8GE=;
        b=s4knDH3db+13qJ7j05xzHfcXReXdzP8PfrwY5YHSffDOcHVY2kMdhFEd/kBpMI737v
         zTQBomE6wfsA9Y14sA6NrhgeNxw0dPSgiS8OGtCtfzWZFmUPN2GJtfrwqo+WhwJIvDv9
         KEAzuzuBc37Du/emCaAjKyhUFn5zNHwwKzKW+WEtr3oEgPXxRdVBO25H0raODJGTu27/
         i3b/X5I+8TLpJLB6Cx5u5AqsjPALqVxjemcysNKQb7/jN4hnQ1QKiuiqnWgkOwzkyF8f
         3Vl8apXyENn+W4Ho7DAReMCRSSD8D3s0AU9CRhyqyw7bM6E/5Tx705l3w+mOfKW3fMH4
         nThw==
X-Gm-Message-State: AOAM532btz1l0sFK1qJjUqOomw2nfT94/7eQwsY3ZQ8oXiXjUxJlEjjI
        s9rZrHFRs69w9Z6G0Qz1X/sXiw==
X-Google-Smtp-Source: ABdhPJzT4kWTe7OAToMzZZAU4W5K1Fgae2SY+FVbLq8HcjZ7nDEsaM7430chMTRWXiz9iMYU6zS6fg==
X-Received: by 2002:ad4:48cf:: with SMTP id v15mr1725778qvx.101.1594680912255;
        Mon, 13 Jul 2020 15:55:12 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id f54sm22405752qte.76.2020.07.13.15.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 15:55:11 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Brian Masney <masneyb@onstation.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), Fabio Estevam <festevam@gmail.com>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        linux-kernel@vger.kernel.org (open list),
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v4 0/3] drm/msm: handle for EPROBE_DEFER for of_icc_get
Date:   Mon, 13 Jul 2020 18:53:39 -0400
Message-Id: <20200713225345.20556-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check for errors instead of silently not using icc if the msm driver
probes before the interconnect driver.

Allow ENODATA for ocmem path, as it is optional and this error
is returned when "gfx-mem" path is provided but not "ocmem".

Because msm_gpu_cleanup assumes msm_gpu_init has been called, the icc path
init needs to be after msm_gpu_init for the error path to work.

v2: changed to not only check for EPROBE_DEFER
v3: move icc path init after msm_gpu_init to avoid deleting a WARN_ON
v4: added two patches to fix issues with probe deferring later in v3

Jonathan Marek (3):
  drm/msm: fix unbalanced pm_runtime_enable in adreno_gpu_{init,cleanup}
  drm/msm: reset devfreq freq_table/max_state before devfreq_add_device
  drm/msm: handle for EPROBE_DEFER for of_icc_get

 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 68 +++++++++++++++----------
 drivers/gpu/drm/msm/msm_gpu.c           |  4 ++
 2 files changed, 45 insertions(+), 27 deletions(-)

-- 
2.26.1

