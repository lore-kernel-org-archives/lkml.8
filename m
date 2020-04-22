Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFB0C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DCF82076E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587553133;
	bh=HnkQ5CHHdwe9lvr7BpMfGxYss3pgl7ZbZQxAJQZMvlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jz3/UumJgii6Wf7vGg27GgIoPOltZziR5ntEOYTFjbwFWU5ur1Uw13SDC0SVReW8C
	 0ZDBRXL9H8013qZX44bHs8dfRhSGSrsL6A8cYzUscBA1uRkDgp24MW9OFpNYoVqyH9
	 ZbD9BnHPWC5qh2ASO9ym82LghcVbSfj8iHZ4zdYQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbgDVK6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:58:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:53456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbgDVKDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:03:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5859D20857;
        Wed, 22 Apr 2020 10:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587549814;
        bh=HnkQ5CHHdwe9lvr7BpMfGxYss3pgl7ZbZQxAJQZMvlQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nO0wbxo8+LyuHVR4Rwd6XjBDjc//5cGQLBWLSx8Ek3T4OZ6tetcEJ6lkEuED+gX91
         fHDwEo8gXaksSrKmUCQUyCZHuAt5634GV13dcqrB/MZLV93S6+7N98KnX+5TL21+wt
         nWk7evkNwQuEPBkbe0eXdzY9o7BJ1iPcjp4i5igc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gyeongtaek Lee <gt82.lee@samsung.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.9 018/125] ASoC: topology: use name_prefix for new kcontrol
Date:   Wed, 22 Apr 2020 11:55:35 +0200
Message-Id: <20200422095036.225034486@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095032.909124119@linuxfoundation.org>
References: <20200422095032.909124119@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: 이경택 <gt82.lee@samsung.com>

commit abca9e4a04fbe9c6df4d48ca7517e1611812af25 upstream.

Current topology doesn't add prefix of component to new kcontrol.

Signed-off-by: Gyeongtaek Lee <gt82.lee@samsung.com>
Link: https://lore.kernel.org/r/009b01d60804$ae25c2d0$0a714870$@samsung.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/soc-topology.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -344,7 +344,7 @@ static int soc_tplg_add_kcontrol(struct
 	struct snd_soc_component *comp = tplg->comp;
 
 	return soc_tplg_add_dcontrol(comp->card->snd_card,
-				comp->dev, k, NULL, comp, kcontrol);
+				comp->dev, k, comp->name_prefix, comp, kcontrol);
 }
 
 /* remove a mixer kcontrol */


