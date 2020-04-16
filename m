Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4AAC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0D5620732
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587051946;
	bh=g0JPxNPuqoHUzF/vEU+fleh3hf32aKcWMVB7AZyvb9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RGClxtq/Ej2qqJEYw0VOBtSwwcroucfjkRUuhTEOThEgt806dHyOymbEchcwLm5az
	 Ad1Qq80/WhsbHLaCTuJhF8PlSmUvXfbZer44sTj4aq5b5zeOsLFUgCpyTCf0r22xvI
	 6NsJHY4784uJ+KML7jBjuH+hTbLlGeNyIC93TxLY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393270AbgDPPpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:45:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:46956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897063AbgDPNfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:35:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 227B520732;
        Thu, 16 Apr 2020 13:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044106;
        bh=g0JPxNPuqoHUzF/vEU+fleh3hf32aKcWMVB7AZyvb9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XS5nQHAc3M+WYE04inD/mxaX/8lgEfnCt5m9NbXWl6z5cSyWPJRqDdxGk8EoF/Dw3
         tzMGBeww49wVd3F2v7bZZlS0gYg9E8a4VnKTgiIO+r+P6t3XkhZ5BVaDQ0OwrSqtxO
         erqY9KSWzONWmZNXMQ0xjoysmXDs1V99nRHI+dDA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gyeongtaek Lee <gt82.lee@samsung.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.5 084/257] ASoC: topology: use name_prefix for new kcontrol
Date:   Thu, 16 Apr 2020 15:22:15 +0200
Message-Id: <20200416131336.457554916@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.891903893@linuxfoundation.org>
References: <20200416131325.891903893@linuxfoundation.org>
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
@@ -362,7 +362,7 @@ static int soc_tplg_add_kcontrol(struct
 	struct snd_soc_component *comp = tplg->comp;
 
 	return soc_tplg_add_dcontrol(comp->card->snd_card,
-				comp->dev, k, NULL, comp, kcontrol);
+				comp->dev, k, comp->name_prefix, comp, kcontrol);
 }
 
 /* remove a mixer kcontrol */


