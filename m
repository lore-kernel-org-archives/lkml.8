Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5B7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3C9820772
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbgGBOMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:12:20 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59124 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728179AbgGBOMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:12:19 -0400
Received: from xps.home (unknown [IPv6:2a01:e35:2fb5:1510:315a:ecf0:6250:a3ed])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aferraris)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id D7F002A5EC2;
        Thu,  2 Jul 2020 15:12:17 +0100 (BST)
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
Subject: [PATCH 0/2] ASoC: fsl-asoc-card: add support for generic codecs
Date:   Thu,  2 Jul 2020 16:11:13 +0200
Message-Id: <20200702141114.232688-1-arnaud.ferraris@collabora.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fsl-asoc-card currently only works with AC97 or a selection of codecs,
although the hardware is capable of more.

Supporting generic codecs when acting as I2S slave (codec is master)
would be useful, especially when using Bluetooth audio, as these are
generally simple I2S devices not controlled by the sound subsystem.

This will allow using simple/dummy codecs along with ASRC.

Arnaud Ferraris (2):
  dt-bindings: sound: fsl-asoc-card: add new compatible for I2S slave
  ASoC: fsl-asoc-card: add support for generic I2S slave use-case

 Documentation/devicetree/bindings/sound/fsl-asoc-card.txt | 23 ++++++++++++++++++++++-
 sound/soc/fsl/fsl-asoc-card.c                             | 46 +++++++++++++++++++++++++++++++++++-----------
 2 files changed, 57 insertions(+), 12 deletions(-)
