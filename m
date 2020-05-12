Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B03CA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 18:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8C60206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 18:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iF5VSIKN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730948AbgELSRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 14:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgELSRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 14:17:53 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3755FC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 11:17:53 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id u6so14762513ljl.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 11:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Iq3dIfv5tPcZS+iVz4vDzZAMKbzd/xG3UK49g/TYZo=;
        b=iF5VSIKN56orrBv8Ix0tyuiVRIOGGJM3gb+4WghfErvAKAJeEh8GeREowaktFH5bKq
         B8lL3tLmcAkBpui1zu3NTMcZX6jPc2nEgHlIqeVW+LBXTHjGwdedMyQesE3t9+ZWair2
         /M0vxmSosa3BSPztXdIu9ZO9eT4Ya6AmHtCpoBAiIERJackz4UCsggpqTpKfRjdiIxxq
         SPsNTrWmeyUpEdjNGoCXHQXibWT7wYSo6x3zqZhE7DLvLe1EuBNcUf47QgiHfwfoGbiP
         maBqNH4GPB3tTIOJbuzE8xRNtXsHKHz7ANTPE/4YpVZ1W0qT2HzolfjlHL7IsctWyWPj
         LiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Iq3dIfv5tPcZS+iVz4vDzZAMKbzd/xG3UK49g/TYZo=;
        b=Nz9pZ6kDccM9rJA0HrVvxlNMyiCniHAh+9y4JKXGzRSrND0R+rk8uuvfL3TQZN7Akl
         T+SjnziEuqXBfY+p1l9yN6CieZ9L1F7EELwYbEsAeFQYiDES29fNQwgrS6x9DjG7yxvN
         RIyyhWnQzxEzSDoulfUyrF8uHV0e1EnUIafy8+0Q9tLcBly6D0nJBzQ9i1sDiro90+Z4
         H/71r6HVmyoTuazXwOi+MUZOD46hamLqCXm86D+WaGDwYYoTQlkEieyCe4tKnm20vcE2
         TyXMPA02k4Kwq9Np3mJ3cTPGYHclmC1cNfj5vzG6LqzhK+X+kAYG8rX8gGTLweGFtTXC
         sDkg==
X-Gm-Message-State: AOAM533LJ7Wbh5xsCVuv4mqsoOoElVyi/DxBaUO+8ynsPkqnWP822Sq/
        MYAarmkw0CeVgVYbwtJyfYOYvw==
X-Google-Smtp-Source: ABdhPJwFkr2rpMdIXqc15qolqNUBFKHUyi/oopg6CLWqNRX2KdRgBoRsLb8B7GxFF5x7ZQpQFWsW3A==
X-Received: by 2002:a2e:9a54:: with SMTP id k20mr15444802ljj.265.1589307471673;
        Tue, 12 May 2020 11:17:51 -0700 (PDT)
Received: from localhost (c-8c28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.140])
        by smtp.gmail.com with ESMTPSA id n23sm13340951ljj.48.2020.05.12.11.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 11:17:51 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     dhowells@redhat.com
Cc:     masahiroy@kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v2] scripts: fix deprecated always and hostprogs-y
Date:   Tue, 12 May 2020 20:17:45 +0200
Message-Id: <20200512181745.11866-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I did an allmodconfig build the following warning showed up:

scripts/Makefile.lib:8: 'always' is deprecated. Please use 'always-y' instead
scripts/Makefile.lib:12: 'hostprogs-y' and 'hostprogs-m' are deprecated. Please use 'hostprogs' instead

Rework to use the new 'always-y' and 'hostprogs'.

Fixes: 631ec151fd96 ("Add sample notification program")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---

Fixed Masahiro's comments.

 samples/watch_queue/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/samples/watch_queue/Makefile b/samples/watch_queue/Makefile
index eec00dd0a8df..8511fb6c53d2 100644
--- a/samples/watch_queue/Makefile
+++ b/samples/watch_queue/Makefile
@@ -1,7 +1,7 @@
 # List of programs to build
-hostprogs-y := watch_test
+hostprogs := watch_test
 
 # Tell kbuild to always build the programs
-always := $(hostprogs-y)
+always-y := $(hostprogs)
 
 HOSTCFLAGS_watch_test.o += -I$(objtree)/usr/include
-- 
2.20.1

