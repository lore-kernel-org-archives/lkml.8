Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7529C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A643B2467D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583845322;
	bh=EhjIXFcU/NEoGOcn/vLlzLLVAbERpWFtTV+W1py1Wo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OH5M2sryzcopcwbnpddiqhOigtZDJ72GH3wmThUm7UMFPXJC73h0zsuEhTkwYNdHi
	 YDs0nPPLBvl6Efzn3AIGSNjbEQn+BlxZZcxXlQg5p8pnMmATOL8OqqV5TwNjkdqbWM
	 kbhEwI+CZw/t/sla/RiU8OtGtQlwO4o8K1la30Q4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgCJNCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:02:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:43602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728387AbgCJNBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:01:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6D8324693;
        Tue, 10 Mar 2020 13:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845315;
        bh=EhjIXFcU/NEoGOcn/vLlzLLVAbERpWFtTV+W1py1Wo4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zk4k4Dkq54r9MIVEryDzoGaZ8LsaHVpUHxfDstxJUmmt3JUZN1lBlrJ2Mszyo5wQT
         NJ7Ozrf0PVS6YZ3q3a13555/C82fBySTkMhahbFBvD7ji80bgfYN0qMiHelw8cwDWR
         vJuaENJ/jHeLyHHCUB6HIHw9hkL/WAzPT4tl6xFc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.5 139/189] ASoC: soc-component: tidyup snd_soc_pcm_component_sync_stop()
Date:   Tue, 10 Mar 2020 13:39:36 +0100
Message-Id: <20200310123653.880021980@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123639.608886314@linuxfoundation.org>
References: <20200310123639.608886314@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

commit f1861a7c58ba1ba43c7adff6909d9a920338e4a8 upstream.

commit 1e5ddb6ba73894 ("ASoC: component: Add sync_stop PCM ops")
added snd_soc_pcm_component_sync_stop(), but it is checking
ioctrl instead of sync_stop. This is bug.
This patch fixup it.

Fixes: commit 1e5ddb6ba73894 ("ASoC: component: Add sync_stop PCM ops")
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/r/8736av7a8c.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/soc-component.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/soc/soc-component.c
+++ b/sound/soc/soc-component.c
@@ -452,7 +452,7 @@ int snd_soc_pcm_component_sync_stop(stru
 	int ret;
 
 	for_each_rtd_components(rtd, rtdcom, component) {
-		if (component->driver->ioctl) {
+		if (component->driver->sync_stop) {
 			ret = component->driver->sync_stop(component,
 							   substream);
 			if (ret < 0)


