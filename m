Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2661FC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 001D7206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jwGWffsD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbgD1SKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbgD1SKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:10:12 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791EDC03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 11:10:12 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s18so8092864pgl.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 11:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YR7svNgZLAa/GMNq00Z1PiEarel0TnzPpj7HuP93QpM=;
        b=jwGWffsD4IH6FHp9Z9ZmMHmEBsm/dQLaHbL3mMwSRiS95j4klMWLaCkN7rQjMN4Ffu
         /su/x7WQH6L/v3beF0mrj0vm9456iZulgBznPQeJfgUKZXCn3vP0dDRGM/zb71TAgYlz
         tVa4FUkgnhzNXt5j3ZpZ+iiIYUEBe+ya1E2B4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YR7svNgZLAa/GMNq00Z1PiEarel0TnzPpj7HuP93QpM=;
        b=BuwFgdlOD0Kk+SNw3AdCtlCLoiwkfUUErZJcZ0Ju1Tee9vNsa5mnt2/v9xixWv5A6M
         8AeBebY5utluUBg0iIsCmzv6RsiGwSAYaaObfihJ0epnvWNrZlczGD8gn4FdnDQS6pR3
         2fm5/RiLF+AUjxQSaj9H4d0E4DBmzeRx1Wq2P3lSbdpg3XthBHTnwJZYF6jbe0UQxzsK
         cx/Cl0UOnJ930TIfvWRCnoJnNBzE7xmYbxWh6BJndUpwPLXAMiTsM205uuUj6ncofR8q
         ZNfIPoS8vT38aVGXd7MCe9aAKj67MUAlw7jvVZEjKYr8bV2fMRFWrQvtivSBQZD4voEr
         Dobw==
X-Gm-Message-State: AGi0PuaKAhLq/aJZbV7NvE/BiWGZXPr3KlDrooxtS6DiKfP0ueyr1YiA
        wcOTuBbBXZB/BsarGDJCIvEUvg==
X-Google-Smtp-Source: APiQypI9HqVyd1i7Zguj/Ug8tJ6Cif/uN5YcUFbKGqXOIuN5Gf/zPIyJZUoGWDwNsgTGF5Jv7wWhng==
X-Received: by 2002:a63:5853:: with SMTP id i19mr27344873pgm.288.1588097411858;
        Tue, 28 Apr 2020 11:10:11 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id h197sm16260910pfe.208.2020.04.28.11.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 11:10:11 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v2 0/2] Minor sparse and style fixes
Date:   Tue, 28 Apr 2020 11:10:08 -0700
Message-Id: <20200428181010.170568-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I got a report that kcalloc() didn't exist in coresight-cti-platform.c
on arm builds and that looked like we didn't include very many headers
to get prototypes of functions like kcalloc(), etc. The first patch fixes
this problem by including the headers and then the rest of these
patches fix minor sparse and style issues that I saw while looking
through the coresight directory.

Pathes based on linux-next.

Cc: Suzuki K Poulose <suzuki.poulose@arm.com> 
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Douglas Anderson <dianders@chromium.org>

Changes from v1:
 * Dropped patches that were applied
 * Added more includes to cti.c and priv.h

Stephen Boyd (2):
  coresight: Include required headers in C files
  coresight: Avoid casting void pointers

 .../hwtracing/coresight/coresight-cti-platform.c    |  8 +++++++-
 drivers/hwtracing/coresight/coresight-cti-sysfs.c   |  7 +++++++
 drivers/hwtracing/coresight/coresight-cti.c         | 13 +++++++++++++
 drivers/hwtracing/coresight/coresight-cti.h         |  8 +++++++-
 drivers/hwtracing/coresight/coresight-priv.h        |  9 ++++++---
 5 files changed, 40 insertions(+), 5 deletions(-)


base-commit: 62eb0c79662ccb3c09c3724d0d4df2501cb8277c
-- 
Sent by a computer, using git, on the internet

