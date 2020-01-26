Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4CBC2D0DB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 17:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC0D3206D5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 17:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mybox7dB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgAZRiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 12:38:04 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33035 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgAZRiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 12:38:03 -0500
Received: by mail-lj1-f195.google.com with SMTP id y6so8253233lji.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jan 2020 09:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=uQCsuSWxUoS41fOaGTKbaWt4unoRSaSJnXlIAweW6F0=;
        b=mybox7dBk7EcxeQzW5QQ5j0Iz6I5zw9PLg8XdqPwDymlsQUQv4DKPsIrRPFQpJ+ZCY
         YxAWzb54kBSo6FiqgnOiVUgfCgWdDwXxRWCCpwiiVs396Kau+Lbs4VlTKzMz+j1GTBRC
         AVH1Z1VQeFJ8/hRAaM6n+nfO68TOk9249PHkJhg4yCYlVo/HllETs4JxqFATGuXSqR9C
         /r82gYC3rxmTmgyTSn+3+RNykp6kIuqdkd9HHct8Ti/qIEdhN7D204hSIbs50XIzcCdU
         Xq7p0l4taeeFhhYjBbiNT5DBEr8/I470PdkiBsGoGpeL4kyRcWLA/F7mbjH/bFyNZERq
         lXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=uQCsuSWxUoS41fOaGTKbaWt4unoRSaSJnXlIAweW6F0=;
        b=WpkiG2T5ThXlSyD6doGGk9KSMRX4dgcYMisbS4VW50Bf9v9fpYWCz00r3g8FGsOzk0
         XztM9oK/TuhFfbaXDt/Voe6QyOrnZvX7AxOkX016879n8R+8UIqiMCsx6GSKQ3JB0nad
         NMDt7CjAEu6Mc6+itFibRzkxYKzf/slk8d4kJsbWjA/vVo5dxxyDQtloxUzj8d/RAgXK
         WPfXcPdoUWLK+JxWma+njUwSpU4fOFYMZLhGssax4h3kg98T92VtYaQYjY0PWVCRmTUP
         5tkhxBnNpjPewcOeOMbUwUp463EMZWssvlVUTW5Azdij4f6tBwL/wXkjAb7HPfUVVqf6
         Pxhw==
X-Gm-Message-State: APjAAAXhqiTE5jPTuMUGZa2c3KNb66elW2jQJcFsAL9G1HALFUbIIafK
        pcybV6poJo4JI22Tz3tUH60=
X-Google-Smtp-Source: APXvYqzBLIDC8HJOqEe0fHf0HgYNEn8/pBcCz065lMMZ+ZACh8w85S5ZGRKDC9DCXGD1owsp75jugQ==
X-Received: by 2002:a2e:a30b:: with SMTP id l11mr4852186lje.271.1580060281896;
        Sun, 26 Jan 2020 09:38:01 -0800 (PST)
Received: from home (109-252-7-246.nat.spd-mgts.ru. [109.252.7.246])
        by smtp.gmail.com with ESMTPSA id p136sm6708868lfa.8.2020.01.26.09.38.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Jan 2020 09:38:01 -0800 (PST)
Date:   Sun, 26 Jan 2020 19:37:58 +0200
From:   Valery Ivanov <ivalery111@gmail.com>
To:     nsaenzjulienne@suse.de
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: bcm2835-audio: fix warning of no space is necessary
Message-ID: <20200126173758.GA28897@home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes "No space is necessary after a cast".
Issue found by checkpatch.pl

Signed-off-by: Valery Ivanov <ivalery111@gmail.com>
---
 drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
index 33485184a98a..997ce88c67c4 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
@@ -237,7 +237,7 @@ static void snd_bcm2835_pcm_transfer(struct snd_pcm_substream *substream,
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct bcm2835_alsa_stream *alsa_stream = runtime->private_data;
-	void *src = (void *) (substream->runtime->dma_area + rec->sw_data);
+	void *src = (void *)(substream->runtime->dma_area + rec->sw_data);
 
 	bcm2835_audio_write(alsa_stream, bytes, src);
 }
-- 
2.17.1

