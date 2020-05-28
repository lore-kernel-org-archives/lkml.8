Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A49C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45BDF207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="n/r/SPAx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407052AbgE1UWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 16:22:49 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:45192 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407005AbgE1UWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 16:22:47 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 49Xzdx6j7Jz9xglC
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 20:22:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JTk3Zt4qr7rS for <linux-kernel@vger.kernel.org>;
        Thu, 28 May 2020 15:22:45 -0500 (CDT)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 49Xzdx4yBFz9xgl6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 15:22:45 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 49Xzdx4yBFz9xgl6
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 49Xzdx4yBFz9xgl6
Received: by mail-il1-f198.google.com with SMTP id p81so317036ill.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 13:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=lZzscT/3tcOZEypZ6BQTFArab8a3rsRWz2aMbBGNpZM=;
        b=n/r/SPAxJuSK6fzuLRA6eJjLW0iM2cuBPBlKEL8+JItm7xpPxeeKpltDjRFQLjd+sE
         VG0u8BXmd9rM8TAj96CVt7aOJxRm7yH4mg0TcQrruvfUhaHPPFozE+uf/hqxVcEtoNpP
         tQB45hy+e7YbR/dgE4XVhhx2F9A/qxnGLys2O2ZCI2ESt9fd86FjRimwlzBS6rQ1GOvW
         y2MaXcewaEC82J7EkRCUboyqFW6XLK9fMfEcZVxDhViXZnRy1pUMrl/wzZXyF5vrxzbo
         DtwTHT/xlAR/Z06pC8XFK20NHNsYvea7fHoHogfGJAtD6E69XdHoYKz2vWX3PuQeMhv6
         3Kcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lZzscT/3tcOZEypZ6BQTFArab8a3rsRWz2aMbBGNpZM=;
        b=NI6MELXGxVaMToB0qGfEAvnn+FldN8nMKaMpR35fJVnVrjw1h861OGicYKYdH99vWg
         AQNS1uLpVWUiLSW7OTn7BSxInsur2VlJEkvFZ8lc7NW7Ji+nI0JzLzxsQA8MEQjAlAq5
         QezQrayj+hPUIwfdQrzpPC1LNFHOzxcUQwEsOL8rFRBoeOmMd/JDZElGCtE2yWBzZvQ/
         PR1Vmr/qBDHS2GiIcVAVkGPcJ2ubjlOdNXWwjBvbR2i4awvGqHSVcPEcWc9tBUyyPzRN
         2V+Y95YgvEIZdlmGIi4dT5ywfLDve2NGlKs03z+dYpZBqSPm2Q7+QNnr4LLGewWPJYmR
         EmIg==
X-Gm-Message-State: AOAM5308M/T/ZsZXTmM2RvHHK4d2t8HF4L6nID+ZxUeiVYWEiDpi4nFb
        LT0ndHQyuBesXz2H7fKzv5dFcnMPkItKJPM8x/mv0/X3wl0+6b91CYo1DhLjAvBhswLiSxsyOSV
        9jutOUB9d326UhMLiSg38ScKLojDY
X-Received: by 2002:a05:6e02:106d:: with SMTP id q13mr4563924ilj.107.1590697365252;
        Thu, 28 May 2020 13:22:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtz4ZMfSdIHu7TCUu1HOBH8M3fDQBiyTjl5Y37TBKLETKbukmvL0ZEh0Ivr/TiHQwRQOb6nw==
X-Received: by 2002:a05:6e02:106d:: with SMTP id q13mr4563906ilj.107.1590697364997;
        Thu, 28 May 2020 13:22:44 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id x22sm3731645ill.9.2020.05.28.13.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 13:22:44 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        Doug Thompson <dougthompson@xmission.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] edac: Fix reference count leak in edac_pci_main_kobj_setup.
Date:   Thu, 28 May 2020 15:22:37 -0500
Message-Id: <20200528202238.18078-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

kobject_init_and_add() should be handled when it return an error,
because kobject_init_and_add() takes reference even when it fails.
If this function returns an error, kobject_put() must be called to
properly clean up the memory associated with the object. Previous
commit "b8eb718348b8" fixed a similar problem. Thus replace calling
kfree() by calling kobject_put().

Fixes: b2ed215a3338 ("Kobject: change drivers/edac to use kobject_init_and_add")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/edac/edac_pci_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/edac_pci_sysfs.c b/drivers/edac/edac_pci_sysfs.c
index 72c9eb9fdffb..53042af7262e 100644
--- a/drivers/edac/edac_pci_sysfs.c
+++ b/drivers/edac/edac_pci_sysfs.c
@@ -386,7 +386,7 @@ static int edac_pci_main_kobj_setup(void)
 
 	/* Error unwind statck */
 kobject_init_and_add_fail:
-	kfree(edac_pci_top_main_kobj);
+	kobject_put(edac_pci_top_main_kobj);
 
 kzalloc_fail:
 	module_put(THIS_MODULE);
-- 
2.17.1

