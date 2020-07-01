Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B47C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3FEA20853
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pj+hCLZL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgGACQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 22:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgGACQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 22:16:33 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C3BC061755;
        Tue, 30 Jun 2020 19:16:32 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id c21so12658939lfb.3;
        Tue, 30 Jun 2020 19:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k7GavqngVCUaBApgwQyCfuKl9lw5lJf0UO6BJ5H8TMY=;
        b=pj+hCLZLkSJQ7gnlprPd1fqPSXDB2HalnCJx/+6pNvnUy4hF9fNKXX1jpL88q5RoYh
         haMHvyHku7okEvKs5IyBpWzyFBJNP7blFKohPZhEQZMnqn7yRRt1aaL2vkHo/CdAPwiQ
         LwjYXPIaaOpFiRF/3tMEkSmCdsz1oIS8hKihIHC3Yh6d61R/TGxxkvnmkAHiumsLAfgw
         1K9NVkBQ1WSvmbWQGZ4IRYzLxZtBcQzElq1iafivdQf4LH1l9AE1EF6Zs+zw+DTVH4j6
         U5ETvTX15hbJHQ6uA5wcE2wnqF1zY6JGc8y+Qn5ZICVoul8zrSagYtqtxN1Ivao2bcG4
         CMRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k7GavqngVCUaBApgwQyCfuKl9lw5lJf0UO6BJ5H8TMY=;
        b=Jq09L80/HHlNSnst8oR+tXnXdgH9K+ut3MSC+QlwIlw73MJVEd4Diyv6nBazkHo6DF
         +psLfWhU3gUTOr1S6OJTZpfSQjWkPRs9JwiFsdSG8Mf+XuwfpE+eT8HzgGuwuLFhA/L/
         9H4aQucCVdzG+74ylo1cbkthc9OHjZIDSDqJna3lPqSCjshQLip0OOxwKeCOBMKbgzcI
         7GGTU7znf3iIGYOEu4tNFoM7g7E8AyEI48PgmWo3NAFVmI6OwZgHZyzYLEl3evEvMVdY
         fq2dNPlHYJpng3kl/EIRkJTsxvwkmRCB9dqRTIAJTLh1iHTQ6XRzX0Aus7ctLpYuZ9DA
         9sjw==
X-Gm-Message-State: AOAM533K5/ATB8bITDoHjcq/NilXiRC8AYKpVM+adxYUfJaWtNUOCSaf
        aqEb9uV4TwSy6EcGStSlQLw=
X-Google-Smtp-Source: ABdhPJxRfiPi+5cDss3Dp0ElI46PwRSZ4XmSiwAh6s3AG1kUhgLRi3HZuUeVrle446Zpc8sjCa//gA==
X-Received: by 2002:a05:6512:6c4:: with SMTP id u4mr13467097lff.98.1593569791344;
        Tue, 30 Jun 2020 19:16:31 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id i2sm1296892lji.59.2020.06.30.19.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 19:16:30 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 0/2] Silence missing-graph error for DRM bridges
Date:   Wed,  1 Jul 2020 05:16:15 +0300
Message-Id: <20200701021617.12030-1-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This small series improves DRM bridges code by silencing a noisy error
coming from of-graph code for the device-trees that are missing a
display bridge graph.

  graph: no port node found in ...

One example where this error happens is an older bridge-less DTB used
in conjunction with a newer kernel which has a display controller driver
that supports DRM bridges.

Changelog:

v9: - These two patches are factored out from [1] in order to ease applying
      of the patches.

    - The of_graph_presents() is renamed to of_graph_is_present() like it
      was requested by Rob Herring in the review comment to [1].

    - Added Rob's r-b.

    [1] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=184102

Dmitry Osipenko (2):
  of_graph: add of_graph_is_present()
  drm/of: Make drm_of_find_panel_or_bridge() to check graph's presence

 drivers/gpu/drm/drm_of.c |  9 +++++++
 drivers/of/property.c    | 52 +++++++++++++++++++++++++++++++++-------
 include/linux/of_graph.h |  6 +++++
 3 files changed, 58 insertions(+), 9 deletions(-)

-- 
2.26.0

