Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00C9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 06:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BC232067D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 06:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foy66+GK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbgF3GDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 02:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgF3GDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 02:03:07 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB75C061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 23:03:07 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id dp18so19234887ejc.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 23:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=EQD1bFwrLDnCLEnmgIyqsRXwmZjYXtc7//XWLwadNSE=;
        b=foy66+GKYBpuHqY/QElQJV7z2X5WD0AEJ6cPUdaT3FRpJ6tWtKriP6i/hwMww8xFsO
         QpaygkSG8C5ftwo3TmL4XFdpxUqNfbeOYXxhG2axAWvMfw2uXw5PnvN3b5q0iLHP73Bm
         EfpKC79geBMGz9Nf0BPZmcZEtlwt6YmrYtM/s0V9E0Uk0e5wLbw+QZQwc+aeXBnTSwSF
         X0W1OIuyOi4UI8BPOD26eVTIi0RS1J/v+G5+ouSaz0igX5d+4Cq9HmsJFRF3Cb2ppN5y
         M0N/IY3QKD4zrUPTtKF2x6305e1BCC+mWdTy05yu/6kEEjmaUAjlHIt9nsEYIWAodw9Z
         FnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=EQD1bFwrLDnCLEnmgIyqsRXwmZjYXtc7//XWLwadNSE=;
        b=rQcporL46cXRhFfLBnKF79iRGYsWlXy5PK8842A2nxZmie09CtumS8cNkEu9PQH/g+
         h0GtMXr78pH6bFCVRIkTBi1v8XYlc8OjsqOezR6kni45EfT2YINm9Ow1E7h4Zj3bhuAt
         1lPRWCTMM5iw3dw9CwPHOueC+OFSmrx+2erNbClGia1etJkCA3uZnlRKJGqkttqwEHJx
         uTT2KQEklSCCGVpVOFa9zrm8ml2oThTrty3EnNjA7+eZREa4DIxVWnVvzyzbeuQJ/+8G
         CojDzWtLvk9sSCiR2/ofSUAMcI8d36piSi/QorB6g2Wq4aYGzMW7KvkHIEMMzylEeqRX
         N2sw==
X-Gm-Message-State: AOAM530oNZdxC0jDT8PZlcGIBA8+9UaOR1ozv9N9MXxpFGT0RV8T9BXw
        KUGnqDOn6iFaZ7UHNDzsljyE4+LQ
X-Google-Smtp-Source: ABdhPJwAF8f/rg1wetky0kH6Oy/tsv9I2rLXjaf75ITfq9FZBjZ5vUt3BnUqkx0Y7uCCx+iy6xH4oA==
X-Received: by 2002:a17:906:3282:: with SMTP id 2mr16336199ejw.93.1593496986141;
        Mon, 29 Jun 2020 23:03:06 -0700 (PDT)
Received: from limone.gonsolo.de ([46.114.35.110])
        by smtp.gmail.com with ESMTPSA id v27sm1163417ejg.36.2020.06.29.23.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 23:03:05 -0700 (PDT)
Date:   Tue, 30 Jun 2020 08:03:01 +0200
From:   Gon Solo <gonsolo@gmail.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, Hawking.Zhang@amd.com,
        tao.zhou1@amd.com, Dennis.Li@amd.com, guchun.chen@amd.com,
        tom.stdenis@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org
Subject: Unused lines
Message-ID: <20200630060301.GA108674@limone.gonsolo.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

Are the 147MB or 1.6 million(!) lines in
drivers/gpu/drm/amd/include/asic_reg really necessary? I grepped a few
of them and they don't seem to be used, neither in the kernel nor drm or
mesa. As an example I removed one of the unused lines (see the attached
patch) and the amdgpu driver seems to build just fine.

Cheers,
g


--+HP7ph2BbKc20aGI
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-Remove-unused-line.patch"

From 6dbc3e4d129ce46f952c8365f6ca22b2e1aaa33b Mon Sep 17 00:00:00 2001
From: Gon Solo <gonsolo@gmail.com>
Date: Tue, 30 Jun 2020 07:47:12 +0200
Subject: [PATCH] Remove unused line.

---
 drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_6_1_sh_mask.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_6_1_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_6_1_sh_mask.h
index 29af5167cd00..d45bd18a05dd 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_6_1_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_6_1_sh_mask.h
@@ -24,7 +24,6 @@
 
 // addressBlock: nbio_pcie_pswuscfg0_cfgdecp
 //PSWUSCFG0_VENDOR_ID
-#define PSWUSCFG0_VENDOR_ID__VENDOR_ID__SHIFT                                                                 0x0
 #define PSWUSCFG0_VENDOR_ID__VENDOR_ID_MASK                                                                   0xFFFFL
 //PSWUSCFG0_DEVICE_ID
 #define PSWUSCFG0_DEVICE_ID__DEVICE_ID__SHIFT                                                                 0x0
-- 
2.25.1


--+HP7ph2BbKc20aGI--
