Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F14AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A97D2073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ij2fML/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730081AbgGUQxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 12:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgGUQxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:53:22 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D37CC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:53:22 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id w3so3566920wmi.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 09:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I60PP0ifqqtbneTVUmcsZVsjqNfLovgwkXHnDS7nrmk=;
        b=ij2fML/xrvdwayy7tlfqTSJBbPRk4/3pp6IQuyAMGsZp9ggQ4e/HMdp4J/FicdrwN1
         auVNr8uB0hCDNuc5zk2Z2IoH4CSvY33ge24xAR0qbe7DMdHb/c/r0LJZ42y4tajv4VAQ
         wkdojyVlybnEUoGH8xPUOiPbISxC2z0RrO8TXnelslgxUSpvR3EuUVLYT914t5S/yzGo
         t6aULZY9c9ZFC7IvntXK0MvvQ7ptUsySjbwdLivyyJarLlsL9tYFEcg2w+m6KIWGbUxj
         WpOTkypthgfJ0lS3T/FW6rKnm3KQuG6Hx+lV5kaUkPcukHIRRVQ2kYBhbl8MZwzY6ajv
         4tYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I60PP0ifqqtbneTVUmcsZVsjqNfLovgwkXHnDS7nrmk=;
        b=jA2BQs4/6x1DWpoS+hGDR3OqCa8W4AbdE6L5zPef4zT54dauW5s5VsBrKmqqPZHQQa
         pS0pF9WfpJeWtHeJ0lgwltzXuW9ZLACoK3SP38qK6Nn+IPL2adCASpOE40Gp1QlCJjFq
         +JUux0aRCx9Kr10TgtfFSqRbgJR+CAbUxRark6C+zSk/tUDjAbEH0VgVqG3RwOsMf+OL
         90uODZjINfjCdc0cDonURcYMeerY3m9dOrri4osksuWXKdPTFIvAUAUOsGWbb/P20I+M
         1ysB8m4ab3wJ0+Ho/7J9puTiY+RTFnn6Hfn4IwBjPPCZZFY8vA5u8r1CrnqIYRoUiCmq
         6h7w==
X-Gm-Message-State: AOAM532U2/pTPIcfFdyN+3m4MMSS9GisYcj3C6thmKn5Ch0kgtXlq1gx
        kIXJe6jAJ8sPe4A+iEX+MkhrTQ==
X-Google-Smtp-Source: ABdhPJzTkiFMaTdH7eNy9LidpiVvIUWAUG2bl+BAYbak8+IUSPqGsVHH0YlWUZ7ELzgu/tXPkqVNPA==
X-Received: by 2002:a1c:3954:: with SMTP id g81mr4834946wma.73.1595350400843;
        Tue, 21 Jul 2020 09:53:20 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id c25sm4058648wml.18.2020.07.21.09.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 09:53:20 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ckeepax@opensource.cirrus.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 0/9] ASoC: qdsp6: add gapless compressed audio support
Date:   Tue, 21 Jul 2020 17:52:57 +0100
Message-Id: <20200721165306.29082-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds gapless compressed audio support on q6asm.
Gapless on q6asm is implemented using 2 streams in a single q6asm session.

First few patches such as stream id per each command, gapless flags
and silence meta data are for preparedness for adding gapless support.
Last patch implements copy callback to allow finer control over buffer offsets,
specially in partial drain cases.

This patchset is tested on RB3 aka DB845c platform.

This patchset as it is will support gapless however QDSP can also
support switching decoders on a single stream. Patches to support such feature
are send in different patchset which involves adding generic interfaces.

Thanks,
srini

Changes since v1:
 - Fixed all the comments to use "q6asm" wording correctly.
 - dropped patches that are already applied

Srinivas Kandagatla (9):
  ASoC: q6asm: rename misleading session id variable
  ASoC: q6asm: make commands specific to streams
  ASoC: q6asm: use flags directly from q6asm-dai
  ASoC: q6asm: add length to write command token
  ASoC: q6asm: add support to remove intial and trailing silence
  ASoC: q6asm: add support to gapless flag in q6asm open
  ASoC: q6asm-dai: add next track metadata support
  ASoC: qdsp6-dai: add gapless support
  ASoC: q6asm-dai: add support to copy callback

 sound/soc/qcom/qdsp6/q6asm-dai.c | 413 +++++++++++++++++++++++--------
 sound/soc/qcom/qdsp6/q6asm.c     | 169 +++++++++----
 sound/soc/qcom/qdsp6/q6asm.h     |  48 ++--
 3 files changed, 467 insertions(+), 163 deletions(-)

-- 
2.21.0

