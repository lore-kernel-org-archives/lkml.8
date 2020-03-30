Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92E7C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 16:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D4820578
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 16:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhDgcVYk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbgC3QaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 12:30:13 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41297 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgC3QaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 12:30:13 -0400
Received: by mail-pg1-f194.google.com with SMTP id b1so8890598pgm.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 09:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HxfNuI2iG4J1qKdJFFaM5eKiU091xw17n/pAcgsjklg=;
        b=OhDgcVYkpggTTlgIL1zbHaw5aMKxRVjpTk+SNPYyMBGbybwmeZOkAWl6IEBhgZOLnD
         sWe0CfXXZqusgiClTU0nbEVrcRrHG0e8XAd4jFKO6l3IjQDs6psRYzPgqOQsSrWnkqou
         zKFN7+yuyGThuCFe4JGIgx1eyGDisMQT81O927yKUDB28iimk0KQSVExn/QW36QsZB+C
         +e05ru4CWs1goUWIY002rXU+Q7GIfeJKq7jWc4Nw/8wKXHcEKtwpFXHHXf7CZwqbv1US
         JCgfVAJ5/gdNfeTFX6XsWJAoOYrOgBtKMOzbUIx8HtqAC8ZxnFHaFQwUMMcJWsnbIi+T
         rP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=HxfNuI2iG4J1qKdJFFaM5eKiU091xw17n/pAcgsjklg=;
        b=UlNb6on2U1yw067Zxs4s+UaVXu1t22EQxYBTiiCLGkqiGYfTPgjCRceIi/ofbXJ/lF
         /9VMaJj823wwg1pnHR9PScY7ch6wsNQPO7hh8SxzYKujntCsrBTV/UXysHEw1NY8VefB
         ZjLpeuJG0JHZz88BsdfsUwN75NgXzF1WFWgLkD8qpI1tqdCliGl0r0q2//sJBcimL2I5
         MA8+bpDishcfrIbXSK3Csu13IoiMjhx+rjNY7LO1kKz1uMImtl8wRRHyxrK3GZ7eM7cA
         wqsL0JtGAH22q+83mXwVq99GSrT0rBQf8RNHbjH2QdAf51SyjbPEe2YflO2V6td2/KSs
         2eUg==
X-Gm-Message-State: ANhLgQ2JB8qp31hQCjqOU2tUcJe8+kMDaAxWD4bBLJFtPPUkHXghOEJK
        DmC6vClv7fITVHPEP3j8yHFkz4Ke
X-Google-Smtp-Source: ADFU+vthwNXtBGqBEVSC0GzYBd7kuRmS/miaLv6x5vJsvdfAAdNkMDYMhpXlRg7eN3sINL26lRKWuw==
X-Received: by 2002:a63:cb4a:: with SMTP id m10mr13998178pgi.101.1585585811879;
        Mon, 30 Mar 2020 09:30:11 -0700 (PDT)
Received: from sultan-box.localdomain (static-198-54-129-52.cust.tzulo.com. [198.54.129.52])
        by smtp.gmail.com with ESMTPSA id mu15sm14398pjb.30.2020.03.30.09.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 09:30:11 -0700 (PDT)
From:   Sultan Alsawaf <sultan@kerneltoast.com>
X-Google-Original-From: Sultan Alsawaf
To:     linux-kernel@vger.kernel.org
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Sultan Alsawaf <sultan@kerneltoast.com>
Subject: [PATCH 0/1] drm/i915: Disable Panel Self Refresh (PSR) by default
Date:   Mon, 30 Mar 2020 09:30:05 -0700
Message-Id: <20200330163006.4064-1-sultan@kerneltoast.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sultan Alsawaf <sultan@kerneltoast.com>

Hi,

Laptops which support an esoteric power-saving mechanism called Panel Self
Refresh (PSR) suffer from severe graphical corruption and flickering. Enabled by
default in 5.0, PSR causes graphical corruption to the point of unusability on
many Dell laptops made within the past few years, since they typically support
PSR. A bug was filed with Intel several months ago for this with more
information [1]. I suspect most of the community hasn't been affected by this
bug because ThinkPads and many other laptops I checked didn't support PSR. As of
writing, the issues I observed with PSR are neither fully fixed in Intel's
drm-tip branch nor in 5.6. Disabling PSR by default brings us safely back to
pre-5.0 behavior, remedying the glitches. Also, Ubuntu now ships with PSR
disabled by default in its affected kernels, so there is distro support behind
this change.

Thanks,
Sultan

[1] https://gitlab.freedesktop.org/drm/intel/issues/425

Sultan Alsawaf (1):
  drm/i915: Disable Panel Self Refresh (PSR) by default

 drivers/gpu/drm/i915/i915_params.c | 3 +--
 drivers/gpu/drm/i915/i915_params.h | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

-- 
2.26.0

