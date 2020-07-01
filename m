Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF917C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBFCE2074D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M851pTqc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgGAHnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 03:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbgGAHnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 03:43:02 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA5DC061755;
        Wed,  1 Jul 2020 00:43:01 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id k17so242230lfg.3;
        Wed, 01 Jul 2020 00:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a4snypAVj1f2VNcK/6wRbxe6KtPA5KToxVeTmWhPjJU=;
        b=M851pTqc4c2ogJ5gYxfK4uOWvSzycFPaZ9aAwL0A8qbCjx/cBFGs5v8oV+vfa6oEts
         htKKU0nx8TG4qiK8J6D6AWWHfgmVGrIpQgeBA+Ou5fZ12/kGa3m571cBnaydZzUR4GG6
         oDjaygrIVRo/kgULJRnpkvsYGykYwgl8diODwFjllP3Fo1YJeCpXHCJ99h+XDQOhrc0h
         HaB5/X6KZGr31Vy14wFuzE49gI1IZK9lBiqoWaTfefdrXecx2+TgAEpzgt7WI0wKrW67
         cEZS0eaeOceFPfHaXeZ2ptUr7cH2sziS21ErJBwfv+JUS97W/yvCuKY3geFy+ypDH/Bt
         ZOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a4snypAVj1f2VNcK/6wRbxe6KtPA5KToxVeTmWhPjJU=;
        b=PAkPWmYYIb9MgBAlqF3hA8w2GasJB2MSN61JaoOyQJlGB/4QOZYWfSmytqMcx5HlVb
         H+13iaevu4SrAezAc4CZ+s0wUP03vRU9HF28d3BngykVACJW9AghsMN03QR612qalLsW
         4uPGpfp6oBAsJR+6CL+Yz2Df0HY2nZ3AJuODfjnNXWatY1HytzAF8xw3rFPyb07asvQO
         QPny6Xi9cO3TWgQXBwNfnB0PM1Gf/nQIbUhDzc2tLvpXdxBve3Frpinzimk0pfPu8K+e
         Ncdc+TqhtdxzAFa5w+DVx8aCn41ES322dr0piuC7OQPYyP9bDiOfcRofJbmzrdlJkdGf
         XFTQ==
X-Gm-Message-State: AOAM530vtp6916xNk933FRiVWp2Ijx3esccpWC9UexXvhB34UXp3YtdJ
        uXz4Nf23KzDXMibNZVUWdW8=
X-Google-Smtp-Source: ABdhPJxn9pilY0l7dKhtPzUDxK+ZvEWyFDHSiQSc1jsTxQqvtuOxYC1rWi9vlPWrh4GodwtgHPP2hQ==
X-Received: by 2002:a19:4bd1:: with SMTP id y200mr14361981lfa.60.1593589380107;
        Wed, 01 Jul 2020 00:43:00 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id e10sm1520881ljb.118.2020.07.01.00.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 00:42:59 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 0/2] Silence missing-graph error for DRM bridges
Date:   Wed,  1 Jul 2020 10:42:30 +0300
Message-Id: <20200701074232.13632-1-digetx@gmail.com>
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

v10:- Corrected doc-comment, unbroke the of_graph_get_next_endpoint() and
      improved commit's message in the "add of_graph_is_present()" patch.
      Thanks to Laurent Pinchart for spotting the problems!

v9: - These two patches are factored out from [1] in order to ease applying
      of the patches.

    - The of_graph_presents() is renamed to of_graph_is_present() like it
      was requested by Rob Herring in the review comment to [1].

    - Added Rob's r-b.

    [1] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=184102

Dmitry Osipenko (2):
  of_graph: add of_graph_is_present()
  drm/of: Make drm_of_find_panel_or_bridge() to check graph's presence

 drivers/gpu/drm/drm_of.c |  9 +++++++++
 drivers/of/property.c    | 23 +++++++++++++++++++++++
 include/linux/of_graph.h |  6 ++++++
 3 files changed, 38 insertions(+)

-- 
2.26.0

