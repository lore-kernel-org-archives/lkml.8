Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEE7C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A80F620772
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gpkp0jMO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbgCYMVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:21:24 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41262 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbgCYMVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:21:24 -0400
Received: by mail-wr1-f65.google.com with SMTP id h9so2776987wrc.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 05:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r2fiVyCm0zg5gOnJSx7WVUX1ZjnEJNRR9Zg/kDFwLRg=;
        b=Gpkp0jMO5443L07QvRhCrZ2ftqe9hjtKbSo53+mO60epwjXSVJL6NninikVr05jAQD
         PJqHO+KPtjNuOhVXI0Sb3Wr7U0MK9lkbZ2ui8jfW9bfwAuMIPk0n3zt2/7rNC4JwLjiT
         s7Ho0HUxy8PLDmOXLUuI5MvzNg/GSGIhanhiIzI8RU1lA7OJSq6rpqaAoIoiJ2ZerDYs
         tFCQG9sx4AiB7u7sedfUIBSqj3z8dDeNRq9his8Yw0Qt7NqWiRxS66/4ThoiswzWnoQo
         kSbKgW0IiC7xu1KFcSqvAeNsvyBRr8ZCMGmnTXd+wsy1/aK/50Pb0e+WrsYSpyPF1ZZJ
         en0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r2fiVyCm0zg5gOnJSx7WVUX1ZjnEJNRR9Zg/kDFwLRg=;
        b=F78kqpnmrubvqiidmFwg/gPsRccqFsQS+deT7YZ9XdaAmSqn4s9TATI7gJz/n+nm+2
         n88s20gKeZclAyXJ+JRMPKDfWYWi2k/Vabv/Fxwen5OKs8Gury39hXc3SE8/JGuo6YD1
         9JbWDV8pGclfiddK6ajwMk6Kn5gwgRAd2QhnJeLR7xCqs54LeePrYDtQLGqRMV+tGoPL
         IDScDp6bogedoIXPQrsUVGVq7hBqkxJrznQdApJye8PzopScUmPQfzSTQE+hXYazl3K0
         aW+5COEr5vPlfRQ62P4Fcu7t6q3x/k072xnBtKSu/7G4LbmJXWmiw1Zl5EAHFUth5qby
         WqjQ==
X-Gm-Message-State: ANhLgQ1Tr9MIoEuqSNfGuFgM1uVLck6siEGM/Z5QtdXvzFQBDzligfeq
        7AmCzxgXoTelmrUCHo3qvLT2SA==
X-Google-Smtp-Source: ADFU+vu6fRUe3PWWHC16GZMmpIkS8M1FTEIoDDLNsRfM51hS6TCpxcpTHsW4uudWERBdityuqO6mXA==
X-Received: by 2002:adf:9796:: with SMTP id s22mr3087807wrb.31.1585138882011;
        Wed, 25 Mar 2020 05:21:22 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id n1sm33620159wrj.77.2020.03.25.05.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 05:21:20 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        nicholas.johnson-opensource@outlook.com.au,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 0/2] nvmem: use is_bin_visible callback
Date:   Wed, 25 Mar 2020 12:21:14 +0000
Message-Id: <20200325122116.15096-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

As suggested I managed to use is_bin_visible for the existing code
and also added few more checks for callbacks before setting
permissions on the file. Which also means that Thunderbolt case
for write-only should be fixed automatically with this patch.

As part of this cleanup it does not make any sense to keep
nvmem-sysfs.c and nvmem.h anymore, so move all the relevant
code to core.c

Changes since v2:
        - Remove nvmem_sysfs_get_groups()
        - remove nvmem-sysfs.c and nvmem.h and move all
        relevant code to core.c

Changes since v1:
	- Updated permissions setup logic as suggested by Greg
	- Added checks for callbacks.

Thanks,
Srini

Srinivas Kandagatla (2):
  nvmem: core: add root_only member to nvmem device struct
  nvmem: core: use is_bin_visible for permissions

 drivers/nvmem/Makefile      |   3 -
 drivers/nvmem/core.c        | 275 +++++++++++++++++++++++++++++++++++-
 drivers/nvmem/nvmem-sysfs.c | 269 -----------------------------------
 drivers/nvmem/nvmem.h       |  64 ---------
 4 files changed, 273 insertions(+), 338 deletions(-)
 delete mode 100644 drivers/nvmem/nvmem-sysfs.c
 delete mode 100644 drivers/nvmem/nvmem.h

-- 
2.21.0

