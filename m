Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C65C8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 12:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 466D42072A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 12:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="MyXancF3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgD3Mlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 08:41:31 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:13036 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbgD3Mlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 08:41:31 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eaac76e0000>; Thu, 30 Apr 2020 05:41:18 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 30 Apr 2020 05:41:30 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 30 Apr 2020 05:41:30 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 30 Apr
 2020 12:41:30 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 30 Apr 2020 12:41:30 +0000
Received: from audio.nvidia.com (Not Verified[10.24.34.185]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5eaac7740003>; Thu, 30 Apr 2020 05:41:29 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <kuninori.morimoto.gx@renesas.com>
CC:     <lgirdwood@gmail.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <digetx@gmail.com>,
        <alsa-devel@alsa-project.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sharadg@nvidia.com>,
        <mkumard@nvidia.com>, <viswanathl@nvidia.com>,
        <rlokhande@nvidia.com>, <dramesh@nvidia.com>,
        <atalambedu@nvidia.com>, <nwartikar@nvidia.com>,
        <swarren@nvidia.com>, <nicoleotsuka@gmail.com>
Subject: [RFC] DPCM for Tegra
Date:   Thu, 30 Apr 2020 18:11:23 +0530
Message-ID: <1588250483-10014-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1588250478; bh=iOTBcDsLLgLJQNleti1NyLgN7hxMgJVLaYlGA0OF9uM=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type;
        b=MyXancF3Zn1YW8lTjlAnrdqdJsnfZSi2IMP6aRcvGmuQldaw9Ll0QThJ9byqHBFzX
         2oKXdykB2Vmd6lQ4PXYhReD3K4VqdTs/lDVnZOrNuP7sbHc9KCXXf8WT3GudVwAoot
         IHtQvJtDaGel/USTbevevWmyBh6i/pPFMU02akxvC8o7nLsEqkLTIQ69mwi1Ro3vhC
         HdD69WSlG5WNr9DCOLV4pzqNpkrQ0jSoUwEqwPOE/gsBhVyBgGuxWZwqQBvLTFPgu9
         5dmqlB71yP6A8nSqrDPgTwdBtN7NIjbsLfzLbHzys6PmWfcDRtScp4YyzoCxaq8sXq
         TzPR4cCpSgGYQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Earlier I had sent Tegra ASoC series [0] for review and writing back
to follow up on the same.


Background
==========
There were following concerns on [0]:

 - Usage of mixer control overrides in each driver for PCM parameters.

 - Exposure of routing controls to the user.

The comments are mostly captured in [1] and [2].

There was a suggestion to use DPCM for the Tegra audio requirements.

Note: As of now, below does not cover specific solution for propogation
of audio configurations or PCM parameters (like sample rate, sample size
and channels).

DPCM Testing
============
Since then I was looking into internals of DPCM and was trying to get it
working with Tegra. I was able to get following things working.

 - Audio playback/capture over I2S/DMIC/DSPK.
 - Audio resampling use case.
 - Mixing of two audio streams with resampler in the path.

Objective was to understand and get audio working with DPCM. Please note
that I used simple-card DPCM driver for a quick testing on top of the above
Tegra Audio series. I had to tweak the simple-card driver a little, but
currently keeping it out of the scope of current discussion.

At a high level Tegra Audio HW is depicted as below.

|     Front End PCMs     |  SoC DSP   |     Back End DAIs    |

                         *************
ADMAIF<0> <------------> *           * <----DAI<0>-----> I2S
                         *           *
ADMAIF<1> <------------> *           * <----DAI<1>-----> DMIC
                         *    XBAR   *
ADMAIF<2> <------------> *           * <----DAI<2>-----> DSPK
                         *           *
ADMAIF<N> <------------> *           * <----DAI<3>-----> SFC (Resampler)
                         *           *
                         *           * <----DAI<4>-----> MIXER
                         *           *
                         *           * <----DAI<N>-----> ...
                         *************

Note:
-----

 * XBAR is just a cross bar interconnecting one component to another.
   Specific switch needs to be programmed for audio data to flow from
   one component to another.

 * SFC or Mixer are separate HW blocks and separate ASoC drivers are
   written for these. These drivers were not sent earlier as part of
   initial upstream series [0].


Follow up queries
=================
Based on the above experience I do have few follow up queries and request
for your inputs on this.

 a) Can I use a DAPM Mux control to activate a BE path? This in turn can
    program required switch in XBAR.

    This is needed for following reasons:

    - For an open platform like Jetson, we want to give maximum flexibility
      for a user to customize their audio paths. Number of connected
      components and order of these can vary depending on a use case.

    - Allow re-use of audio components across multiple use cases.
      For example, number of SFC instances are lesser than PCM playback or
      capture devices.

 b) I have modelled SFC and MIXER as backends. Is this allowed?

    This was done to include SFC or MIXER HW components as part of the
    sound card and use like below in one of the audio use cases.
 
    ADMAIF1(FE) --> SFC(BE1) --> I2S(BE2) ... OR
    ADMAIF2(FE) --> SFC(BE1) --> I2S(BE2) ...

    I used following workaround to connect multiple BE components.
    With this I can see PCM callbacks happen for all BE DAIs along the DAPM
    path. The obective was to connect multiple components together and (a)
    was used to connect one component to another. Each "-->" here connects
    two components and it is a switch in XBAR. 

    ---
      sound/soc/soc-pcm.c | 2 +-
      1 file changed, 1 insertion(+), 1 deletion(-)

      diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
      index e256d43..ee7af55 100644
      --- a/sound/soc/soc-pcm.c
      +++ b/sound/soc/soc-pcm.c
      @@ -1494,7 +1494,7 @@ int dpcm_path_get(struct snd_soc_pcm_runtime *fe,
 
 	  /* get number of valid DAI paths and their widgets */
 	  paths = snd_soc_dapm_dai_get_connected_widgets(cpu_dai, stream, list,
      -			dpcm_end_walk_at_be);
      +			NULL);
 
 	dev_dbg(fe->dev, "ASoC: found %d audio %s paths\n", paths,
 			stream ? "capture" : "playback");
    -- 

 c) Hostless mode did NOT work:
     - Following audio path was intended to be tested:
       I2S1 --> SFC --> I2S2

     - [3] offers two options:
         * CODEC<->CODEC: If I were to use a separate DAI link for each BE to BE
           connection, then it will result in a similar design what we have
           currently.

         * Hostless: I did not come across references for this.
           (Any references in this regard will be helpful)


May be the current Tegra ASoC design is more suitable for component model as you
had previously mentioned. I wanted to understand if above, especially (a) and (b),
are acceptable in this regard or if there are better options to interconnect
multiple ASoC components.

Looking forward for your feedback.

Thanks,
Sameer.

References
==========
[0] http://patchwork.ozlabs.org/project/linux-tegra/list/?series=159664&archive=both&state=*
[1] http://patchwork.ozlabs.org/project/linux-tegra/patch/1582180492-25297-6-git-send-email-spujar@nvidia.com/
[2] http://patchwork.ozlabs.org/project/linux-tegra/patch/1582180492-25297-4-git-send-email-spujar@nvidia.com/
[3] https://www.kernel.org/doc/html/v5.6/sound/soc/dpcm.html
