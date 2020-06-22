Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19644C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 07:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC0F120857
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 07:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=elastisys.com header.i=@elastisys.com header.b="jCqge3D6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbgFVH7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 03:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbgFVH7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 03:59:06 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9728C061794
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 00:59:05 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id c11so9026490lfh.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 00:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=elastisys.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+72HVS79yQlhaAUpl1BQ92pBtKAe/k4uQc7WSaUvr00=;
        b=jCqge3D6KoP/sIdIThN/DHv8XTHSxY/xJDbvFROYkEp5HxGRHew4puiSQD3ry7G87b
         UBY2DmEKrJ4dMkhtTOw0UHjZPbvGmjtxO+QYkUgo4vfw2gKXanYztqq5J6XcoNbgvj5+
         dy/jhBx9k1/RltLhcE02EVQJfMZiSdKukXWio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+72HVS79yQlhaAUpl1BQ92pBtKAe/k4uQc7WSaUvr00=;
        b=LOGx42GX2okUaoMQLvwna2+bF0UluTeaKIOIMuHT16MY/u0xYLL8aGStKnKot0PNAv
         Usn6mBP0/Shz6HmKWLQWRwPHjJgdx2OqaU4wjOiKJeZV9iBjhWsFKBgRHLTnS4xvmK0R
         4SUiUWfZz4C/9xqqxwNhBN0XvGNDm48QJnjRmS3kjvYMG1wACDRu+1rEqYOCPlWRxUGa
         zaDWCLl0N87TjP/SXYtkqg8T5Y8n39qu7q3yAI/3msuJusBwA4BJCMUPZO0hGE8SMjxX
         h/Hi4ttiMMjhET3+sAMOymEGvhbscNfVv3goC/KZdJVE1/Tka2hBI6IpdtwDOB9TYFGQ
         PGwQ==
X-Gm-Message-State: AOAM531EgwEUawwnqD9PMwJgCWcpZ41Lcgt6aYMfdAO6Dc/g2CzumaAE
        r6AyGjJwh6YuZgyXkjDsQrUpaQ==
X-Google-Smtp-Source: ABdhPJzIyS6pITV9AXVhsR6vURj//yrc+F7c8fH4PfDJ/YlnbkX/r3We1eWExkMnSuxvybu5Nsx6gw==
X-Received: by 2002:ac2:5e6c:: with SMTP id a12mr9124696lfr.35.1592812744344;
        Mon, 22 Jun 2020 00:59:04 -0700 (PDT)
Received: from minitrue (90-224-48-115-no56.tbcn.telia.com. [90.224.48.115])
        by smtp.gmail.com with ESMTPSA id v23sm2568173ljg.122.2020.06.22.00.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 00:59:03 -0700 (PDT)
Date:   Mon, 22 Jun 2020 09:59:02 +0200
From:   Cristian Klein <cristian.klein@elastisys.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the hid tree
Message-ID: <20200622075902.GA24615@minitrue>
References: <20200621075124.206aeeea@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="K8nIJk4ghYZn606h"
Content-Disposition: inline
In-Reply-To: <20200621075124.206aeeea@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 21, 2020 at 07:51:24AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   470376737e88 ("HID: allow building hid.ko as an external module")
> 
> is missing a Signed-off-by from its author.
> 
> -- 
> Cheers,
> Stephen Rothwell

Hi,

My bad. Please find attached the corrected patch.

Cheers,
Cristian

--K8nIJk4ghYZn606h
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-Allow-building-hid.ko-as-an-external-module.patch"

From 8005724373d8cecb241c013d16b2242c7c1fb39e Mon Sep 17 00:00:00 2001
From: Cristian Klein <cristian.klein@elastisys.com>
Date: Mon, 22 Jun 2020 08:47:58 +0200
Subject: [PATCH] Allow building hid.ko as an "external" module

For quickly testing USB HID quirks with a larger community, it is useful
to be able to build hid.ko as an external module, e.g., against the
source code of the running kernel.

Before this patch this failed as follows:
```
$ make -C /lib/modules/$(uname -r)/build M=$PWD/drivers/hid
make: Entering directory '/usr/src/linux-headers-5.3.0-51-generic'
  CC [M]  /home/cklein/linux/drivers/hid/i2c-hid/i2c-hid-core.o
  CC [M]  /home/cklein/linux/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.o
  LD [M]  /home/cklein/linux/drivers/hid/i2c-hid/i2c-hid.o
  CC [M]  /home/cklein/linux/drivers/hid/intel-ish-hid/ishtp/init.o
  CC [M]  /home/cklein/linux/drivers/hid/intel-ish-hid/ishtp/hbm.o
  CC [M]  /home/cklein/linux/drivers/hid/intel-ish-hid/ishtp/client.o
  CC [M]  /home/cklein/linux/drivers/hid/intel-ish-hid/ishtp/bus.o
  CC [M]  /home/cklein/linux/drivers/hid/intel-ish-hid/ishtp/dma-if.o
  CC [M]  /home/cklein/linux/drivers/hid/intel-ish-hid/ishtp/client-buffers.o
  LD [M]  /home/cklein/linux/drivers/hid/intel-ish-hid/intel-ishtp.o
  CC [M]  /home/cklein/linux/drivers/hid/intel-ish-hid/ipc/ipc.o
/home/cklein/linux/drivers/hid/intel-ish-hid/ipc/ipc.c:12:10: fatal error: client.h: No such file or directory
   12 | #include "client.h"
      |          ^~~~~~~~~~
compilation terminated.
make[2]: *** [scripts/Makefile.build:290: /home/cklein/linux/drivers/hid/intel-ish-hid/ipc/ipc.o] Error 1
make[1]: *** [scripts/Makefile.build:519: /home/cklein/linux/drivers/hid/intel-ish-hid] Error 2
make: *** [Makefile:1656: _module_/home/cklein/linux/drivers/hid] Error 2
make: Leaving directory '/usr/src/linux-headers-5.3.0-51-generic'
```

Signed-off-by: Cristian Klein <cristian.klein@elastisys.com>
---
 drivers/hid/intel-ish-hid/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/intel-ish-hid/Makefile b/drivers/hid/intel-ish-hid/Makefile
index f0a82b1c7..db4974c43 100644
--- a/drivers/hid/intel-ish-hid/Makefile
+++ b/drivers/hid/intel-ish-hid/Makefile
@@ -23,4 +23,4 @@ intel-ishtp-hid-objs += ishtp-hid-client.o
 obj-$(CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER) += intel-ishtp-loader.o
 intel-ishtp-loader-objs += ishtp-fw-loader.o
 
-ccflags-y += -I $(srctree)/$(src)/ishtp
+ccflags-y += -I $(src)/ishtp
-- 
2.20.1


--K8nIJk4ghYZn606h--
