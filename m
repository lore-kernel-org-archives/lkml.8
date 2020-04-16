Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5482DC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2584C214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587050608;
	bh=g0JPxNPuqoHUzF/vEU+fleh3hf32aKcWMVB7AZyvb9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Qe3Zcu3ke27jRPtNML8EP8m0pmOJHW9FmLrqOgKyMTtuZ27UF2ZVhaDIyh1pqjsqi
	 vVhcK5PlRZUxMEAmTFYFWmija8ocXMs449q0CoyYcoeZRheAw6v4a1LVhRtjmO9Ofj
	 IX9sugQlelXOnAR+4H7DZ/IgEUjzte9U3ZLooC54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731778AbgDPPX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:23:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:58694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898493AbgDPNpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:45:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4514520732;
        Thu, 16 Apr 2020 13:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044715;
        bh=g0JPxNPuqoHUzF/vEU+fleh3hf32aKcWMVB7AZyvb9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mWjbGoEVVBD8bokRg0uVjQtUOAGXnaqWGYmKPwZybpRuWw3iNwekfcOxYfs5EkAAm
         qy9Uo6RW0999I7imNpjZnjj2BxbVIJpjwh2z+FgZr9mZZ/6m2Glg2nsxhiTkX2LpSa
         6nu5871dZ1tpzg7zyQmbs6OVwd5nSMHp7UmNOUk8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gyeongtaek Lee <gt82.lee@samsung.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.4 072/232] ASoC: topology: use name_prefix for new kcontrol
Date:   Thu, 16 Apr 2020 15:22:46 +0200
Message-Id: <20200416131324.327680106@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131316.640996080@linuxfoundation.org>
References: <20200416131316.640996080@linuxfoundation.org>
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


