Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0228C47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 10:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B13C22075A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 10:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588587820;
	bh=CSaRm9DKo7meHdbRYqvBwsb3kcBdv7WrQm6O6JK9GB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LfbpYLRaD3RYPkQ3cB7o08J9caEV84UD4OcsfssuZprHHyMFz0/4wVuNbEWTEfcLx
	 7fZQrYs8xn5+ITYxSv+wI3e9rOnxiab4fPbxqzpGg7qJ22QXntcUSCp8sJrPOlzmng
	 pWTUMn8beimCYYbeS9VsMVY1ynIEbSnt2PTbkTE4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbgEDKXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 06:23:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:44956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbgEDKXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 06:23:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8134206E6;
        Mon,  4 May 2020 10:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588587819;
        bh=CSaRm9DKo7meHdbRYqvBwsb3kcBdv7WrQm6O6JK9GB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ijZfQ4FxExFlQkeOTAFYQXSnzIugzZH2kct6ir2oJbLP9oET7kl2/TX4jIgIvCcyc
         dCOQDUjNgh43OEQMzCESE88PuEfuuf6qKdiK2/0hY2Ob05jJ/BzDHGzsxu8x9L78cz
         o+7JC3zeWOuzbVV4JJzzhF95T/JE5WUYGdzk2jfc=
Date:   Mon, 4 May 2020 12:23:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Re: Linux 5.4.38
Message-ID: <20200504102337.GB1457780@kroah.com>
References: <20200504102331.GA1457780@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504102331.GA1457780@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 33690285d6aa..989e7d649633 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 4
-SUBLEVEL = 37
+SUBLEVEL = 38
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
