Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEADC352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 21:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 976FD206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 21:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W0GLvkV1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgBLVMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 16:12:54 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:51299 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbgBLVMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 16:12:54 -0500
Received: by mail-pj1-f65.google.com with SMTP id fa20so1406049pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 13:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=275VVMOyJXet8qGLKyv0s317kOMxSP4+JyRYkzCxaYY=;
        b=W0GLvkV1U5dDPe+pJywp8njwe6WCtqdNa2KjL6qSN5P5xQHXJVgf0acZuuuabOYoOe
         jR915WNQ9UJgNqi15kS1w8dPIAIwKQTc6lhZd8MW07Lrf1rCdmSYuqppVzkFtRqJ/M9w
         cCg7ykX1mdocrkskiqXt9zVlMZiegc2swzvc51zZoODNMt0QWMnqE7zO9RBPQcPGlE0v
         EYJ+NQHnhPPYQfMKd27AzKhDlrrfRENxF1u1mye6Lqf5nbHb945ifCooEOb3ot0jW1rm
         LmwrJyWFee6UbsaWFIMG6W8frSlDTOgPVIrgJM4lCEo/lVwNNDg+n45Vg+18CtB69Xd5
         WoDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=275VVMOyJXet8qGLKyv0s317kOMxSP4+JyRYkzCxaYY=;
        b=RZi8LGF6bDzDnlCCj8TlVqvtc/tjXGt1ZGRJ1TOD68/gD7XPWKfcRajc39lg8bkcsY
         iRUNm/xBQhujnSifvVp2joQl8XC1L3lodgTIDcnyKEPIDIOeOFmIcWXrbBQK86VxQVC+
         /SBqcDoaYX6wyWfg7qOgBU/Qha86bCAbhVcGqCuV7BYvVR+eAGGIRv8OIrlgBX2lDnnd
         ltWEOhVbojVt/HrGpnx8HAnn76HjK0tjpmgCxsDvPKltTY7ViW3U76ovuFEyGSN7ppAe
         tGq5kezCe6SWKzYqkSzQw5XOC7UoY8cJuABOFh6WVFqA8gy2GeoN6iqlOHul9naGRMEO
         ZaHw==
X-Gm-Message-State: APjAAAWzCwdUQI39ivmZkxqgRTwDMkYTJvgd/cIDVmxW0zKF8Evot+Fj
        /VG1zRTixtBs8+Iv9ETh4IdQpA==
X-Google-Smtp-Source: APXvYqzAWAyGpNzKK/hjbqAiQOK9BJLJ5eVAoJ6DTQ/v8VYBEDWCd15/FCRUxXaFn6YZUBZSj2rV7g==
X-Received: by 2002:a17:90a:9b88:: with SMTP id g8mr1134751pjp.72.1581541973841;
        Wed, 12 Feb 2020 13:12:53 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id h11sm48295pgk.48.2020.02.12.13.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 13:12:53 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     arnaud.pouliquen@st.com, s-anna@ti.com, xiaoxiang@xiaomi.com,
        t-kristo@ti.com, loic.pallardy@st.com, remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] rpmsg: core: Add wildcard match for name service 
Date:   Wed, 12 Feb 2020 14:12:50 -0700
Message-Id: <20200212211251.32091-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is the newest iteration of a feature that has been explored in
the past by Xiang[1] and Suman[2].  It was also deemed useful by Arnaud.

I have decided to use a new approach to avoid potential code duplication
that may happen with the introduction of an rpdev->match() and reduce the
footprint inherent from the addition of an additional description field.

I'm sending this out to restart the conversation on the best way to move
forward with this feature.

I have tested this on ST's mp157c-ev1 board - the kernel was enhanced but
MCU image remained unchanged, proving backward compatibility with the
current implementation.

Thanks,
Mathieu

Mathieu Poirier (1):
  rpmsg: core: Add wildcard match for name service

 drivers/rpmsg/rpmsg_core.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

-- 
2.20.1

