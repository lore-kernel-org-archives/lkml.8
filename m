Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74B8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 16:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96343206BE
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 16:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P5fahlT9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388169AbgF3QbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 12:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728931AbgF3QbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 12:31:20 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AFFC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 09:31:20 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e9so10180517pgo.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 09:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hpHucya7a8dIbm3wn4a+7ihI+YD3U03xQgOBmUslQ5o=;
        b=P5fahlT9Hus7d9QA8pdqL3XA8RGUa3MyYrdNdlIbpjs2/pTb11AgLGZQt5zvEE+zST
         0kTUImtlf+5a7qxDQovr0j8SVJ6AeDOJcqzQf+HxPF4gD/LOY8eE4jfiRnl3+FHZKDj7
         HJwjf/1WKIZv1WVA2jqujSlPyALyKI4rz29BKhhMG4K2DP/c+LCB/g0a71tTTC4f2Pvv
         TPfudfi/ipvVOe58ujypt6hVAP6GW/EHJXkoEmyywcH8Ha/YpDOZqdkH8TpjRf026uRY
         m4s5CAYpYTkAXNeJcvYxBp2zK3LvaehPDT7/fdZtTBmpHExeESjio0Oz06ybDbEIAeSW
         Za9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hpHucya7a8dIbm3wn4a+7ihI+YD3U03xQgOBmUslQ5o=;
        b=I+uZcNcxc9CrZLlbGNFqnfkq4ApetykDwaTv06RJKCHHC4sroXf9UA2m6usx/Bpr+k
         bACl6pcnoMD17z1b1oerfj4Tvmr4ZTGHUdEoo7Hk38/Mxbi6VAn4eYoKdKE+rJB+i3UP
         /axiR0ceGIpDAj9oLtWNZ9L1qpVuhqRBkJhfBYq5/lr4V70MaeH7wOjHL5NIrZIQ8inQ
         9/NfKVLhnOHuLCv8LkDK+lIhBWl0L3Sg2I0b3T4CgokVEzgAfdV7HKTXPJWGtV1c5JHL
         XVudzYqB1ZwfnhxenCgszrbjesSaJDUOTNPuZztjhDsz6pLwpcPVglwJ1GsDPTN0og4m
         fl0w==
X-Gm-Message-State: AOAM533xYMXe886FvwNt94YJ9F8DQ7CdWJNZl4fbpirwEeTuc2pE1E5w
        6NgKUiEKDyZfh8Iitu9NSmFZSw==
X-Google-Smtp-Source: ABdhPJzxC74HqZ6+A4CZOG8QIFOijrZosi5zg/Dajb3WL7cYjh6fzO73uKGMJ5h7n1yH4qYiub2HcA==
X-Received: by 2002:a62:d418:: with SMTP id a24mr6786540pfh.249.1593534680348;
        Tue, 30 Jun 2020 09:31:20 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id n4sm3184606pfq.9.2020.06.30.09.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 09:31:19 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, paul@crapouillou.net,
        s-anna@ti.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] remoteproc: Address runtime PM issues 
Date:   Tue, 30 Jun 2020 10:31:16 -0600
Message-Id: <20200630163118.3830422-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set follows the conversation that took place here[1] and provides
the "two small patches" I alluded to at the end of the thread.

Paul Cercueil: patch 1/2 is compile tested only - please see that it does what
you want.
Suman Anna: Please test on your side and confirm that it addresses the Omap
regression.

Applies on top of rproc-next (7dcef3988eed)

Thanks,
Mathieu

[1]. https://lore.kernel.org/linux-remoteproc/20200515104340.10473-1-paul@crapouillou.net/T/#t

Mathieu Poirier (2):
  remoteproc: ingenic: Move clock handling to prepare/unprepare
    callbacks
  Revert "remoteproc: Add support for runtime PM"

 drivers/remoteproc/ingenic_rproc.c   | 84 +++++++++-------------------
 drivers/remoteproc/remoteproc_core.c | 17 +-----
 2 files changed, 27 insertions(+), 74 deletions(-)

-- 
2.25.1

