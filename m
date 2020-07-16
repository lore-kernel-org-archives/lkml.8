Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A482C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4894720760
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QOdYFmVl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbgGPNVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 09:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgGPNVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:21:22 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A0EC061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:21:21 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f7so7076670wrw.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=7YbtSjQOGUa/q+irulkRFVoHCpjbJGuPHTve5CYTDyY=;
        b=QOdYFmVlH7OY1uIqGhDN9Cb/bQtBwCY++VIocH0ZX2YtmJfaHdIthkum9ne1K2L3km
         x/NAgqoY9mjWAWQeOMeC1A9qm9IiD23UucmNZy1HSW/z1j6rnZAKtnGmWWhGdeV1PqKm
         7FrW+MdB+6FcFO3z5rVGVLG/4ERXiBkzp5CGYB3LnjDgEezHGOwY/59gjrPTl+FgA5pR
         oSWG13l4Urz3ziXeIXgSRJPCvLJwf9yCj7PyuDSxflm7mTdxfnGz/6eJV+qRz3pUEolf
         CcNrttAD2uDeYWcCbrCH5V+kTsXVbgLtOaVpEcbkjFLig9Og7ut7Etw+m0MQZIVgM45G
         01Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=7YbtSjQOGUa/q+irulkRFVoHCpjbJGuPHTve5CYTDyY=;
        b=KGYayR3wsp4IaxZpUN7gSOak4g+CDDBo9KrchmFr+UUSPZIMEPMLOEu6t3998o0ncp
         8Wg54ZvN12zUc+MIziABGwgrSTDnnNRQVB++WriPry23ZOmC/n5UVGiAQ9E4UN3hqFNJ
         wLxXtMdsVwcQ0wvd0PK5ZKz/kVDUxBkmZ14zX/oaa6rJt1MRLAHfgNYJq+vMCzNA9OND
         nyILRvPZsEWcWv6gAtP5uNfLrO0KZXur73VwPctNfSxZ1tgZvSKwtSFLISU/XM/keszs
         PiTrvju3NYSHZk2ezppkiQi8S0k7ANtvUbz/YVEXf3JOAYwEJlBa2cyX267U3jots/tt
         tiCA==
X-Gm-Message-State: AOAM533OTer5qXOCEIUwY0sR+QaXMskOQY9IiDqSLBHl37pnNmcT7GAM
        E7yE6VLw+Bh6YpKJ1CdCoi/Qrw==
X-Google-Smtp-Source: ABdhPJziwy34yB77Mu4b5lIbKxi2PVplLfoz+eGeRbOlWefCvTn6vC0VVKdXrNjnmr6t6gwKmfAYTQ==
X-Received: by 2002:a5d:420b:: with SMTP id n11mr5018134wrq.91.1594905680354;
        Thu, 16 Jul 2020 06:21:20 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:9880:a643:3e69:6393? ([2a01:e34:ed2f:f020:9880:a643:3e69:6393])
        by smtp.googlemail.com with ESMTPSA id 133sm9027135wme.5.2020.07.16.06.21.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 06:21:19 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM mailing list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        alex.hung@canonical.com, bsz@semihalf.com
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] thermal fixes for v5.8-rc6
Message-ID: <40ec1ad2-1938-81ee-5ddb-965c18ddd25f@linaro.org>
Date:   Thu, 16 Jul 2020 15:21:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9ebcfadb0610322ac537dd7aa5d9cbc2b2894c68:

  Linux 5.8-rc3 (2020-06-28 15:00:24 -0700)

are available in the Git repository at:


ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
tags/thermal-v5.8-rc6

for you to fetch changes up to a8f62f183021be389561570ab5f8c701a5e70298:

  Revert "thermal: mediatek: fix register index error" (2020-07-15
11:12:48 +0200)

----------------------------------------------------------------
- Fix invalid index array access on int340x_thermal leading to a
  kernel panic (Bartosz Szczepanek)

- Fix debug message level to prevent flooding on some platform (Alex
  Hung)

- Fix invalid bank access by reverting "thermal: mediatek: fix
  register index error" (Enric Balletbo i Serra)

----------------------------------------------------------------
Alex Hung (1):
      thermal: int3403_thermal: Downgrade error message

Bartosz Szczepanek (1):
      thermal/int340x_thermal: Prevent page fault on .set_mode() op

Enric Balletbo i Serra (1):
      Revert "thermal: mediatek: fix register index error"

 drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 7 ++++++-
 drivers/thermal/intel/int340x_thermal/int3403_thermal.c | 2 +-
 drivers/thermal/mtk_thermal.c                           | 6 ++----
 3 files changed, 9 insertions(+), 6 deletions(-)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
