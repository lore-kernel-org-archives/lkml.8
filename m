Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A8FC2D0E7
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 05:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B332074D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 05:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mX79wM0Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731752AbgDAFNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 01:13:53 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38142 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgDAFNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 01:13:53 -0400
Received: by mail-lf1-f68.google.com with SMTP id c5so19324568lfp.5;
        Tue, 31 Mar 2020 22:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=XMjp4N6SkBeomidPSlGof0y8W8f19f9rN+PDD5MSzR8=;
        b=mX79wM0Ys6iRYP7zbiZO2UTVcI0EFgfA7iO4H5EUpywt5FKdTbIRWKJo7ZcG2yorFI
         iRKEGTPtt3ifxvHSp6wG6utNKuzyWpivY0Sg9qISnsMyLJAQCl6MAGYt1xjShOVyXwvV
         Gr9jEJOyoGNqM7UhRDQG+8mIG8jmD8lIo7QMbIwIldn7xcutQ/DkmvF8kFcQDCInUYm9
         Mkyix0+uWtOeXV+mvq3FbKT7k3q3RQuHHd62Z3K7R4GbEWNGnQB05FpBU/lATAWm/8AW
         YUulKJMYDAgaBa3xtJLwr+7AowdOBwgLQlt54VkjRnlmnE/lojAbk1HC5PRa7oj1roZh
         dVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=XMjp4N6SkBeomidPSlGof0y8W8f19f9rN+PDD5MSzR8=;
        b=lvASAZ0arung9/gAZysdtRuRCaHVcGjUtzzEmFgnmjSZ9vr+GkFCwMOoHQoAe+DKR9
         AZGcimxkZa6WycCzNk2Xa7eJld8lA882bL0VChnchOV6btjErKmmYzbeoXp4rhor8WM8
         D8b0llrTRMCd85C4gvuJniqcPuV11U7IAmLO14mtx2uIYMDfD2w8CbLuV1QBb2rcLedi
         BAM5I5/ytMPrWSGKmVCin0q8yvIpQ5WrX9kycaO+gv0oiAl1GJpV/uf7AetFb9qK+3/e
         5oKdgnOIPhmsIH1ttQgtRwLnXO5RC5nzGr0U2dwpc4rjIBfE/IdoGmVVPlXbWfGbQ5C7
         CZEg==
X-Gm-Message-State: AGi0PuYCJm2kwLvGtTWyy5PlfVgePywbVDJrzqJLF5zUYzOjAZd78hUX
        FikEY2pbol6FU2Ej+YVTiJ5crTm+u4CsId9dtm0=
X-Google-Smtp-Source: APiQypIjpsODi91FVhgnbfbLT9/wj3HuTOXlQv/Ss9qaiw2mbZ747HdPkNwE2Ig/ZXUaS9X+IrwFGM7xhSvIpEIulR8=
X-Received: by 2002:a05:6512:3091:: with SMTP id z17mr14033512lfd.42.1585718030102;
 Tue, 31 Mar 2020 22:13:50 -0700 (PDT)
MIME-Version: 1.0
From:   "she90122 ." <she90122@gmail.com>
Date:   Wed, 1 Apr 2020 13:13:39 +0800
Message-ID: <CAMhTFwnDYz=SQsyT6yV+Whp6mQiCw7KTrgt-4oE3Ve3mvOKgxA@mail.gmail.com>
Subject: [RESEND,v3,1/1] EDAC: (pnd2) Change the return value of function
 apl_check_ecc_active() & dnv_check_ecc_active() when installed the non-ECC
 memory device.
To:     she90122 <she90122@gmail.com>
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Amy.Shih" <Amy.Shih@advantech.com.tw>,
        "Oakley.Ding" <Oakley.Ding@advantech.com.tw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amy Shih <amy.shih@advantech.com.tw>

Set function apl_check_ecc_active() &
dnv_check_ecc_active() to return -ENXIO when installed the non-ECC
memory device. And print the message in pnd2_init() accordingly.

Signed-off-by: Amy Shih <amy.shih@advantech.com.tw>
---
Changes in v3:
- Change the return value of function check_ecc when installed the
non-ECC memory device.
Changes in v2:
- Remove the word "error" from output message.

 drivers/edac/pnd2_edac.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c index
933f772..27172d7 100644
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -1089,7 +1089,7 @@ static int apl_check_ecc_active(void)
  for (i = 0; i < APL_NUM_CHANNELS; i++)
  if (chan_mask & BIT(i))
  ret += check_channel(i);
- return ret ? -EINVAL : 0;
+ return ret ? -ENXIO : 0;
 }

 #define DIMMS_PRESENT(d) ((d)->rken0 + (d)->rken1 + (d)->rken2 +
(d)->rken3) @@ -1111,7 +1111,7 @@ static int
dnv_check_ecc_active(void)

  for (i = 0; i < DNV_NUM_CHANNELS; i++)
  ret += check_unit(i);
- return ret ? -EINVAL : 0;
+ return ret ? -ENXIO : 0;
 }

 static int get_memory_error_data(struct mem_ctl_info *mci, u64 addr,
@@ -1572,7 +1572,12 @@ static int __init pnd2_init(void)

  rc = pnd2_probe();
  if (rc < 0) {
- pnd2_printk(KERN_ERR, "Failed to register device with error %d.\n", rc);
+ if (rc == -ENXIO)
+ pnd2_printk(KERN_INFO, "System is not using ECC memory\n");
+ else
+ pnd2_printk(KERN_ERR,
+     "Failed to register device with error %d.\n",
+     rc);
  return rc;
  }

--
1.8.3.1
