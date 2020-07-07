Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179FBC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6D6A206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tCwo5WCq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgGGVAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 17:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728981AbgGGVAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 17:00:17 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0717DC08C5DC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 14:00:16 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id u5so18952493pfn.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 14:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e0eJn8FGSR8dkHsS13OS+/058gx5Z0WZfRiZRVi4N2k=;
        b=tCwo5WCqkQBIbpNM9kp9nC0WWWNsmQijesmFFk/s/0UkiFbatdZB6A0JOVesxoY6Hb
         E3V7T8CWlhR/h6r5dwWHZ2cx8M5o6egFs39C7PEDovTDj3iiQLS+cSccRLvzPbzD0KnF
         PHKtu97DE8wK7Kqvo+hQaXolXcC0LjKEeIiIY+1MbXjbVKjZIhezLZExpcLXDeg+suvd
         yhw02wjZzVzeKCq3tplC5GDwdxokLiwCu1YDGKshNXkszA0XvdfEzyLvKMy9hdz3B/ed
         /N/sEBqwP380yOu1do8qXxYO0qexVAB20i69eZbMcpEclBSeB5mlIWKBGkjvIhTFQGcc
         wMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e0eJn8FGSR8dkHsS13OS+/058gx5Z0WZfRiZRVi4N2k=;
        b=Vchg5bpHWr4Z610nB2DRON0v4UkmIsqUNHdhr35t1BHjQu8L1JPOav2M9UZsDwU/dH
         be5gVHUhKf6iJAIQYmplY80o8LAFORP+dJH8cekNtnL/cQF+IUvei1rRsnZeyKna6rji
         TMLinhojMTaZ40Jg0rj764xBehjoSAoEFlDJlmznsQc3DSu6RvAIbG0ZqlD4IA1Jj7IA
         hb/wMnRkfdCZCChfNiP0LQ4BtvgP4yemCiWmsRpJgMgfUTPMm18Eu0mYfBOE7nECIJYj
         Suaow+qbtVnoPFRgw36dAL2zj2CjxNDCWmNsSU1WLvir1BjZpp6QrX8V4olbTXKnO3yn
         3HGA==
X-Gm-Message-State: AOAM530KCeknAr6ElaJ3JfAwFV94EG5Obmv9YtrFDVVL7WsZJDSUltoC
        CHRM5RDNOKqOO8hkOlSLnb1Img==
X-Google-Smtp-Source: ABdhPJwh6/TcSsh6pYnC27AJdTiG0hqRhzapf7D7/kHjK8mNOh78D6OxQPwnNLcGit+QIWG8jPizLw==
X-Received: by 2002:a63:a05f:: with SMTP id u31mr39957007pgn.4.1594155616424;
        Tue, 07 Jul 2020 14:00:16 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id b21sm13738061pfb.45.2020.07.07.14.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 14:00:15 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/9] remoteproc: Add support for attaching with rproc
Date:   Tue,  7 Jul 2020 15:00:05 -0600
Message-Id: <20200707210014.927691-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set provides functionality allowing the remoteproc core to attach to 
a remote processor that was started by another entity.

New in V5:
1) Added Bjorn's reviewed-by.
2) Removed PM runtime call from patch 04.
3) Used a 'case' statement in patch 05.

Patches that need to be reviewed: 4, 5 and 9.

Applies cleanly on rproc-next (49cff1256879)

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

