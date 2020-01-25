Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B582CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 13:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 829892071A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 13:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="utalDz0D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbgAYNPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 08:15:42 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43247 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgAYNPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 08:15:42 -0500
Received: by mail-pg1-f193.google.com with SMTP id u131so2623524pgc.10
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jan 2020 05:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=3QVXWFxwGX7QiCNvy96Dga4mKxwmEj2CJq1V24a5GDQ=;
        b=utalDz0DtbPvdQB+fVEPFCD9uAV+diqbxtaE6nLAPAT4Rv551mgKHVL52z54ilOP+j
         4NdcGGy4Iu8oF+pQNUPDtS2yL8kLE8H3HxIniwYOhxp/9iBOjDanzLIe8WSpyQbuWuFv
         pQ1eFhZINDOMd9Y6XOi8/9/pWlyVR5D9FynQbAWlV1+2hE1YJqWkBT4hDHnastA81fhF
         M2KvZwldi1zv1Srpm9cUteUYxO5Ylxvd5WbQhVX3I4wZfePzgtz0LZmb16gUguApSH5B
         KKcGGB0tZHazknx1GB/9swxz927Sw3gZsZsQSpCirB9JeI8mUN3bxlxe1/GXAUNf6Snl
         5bBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=3QVXWFxwGX7QiCNvy96Dga4mKxwmEj2CJq1V24a5GDQ=;
        b=XV500P8HxyGf4iCFgZIlo7G9rw+UOs1G9ZKjlIrvXMa1wm234JAt9WYNis6SRWHNbW
         tA6PNlC6r80boBc44a54Gcm/DG6zvENL23YkMdwPxOFe56k77o3FbZOfeTx3yRQ/bMmS
         zcNLzixho/eWtvFPWYqGXrkfNPOueAfg2BhkwP6I8m8yfUUgVGwLp5DPrtvZ6k4bHD9v
         HC/q4ihefS4gcHjT0lLG7mN1gE8s4mUiv4Nk0FTtCGn6z8pcd77qm2m4Qq89ODPQt3Iy
         VNnv9FjAI65SwhfSdl0gR5S0jzwmmdqIJ9IXvNQ/4NKVclAKNlyYNBtGV/qsMCrQTQYt
         K6sw==
X-Gm-Message-State: APjAAAV2+buzf5HySpHbSRrVJSVxz8d/St1pTe1CjUKcHa0lz44k0mpO
        ihUDe7BvMYv4oN7KNObQYo0=
X-Google-Smtp-Source: APXvYqz8fKPgyFBdtF4tRUmTiUa5qf+2L3gDnSZV4kLyc14yiXiCILJRmIvrCRDA3OsHpTeJ+oOfyQ==
X-Received: by 2002:a63:34cc:: with SMTP id b195mr8099939pga.268.1579958141494;
        Sat, 25 Jan 2020 05:15:41 -0800 (PST)
Received: from google.com ([123.201.163.7])
        by smtp.gmail.com with ESMTPSA id c34sm9859242pgc.61.2020.01.25.05.15.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 25 Jan 2020 05:15:41 -0800 (PST)
Date:   Sat, 25 Jan 2020 18:45:35 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     hsweeten@visionengravers.com, gregkh@linuxfoundation.org,
        saurav.girepunje@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: comedi: drivers: fix condition with no effect
Message-ID: <20200125131535.GA4171@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.6.2-neo (NetBSD/sparc64)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix warning reorted by coccicheck
WARNING: possible condition with no effect (if == else)

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
  drivers/staging/comedi/drivers/das1800.c | 6 ------
  1 file changed, 6 deletions(-)

diff --git a/drivers/staging/comedi/drivers/das1800.c b/drivers/staging/comedi/drivers/das1800.c
index f16aa7e9..7ab72e8 100644
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
1.9.1

