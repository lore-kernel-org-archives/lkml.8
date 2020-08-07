Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610F8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 19:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E36A2086A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 19:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cvmZEENp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgHGTzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 15:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGTze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 15:55:34 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90993C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 12:55:34 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p3so1479958pgh.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 12:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=lc4ip8IuREvQJlhnv84WeQVzFK5ehI3Ao0CDpvwe7OY=;
        b=cvmZEENphTLaFd4eCuuel6D11tsxU6L9ejl3xoNtS5T8uzcK9bFpvFoxntbx979R83
         R/Mi5MRj7UUySEttXw9KgytrA+NhGWfKltTueJ2uBERg4gfNm2sPMwK/xa1UFrpOilq/
         A1E7Qk2wLck3UQfEWRKVPk1wCPylP3XC5fTdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=lc4ip8IuREvQJlhnv84WeQVzFK5ehI3Ao0CDpvwe7OY=;
        b=FePM87ufd3YNKuKA7y3gDqb8+jBFsorIcsmq0MXh05aeXw4GO3v/yoqFWtLXHEjrZU
         roeORW0+VCPLUCRFlBAvxPO/zkjDmv9polqmZK8/ZR3DguYDa6a2DzgaLV4iAuQA/Zfh
         L1omK5uhOSvEi6c7EkdR2nJ/etO1QCUdDAOTzGpPt8STSKAqDcRTOP0U2Y16Lz85rwu6
         38w6YwoMkqEzyX9F6nct9M5LgQ/vW9fmNF4MxBMyOnW+UpqwaI6xhakh6v61bEm5gG1O
         tcBVlJxGS0tgUk+1tRFhWRLVXkT0jr3KdDsPJ0C3s+UPSsP6UjONLYcK6+uGIxZpUUdA
         hX5w==
X-Gm-Message-State: AOAM5338EUukL1aUXcigI+XP2KCzypSEHuun+PjMXp5FTbNVmrLSlIvo
        FzEhb6AfEgTbWpFidWcGiW+vqPkG018=
X-Google-Smtp-Source: ABdhPJzcdcYgdH7PKpGWCXCMe8VFF8lb21ozUZhQ1sTZ5AtwoXvPWPfiLeheRgiLQF+LcYl+Mfu1eQ==
X-Received: by 2002:a62:f807:: with SMTP id d7mr6990374pfh.207.1596830133900;
        Fri, 07 Aug 2020 12:55:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y135sm14612855pfg.148.2020.08.07.12.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 12:55:33 -0700 (PDT)
Date:   Fri, 7 Aug 2020 12:55:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Shuah Khan <shuah@kernel.org>
Subject: [GIT PULL] kallsyms_show_value-fix updates for v5.9-rc1
Message-ID: <202008071250.7DC8D5FF61@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this fix to my kallsyms_show_value() refactoring for
v5.9-rc1. About a month after the original refactoring landed, 0day
noticed that there was a path through the kernfs binattr read handlers
that did not have PAGE_SIZEd buffers, and the module "sections" read
handler made a bad assumption about this, resulting in it stomping on
memory when reached through small-sized splice() calls. I've added a set
of tests to find these kinds of regressions more quickly in the future
as well.

Thanks!

-Kees

The following changes since commit bcf876870b95592b52519ed4aafcf9d95999bc9c:

  Linux 5.8 (2020-08-02 14:21:45 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/kallsyms_show_value-fix-v5.9-rc1

for you to fetch changes up to 9af47666cb0f331bfcd76799ee368cdfcb00882c:

  selftests: splice: Check behavior of full and short splices (2020-08-07 10:50:11 -0700)

----------------------------------------------------------------
Fix sysfs module section output overflow

----------------------------------------------------------------
Kees Cook (2):
      module: Correctly truncate sysfs sections output
      selftests: splice: Check behavior of full and short splices

 kernel/module.c                                    | 22 +++++++--
 tools/testing/selftests/splice/.gitignore          |  1 +
 tools/testing/selftests/splice/Makefile            |  4 +-
 tools/testing/selftests/splice/config              |  1 +
 tools/testing/selftests/splice/settings            |  1 +
 .../testing/selftests/splice/short_splice_read.sh  | 56 +++++++++++++++++++++
 tools/testing/selftests/splice/splice_read.c       | 57 ++++++++++++++++++++++
 7 files changed, 137 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/splice/config
 create mode 100644 tools/testing/selftests/splice/settings
 create mode 100755 tools/testing/selftests/splice/short_splice_read.sh
 create mode 100644 tools/testing/selftests/splice/splice_read.c

-- 
Kees Cook
