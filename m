Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68574C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 11:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 395C1207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 11:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qp8Q9pfV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732659AbgFSLUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 07:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730962AbgFSLUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 07:20:52 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F3EC06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 04:20:52 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id i4so4175313pjd.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 04:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=82ZpbBZmPoGIYKi4X7qcLJ5HQ4WEhVLHyB6WAT9TAf0=;
        b=Qp8Q9pfVq4nvwh6FnwFgq7Znv4j/DRaBmokxtOX1ZhMXVj5GXEDHQXAEnDUVjx/w1G
         /ozgQc8nEg2xz9P+4Qxi3DHkpFNMhNx68JhdDbLQ/miLZA+aTWjjMblh6VfVuXPWsC+h
         SmV5bfiwmgeDi4O6RkbuKD4Jt323+fmp9EHm6OTQDg/+z2SHoWQwJXPhhzoTN1N9ucj5
         SVSGBOalCNu9G9LxaKkQJFcxF07PBMlmk9RDW+uzZ7/wtyIoRS7eiLewuXrc0l+Wnb2d
         e22z2bRpIqV1S7REW41RP3SVLNg/9AnPqLnZtUARdfStpF8Brz9ZT9MSIVsmH5E1IMaD
         /FqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=82ZpbBZmPoGIYKi4X7qcLJ5HQ4WEhVLHyB6WAT9TAf0=;
        b=b+EVsEEh+VDbt6n3QGrhbmF4dNoAUsx2oDj+LXlzlh9qiWFURCJPxYeLAR6xEU1w1X
         EV6IZ8veOK7GurZ9BlJZsnfb642uMZFsXjCUPUgG1896Rgt6cFatA4zBVPFr9TNorbz+
         XUpJ/th0nTlxNyYEn8KXgg8HKGZd0u8EHmGRWDdsvOVoohTVImbCSyCWONOxi1THXcpn
         90oAUppPot7YQ20MYAHwUXpanzI945z1LpEnzJqH5iRxrbdiei3wjZYDRCwipl250vLo
         pN+D7f6SZJCPqXf2z8sy4pudJ5k1jjjxFa7BfCjv5axud/n8NcUdJcRYMdf+Awqi83tA
         MO7Q==
X-Gm-Message-State: AOAM531Vi64lCLgMRWTHoWrD5J5nIUJhz7aHkC8E5UhBCsx8EAn9Hh1r
        bQHpInnxn05wiQRdA5kcd20G+TET8mw=
X-Google-Smtp-Source: ABdhPJyQKktAbGK2vaOg44HxDtXF1HuPiQA4UzHMXBleJHDMQxcSuLf0QiMtAnnd8U/Ema9XVF+7lg==
X-Received: by 2002:a17:90a:7c48:: with SMTP id e8mr2988145pjl.235.1592565651563;
        Fri, 19 Jun 2020 04:20:51 -0700 (PDT)
Received: from cvds-vagarw7.iind.intel.com ([192.55.55.41])
        by smtp.googlemail.com with ESMTPSA id d9sm4974293pgg.74.2020.06.19.04.20.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jun 2020 04:20:50 -0700 (PDT)
From:   Vaibhav Agarwal <vaibhav.sr@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>, Johan Hovold <johan@kernel.org>,
        Mark Greer <mgreer@animalcreek.com>
Cc:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>
Subject: [PATCH v3 0/6] Enable Greybus Audio codec driver
Date:   Fri, 19 Jun 2020 16:50:20 +0530
Message-Id: <cover.1592537217.git.vaibhav.sr@gmail.com>
X-Mailer: git-send-email 2.26.2
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

[1] https://lore.kernel.org/lkml/20200507212912.599433-1-alexandre.belloni@bootlin.com/
[2] https://lore.kernel.org/alsa-devel/20200612160620.GK5396@sirena.org.uk/

v1:
- Include the changes for the review comments suggested by Dan
- Rebase to latest staging-next

v2:
- Avoid defining unused 'update' pointer
- Fix the missing connect bool value required during mixer_update_power
- Added Reviewed-by tag from Dan
- Rebase to latest staging-next

Vaibhav Agarwal (6):
  staging: greybus: audio: Update snd_jack FW usage as per new APIs
  staging: greybus: audio: Maintain jack list within GB Audio module
  staging: greybus: audio: Resolve compilation errors for GB codec
    module
  staging: greybus: audio: Resolve compilation error in topology parser
  staging: greybus: audio: Add helper APIs for dynamic audio modules
  staging: greybus: audio: Enable GB codec, audio module compilation.

 drivers/staging/greybus/Kconfig          |  14 +-
 drivers/staging/greybus/Makefile         |   6 +-
 drivers/staging/greybus/audio_codec.c    | 178 +++++++++++---------
 drivers/staging/greybus/audio_codec.h    |  12 +-
 drivers/staging/greybus/audio_helper.c   | 197 +++++++++++++++++++++++
 drivers/staging/greybus/audio_helper.h   |  17 ++
 drivers/staging/greybus/audio_module.c   |  15 +-
 drivers/staging/greybus/audio_topology.c | 123 +++++++-------
 8 files changed, 409 insertions(+), 153 deletions(-)
 create mode 100644 drivers/staging/greybus/audio_helper.c
 create mode 100644 drivers/staging/greybus/audio_helper.h


base-commit: 98fe05e21a6e0ca242e974650ed58b64813cb2dc
-- 
2.26.2

