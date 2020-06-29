Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303EFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0642520663
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sItA/+/H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731590AbgF2UpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731586AbgF2TN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:59 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75101C008619
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 03:31:36 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id j18so14871417wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 03:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Opmj4uUxeQ3xM8gi/GCKlnFKXWu2kvQ3Y3KwfIa2RwM=;
        b=sItA/+/HhStbK5wIjrUza13deCS4ZJu4rsRpymnZyD6rZNKz8QjS/Mo4z0gD9K3xm5
         /h9MQMMDP7bSNZcl/JU+/9TzJZnMfBYLv7nXH1e4N+kqk4+ZqZ+TpmZrl2EaX6crXyEf
         7JQ8EmBe9LL1n/ESxycsfrrAlP3ZEbg1X0nTEGSff4zL9jaoYXTQAoSTXoDhU0YEm5Gt
         GreChXhKfZw0zxUwCibBPw71jxVt4U2DYki76sOIvRFlzjZ5Oje/OJxby2T/X6jkwGXd
         UVj55psbxsIV/QN0ipSfOV287YLdu0TuamjT0r3vr3QB5cyEKC/ffVePZvTTz+Sh0Kt6
         hdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Opmj4uUxeQ3xM8gi/GCKlnFKXWu2kvQ3Y3KwfIa2RwM=;
        b=i3pgW6epJF5S3wluWV51emC6go0UuRXumi1qw5v7UQi1SZ46502uRBoR3kmauyJVxb
         xyBHyr48elVp96dj4lyHFbwI7qA5j/N7ibmLKxVYiDoOEPyy+n3R2npamtbh5mABIrgM
         jf45RihfFLjkKTMetJa+NGxWK80GIorzzpjLshbWRZlaLVCD9zO02t8MK0LX3YxpSN0l
         q14790vkM/RwiFS/JLvJJjw7VNUwmAw9JsONPYa/1XIsC2pWPasGCyyLP7sCFj6Vqo7i
         ZTh6AA4+2u6rsDmWcStuyj+qfEk62s5zkNv8KkSwMRQNDEAXDtm2dgwCvA1pmoZIewbZ
         0Irw==
X-Gm-Message-State: AOAM532n9M6wvK5+RWDUH3fWn6QXtdNUKjKNaOzl5zakPTf99DN9fAbr
        WkKRX6CD0Ka6KenasKJiCNaPoQ==
X-Google-Smtp-Source: ABdhPJylw7ckn2lELoN/+/TUqPmKJiz0YUqslHSGb9pFmWdwp7Zkk3VjmDYZj3oo2b+gI8Y0OIBe2w==
X-Received: by 2002:a1c:790c:: with SMTP id l12mr15728140wme.50.1593426695092;
        Mon, 29 Jun 2020 03:31:35 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:a5b5:45c4:c00e:7063? ([2a01:e34:ed2f:f020:a5b5:45c4:c00e:7063])
        by smtp.googlemail.com with ESMTPSA id m9sm6602024wml.45.2020.06.29.03.31.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 03:31:34 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Anson Huang <anson.huang@nxp.com>, dien.pham.ry@renesas.com,
        Finley Xiao <finley.xiao@rock-chips.com>,
        "michael.kao" <Michael.Kao@mediatek.com>, yangtiezhu@loongson.cn,
        Zhang Rui <rui.zhang@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] thermal fixes for v5.8-rc4
Message-ID: <55cb7814-8305-23bd-873c-5a82104b1248@linaro.org>
Date:   Mon, 29 Jun 2020 12:31:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
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
tags/thermal-v5.8-rc4

for you to fetch changes up to 5f8f06425a0dcdad7bedbb77e67f5c65ab4dacfc:

  thermal/drivers/rcar_gen3: Fix undefined temperature if negative
(2020-06-29 12:15:34 +0200)

----------------------------------------------------------------
- Fix undefined temperature if negative on the rcar_gen3 (Dien Pham)

- Fix wrong frequency converted from power for the cpufreq cooling
  device (Finley Xiao)

- Fix compilation warnings by making functions static in the tsens
  driver (Amit Kucheria)

- Fix return value of sprd_thm_probe for the Spreadtrum driver
  (Tiezhu Yang)

- Fix bank number settings on the Mediatek mt8183 (Michael Kao)

- Fix missing of_node_put() at probe time i.MX (Anson Huang)

----------------------------------------------------------------
Amit Kucheria (1):
      thermal/drivers/tsens: Fix compilation warnings by making
functions static

Anson Huang (1):
      thermal/drivers: imx: Fix missing of_node_put() at probe time

Dien Pham (1):
      thermal/drivers/rcar_gen3: Fix undefined temperature if negative

Finley Xiao (1):
      thermal/drivers/cpufreq_cooling: Fix wrong frequency converted
from power

Michael Kao (1):
      thermal/drivers/mediatek: Fix bank number settings on mt8183

Tiezhu Yang (1):
      thermal/drivers/sprd: Fix return value of sprd_thm_probe()

 drivers/thermal/cpufreq_cooling.c   |  6 +++---
 drivers/thermal/imx_thermal.c       |  7 ++++---
 drivers/thermal/mtk_thermal.c       |  5 ++++-
 drivers/thermal/qcom/tsens.c        | 10 +++++-----
 drivers/thermal/rcar_gen3_thermal.c |  2 +-
 drivers/thermal/sprd_thermal.c      |  4 ++--
 6 files changed, 19 insertions(+), 15 deletions(-)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
