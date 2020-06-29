Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69B7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 03:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82C4E206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 03:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DE01pAvH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgF2DX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 23:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgF2DX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 23:23:59 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A930C03E979
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 20:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=blQRyd/HnAyTbWfbQ9xtykWqeCj1aEkm67zC7s9PG2w=; b=DE01pAvHW6rcfid3cvE/jIdTqU
        nqqb9R2nFsmYFIjfnzSXtcbUHQzBQ95NnEZPBuq7UNDzYSHWA5DhHA9ZAUXVOSdrixZqIQdMu0y3S
        v7F9ibuJJoanNGjL1CC9W+CoBW6KsNZoF06HAKqv3EBhpa7G+BCKyzb+ZtxhnV6vxy475Lf5Fl7xV
        75aDqAn1/Bi0T6Z0VxVzxkg6vqZCjEWqcxVBAoBE+Rjus2AeKz+GA8NWMl0lnSIkis89unej4pTSk
        lYmf1ALW0kemIFuM6ca57rm/yYqUy1jDytPH4zD64cjYRGnDME8bc9pdmm+QXInAKpdCC2Y4E/FXf
        2oo5LwhA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpkOO-0003eW-BA; Mon, 29 Jun 2020 03:23:37 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        moderated for non-subscribers <alsa-devel@alsa-project.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] ASoC: Documentation: fix reference to renamed source
 file
Message-ID: <a9f59f30-8cf2-ea82-567c-1706fd64fe62@infradead.org>
Date:   Sun, 28 Jun 2020 20:23:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

sound/soc/soc-io.c was merged into sound/soc/soc-component.c, so fixup
the Documentation to use the updated file name.

Error: Cannot open file ../sound/soc/soc-io.c
WARNING: kernel-doc '../scripts/kernel-doc -rst -enable-lineno ../sound/soc/soc-io.c' failed with return code 1

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>
---
 Documentation/sound/kernel-api/alsa-driver-api.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200626.orig/Documentation/sound/kernel-api/alsa-driver-api.rst
+++ linux-next-20200626/Documentation/sound/kernel-api/alsa-driver-api.rst
@@ -99,7 +99,7 @@ ASoC Core API
 .. kernel-doc:: include/sound/soc.h
 .. kernel-doc:: sound/soc/soc-core.c
 .. kernel-doc:: sound/soc/soc-devres.c
-.. kernel-doc:: sound/soc/soc-io.c
+.. kernel-doc:: sound/soc/soc-component.c
 .. kernel-doc:: sound/soc/soc-pcm.c
 .. kernel-doc:: sound/soc/soc-ops.c
 .. kernel-doc:: sound/soc/soc-compress.c

