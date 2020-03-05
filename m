Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DEBC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 05:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 401582146E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 05:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="MhEVqnS8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qUykTYP/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbgCEFLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 00:11:47 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:59323 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725844AbgCEFLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 00:11:47 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 53C8E13EF;
        Thu,  5 Mar 2020 00:11:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 05 Mar 2020 00:11:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=PScnJ6CuMqDBUUffmRP5+N0vni
        LQnYGo+Aq7HzbeNwU=; b=MhEVqnS8+2y4D/730NbQnzZ/bz2kXU+ilZ3pQQv6Zv
        YzvvplnLkQK45M+SNeUsSpubZ5DtMwwigWbbNWzX7ONNlVmBNKh96jfDja7dbviB
        OH30EzR22Xru9xzKptdByEankPV7ceU09HwgT8xy+bhEVCSitWu7bkijHfw/ST5Z
        wrMuu5s4+tlAwW8/DOEP1RAvoJsCuLwlmoOdhnqd6coIhNH8j949EBUxsJ9PBiD1
        6UJbF6NOuMnMXFvPq5VXsVEw3vk3T0LreDyaj/gggZXD9JxP59963oNEal9Xi48/
        4tXIkO35qCbnrJR6o+vgaBcxs0ae/F4oounUHAoDtxsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=PScnJ6CuMqDBUUffm
        RP5+N0vniLQnYGo+Aq7HzbeNwU=; b=qUykTYP/KzkfwrZuZuwsC+31/IWLifoTG
        xUjgibR4b6J5uZvc7Ts1mphjsLIsk0vQELVDKs6DtJtGE0ipvnjc+3mZJulZEVxM
        n98lErR7PIfPYTqtASJxsqujYkk4VeLTEq6N/V16FUmsV2Mv3CopPtFMMDhzBpqK
        Tmj8lGQvvOzg4fuZV6cDa0ZN5YhHHZhFOaqHWTLkOkS0FQTs2rpx9DxZD8ZGuo+f
        MTpqlCLPZmrZWle/iE3kowyEjuIKnJJbWNnR0+7XCb4OhPqX0pfMv8yrCgw21vdY
        Wv2w2reDEMj3+EnMGmIaWt8E3qhxCoy8Nh9M49nI9yjGYRW+dOnMg==
X-ME-Sender: <xms:EIpgXrdBjTZ1yWZ6NStxIgdJ4acssIIvZ1PddReLeCBWMJlIU1umRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddtledgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkphepje
    dtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:EIpgXuqqvbzx9JAHluhgUl7Uvf_7OaEXSJ4rNjr2CRUgrJrFnDbo3A>
    <xmx:EIpgXke9WF6qju8u84TIBWMMKnOJt8NRPLurOi4RteH2ENcPFf2nrQ>
    <xmx:EIpgXun5jl-qKOqwmPe4UZXYrAXm_hpJCHwJcMW1-29pC__Jl0EpEQ>
    <xmx:EopgXrtnF6oh-p8fQUk3q0RlBgD_MA0-K35yteAbeFkvK2yo-ODJIA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id E82833280064;
        Thu,  5 Mar 2020 00:11:43 -0500 (EST)
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
Subject: [PATCH v4 0/3] simple-audio-card codec2codec support
Date:   Wed,  4 Mar 2020 23:11:40 -0600
Message-Id: <20200305051143.60691-1-samuel@sholland.org>
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

Changes in v4:
  - Rebased on top of asoc/for-next, several changes to patch 2
  - Removed unused variable from patch 3
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
 sound/soc/generic/simple-card-utils.c      | 48 ++++++++++++++++++
 sound/soc/soc-pcm.c                        | 59 ++++++++++++++--------
 6 files changed, 114 insertions(+), 32 deletions(-)

-- 
2.24.1

