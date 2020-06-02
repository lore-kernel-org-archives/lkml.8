Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8823BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 05:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57DCA2072F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 05:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yx8Rvc6H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgFBFVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 01:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgFBFVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 01:21:37 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D855FC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 22:21:36 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 64so4513082pfg.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 22:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kdz9W6x1z78WJYfw94insK8Fd4+Xm8e4ZRVXoKUzvSY=;
        b=Yx8Rvc6H/3eq0UMPJ+mBWxx2n3X10X8TZ2xCt3ufzj/oMJA7EYddKDNEN+xrIbdNa0
         Goz1ThwnFqW6BZ0cbDh6AxaRW2U/x7/gxlvhbuaLQauNhxS8qNACiIEO5vHv7atuJVoL
         O3DrPnA/jIz+lZhpwzYhsApqbKTm9HdcGjpMmMU8MkLYvOug4bJn+YbIzUOTWf9kJFa8
         wjvz2P6TmTF+3qSnePRd3T7ua3QpMtqPXM+4+J714n7EsgcAQ6Gj5jYSRlkEC9OgHqQ9
         zBm/55JpUSdAK0I7I70drBpztTLmlOgYROSDj1DoXLuIJMRb1AWI9o6Lu6cb63yBnFZY
         g2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kdz9W6x1z78WJYfw94insK8Fd4+Xm8e4ZRVXoKUzvSY=;
        b=Z7OE37ewhILHIqPcv3kUn5XIlp/qhAmLDRFgF6VN+PL+2xRFpZp2X1nczAeXmXQcSd
         winyGEB+zhtBsXmjMW3ZTVmDaIZp1IcPyyjMh6XR2r0dZ+JbdP8kEsdRjY49se7E6n/3
         O7GQ+b/O08CMmsPSaCKkDttwjzFKJ3QueBVn0fVEyuhtjAzzUV7NmqKmqOUjdgHzVULZ
         0aP8h5K3eF2iptdS7+hECAxCozreNPc6ksPIcjCAcSTgbnealnmXwAmuYtvfN5B/Oe88
         ilyfPBc6KyYCTI2PXjs2H1hg3JXNt1oyhZ6q6n2FKwMUWsb51MFIVwJYvbVsMM8Zuiwe
         qNYQ==
X-Gm-Message-State: AOAM531MS70Ymbh+P5ymySdXWjmiqwjUTK5Crn3JwhnuPBERjoTTWCcg
        muqpZ6f6tw+ZNDWwKWIhuxI=
X-Google-Smtp-Source: ABdhPJzyy+fKy3+80OPPYMUOh8KsX3+BuN5V6lT7FHP1F8AKIMrKUKcYMuv0+jcSMkuxde+7Z2c9SQ==
X-Received: by 2002:a63:9319:: with SMTP id b25mr23287242pge.374.1591075296239;
        Mon, 01 Jun 2020 22:21:36 -0700 (PDT)
Received: from cvds-vagarw7.iind.intel.com ([192.55.55.41])
        by smtp.googlemail.com with ESMTPSA id f18sm1004764pga.75.2020.06.01.22.21.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jun 2020 22:21:35 -0700 (PDT)
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
Subject: [RESEND PATCH v1 0/6] Enable Greybus Audio codec driver
Date:   Tue,  2 Jun 2020 10:51:09 +0530
Message-Id: <cover.1591040859.git.vaibhav.sr@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[REQUEST]

This patch series intends to "Enable Greybus Audio codec driver"
existing in the staging tree. I have shared the original patch series with
Greybus-Dev mailing list and as per the suggestion from Alexandre, I'm
also interested to push Greybus Audio to sound soc tree. Thus, now I'm
resending it to ASoc maintainers for review.

Following is the top level SW design for GB Codec driver and GB Audio
modules.

                                            +--------------+
                            +-------------->+GBA Module 1  |
                            |               +--------------+
    +-----------------------+
    |            |          |
    |            | Greybus  |               +--------------+
    | SND SOC    | Audio    +-------------->+GBA Module 2  |
    | Framework  | Codec    |               +--------------+
    |            | Driver   |
    |            |          |
    +-----------------------+               +--------------+
                            +-------------->+GBA Module N  |
                                            +--------------+

Patch 5 contains the changes to provide helper APIs to link DAPM DAI widgets
for the module added and remove/free component controls for the module removed
dynamically. Eventually, I propose to extend snd_soc_xxx APIs for this
purpose.

Kindly share your inputs.

[COVER LETTER]

The existing GB Audio codec driver is dependent on MSM8994 Audio driver.
During the development stage, this depdency was configured due to
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
 drivers/staging/greybus/audio_codec.c    | 187 +++++++++++++--------
 drivers/staging/greybus/audio_codec.h    |  12 +-
 drivers/staging/greybus/audio_helper.c   | 197 +++++++++++++++++++++++
 drivers/staging/greybus/audio_helper.h   |  17 ++
 drivers/staging/greybus/audio_module.c   |  20 +--
 drivers/staging/greybus/audio_topology.c | 130 +++++++--------
 8 files changed, 427 insertions(+), 156 deletions(-)
 create mode 100644 drivers/staging/greybus/audio_helper.c
 create mode 100644 drivers/staging/greybus/audio_helper.h


base-commit: ae73e7784871ebe2c43da619b4a1e2c9ff81508d
-- 
2.26.2

