Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD726C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 12:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B17D42074B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 12:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=es-iitr-ac-in.20150623.gappssmtp.com header.i=@es-iitr-ac-in.20150623.gappssmtp.com header.b="WjefxjKp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgGXMCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 08:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgGXMC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 08:02:28 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45005C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 05:02:28 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 1so4985175pfn.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 05:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=es-iitr-ac-in.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jD9j6opAZjPsy3NUA4rBVj0Mn4JgNhzYg7OVCYAcm1o=;
        b=WjefxjKpwQYRJAw8+fhmEXe7R2Z9Ykf1di6zK8tOvYlFU3CZWul7kx1m3QMHmFmh8i
         lbnjKbf79tLW+MpJScjd8llgAkR48TvpGKH6/D29dRaMPJMwfJ3Ohu6KlOA9IGHZDzln
         we61sxpM/OJUwk5UgrsnEWVQz+yYIwC3acOtlHMx+qhJU6s6sl0DCn7xwQKQM3E2+6vJ
         zWaBd7zZKHgKC7qWf3GO7jyjt4zZlEmi9gj7u19zr/37JxI0eeMdFkb4GnRfSyI4e1UT
         pu/xZ0q5ytjhSXcxW4G41dS/ylaZVcHen4Wc35xt83Rd3Ym1SaJ1kAsF197sUmTooNrD
         m5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jD9j6opAZjPsy3NUA4rBVj0Mn4JgNhzYg7OVCYAcm1o=;
        b=mdORb3tGIEtTnsY5OOTQ013NUO6UUchfCu/gcRPR3JlOGzALH+kgLppJXEdiUG2qYk
         2r3XKHtOr/HNi1y6MRqBFaCOKZm0Fp/MxQjEmPNzssCwcrWtS6cY8btCi4PnBi3E5yON
         niZoYZ6rdq5cGlKVWEYIuXe6VlIa990xs3WAEpMHMy55SqOpTFdcRLgdYfcPCCo66GGE
         mwwyDVtdDrIjuQO6ctoEqeBR/zWKzkqWBeag0paC5zn8FkD6cOe9X0GOZVzOCVqvD9nc
         Rg1LkBeLL8llLfX7yJ0BmyW5kkNHAyvakJMbwVDG45LkdYqaP1QwZXS1QBv+zhW+FANY
         QGpg==
X-Gm-Message-State: AOAM531OkklsEngbSu6MoU311menoA7FP4iOwfxOryiandXsTyFbAwaf
        FHVpfCkhe6eyfqfHQCn0+cV0Tg==
X-Google-Smtp-Source: ABdhPJwkTBH8ZPUfyKqhTdhf8safIlGUaU734H4KQFMiE4FD51jyGoAjD8Cm12hkJB9HJ4600Whhfw==
X-Received: by 2002:a63:29c8:: with SMTP id p191mr8499852pgp.333.1595592147687;
        Fri, 24 Jul 2020 05:02:27 -0700 (PDT)
Received: from kaaira-HP-Pavilion-Notebook ([103.113.213.178])
        by smtp.gmail.com with ESMTPSA id c23sm6154734pfo.32.2020.07.24.05.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 05:02:26 -0700 (PDT)
From:   Kaaira Gupta <kgupta@es.iitr.ac.in>
To:     Helen Koike <helen.koike@collabora.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc:     Kaaira Gupta <kgupta@es.iitr.ac.in>
Subject: [PATCH v2 0/3] media: vimc: Allow multiple capture devices to use the same sensor
Date:   Fri, 24 Jul 2020 17:32:10 +0530
Message-Id: <20200724120213.17119-1-kgupta@es.iitr.ac.in>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is version 2 of the patch series posted by Niklas for allowing
multiple streams in VIMC.
The original series can be found here:
https://patchwork.kernel.org/cover/10948831/

This series adds support for two (or more) capture devices to be 
connected to the same sensors and run simultaneously. Each capture device 
can be started and stopped independent of each other.

Patch 1/3 and 2/3 deals with solving the issues that arises once two 
capture devices can be part of the same pipeline. While 3/3 allows for 
two capture devices to be part of the same pipeline and thus allows for 
simultaneously use.

Changes since v1:
	- All three patches rebased on latest media-tree.
	Patch 3:
	- Search for an entity with a non-NULL pipe instead of searching
	  for sensor. This terminates the search at output itself.

Kaaira Gupta (3):
  media: vimc: Add usage count to subdevices
  media: vimc: Serialize vimc_streamer_s_stream()
  media: vimc: Join pipeline if one already exists

 .../media/test-drivers/vimc/vimc-capture.c    | 35 ++++++++++++++++++-
 .../media/test-drivers/vimc/vimc-debayer.c    |  8 +++++
 drivers/media/test-drivers/vimc/vimc-scaler.c |  8 +++++
 drivers/media/test-drivers/vimc/vimc-sensor.c |  9 ++++-
 .../media/test-drivers/vimc/vimc-streamer.c   | 23 +++++++-----
 5 files changed, 73 insertions(+), 10 deletions(-)

-- 
2.17.1

