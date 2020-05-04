Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB24C47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 10:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F32A120721
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 10:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588587863;
	bh=3jWEsSWVgRD8xTwuvvsewZg4tQVkhPVAueGamNM5GrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lS0q8T9ibeBl8b9YCJRA1uwL327yHOJh0xBK12wPogSsn0OrwO78871V1wtgViok1
	 rSVlusWpFCtkxxVQM6x/6ohdK9udlGgGwJscknDp3ro0W0ZOxAlyx+bmGzD578a3si
	 8GrUagS0W5IOeA1WTdkcva9EoRyAeqvd83kICs3Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbgEDKYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 06:24:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbgEDKYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 06:24:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5609B2054F;
        Mon,  4 May 2020 10:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588587861;
        bh=3jWEsSWVgRD8xTwuvvsewZg4tQVkhPVAueGamNM5GrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mniw2MBBBxPeuDnDV6qPr5bL24ehQOKWfDAxXqcxKFi6uJENxS768Tes5DIsIJGAM
         I+yL2RuO30hHd8LXQwnNzeRU1gq7xmzyaSNom+6vkc2xihRpjP8Gdcg0NLgm3veWY3
         Ir4XejJcNUnyFuowebrKYsZmGd0BdEuOXrD7/n9A=
Date:   Mon, 4 May 2020 12:24:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Re: Linux 5.6.10
Message-ID: <20200504102419.GB1461414@kroah.com>
References: <20200504102408.GA1461414@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504102408.GA1461414@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 2fc8ba07d930..4b29cc9769e8 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 6
-SUBLEVEL = 9
+SUBLEVEL = 10
 EXTRAVERSION =
 NAME = Kleptomaniac Octopus
 
diff --git a/sound/soc/meson/axg-card.c b/sound/soc/meson/axg-card.c
index 2b04ac3d8fd3..1f698adde506 100644
--- a/sound/soc/meson/axg-card.c
+++ b/sound/soc/meson/axg-card.c
@@ -586,10 +586,8 @@ static int axg_card_add_link(struct snd_soc_card *card, struct device_node *np,
 
 	if (axg_card_cpu_is_tdm_iface(dai_link->cpus->of_node))
 		ret = axg_card_parse_tdm(card, np, index);
-	else if (axg_card_cpu_is_codec(dai_link->cpus->of_node)) {
+	else if (axg_card_cpu_is_codec(dai_link->cpus->of_node))
 		dai_link->params = &codec_params;
-		dai_link->no_pcm = 0; /* link is not a DPCM BE */
-	}
 
 	return ret;
 }
