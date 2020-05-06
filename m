Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDF5C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87DAB2080D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BJcGak/P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbgEFPVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728821AbgEFPVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:21:43 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF5AC061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 08:21:43 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id w65so1128578pfc.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 08:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yvJTtl57sUO2WMjzmpPDnFligWXw+OCy735zrKtQaIk=;
        b=BJcGak/P1jcd5LOiSqct2baSk98+CeP7xG9p5Yb35K6EzmHrQxRxruxkWl4s8vYdfP
         5enKuYybYLArB5VnCKfCLyaSu5L6JB6IO9fjDACPJbwds5gMDSMW7b0VfGuFZCV9Kz/D
         0BI8VsDa+D/YgnytlEEYXCINw5b1luLWH0T/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yvJTtl57sUO2WMjzmpPDnFligWXw+OCy735zrKtQaIk=;
        b=qEXwf9DGaPod6cKjD9K483X3p6szca7Y1ROhD325etRIxFcbHkElC28PImcR9pAqtY
         J5XWEacpC6LiQj2YiGykf9ZSS3/l3zEPjhPIAmTrP1m8zVLval2rlcW68vDHoS6PutD8
         HgXQi9i8s6Xvb0YfqI80EkgSOh6wHq8eqVnIWz7gyaHFZrhpKH+VZoCbCr426ZhAEVrm
         6Q68AE94IK7y33dA66EjKE+PmXVdT6NNnPijVVK9E8qToWK5fc36obGAUB9QCOFvk7uS
         ofDJiHBVW6laX5ystw95kDqAfnomWKwS4Yv5l+LNjvGLxW7gfP+uOUkvU8v6pheU5mXr
         JIMw==
X-Gm-Message-State: AGi0PubL1MvETpA7IPr9jfXXR9MyS+GuTy+xuG6F33YyEmu1QK3O3r+b
        vRXhMWFKWhOV50wkb2uu2H+SXw==
X-Google-Smtp-Source: APiQypLHOSSw3Hai2n77K1UhP/PuT1+8HCSkPUSeWThn6qQ+KlJ2HFXfYg8RCToFR6tHX38fI61Xcg==
X-Received: by 2002:a63:a54f:: with SMTP id r15mr225264pgu.17.1588778503173;
        Wed, 06 May 2020 08:21:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w186sm2177312pff.83.2020.05.06.08.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 08:21:41 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Luis Henriques <lhenriques@suse.com>
Subject: [PATCH 00/10] pstore: Remove filesystem records when backend is unregistered
Date:   Wed,  6 May 2020 08:21:04 -0700
Message-Id: <20200506152114.50375-1-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This fixes a long-standing problem[1] with pstore where the filesystem
view of backend records was not updated when the backend was unloaded
(in a modular build) through pstore_unregister(). This series is
mostly refactoring and improvements to the various locking semantics
around management of the active backend and the filesystem mount before
ultimately providing the routine to walk the filesystem to remove the
records associated with a given backend.

I'm still doing more build and runtime testing, but I just wanted to get
this posted so I can let other people look at it if they want while the
testing finishes.

Thanks!

-Kees

[1] https://lore.kernel.org/lkml/87o8yrmv69.fsf@suse.com

Kees Cook (10):
  pstore: Drop useless try_module_get() for backend
  pstore: Rename "pstore_lock" to "psinfo_lock"
  pstore: Convert "psinfo" locking to mutex
  pstore: Rename "allpstore" to "records_list"
  pstore: Convert "records_list" locking to mutex
  pstore: Add proper unregister lock checking
  pstore: Refactor pstorefs record list removal
  pstore: Add locking around superblock changes
  pstore: Do not leave timer disabled for next backend
  pstore: Remove filesystem records when backend is unregistered

 fs/pstore/inode.c    | 127 +++++++++++++++++++++++++++++++------------
 fs/pstore/internal.h |   2 +-
 fs/pstore/platform.c |  72 ++++++++++++++----------
 3 files changed, 134 insertions(+), 67 deletions(-)

-- 
2.20.1

