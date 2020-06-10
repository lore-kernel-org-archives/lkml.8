Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67238C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FDA92072E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTEeLvTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbgFJRaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgFJR3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 13:29:07 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDB5C03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 10:29:05 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id j1so1400303pfe.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 10:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HHuDWwcD46GsqYCnpIwOKdwPxiPdPtfeZ6O9l504PHI=;
        b=NTEeLvTsB773KwO3u1uhA/EelDoidUC0VKkIcpcQrmyOC1w2cR+PIIEC4cgymCPIkB
         D7ur/mAjSTtCMZ3UB0AE2tienoebk9nml/E03FpD6lYsBQKZTzlGQ9g+BdiwoRMuIonu
         QFwa59Nm9PBiqllyRfTrHkzVP/8XP4NNrFCHO5ITW06ZQkdN/NkbZLlmgIFVxpEZNqQY
         r4JLz+eY0WDzRRYsDY5I8QeKDlCnE/MpxuJaxVySqLG14lzlfNJFSO5LSHNThAjDTiCn
         RAA1LV/LDeOP4b3VFxsMcItY2ijjdh9uCOMQazHSIc9XQRmCswJLZ62R1Bj8LwnJsY8d
         tEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HHuDWwcD46GsqYCnpIwOKdwPxiPdPtfeZ6O9l504PHI=;
        b=GF4o6krIPogSdwdPfafltub5znvsk5Zip78y2zMLEC0hpi9BZ9kZjpQaZsRlHnEs7A
         lDU8JlT2F8UklcAxE+sQf3vxuNkPh0oKz3gKY0J7L7xK2D2jUIQTpMVOfa+6WEmsTXVv
         XPY2+sQNe1tBbmwD7zJpyuujd1dn0C/20X9beV+MEaz1JGm9csTOjdnVoVpgZ2/aZFBQ
         +2DWxAoPBPYSnJbPAm1S6ghOC6TyB5vtOGPchU2NKCO4y7t9tnCNRlydbF8iF457CyT9
         FyfDK0k/i6yY7XBQoXRWm/veA6XODAi1j3WKEG0+XbRJRw1lWChf/ax+3BEmxjjgXINg
         g3hw==
X-Gm-Message-State: AOAM532av1S5mtvw7T+06ozJWryQ1laDPbaOiW5Gp142xP+u0bqVcGay
        LzjBaN0O+Satq4lXC0oD7coX98DN52R7+w==
X-Google-Smtp-Source: ABdhPJxFC3aE1JPqfxE9yyHQOhKXlvby4i0EuVHpuVNTvbzQGF1PAL+ca8iz/SWsLtCNhFD4L8Xpww==
X-Received: by 2002:a65:6550:: with SMTP id a16mr3411032pgw.183.1591810145159;
        Wed, 10 Jun 2020 10:29:05 -0700 (PDT)
Received: from cvds-vagarw7.iind.intel.com ([192.55.54.40])
        by smtp.googlemail.com with ESMTPSA id l83sm490470pfd.150.2020.06.10.10.28.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jun 2020 10:29:04 -0700 (PDT)
From:   Vaibhav Agarwal <vaibhav.sr@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>, Johan Hovold <johan@kernel.org>,
        Mark Greer <mgreer@animalcreek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>
Subject: [PATCH v2 0/6] Enable Greybus Audio codec driver
Date:   Wed, 10 Jun 2020 22:58:24 +0530
Message-Id: <cover.1591802243.git.vaibhav.sr@gmail.com>
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

[1] https://lore.kernel.org/lkml/20200507212912.599433-1-alexandre.belloni@bootlin.com/

Changes from v1
- Include the changes for the review comments suggested by Dan
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
 drivers/staging/greybus/audio_topology.c | 128 +++++++--------
 8 files changed, 412 insertions(+), 155 deletions(-)
 create mode 100644 drivers/staging/greybus/audio_helper.c
 create mode 100644 drivers/staging/greybus/audio_helper.h


base-commit: af7b4801030c07637840191c69eb666917e4135d
-- 
2.26.2

