Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3F9C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 11:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A88CC21548
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 11:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XC3+t30G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbgIDLtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 07:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbgIDLsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 07:48:54 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20182C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 04:48:53 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id e17so5817503wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 04:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GC+xI1v+LH6EwCCui2W/bylz3lef9qs2WP5w5Vt2gQk=;
        b=XC3+t30GNQR7ER8LucbrB4H8KErDli+kgNmGVOpcPZeTAIoh4R7GVULyA1GAefC1rA
         iYVp4aj0kXEgCzvNc+7LWpENDQwjVOndNaddaYHuZbi2UpQRnDeBcq96OLf1OlvTWRw7
         cJr9Yk6RUKUM9lpoGONtlaxxlXwQKPs0OM2e3RRfvm1GcG8NdNorGt8zdIFYfn8a0wl4
         TVxZi9T180QNkUdqKOOk3grHclUZL0oHeNSu07pvsKQ+r2IVcHktOuR/mwtr1ypxW/VJ
         RIQG4+SN82jWt4acFG4vC8r8b3iktrYkCnLNfJmwqa4UQZBK08944D78bOJ6L5+kQYO/
         Zhtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GC+xI1v+LH6EwCCui2W/bylz3lef9qs2WP5w5Vt2gQk=;
        b=DrWB6fyor4eESzngarZDJzkmD1rv4gjb+4kWw4CJSdZsuoTO2Jwd/OAkBKonEKDaYi
         18XjjaTUmHSUhRJFhuYin4wgJinTQ4sdzFw6FudZdkA2ViT/TXnMvhSuiCEnmsNFZtNk
         ueR0bz24ehTtDYp+FOh+XeWFgsIh/MH0I8In9uvdwj51S94qYIQfAykpnjpxSid6wwQW
         fz2wFw7x/JBjZD0igx8H1w9uq469m+3XLBsON82NfA/PvB5pDLiYY2t/pzte0IvDhqp2
         0kOGiwHgmIChyMYbOw0/91BvjC6J2j4bGXMNpP2BQMqPM6o3SEFxguL9bTCy1FrfZNA+
         XUGA==
X-Gm-Message-State: AOAM533xzdRcjdisd6H90r3IjdSLMus5hhaUTiZgKh7I9g83fo5TEAyW
        JXjtVp4iE/jftwjqB8120VVN9UXyxbYJXg==
X-Google-Smtp-Source: ABdhPJwy4VbJBI0m+gT1IvKW1eTOd1kIDsXiLbKJ1JXltWdN7a4qJUGSVTyqx9anLYZaP8TVx8pPnw==
X-Received: by 2002:a05:600c:2f8f:: with SMTP id t15mr7509311wmn.41.1599220131751;
        Fri, 04 Sep 2020 04:48:51 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id r129sm10609714wmr.40.2020.09.04.04.48.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Sep 2020 04:48:51 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [GIT PULL] interconnect fixes for 5.9
Date:   Fri,  4 Sep 2020 14:48:50 +0300
Message-Id: <20200904114850.4306-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

Here is a small pull request with interconnect fixes for 5.9-rc. Please
take them into char-misc-linus when possible.

Thanks,
Georgi

The following changes since commit f75aef392f869018f78cfedf3c320a6b3fcfda6b:

  Linux 5.9-rc3 (2020-08-30 16:01:54 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/georgi.djakov/linux.git tags/icc-5.9-rc4

for you to fetch changes up to 91e045b93db79a2ef66e045ad0d1f8f9d348e1f4:

  interconnect: qcom: Fix small BW votes being truncated to zero (2020-09-04 00:07:12 +0300)

----------------------------------------------------------------
interconnect fixes for v5.9

This contains two fixes:
- Fix the core to show correctly the bandwidth for disabled paths.
- Fix a driver to make sure small values are not truncated.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

----------------------------------------------------------------
Matthias Kaehlcke (1):
      interconnect: Show bandwidth for disabled paths as zero in debugfs

Mike Tipton (1):
      interconnect: qcom: Fix small BW votes being truncated to zero

 drivers/interconnect/core.c           | 10 ++-
 drivers/interconnect/qcom/bcm-voter.c | 27 +++++---
 2 files changed, 27 insertions(+), 10 deletions(-)
