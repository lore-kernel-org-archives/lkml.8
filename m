Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75EAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD98620890
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbgGBOWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729399AbgGBOWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:22:50 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A99C08C5C1;
        Thu,  2 Jul 2020 07:22:50 -0700 (PDT)
Received: from xps.home (unknown [IPv6:2a01:e35:2fb5:1510:315a:ecf0:6250:a3ed])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aferraris)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 3CE162A1D11;
        Thu,  2 Jul 2020 15:22:49 +0100 (BST)
From:   Arnaud Ferraris <arnaud.ferraris@collabora.com>
Cc:     kernel@collabora.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/4] ASoC: fsl_asrc: allow selecting arbitrary clocks
Date:   Thu,  2 Jul 2020 16:22:31 +0200
Message-Id: <20200702142235.235869-1-arnaud.ferraris@collabora.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current ASRC driver hardcodes the input and output clocks used for
sample rate conversions. In order to allow greater flexibility and to
cover more use cases, it would be preferable to select the clocks using
device-tree properties.

This series also fix register configuration and clock assignment so
conversion can be conducted effectively in both directions with a good
quality.

Arnaud Ferraris (4):
  dt-bindings: sound: fsl,asrc: add properties to select in/out clocks
  ASoC: fsl_asrc: allow using arbitrary input and output clocks
  ASoC: fsl_asrc: always use ratio for conversion
  ASoC: fsl_asrc: swap input and output clocks in capture mode

 Documentation/devicetree/bindings/sound/fsl,asrc.txt |  8 ++++++++
 sound/soc/fsl/fsl_asrc.c                             | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 sound/soc/fsl/fsl_asrc_common.h                      |  3 +++
 3 files changed, 75 insertions(+), 5 deletions(-)


