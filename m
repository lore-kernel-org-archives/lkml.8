Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B91C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0BDE20714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WPPBH3nz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbgCZHYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 03:24:17 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:55521 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgCZHYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 03:24:16 -0400
Received: by mail-pj1-f67.google.com with SMTP id mj6so2083929pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 00:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=zaVPiZSbTwkEt7KpNN/M3BI21ttEa/LUmUrZmTXZKSM=;
        b=WPPBH3nzYe5MV9mhKaH46HyuwQto7ae8Aw88kXpP2pA1fw+4OjqEr0aSMcR7nzjQJ2
         VOepy8fARXXsgBRvE50Jh3oFX01IlpbbMgyqqMe4O6cgUjyMFaqXtptkEKv7/FEOOsbT
         t2umhmCRfNt/QqFerQMULiMufQg0gmI0qLiZhXiOA799XsLZn31691jsWBMUdFtYnY5v
         /uV/8IWzyOe1B6OiSNPL0wC9PfrXiFl8H48rVSUjK8LfStIZEPF0IbO1BSLypFIsepR3
         0Dfbxa6WwohUmNMNgMw9E+8QtWK4KqYtumh0Y3L6n+8wW6Vgoox80tqqwERpwGjBKwz2
         LaBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zaVPiZSbTwkEt7KpNN/M3BI21ttEa/LUmUrZmTXZKSM=;
        b=UScqGL+QygE+H6sZkgNGHG2S5pvD4VhIznNkOqepuUGLrZd/C7RUbFt6IlnyynNiqU
         7+/xPBZfjTOEMTQmaCLRnwKcA3jnwfI158+uxPDyr0sGXPHgRc7DXs11CNKKepdnp3U6
         31w5H0s4kz5UXBvcpOSIDI6k1NxPRKIjFKrf9Y2cnwFuzmeVG65lGFbloBkNVyEnJ/i0
         8+AsVDxV9rQ2rJFqMFT688198sv5XT6xKOBXFgB5wOEwIq9NEwuT8aJtnFyli6XUBWY6
         tdKXY9nKayIM8trsS5AkpKbS7akjUMeO4WCl4aKpL539ApBgpkOqdJQo9QzWcpYn2Lpz
         mwAA==
X-Gm-Message-State: ANhLgQ1lyWRoltTMynaubWzYO4CjBRtG2ss+0iD3gbxeDc58snc7R/l8
        Pfq4rFpzaAdCZ9MDaVeRDi1zVGop+FM=
X-Google-Smtp-Source: ADFU+vtX2Qo07Fy8MDY1/vrCHaJqDE2yYS2qqPsEesFJSsVljg2ZDOtR78hoKUwRUBrCWZv1/ooJJA==
X-Received: by 2002:a17:90a:4809:: with SMTP id a9mr1618593pjh.73.1585207453904;
        Thu, 26 Mar 2020 00:24:13 -0700 (PDT)
Received: from localhost.localdomain ([117.210.211.37])
        by smtp.gmail.com with ESMTPSA id e80sm979504pfh.117.2020.03.26.00.24.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Mar 2020 00:24:13 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     jens.wiklander@linaro.org
Cc:     tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        stuart.yoder@arm.com, daniel.thompson@linaro.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v5 0/2] Enhance TEE kernel client interface
Date:   Thu, 26 Mar 2020 12:53:47 +0530
Message-Id: <1585207429-10630-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Earlier this patch-set was part of TEE Trusted keys patch-set [1]. But
since these are completely independent enhancements for TEE kernel
client interface which can be merged separately while TEE Trusted keys
discussions are ongoing.

Patch #1 enables support for registered kernel shared memory with TEE.

Patch #2 enables support for private kernel login method required for
cases like trusted keys where we don't wan't user-space to directly
access TEE service.

[1] https://lkml.org/lkml/2019/10/31/430

Changes in v5:
- Misc. renaming of variables.

Sumit Garg (2):
  tee: enable support to register kernel memory
  tee: add private login method for kernel clients

 drivers/tee/tee_core.c   |  6 ++++++
 drivers/tee/tee_shm.c    | 28 +++++++++++++++++++++++++---
 include/linux/tee_drv.h  |  1 +
 include/uapi/linux/tee.h |  8 ++++++++
 4 files changed, 40 insertions(+), 3 deletions(-)

-- 
2.7.4

