Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2564C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E852206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261436;
	bh=fvKTvQppfJjOPm9ev9R0LLaRbKSdKwZuxaEYJ+Ekcjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ChrEfoFW40Ffq3qh/VSyioSmj0r0re1mSwRGVTthRtQb6n0wix7AGckhkR1dVp767
	 gdqRP98IAuqmCzb0TbI/9f4gYffLSiuiyahmIy0ZVqLuaybChKexdNwsafbZbwsffK
	 dBtBW/LOBPAOcm3joslF8ewUOgZt9tJIyhTOs4ms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732954AbgGTQKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:10:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:48946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387656AbgGTQK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:10:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 081D42065E;
        Mon, 20 Jul 2020 16:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261425;
        bh=fvKTvQppfJjOPm9ev9R0LLaRbKSdKwZuxaEYJ+Ekcjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fXbZnC8n4w50Cy4shKIIZ+oZ/0Jm5OusJ6anO9Dc/B3iWobqY5rDcuMiZLAZnTCoV
         CvCe4XDV/tCuQIiz/Rh0gz/qHaE5a70e42uzXUuUwmWoi2UDni0Eex7npP1pkkR0Va
         klUVRpnF/Y446u0jqJAVNfKIYMitxVM93t8fhDFE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 081/244] soundwire: intel: fix memory leak with devm_kasprintf
Date:   Mon, 20 Jul 2020 17:35:52 +0200
Message-Id: <20200720152829.695257062@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit bf6d6e68d2028a2d82f4c106f50ec75cc1e6ef89 ]

The dais are allocated with devm_kcalloc() but their name isn't
resourced managed and never freed. Fix by also using devm_ for the dai
names as well.

Fixes: c46302ec554c5 ('soundwire: intel: Add audio DAI ops')
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Daniel Baluta <daniel.baluta@gmail.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://lore.kernel.org/r/20200617163536.17401-1-pierre-louis.bossart@linux.intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soundwire/intel.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 3c83e76c6bf90..cab425070e641 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -930,8 +930,9 @@ static int intel_create_dai(struct sdw_cdns *cdns,
 
 	 /* TODO: Read supported rates/formats from hardware */
 	for (i = off; i < (off + num); i++) {
-		dais[i].name = kasprintf(GFP_KERNEL, "SDW%d Pin%d",
-					 cdns->instance, i);
+		dais[i].name = devm_kasprintf(cdns->dev, GFP_KERNEL,
+					      "SDW%d Pin%d",
+					      cdns->instance, i);
 		if (!dais[i].name)
 			return -ENOMEM;
 
-- 
2.25.1



