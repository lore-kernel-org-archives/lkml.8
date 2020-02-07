Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72383C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 20:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46CD322314
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 20:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=serbinski.com header.i=@serbinski.com header.b="mMdBltuh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbgBGU6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 15:58:45 -0500
Received: from mail.serbinski.com ([162.218.126.2]:46978 "EHLO
        mail.serbinski.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbgBGU6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 15:58:44 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.serbinski.com (Postfix) with ESMTP id 854DCD00727;
        Fri,  7 Feb 2020 20:50:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at serbinski.com
Received: from mail.serbinski.com ([127.0.0.1])
        by localhost (mail.serbinski.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id j-EbtHU13np8; Fri,  7 Feb 2020 15:50:36 -0500 (EST)
Received: from anet (ipagstaticip-7ac5353e-e7de-3a0d-ff65-4540e9bc137f.sdsl.bell.ca [142.112.15.192])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.serbinski.com (Postfix) with ESMTPSA id 854D1D00717;
        Fri,  7 Feb 2020 15:50:28 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.serbinski.com 854D1D00717
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=serbinski.com;
        s=default; t=1581108628;
        bh=MlElQX8UGSNGpk/B5oaMq2Wl0cfEBed5ksQ493alu7Y=;
        h=From:To:Cc:Subject:Date:From;
        b=mMdBltuhTPxNolWE+/ZrxcYY8ll4FHCgyjB84nIXrIXYSM75RY5Jdk5HyGxdb7fef
         vVRVYkL41HHJXLd3mE/0qrR7VziDpq925OlaUDSASqoUuOBeup1j53QiRkfDMkCFIS
         nQDV9jKtn2W/4OcmZJQQBLR4RosJY0mly17QQ5z0=
From:   Adam Serbinski <adam@serbinski.com>
To:     Mark Brown <broonie@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Adam Serbinski <adam@serbinski.com>,
        Andy Gross <agross@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] ASoC: qdsp6: db820c: Add support for external and bluetooth audio
Date:   Fri,  7 Feb 2020 15:50:05 -0500
Message-Id: <20200207205013.12274-1-adam@serbinski.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set implements PCM audio support in qdsp6 and
PCM and MI2S in apq8096/db820c to enable use of bluetooth
audio codec and external MI2S port on db820c.

The db820c uses qca6174a for bluetooth, which by default
is configured to use what qualcomm refers to as "PCM"
format, which is a variation of TDM.

CC: Andy Gross <agross@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: Liam Girdwood <lgirdwood@gmail.com>
CC: Patrick Lai <plai@codeaurora.org>
CC: Banajit Goswami <bgoswami@codeaurora.org>
CC: Jaroslav Kysela <perex@perex.cz>
CC: Takashi Iwai <tiwai@suse.com>
CC: alsa-devel@alsa-project.org
CC: linux-arm-msm@vger.kernel.org
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org

Adam Serbinski (8):
  ASoC: qdsp6: dt-bindings: Add q6afe pcm dt binding
  ASoC: qdsp6: q6afe: add support to pcm ports
  ASoC: qdsp6: q6afe-dai: add support to pcm port dais
  ASoC: qdsp6: q6routing: add pcm port routing
  ASoC: qcom: apq8096: add support for primary and quaternary I2S/PCM
  ASoC: qcom/common: Use snd-soc-dummy-dai when codec is not specified
  dts: msm8996/db820c: enable primary pcm and quaternary i2s
  ASoC: qcom: apq8096: add kcontrols to set PCM rate

 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 113 +++++++++
 arch/arm64/boot/dts/qcom/msm8996-pins.dtsi   | 162 ++++++++++++
 include/dt-bindings/sound/qcom,q6afe.h       |   8 +
 sound/soc/qcom/apq8096.c                     | 172 +++++++++++--
 sound/soc/qcom/common.c                      |  22 +-
 sound/soc/qcom/qdsp6/q6afe-dai.c             | 198 ++++++++++++++-
 sound/soc/qcom/qdsp6/q6afe.c                 | 246 +++++++++++++++++++
 sound/soc/qcom/qdsp6/q6afe.h                 |   9 +-
 sound/soc/qcom/qdsp6/q6routing.c             |  44 ++++
 9 files changed, 953 insertions(+), 21 deletions(-)

-- 
2.21.1

