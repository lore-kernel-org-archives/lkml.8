Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78F5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 06:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 798972177B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 06:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WXIRFhFC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgHGGf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 02:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgHGGfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 02:35:51 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DE3C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 23:35:50 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id g33so433861pgb.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 23:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sArfDCPX+yKb9TQ1ON2BnB3SsuAFh3sZzLbDb6cibRU=;
        b=WXIRFhFCe4W5I6UgKWDCW3UyMYilZ32XCNH9uee6t/xanqVry8VnS7gryJMsuZBFY/
         yBoQD8rGfleNlkW7yfU+4wlASpGIk6kZbcI7RoTXpUe1/M1ruF8pdmz+KCAV9qOIER1N
         AHutCbPhvDh3rzitWzIXBLnCKJ63fOFuZ5gZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sArfDCPX+yKb9TQ1ON2BnB3SsuAFh3sZzLbDb6cibRU=;
        b=M8ZVcCWTSmVbxxfZNLcbtG2WRSAARGvGpI/89aALpEntRAoMkY3vBMEk52RLuUI4z1
         MCwODJJ5hTb3G0b65ZDzEt261RnjBCjpDJTTqfBi1O3CNxMZQWKar+1KaQFmvaCLNnIU
         jzxa4gNuCNmk6i1LrpEAmc0t1wMqS9se0uwZLcL6WoGcjrQsewFhFeVrFGfYL45hrF/m
         7y220WAnlLQsqHyCbb4WHdou3LfZBQRVVnYvPccBfWzZZw2lmpYKOnmpVkZUxM71LGpu
         A2WG4SE0cDq+1NXGeCfFHP517vKjNjLRIl+/HrUcRWgrlZRh3J0ipuz05G9rGnpI3wt0
         EQ3Q==
X-Gm-Message-State: AOAM531cULd9QJyi0JeW1OZWcZRvaloZoOM0u1eVe8qsz3/SKUmlSnbA
        vL/zLCx3jFYux8jT1lCjUsViNQ==
X-Google-Smtp-Source: ABdhPJwYh4MTlWGIL+50lpLKghCeomuo6cIkL3bH4TI5zJoOsDhOPDjNUP7PEy8JCuaxkfuLRBFvvA==
X-Received: by 2002:a65:614f:: with SMTP id o15mr10400330pgv.321.1596782150506;
        Thu, 06 Aug 2020 23:35:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o192sm12514425pfg.81.2020.08.06.23.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 23:35:48 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Jessica Yu <jeyu@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 0/2] module: Correctly truncate sysfs sections output
Date:   Thu,  6 Aug 2020 23:35:37 -0700
Message-Id: <20200807063539.2620154-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This fixes my sysfs module sections refactoring to take into account
the case where the output buffer is not PAGE_SIZE. :( Thanks to 0day
and trinity for noticing.

I'll let this sit in -next for a few days and then send it to Linus.

-Kees

Kees Cook (2):
  module: Correctly truncate sysfs sections output
  selftests: splice: Check behavior of full and short splices

 kernel/module.c                               | 22 ++++++-
 tools/testing/selftests/splice/.gitignore     |  1 +
 tools/testing/selftests/splice/Makefile       |  4 +-
 tools/testing/selftests/splice/config         |  1 +
 tools/testing/selftests/splice/settings       |  1 +
 .../selftests/splice/short_splice_read.sh     | 56 ++++++++++++++++++
 tools/testing/selftests/splice/splice_read.c  | 57 +++++++++++++++++++
 7 files changed, 137 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/splice/config
 create mode 100644 tools/testing/selftests/splice/settings
 create mode 100755 tools/testing/selftests/splice/short_splice_read.sh
 create mode 100644 tools/testing/selftests/splice/splice_read.c

-- 
2.25.1

