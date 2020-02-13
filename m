Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A16FC3B189
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB64246C7
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581607483;
	bh=uf0sW80CIBSxOkP6grpHcVop7BngU6qc+NqqsOk2MDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iXYGjyP4UKGncdsGCVE+tkqUEUaddnkd3FoNzl+J43tZ6qYuLv9Yr+PdxUjRMr+Vr
	 piEkk04GPhb0NEMzgyqkv+QvqCY1+q/FbqW0HeeXiO4uJ9QqtCK/9QgNU+C308g3LO
	 ug1/KekY9e8aae0wL9tKgMBBm7dV/XsOjK5AOkEY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbgBMPYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:24:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:34420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728363AbgBMPXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:23:23 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 819CB24699;
        Thu, 13 Feb 2020 15:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607402;
        bh=uf0sW80CIBSxOkP6grpHcVop7BngU6qc+NqqsOk2MDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E/ByYe6uiyXA3NRtOFdaif0r+MzSMxkB0njtE/0Gw8f1hchCm/rDYqKZoOFx6Tn/F
         Pi0SMNUfAj9I5IphHpoaA1OlmoL20Huvfp/vMlI9zZxzlpx2fcR1bB2oyV2IpbtCBr
         KHLhybZ+2jJJ4gT1sYQzoDcWeuCkbcMjUdfOVkiQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH 4.9 004/116] ASoC: qcom: Fix of-node refcount unbalance to link->codec_of_node
Date:   Thu, 13 Feb 2020 07:19:08 -0800
Message-Id: <20200213151844.171406458@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151842.259660170@linuxfoundation.org>
References: <20200213151842.259660170@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

[ This is a fix specific to 4.4.y and 4.9.y stable trees;
  4.14.y and older are not affected ]

The of-node refcount fixes were made in commit 8d1667200850 ("ASoC: qcom:
Fix of-node refcount unbalance in apq8016_sbc_parse_of()"), but not enough
in 4.4.y and 4.9.y. The modification of link->codec_of_node is missing.
This fixes of-node refcount unbalance to link->codec_of_node.

Fixes: 8d1667200850 ("ASoC: qcom: Fix of-node refcount unbalance in apq8016_sbc_parse_of()")
Cc: Patrick Lai <plai@codeaurora.org>
Cc: Banajit Goswami <bgoswami@codeaurora.org>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Mark Brown <broonie@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/qcom/apq8016_sbc.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/sound/soc/qcom/apq8016_sbc.c
+++ b/sound/soc/qcom/apq8016_sbc.c
@@ -128,7 +128,8 @@ static struct apq8016_sbc_data *apq8016_
 		link->codec_of_node = of_parse_phandle(codec, "sound-dai", 0);
 		if (!link->codec_of_node) {
 			dev_err(card->dev, "error getting codec phandle\n");
-			return ERR_PTR(-EINVAL);
+			ret = -EINVAL;
+			goto error;
 		}
 
 		ret = snd_soc_of_get_dai_name(cpu, &link->cpu_dai_name);


