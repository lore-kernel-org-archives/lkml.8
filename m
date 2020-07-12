Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF13C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 07:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAD092065F
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 07:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0MiyFdd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgGLHGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 03:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgGLHGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 03:06:36 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795F3C08C5DD
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 00:06:35 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x11so4130214plo.7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 00:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=1RQK81eHkq8yc1kfeadt5EYNtBGoEuKdAYto1gErhzc=;
        b=A0MiyFddpyFuTHAgIm24ljX0OliA2LRGPrT4rgFhlZRP981ZJCrPmM/PDO50nc62e4
         N/rhxwgbehdppico+uJVvsRJT9GlYP2fKVHP5Z5MVJBKvayG6qoqv6UGA6nEHzSTWixQ
         vZPl1u5j1pdzi4AQ5mY7DvEaZ5G9CTraR628BLzAysBM8NxX0J7248dt1ctP3cdTGBdk
         4ki6077MMSTgRqm6lPK9P6tjua8ucbOZ/LQ0tqhWI+k64ZJkdSAkTbe9yA81/eW2enWE
         /K1jpszIdHOy5nZdvHh0BxyGIc/0mp5mALu5dh0nqHX8V6HzhYNVN3zUfH8SnB0eYmXo
         whDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=1RQK81eHkq8yc1kfeadt5EYNtBGoEuKdAYto1gErhzc=;
        b=fgugp6HAotYA3n52TL+XhVXq3Z1yyRgl0cjRlozau4XY+R2nDjLYZZ7q8UgsdtDiC8
         JSk0Mz4YFmSlrEQcRbeaJPxxsKAv6OWV4LBTUG7pKrEzQVpncxTCAQE36QCWpHMn9y+k
         aADYL30cA+BTVDua09hjbSHwKJ3JenYiQbOrPUWQaZehXMbEusb5B5sg3/T4IBCv5a6/
         skPMKOtaF/S+XkEhaSKDjs0EnlHir8Zne8l7ljH3iYdPvbZpIbm/R7l/98f5MRylRi/0
         oeT7QM1HGHrhl95uJnYNL0/USfyfcLqWa0sK8T8QeUbrTISWIAtiVmFEktVUy6Geg8eh
         Zl6g==
X-Gm-Message-State: AOAM531xS26NnyeNs92PAAVSWJDbUZaZNRUQ4fmPuJljspYoo5whXRTs
        XpuupoBxrGbnTEd5zAI5taA=
X-Google-Smtp-Source: ABdhPJygtYo9+UK8o8C4+DXRTtWC3sAw9KxKlFMCS9b4ib9pPE7diULd0c7YtsZYkelgaMh1SkiiFQ==
X-Received: by 2002:a17:90a:fd12:: with SMTP id cv18mr14477227pjb.66.1594537594990;
        Sun, 12 Jul 2020 00:06:34 -0700 (PDT)
Received: from saurav ([203.187.233.95])
        by smtp.gmail.com with ESMTPSA id g8sm10338465pgr.70.2020.07.12.00.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 00:06:34 -0700 (PDT)
Date:   Sun, 12 Jul 2020 12:36:28 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        gregkh@linuxfoundation.org, saurav.girepunje@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] Staging: comedi: driver: Remove condition with no effect
Message-ID: <20200712070628.GA18340@saurav>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove below warning in das1800.c
WARNING: possible condition with no effect (if == else)

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/comedi/drivers/das1800.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/comedi/drivers/das1800.c b/drivers/staging/comedi/drivers/das1800.c
index f16aa7e9f4f3..7ab72e83d3d0 100644
--- a/drivers/staging/comedi/drivers/das1800.c
+++ b/drivers/staging/comedi/drivers/das1800.c
@@ -1299,12 +1299,6 @@ static int das1800_attach(struct comedi_device *dev,
 			outb(DAC(i), dev->iobase + DAS1800_SELECT);
 			outw(0, dev->iobase + DAS1800_DAC);
 		}
-	} else if (board->id == DAS1800_ID_AO) {
-		/*
-		 * 'ao' boards have waveform analog outputs that are not
-		 * currently supported.
-		 */
-		s->type		= COMEDI_SUBD_UNUSED;
 	} else {
 		s->type		= COMEDI_SUBD_UNUSED;
 	}
-- 
2.20.1

