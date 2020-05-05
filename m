Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B460C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 10:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B29A206E6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 10:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jpA4029p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbgEEK1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 06:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728675AbgEEK1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 06:27:03 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B735AC061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 03:27:01 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id h4so1026449ljg.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 03:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=blGQJMoBvAS+iUdy6OjWgWZCgbDmhcjzl5awL9j79VQ=;
        b=jpA4029pUaIVnF4l5PbVwW0LEra4+nkabdz0qEKiJpYh8EP7TB52OoKvjTZLfRHpnc
         xwVpZZFisR3GARWRYbIp86xNASa+7K2ZN29F8TflMofeX8A1wgcrutrRov2QmOHCftnB
         f2Nby+IcpbDf9Ux1zkpH1exN6WAs0S3Z7rlShX2tEhTOErYgTI8gr3NgJuEUZ9iXX8CP
         4MvayBIM7sw+gf5FwkxCYvV0D56OuYUWbruy8qGMst2KgepBJVkakOuSVqHfil4Sm2C3
         ra9kpmz7uaVBZHrkCHzzcs9M/MCHmtuB+zqpuqS0kCk5tirZf2ktYoGqUfgvujroKJiO
         LqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=blGQJMoBvAS+iUdy6OjWgWZCgbDmhcjzl5awL9j79VQ=;
        b=TLJ8/+uRZeygnKl0gxLO6MmUZK/JLcXgnKXTn7CLXHpuaj72vGFLzkq8X6Knp20NUV
         wrU0tL+a6c9ry8jkZ1+7wpQlwcUG3kkY4K9SgDBJjNsbxPjox7EaRNEZVGwOJssMiJ33
         ezOWTMFYiZINSY6o6fzKSk8bKwchwE2YLu1oTj/EkxC8YHfwIF4fw1J42kCA2ZHIScEi
         NbKNH0Zmyz+I+7nqoXGOyQgcc5sMf+qbMhjRWS974hkze39mmqtyMze+q3cGZFjwOfi3
         L3nXoAoGsg7mXEE+LuINkOeECeBHedCOyQt7u7Ce86gaPd8t6u4V1hhnECsH1XDbqTXS
         rTsA==
X-Gm-Message-State: AGi0PuY2xohjBddovHlzhjKCDxhvbvdc1OW/+wYbvjR49FytUUk9l6ve
        aBQYu/7lMqPGZITY+eNfWwnLuQ==
X-Google-Smtp-Source: APiQypKfa8VOGWn3WPZrzc/EhIZHCyr2xy8NZIclTsRKBVWbLEv8EvZCy1rPGqOMeOu9F7hKN9nnXA==
X-Received: by 2002:a2e:3009:: with SMTP id w9mr1422695ljw.71.1588674419933;
        Tue, 05 May 2020 03:26:59 -0700 (PDT)
Received: from localhost (c-8c28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.140])
        by smtp.gmail.com with ESMTPSA id u16sm1860861ljk.9.2020.05.05.03.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 03:26:59 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     brendanhiggins@google.com, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, john.johansen@canonical.com,
        jmorris@namei.org, serge@hallyn.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-security-module@vger.kernel.org, elver@google.com,
        davidgow@google.com, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2 0/6] Enable as many KUnit tests as possible
Date:   Tue,  5 May 2020 12:26:47 +0200
Message-Id: <20200505102647.7862-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset will try to enable as many KUnit test fragments as
possible for the current .config file.
This will make it easier for both developers that tests their specific
feature and also for test-systems that would like to get as much as
possible for their current .config file.

I will send a separate KCSAN KUnit patch after this patchset since that
isn't in mainline yet.

Since v1:
Marco commented to split up the patches, and change a "." to a ",".


Cheers,
Anders

Anders Roxell (6):
  kunit: Kconfig: enable a KUNIT_RUN_ALL fragment
  kunit: default KUNIT_* fragments to KUNIT_RUN_ALL
  lib: Kconfig.debug: default KUNIT_* fragments to KUNIT_RUN_ALL
  drivers: base: default KUNIT_* fragments to KUNIT_RUN_ALL
  fs: ext4: default KUNIT_* fragments to KUNIT_RUN_ALL
  security: apparmor: default KUNIT_* fragments to KUNIT_RUN_ALL

 drivers/base/Kconfig      |  3 ++-
 drivers/base/test/Kconfig |  3 ++-
 fs/ext4/Kconfig           |  3 ++-
 lib/Kconfig.debug         |  6 ++++--
 lib/kunit/Kconfig         | 15 ++++++++++++---
 security/apparmor/Kconfig |  3 ++-
 6 files changed, 24 insertions(+), 9 deletions(-)

-- 
2.20.1

