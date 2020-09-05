Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEC1C433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 12:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0039C20757
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 12:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5uXCGsB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgIEMBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 08:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgIEMBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 08:01:39 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE585C061244
        for <linux-kernel@vger.kernel.org>; Sat,  5 Sep 2020 05:01:38 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id e23so11977031eja.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Sep 2020 05:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=cLz1/Biyd64KQ9k6gV8XiANa7TWvRK+LB+vKBTc4LgE=;
        b=O5uXCGsBMf06w3DhH/j4DK6bFHjPhTAs6lGLKd466byA7ffj4/6ZVZ3EcM9YgR1MWl
         414bspfYXu9KpEUNbawMeHso2+/UJoAAWZZZLiYGxoEmT7WO8dnY//XtMl9LBCzPCFU3
         ia0+2wfbsugFKmPQGbyR874BA835VljKWyyyOOWR/jsWuKhsVKHhYqmZzjIpUHtjQ25C
         UJkEyxSx96y0Mf0LtXJnrCxJzga0vOiphrxJd44KKcNmVsEmTxrViIcXEU8mz4/sPx81
         5QNGoeK7PtRphJC6FetXsDet04jS79bPZxEfBrEYIHsctH1CS9pgKYwGyb46nP3CXuRC
         YO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=cLz1/Biyd64KQ9k6gV8XiANa7TWvRK+LB+vKBTc4LgE=;
        b=k6eHNd0Q9VO8U5bGS2flT3Tgd+qJR6tNMfrL7LJXclNNxq1i87RwNjiyqgHmtq7bF4
         rZhRTJo23SEo82gPmE+VOu0rjqDTCKxexzUyFXeSnQcwvEcz5fg16qWmt29mvdI4c/Ez
         /zdUlfUHp6Y93e908GHd637WTTGVYLzrtLiL0hQT6T5BT+L5z9PKENcBhHXPGgS4reRS
         VX1QplHkYg621cxh+39hkqxBHAIEejwvRBrEonO80lg3v8G1C7TDo82AGqrZPUzHgfNB
         0aomv+HHCJPnS/vLw8yC2PmbuqlbymwFbeFKeFO8su28D9UglTYF5PX9ioAGJieid/Yr
         obRQ==
X-Gm-Message-State: AOAM531c045RS7Ba92jDt/jMoY++JqS/Bh8gGGkS4ueqWs+9iVaRzv/x
        BB2/V0hToP5P3ug819TOrl4fOd+QmT/JftNE
X-Google-Smtp-Source: ABdhPJy3tA3eKLOjDax66KrXvIVUCeujRNw6pC2lErvdFQ682RFRGaVu/m1Pn1bmN87z4N7zHtyTQw==
X-Received: by 2002:a17:906:2712:: with SMTP id z18mr12654505ejc.380.1599307295809;
        Sat, 05 Sep 2020 05:01:35 -0700 (PDT)
Received: from gmail.com ([46.101.156.237])
        by smtp.gmail.com with ESMTPSA id g20sm8796788edh.62.2020.09.05.05.01.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 05 Sep 2020 05:01:35 -0700 (PDT)
Date:   Sat, 5 Sep 2020 14:01:25 +0200
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Compiler Attributes for v5.9-rc4
Message-ID: <20200905120125.GA22011@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Luc requested me to pick a sparse fix on my queue, so here it goes
along with other two trivial Compiler Attributes ones (also from Luc).

Cheers,
Miguel

The following changes since commit d012a7190fc1fd72ed48911e77ca97ba4521bccd:

  Linux 5.9-rc2 (2020-08-23 14:08:43 -0700)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/compiler-attributes-for-linus-v5.9-rc4

for you to fetch changes up to e5fc436f06eef54ef512ea55a9db8eb9f2e76959:

  sparse: use static inline for __chk_{user,io}_ptr() (2020-08-29 09:29:32 +0200)

----------------------------------------------------------------
Two trivial changes and a fix for sparse:

 - sparse: use static inline for __chk_{user,io}_ptr() (Luc Van Oostenryck)

 - Compiler Attributes: fix comment concerning GCC 4.6 (Luc Van Oostenryck)

 - Compiler Attributes: remove comment about sparse not supporting __has_attribute (Luc Van Oostenryck)

----------------------------------------------------------------
Luc Van Oostenryck (3):
      Compiler Attributes: remove comment about sparse not supporting __has_attribute
      Compiler Attributes: fix comment concerning GCC 4.6
      sparse: use static inline for __chk_{user,io}_ptr()

 include/linux/compiler_attributes.h | 8 +-------
 include/linux/compiler_types.h      | 4 ++--
 2 files changed, 3 insertions(+), 9 deletions(-)
