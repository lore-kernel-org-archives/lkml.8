Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885CBC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6407C22BEB
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KSymSSKd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbgGNTui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgGNTuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:50:37 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE58DC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 12:50:37 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id u185so8036130pfu.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 12:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kBJuLgP6wmV5hW1d8I07AWIyxZtdhu1kC6fJyMZfmXA=;
        b=KSymSSKdQOVrflKQG86mqDePMsbu+RSK95GaMCjUwVLoRDXYRTiTwpU3YaFKHlAFfr
         ZrGmM9tRixjEmzsBGv+yMmpBJPL0TBWnz8KOvrtHcB4VPZnjiMzbbNgmTdglUMPKy6LI
         8mGHrFWSX7s3wluZNRpRYYs8yyRYXP9s8yjbAHFNp7Ssj0626ZGK2qaAQcN/6Z4cF2mM
         Lpr65Od66NHGgi+oxB2rEun8Lv+wuTAxQMlpXQ9vwYy/p0glfyLDW8cVICVVEsXqoBA0
         BmUPMTGAi2AhhqH1ybo/IezmrKtzLJW9suCvTfucwFnQMe59GgQZvui/ORWu0hHFnjT8
         yKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kBJuLgP6wmV5hW1d8I07AWIyxZtdhu1kC6fJyMZfmXA=;
        b=q1Id1bg4v1IiqVBpSTY1J9dPmJWFGDX+LhLjGDXaShzuSi8N5GT+15SN84GfoHXFqO
         0aL5uzzCdCivPGDY7I1mACtugZfRoOoxn8Qe7OWn6bt6nHNiOqdx36yD5A/ukD1DzcXS
         ns3GMLy86o/+ZJfEnFa6rWcN2qhdsu/2G1EyKeX7GWeNXLbvK4TF3X8VPbJoEsQ/6NXs
         h3pRtRZFQNl7uEtqTdvUekhn+w6mKZmmzPk2PmmH3VbGpei3pFDAlx33TZ8/JDF01m9q
         CSTh3fnMqVZIiJnU4WLxMYtzZmEg0VR5tMntyz3Pm+euTTDFL43BTd1Qy1NglFDNF5jd
         KWqA==
X-Gm-Message-State: AOAM531tsLw8tiu0v/EEqwm2e3bZ+8voye71yKTBTdZoZPX2doOxB3R/
        UY7Ibd4M9bDXe/JCMCa/WQkZ5A==
X-Google-Smtp-Source: ABdhPJwm/lndK2qNQAC1umQRfwvJaHpzS2KAY/BT0ybc3nozyRnHgCSMuMsASMmhV7k+Zjing9plkg==
X-Received: by 2002:aa7:9a03:: with SMTP id w3mr5476793pfj.228.1594756237404;
        Tue, 14 Jul 2020 12:50:37 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id g8sm16736689pgr.70.2020.07.14.12.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 12:50:36 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/9] remoteproc: Add support for attaching with rproc
Date:   Tue, 14 Jul 2020 13:50:26 -0600
Message-Id: <20200714195035.1426873-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set provides functionality allowing the remoteproc core to attach to
a remote processor that was started by another entity.

New in V6:
1) Added Arnaud's reviewed-by and tested-by tags.

Applies cleanly on rproc-next (0cf17702d872)

Thanks,
Mathieu

Mathieu Poirier (9):
  remoteproc: Add new RPROC_DETACHED state
  remoteproc: Add new attach() remoteproc operation
  remoteproc: Introducing function rproc_attach()
  remoteproc: Introducing function rproc_actuate()
  remoteproc: Introducing function rproc_validate()
  remoteproc: Refactor function rproc_boot()
  remoteproc: Refactor function rproc_trigger_auto_boot()
  remoteproc: Refactor function rproc_free_vring()
  remoteproc: Properly handle firmware name when attaching

 drivers/remoteproc/remoteproc_core.c     | 213 +++++++++++++++++++++--
 drivers/remoteproc/remoteproc_internal.h |   8 +
 drivers/remoteproc/remoteproc_sysfs.c    |  17 +-
 include/linux/remoteproc.h               |   9 +-
 4 files changed, 230 insertions(+), 17 deletions(-)

-- 
2.25.1

