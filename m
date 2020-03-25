Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59F7C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 13:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ABC92077D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 13:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l8vxYG2i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbgCYNTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 09:19:55 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53843 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgCYNTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 09:19:55 -0400
Received: by mail-wm1-f65.google.com with SMTP id b12so2434788wmj.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 06:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qiuKH82RkkinscpVT5MDmCf35SBcMm8Pn5gqUPKg/6U=;
        b=l8vxYG2im6WxUeb7IB2kpYSjpoQnWUR+97IRP6w4deFbTZaCnijIjb6gg4s0ipUYga
         aDiziknssB202MurD0oRGObbJrZ6pC9rBRVKm5EAxs40ju4BSOzcaobkDBSqDRPle941
         s2IbfcP/GN2EhrGlh6FSS3aJXxj77aSaoWxxE/ytxIn2PmQi2pgWQT031BNrKvG/fIs4
         058pMdsMkeqk9dfyiz4g1jvWSorByC4/F3gAOjFXtTkOC3i8Qfw1g9IbM1UXWcFK4jwV
         4cs5KKhTNrCY6waUyDhoZ938kBfBLzyukOEwF85fYatG037I6kDP6bNu7frb2jQW5/Ls
         YD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qiuKH82RkkinscpVT5MDmCf35SBcMm8Pn5gqUPKg/6U=;
        b=GR7SS1qbeVfw0GLHdFIY2FSdka0F8pON6oQjpMYHfhCItHUyrDIdLphOJHwpBamqo5
         Lza/bbcR0MzTw5P4GItAMf40FHEfSEHdNqsIzPdNgsWjur7N+7sefrvYgXqr8pe5FYpg
         1wIm1QkrI2okCVD9R3NbnB6BA46pwySIYCntTqpYPjsl8XZu7a6AwmLKaAelNCe111p/
         FLsNCyijIP3PtN75G+hzjQ9OlzdGLQ2gcOtAgMdUDI7NdYcl7J5Ft9XtKHNbnaEQ5VBR
         l6SEuphMqkZ9Dw/tSSsCgJqs4n1bJwOq5Tb0QSnphao3UFVoNri5QIRS+JwcIWqxic5d
         CGZA==
X-Gm-Message-State: ANhLgQ3Cx9I4ofWb33iUOqLuwGL44qBFBRoSL2C26eE/vRHQVehnynli
        KIK7XnIJe7E5WkUpLhp6v8sq7g==
X-Google-Smtp-Source: ADFU+vtBvgsiUIDz2IOhLAYWwC7bAlWL2ptxwgaCU9+pyFs+9zVqAbJO0hvpZK91PNF/2pa3kIQDvg==
X-Received: by 2002:a1c:7f8e:: with SMTP id a136mr3548626wmd.33.1585142393979;
        Wed, 25 Mar 2020 06:19:53 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id d21sm33558302wrb.51.2020.03.25.06.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 06:19:53 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        nicholas.johnson-opensource@outlook.com.au,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 0/2] nvmem: use is_bin_visible callback
Date:   Wed, 25 Mar 2020 13:19:49 +0000
Message-Id: <20200325131951.31887-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As suggested I managed to use is_bin_visible for the existing code
and also added few more checks for callbacks before setting
permissions on the file. Which also means that Thunderbolt case
for write-only should be fixed automatically with this patch.

As part of this cleanup it does not make any sense to keep
nvmem-sysfs.c and nvmem.h anymore, so move all the relevant
code to core.c

Changes since v3:
	- Split patch2 in to two patches for better review.
	- drop first patch to add root_only as its queued

Changes since v2:
        - Remove nvmem_sysfs_get_groups()
        - remove nvmem-sysfs.c and nvmem.h and move all
        relevant code to core.c

Changes since v1:
	- Updated permissions setup logic as suggested by Greg
	- Added checks for callbacks.

Srinivas Kandagatla (2):
  nvmem: core: use is_bin_visible for permissions
  nvmem: core: remove nvmem_sysfs_get_groups()

 drivers/nvmem/Makefile      |   3 -
 drivers/nvmem/core.c        | 274 +++++++++++++++++++++++++++++++++++-
 drivers/nvmem/nvmem-sysfs.c | 269 -----------------------------------
 drivers/nvmem/nvmem.h       |  65 ---------
 4 files changed, 272 insertions(+), 339 deletions(-)
 delete mode 100644 drivers/nvmem/nvmem-sysfs.c
 delete mode 100644 drivers/nvmem/nvmem.h

-- 
2.21.0

