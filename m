Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E713DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 20:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C029320767
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 20:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T+TvmO6f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407180AbgFYUhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 16:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405041AbgFYUhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 16:37:09 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1F7C08C5DC
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 13:37:09 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id p3so3876698pgh.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 13:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d3GeLK+nXjwF6qopXKxu4ABEIWtd3N9QgHPk+DpZ9DQ=;
        b=T+TvmO6fHmdSxxhmwQF6bCqwTYesZ26yWqZboO+42b4Ie4kzH6zGD3MEM6/mR+k1qo
         3/53fF6qs1obN0PM9p7Ghgh3T59x1FbCG7HXARnuUe34xNmxM1tkRPBj2CkA0LelU/GV
         Anxsf9KOCQ0VaVa1QhyynBigEsblv0lSlybEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d3GeLK+nXjwF6qopXKxu4ABEIWtd3N9QgHPk+DpZ9DQ=;
        b=CSgz9Y3QDsOR5dDg9E/KM48DeqATv39RjJDRVV5eFdd2U5JfUZWdQpvOjNLFfLkA5E
         wIm5fckw98NDVUn1l9RaOVJzNkVHi6Oc2iDrXXc9C7uoTfqza9/IIdD7fxj6dFSN6TDZ
         6Yi/1y77E2VDhaT2L9u/c9gsAyNOmiAiS7e0yX3zNfJm5I07Oyu+Z3aTcpKDAsfD2Pkm
         aRtfP0NCDL0mT41PRQdndsUy/Uiw0QMMQ9uZH0ybfHePBgKXi1X3dbJJZDlcbqJkhc1j
         SmaVaX5ZyhjhEWkB3puUWzSBKJ7T3T/4jdvk92iJmaD5SnkOQl4ef7eHxmVkPd0sW0Hf
         sUhw==
X-Gm-Message-State: AOAM532j/XyitrHq/u61iXAe0Cm7FuMvMVjLLCUlELUEDSQ7kMA0BtG1
        UJ57sCHgMCEbTEwY5wCyXMKMyw==
X-Google-Smtp-Source: ABdhPJxuNWPKYgd5trz2foxr85WYRx00emue48cZggJc6TgB+Btx4HxdZWfpU/cEGBgAfXWd09NKFg==
X-Received: by 2002:a63:fe0a:: with SMTP id p10mr21957815pgh.255.1593117428713;
        Thu, 25 Jun 2020 13:37:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w10sm21295494pgm.70.2020.06.25.13.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 13:37:07 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [PATCH drivers/misc v2 0/4] lkdtm: Various clean ups
Date:   Thu, 25 Jun 2020 13:37:00 -0700
Message-Id: <20200625203704.317097-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

(Since this was aleady pending, I just spun a v2, resent here.)

Can you please apply these patches to your drivers/misc tree for LKDTM?
It's mostly a collection of fixes and improvements and tweaks to the
selftest integration.

Thanks!

-Kees

v2: - add fix for UML build failures (Randy, Richard)
v1: https://lore.kernel.org/lkml/20200529200347.2464284-1-keescook@chromium.org/

Kees Cook (4):
  lkdtm: Avoid more compiler optimizations for bad writes
  lkdtm/heap: Avoid edge and middle of slabs
  selftests/lkdtm: Reset WARN_ONCE to avoid false negatives
  lkdtm: Make arch-specific tests always available

 drivers/misc/lkdtm/bugs.c               | 49 +++++++++++++------------
 drivers/misc/lkdtm/heap.c               |  9 +++--
 drivers/misc/lkdtm/lkdtm.h              |  2 -
 drivers/misc/lkdtm/perms.c              | 22 +++++++----
 drivers/misc/lkdtm/usercopy.c           |  7 +++-
 tools/testing/selftests/lkdtm/run.sh    |  6 +++
 tools/testing/selftests/lkdtm/tests.txt |  1 +
 7 files changed, 58 insertions(+), 38 deletions(-)

-- 
2.25.1

