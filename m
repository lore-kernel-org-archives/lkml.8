Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0B5C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 140AD2082F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579217294;
	bh=EJ9iI+eUjvW2rcFKp3DjF2SfLtjsxCOxAXRBiIJFWj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1cEjlnZe8fR2y/BbIVRFfoWPgg/lz50QZJsNhh5WWde+m9tbYTT1P9gWv6mGHPtcS
	 pRFfjHdFFJ0qn0lcgdeu/QFXrNOd++X1rNVqImJiyk8r5oQnTJ9lKsXQp8GY0g9kwo
	 NZCfo822RpSpDVw+0dfuPGG2+KqkzBctFF+s3VGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391068AbgAPX2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:28:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:60662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391044AbgAPX2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:28:07 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26FFA206D9;
        Thu, 16 Jan 2020 23:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217286;
        bh=EJ9iI+eUjvW2rcFKp3DjF2SfLtjsxCOxAXRBiIJFWj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VN4mSq+eQWEZmmav9xtJ76+4iJcikjJmmf0tWjnWqsiYWRvnmmatAemObtWLE/UuZ
         pR2qkVY4oGKZ3MO23VFxxMq5FUOjy+4Si4aCN6UbzCWny1a2vw5gK9h2fgAVovQoMo
         c4xnb03jLMyfoYG8JrmxvqbBM708PRuj2c9BqjPE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.19 20/84] ASoC: soc-core: Set dpcm_playback / dpcm_capture
Date:   Fri, 17 Jan 2020 00:17:54 +0100
Message-Id: <20200116231716.046108056@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231713.087649517@linuxfoundation.org>
References: <20200116231713.087649517@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

commit 218fe9b7ec7f32c10a07539365488d80af7b0084 upstream.

When converting a normal link to a DPCM link we need
to set dpcm_playback / dpcm_capture otherwise playback/capture
streams will not be created resulting in errors like this:

[   36.039111]  sai1-wm8960-hifi: ASoC: no backend playback stream

Fixes: a655de808cbde ("ASoC: core: Allow topology to override machine driver FE DAI link config")
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Link: https://lore.kernel.org/r/20191204151333.26625-1-daniel.baluta@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/soc-core.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1921,6 +1921,8 @@ static void soc_check_tplg_fes(struct sn
 
 			/* convert non BE into BE */
 			dai_link->no_pcm = 1;
+			dai_link->dpcm_playback = 1;
+			dai_link->dpcm_capture = 1;
 
 			/* override any BE fixups */
 			dai_link->be_hw_params_fixup =


