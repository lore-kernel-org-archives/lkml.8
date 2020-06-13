Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F36FC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 22:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 475972078A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 22:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YfeUkdrA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgFMWjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 18:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgFMWjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 18:39:36 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EBEC08C5C3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 15:39:35 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id gl26so13573803ejb.11
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 15:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=1HN9alufzB8NJoHpHLW1/fOwOpiyc7Q8JMhu8E/6NQY=;
        b=YfeUkdrAAXeRR5txHP9A1x7xhuS6YwR2+n0z3Gwfv5nU4OSpCX39r2h26Il2RUKKdc
         L9zBxDGk19TusapRgmGNI16ZqavPQ/vDyF+86cm+e/0Hz2FmsO8l3qbndJ+FXfMoVSnK
         KFVWdsFC4Zlx6P4+S4DzmdWvQmdj46ceiH3JHYlGsFZNWpzXT0+vD+dhTFDjycoae9LR
         H+PENYzUDIn0RCHLoyFx8obpbHpxsIhIHa3bOcSGmym0nAc/4lcWVLFDm/lP4tuPFhAr
         1enFOWs3RCkwxFYyfacXUZrgnFkkdca3prmhYwxEtdaFT3SfUx8To5GurbzCjLuhJ+9g
         GktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1HN9alufzB8NJoHpHLW1/fOwOpiyc7Q8JMhu8E/6NQY=;
        b=n2tYTqrZ48GokKN7Bob6uJbQTBT8hFI5r1Dwz9g5tD49vqfh4MfYzem7lvRhC0oby9
         qNrxx3dGZTOq4IHsOuoO7ljMzIfIxKm94lEJfoHFWbVK1bYxRpwd1kPncO5sOLT6E5qN
         eQagGBFdSGiiHHQSE1ehH66/wl5PZ6qAf6ybfWeGA+LhNqlsamI6LddOpZj8Guyt1g1N
         crbmq9MVYgyn1iy/wjfwN5pSyHukbYS5b23bnSX052ACYGSq80wwWw0NPcLVcVJQAGcI
         okj7KFkhY1wVp6z7efIhWVpCAlBIJSwcIsn7dcSIE3VOXmVUhqcOMm+vap9In7053y1M
         KPFA==
X-Gm-Message-State: AOAM533E5eCx0//diOqYyElRicMZdcD7XzS7Pw/VpKZTHsbar7OC1d6e
        GNBUCLEX7pzjffb7CWFwjVLwQfxOzS5bLg==
X-Google-Smtp-Source: ABdhPJwlcm5rgjD40HUNjeatpPH2udNWa8GwXsbY6X8NtkOfsPUGF7hlTw962UHa4NYMm4OFPHU1bg==
X-Received: by 2002:a17:906:7247:: with SMTP id n7mr19422656ejk.105.1592087974315;
        Sat, 13 Jun 2020 15:39:34 -0700 (PDT)
Received: from localhost.localdomain (212-5-158-38.ip.btc-net.bg. [212.5.158.38])
        by smtp.gmail.com with ESMTPSA id u3sm5581606edx.25.2020.06.13.15.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 15:39:33 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        jim.cromie@gmail.com, Joe Perches <joe@perches.com>,
        Jason Baron <jbaron@akamai.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v4 0/3] Venus dynamic debug
Date:   Sun, 14 Jun 2020 01:39:16 +0300
Message-Id: <20200613223919.7038-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Time for v4 with following changes:
 * 1/3 taken comments into account - Greg KH
 * 2/3 kept the patch version from v2.

Cc: jim.cromie@gmail.com
Cc: Joe Perches <joe@perches.com>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

I decided to keep 2/3 as it was in v2 of the current patchset
where the grouping of KERN_DEBUG messages has been accomplished
by dynamic debug 'format' filter. Depending on how WIP patches
from Jim [1] will progress I'm ready to change that. Until then
I'd like to have a  way to group the debug messages.
In case 2/3 is not accepted I'm willing to drop it from next
pull request.

v3 can be found at [2].

regards.
Stan

[1] https://lore.kernel.org/lkml/20200613155738.2249399-1-jim.cromie@gmail.com/T/#t
[2] https://lore.kernel.org/lkml/20200609104604.1594-1-stanimir.varbanov@linaro.org/

Stanimir Varbanov (3):
  venus: Add debugfs interface to set firmware log level
  venus: Make debug infrastructure more flexible
  venus: Add a debugfs file for SSR trigger

 drivers/media/platform/qcom/venus/Makefile    |  2 +-
 drivers/media/platform/qcom/venus/core.c      |  3 +
 drivers/media/platform/qcom/venus/core.h      |  8 +++
 drivers/media/platform/qcom/venus/dbgfs.c     | 51 +++++++++++++++
 drivers/media/platform/qcom/venus/dbgfs.h     | 12 ++++
 drivers/media/platform/qcom/venus/helpers.c   |  2 +-
 drivers/media/platform/qcom/venus/hfi_msgs.c  | 30 ++++-----
 drivers/media/platform/qcom/venus/hfi_venus.c | 27 ++++++--
 .../media/platform/qcom/venus/pm_helpers.c    |  3 +-
 drivers/media/platform/qcom/venus/vdec.c      | 63 +++++++++++++++++--
 drivers/media/platform/qcom/venus/venc.c      |  4 ++
 11 files changed, 172 insertions(+), 33 deletions(-)
 create mode 100644 drivers/media/platform/qcom/venus/dbgfs.c
 create mode 100644 drivers/media/platform/qcom/venus/dbgfs.h

-- 
2.17.1

