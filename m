Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65402C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 401202077D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tm2IeYdz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgGIK1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 06:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgGIK1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 06:27:39 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C064CC061A0B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 03:27:39 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id u18so829211pfk.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 03:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZjSXZR3FNSufIrtXfZE7yigmBZ+MTS6USGX6kAflGaU=;
        b=Tm2IeYdzXRc+tutG2Ki56wiDAtLZV8yDvJmsZOObSCNuCgS9fVGa4pvvZg1aTH7jiy
         E8HI1sb8VB5DoZ0plJwJCUzLyIa7TZFaPh1fNMMZ/yMY6Spq7OLSYkkKY4QdGFXCU9XX
         Q5H8Ry7kkVGQN2QKG98tKZ9i4kRcdt32sENcKDRyQnRhsiGXqshCyn2j6DtRmmZBnM+g
         vNsN8YIYyGSzC10FYKieEkGcAcCcNVstPu1tHxdY2I+lZ9UeuldFyBcarI6jn+eED47c
         r3eu1c5KwE22S0xVNFb7tSoZMycsBRXo3fFx+BuGPqeWKQjp/ky27NtkN6JY6m8DS7bY
         U5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZjSXZR3FNSufIrtXfZE7yigmBZ+MTS6USGX6kAflGaU=;
        b=cljvXtXLaQrgWi7GzOxddIB0fYoobfJIMORYY2+BgZbzTuUpyDJ84RHOrpa1BcRcd4
         /TQ4dka9SRH+t+iqOeYOuSCnTiFJdx272LzFISwpArN/mVfv5zNlt7130oDpN96TuY8T
         a0kTPp3DCzHN7Oxbcp4EdobCVhSRzjGHiGO0lzaBUsihMhjEazK9qy5xwL2f1och+fyh
         hefJxK3i1ndysqnzTRQyrU3TNVVykOPzVIqChsmBIdKxrqVjyGyRbkBovNOLB25Yhl9U
         px/A/a0ZRGRG0RdPHrW5kdqW41YsFmnD+ivLlqA57+Q0k5OXxmMvHYblEUok+pqZM1Jc
         ocnQ==
X-Gm-Message-State: AOAM531uZgHT4hUSOz4fZV+bO0RRQOA7bWxpPXW2DlxF4FsNF1iZJ4cj
        Lm9cJ0cPIsLq5gvxpjaAFdE=
X-Google-Smtp-Source: ABdhPJwOttN/c6ZOvhQNZVKcz/AmmxLzPBN6yDPOrriaV1tLe9zVPrkbWS1mM0b5vE9md3mAamgjRQ==
X-Received: by 2002:a63:c50a:: with SMTP id f10mr54749296pgd.167.1594290459164;
        Thu, 09 Jul 2020 03:27:39 -0700 (PDT)
Received: from cvds-vagarw7.iind.intel.com ([192.55.54.40])
        by smtp.googlemail.com with ESMTPSA id y8sm2125163pju.49.2020.07.09.03.27.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2020 03:27:38 -0700 (PDT)
From:   Vaibhav Agarwal <vaibhav.sr@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>, Johan Hovold <johan@kernel.org>,
        Mark Greer <mgreer@animalcreek.com>
Cc:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>
Subject: [PATCH v4 0/7] Enable Greybus Audio codec driver
Date:   Thu,  9 Jul 2020 15:57:16 +0530
Message-Id: <cover.1594290158.git.vaibhav.sr@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing GB Audio codec driver is dependent on MSM8994 Audio driver.
During the development stage, this dependency was configured due to
various changes involved in MSM Audio driver to enable addtional codec
card and some of the changes proposed in mainline ASoC framework.
However, these are not the real dependencies and some of them can be
easily removed.

The folowing patch series includes the changes to resolve unnecessary
depedencies and make the codec driver functional with the latest kernel.

Patch 1,2: Incudes jack framework related changes.
Patch 3,4,5: Resolves compilation error observed with the latest kernel and
also provides helper APIs required to allow dynamic addition/removal of
modules.
Patch 6: Finally provides config options and related Makefile changes to
enable GB Codec driver.

Thanks to Alexandre for raising the headsup [1] and motivating me to provide
the necessary changes.

This patchset is intended to resolve the componentization issue only.
And as per the suggestion [2] from Mark, I'll share a separate patch series
aligned to ASoC tree. Once the relevant changes are accepted in snd-soc
framework, I'll share relevant patches to pull GB Audio out of the
staging tree.

v1:
- Include the changes for the review comments suggested by Dan
- Rebase to latest staging-next

v2:
- Avoid defining unused 'update' pointer
- Fix the missing connect bool value required during mixer_update_power
- Added Reviewed-by tag from Dan
- Rebase to latest staging-next

v3:
- Fix the warnings reported by lkp[3]
- Rebase to latest staging-next

[1] https://lore.kernel.org/lkml/20200507212912.599433-1-alexandre.belloni@bootlin.com/
[2] https://lore.kernel.org/alsa-devel/20200612160620.GK5396@sirena.org.uk/
[3] https://lore.kernel.org/lkml/202006200150.mNVj1Duq%25lkp@intel.com/

Vaibhav Agarwal (7):
  staging: greybus: audio: Update snd_jack FW usage as per new APIs
  staging: greybus: audio: Maintain jack list within GB Audio module
  staging: greybus: audio: Resolve compilation errors for GB codec
    module
  staging: greybus: audio: Resolve compilation error in topology parser
  staging: greybus: audio: Add helper APIs for dynamic audio modules
  staging: greybus: audio: Enable GB codec, audio module compilation.
  drivers: staging: audio: Fix the missing header file for helper file

 drivers/staging/greybus/Kconfig          |  14 +-
 drivers/staging/greybus/Makefile         |   6 +-
 drivers/staging/greybus/audio_codec.c    | 178 +++++++++++---------
 drivers/staging/greybus/audio_codec.h    |  12 +-
 drivers/staging/greybus/audio_helper.c   | 198 +++++++++++++++++++++++
 drivers/staging/greybus/audio_helper.h   |  17 ++
 drivers/staging/greybus/audio_module.c   |  15 +-
 drivers/staging/greybus/audio_topology.c | 131 +++++++--------
 8 files changed, 414 insertions(+), 157 deletions(-)
 create mode 100644 drivers/staging/greybus/audio_helper.c
 create mode 100644 drivers/staging/greybus/audio_helper.h


base-commit: 14442181d20490945f341644bb8257e334b01447
-- 
2.27.0

