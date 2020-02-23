Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770A0C35670
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 03:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49972206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 03:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="N15Z7jSU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ViTn650G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbgBWDph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 22:45:37 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:35585 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726884AbgBWDpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 22:45:36 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id C7E016A20;
        Sat, 22 Feb 2020 22:45:35 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 22 Feb 2020 22:45:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=JMfR+VrrDoBk0uiOZlbWJKwHPD
        wLyBQJby+91WZGxwo=; b=N15Z7jSUHNbz+mOHEHh9vOf++wuuoKnB3PsgyLkvBC
        Jgd/3kRocYSbOQo6xAfqnqIV6K+B6EFoN4p95GFDrHgwTkCRVxQbYrB1p/xKhAuP
        A2jZDHH3jNATzObmEqMAPXVIf9OptXQM2P3xIBPsnEclURSOD9cR0XezUlYxOMpb
        AWQJJsa+dTYzLFD2tMybJg7yuHssBeM7mEKDUJSLZCT4v/+bH2px4G8sWQqppksS
        QRfZ06pCUHh1lUrfEr4fsYjTWCALrwWNP167atO547OnzalTGBEFoE62g2LMfDfs
        ZfJcrkxRX6Hu0RQjCIsfxnBv8tBJaKw/AzC0G2pCyc4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=JMfR+VrrDoBk0uiOZ
        lbWJKwHPDwLyBQJby+91WZGxwo=; b=ViTn650G/ITqnEZaxdRRq1Px708Tpx7IL
        6rIFKsUtxC/91d7eYk8XJyJ7h3oYHtnwQcM6QqbA18vNEC8Or1Pcdzja1MWoEjpZ
        0eV7iTjE4nNc4Iocb+nA7nb2AHc/xOcIDv050uf0kNCg4183CQzlreRCGmh2GAqW
        vFViFctcOAzgtJ+O32qHcikV56OMKCYXcTOvZ8DSKtFCXWx+hdx29PQk6b0FfV9N
        4LeUWQt4wagG1FVMh2PkDiRwaSMIg/GAp+BIJC3D/qIsIHw4GXQSEBVi6Z3b8lsl
        5WySNwkpwWoKvf9fMBL0M4uSWguBeXDdq7dp/db3SdANrCmnKOGBw==
X-ME-Sender: <xms:XvVRXsEGLApsGVhP9X0Uvwv0ihw2IEdDB3YOYxcXos1Vx-8BIZZR5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrkeejgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghlucfj
    ohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppeejtd
    drudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:XvVRXpIaccIq6yUpwks2VERhBIKwEPRyJAzXCLcaWaA9AVUS3CF99g>
    <xmx:XvVRXvPb7NRIuARAiPqP49vSipDB_z-4we1CTrA-MYDdKyXD98o6IQ>
    <xmx:XvVRXhlUVGjXJO3xaPjeBqm07zAIWCt7altd8e8jjp1JYLHbJUTw-w>
    <xmx:X_VRXvD5uUkrC7iwE2GgfU6duBgXHVk6qB_NtBHs1bbcSUKofbkOdQ>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id F27D83060BD1;
        Sat, 22 Feb 2020 22:45:33 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 0/3] simple-audio-card codec2codec support
Date:   Sat, 22 Feb 2020 21:45:30 -0600
Message-Id: <20200223034533.1035-1-samuel@sholland.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are currently using simple-audio-card on the Allwinner A64 SoC.
The digital audio codec there (sun8i-codec) has 3 AIFs, one each for the
CPU, the modem, and Bluetooth. Adding support for the secondary AIFs
requires adding codec2codec DAI links.

Since the modem and bt-sco codec DAI drivers only have one set of
possible PCM parameters (namely, 8kHz mono S16LE), there's no real
need for a machine driver to specify the DAI link configuration. The
parameters for these "simple" DAI links can be chosen automatically.

This series adds codec2codec DAI link support to simple-audio-card.
Codec to codec links are automatically detected when all DAIs in the
link belong to codec components.

I tried to reuse as much code as possible, so the first two patches
refactor a couple of helper functions to be more generic.

The last patch adds the new feature and its documentation.

Changes in v3:
  - Update use of for_each_rtd_components for v5.6
Changes in v2:
  - Drop patch 1 as it was merged
  - Automatically detect codec2codec links instead of using a DT property

Samuel Holland (3):
  ALSA: pcm: Add a standalone version of snd_pcm_limit_hw_rates
  ASoC: pcm: Export parameter intersection logic
  ASoC: simple-card: Add support for codec2codec DAI links

 Documentation/sound/soc/codec-to-codec.rst |  9 +++-
 include/sound/pcm.h                        |  9 +++-
 include/sound/soc.h                        |  3 ++
 sound/core/pcm_misc.c                      | 18 +++----
 sound/soc/generic/simple-card-utils.c      | 49 +++++++++++++++++++
 sound/soc/soc-pcm.c                        | 55 +++++++++++++++-------
 6 files changed, 115 insertions(+), 28 deletions(-)

-- 
2.24.1

