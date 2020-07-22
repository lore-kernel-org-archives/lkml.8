Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA51AC4346B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 11:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7A0120792
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 11:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blnhOXIR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732256AbgGVLEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 07:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729064AbgGVLEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 07:04:23 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0664DC0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 04:04:23 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a15so1460740wrh.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 04:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=OCy4M+IerAUwrGq+R10RYFBywYGUc8/udZhkNLn8gcA=;
        b=blnhOXIRlgBIHslJnR+DyX3qRw0egROpKwj7Y0Zkk0MMdUtpreXtgx75Kq1wPrfpcw
         YT0xqBP0X9bvfkLrjDAjTmnTxzFZrZQIvAqUg6rrrRMpE1+2Am8fg/BMXJTPLpUCrRHG
         WG4KDPcO+AnnCn+WJph8oQSDcEQOtFVBnYkClbRvOg2bqXfvK2yeOn1d/J2s59wzpd0b
         VTw1CPE1C6poESLQsUVR+9mx8lbuqnKWymfrOoz608Ea4C1gFhgHQ1OA0EBcrOP2hpnE
         2Z07LwLiO83BYhupbyWqS0g8hcUHHqXlNFYa0FOnBXmju5sMmeNIWSPap5YxzMnH1UeX
         n0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=OCy4M+IerAUwrGq+R10RYFBywYGUc8/udZhkNLn8gcA=;
        b=Mc9dCG7d+wS0lzUm7bVrMVmSvoordyyrxIn+slHaG6921MIcSvpgYcEbaoHpKK3DEO
         wdGWducVgsFi3a3QsrWPBrs16bkRtQdHyIhA8r7MVKGCuCcrv6YGKyy5iHHF4ymcBLrl
         MdtGzwz7zjTOKkDPnMHdBj5DwIsvctTk6brwszWBkKyCRoSSnyfm+umPpRv25jCyvdFv
         0zkz5OGqhaP30I5n4P+VaeIqPmN/6gdZCx7n2mKxudoKkibT/6O2ioVeE0Nnjtwc5DOR
         3bIhxJE/3X7jwnf+BdjIaFFJCU6cDfcmpBomBf11c8Jz/2CxkfkWWp68KuAXpKvpsTPO
         mV/g==
X-Gm-Message-State: AOAM530FgtPxffUNg0y9gVUWOKkjPYjOuxuSnaocyCrG7Np8s7xGolEe
        HpgUV2Lh/z7lPx2SQAMDrcTFTS1ybIQ=
X-Google-Smtp-Source: ABdhPJyen9XQxbMOmxYyIRo9xkcOiFhcP/BsUcVILGQr7xM0UXW3SkKzFeItTtT4WGFXCvo6Y3Wceg==
X-Received: by 2002:adf:ea06:: with SMTP id q6mr29366083wrm.69.1595415861662;
        Wed, 22 Jul 2020 04:04:21 -0700 (PDT)
Received: from smtp.gmail.com (a95-92-181-29.cpe.netcabo.pt. [95.92.181.29])
        by smtp.gmail.com with ESMTPSA id t2sm6735027wma.43.2020.07.22.04.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 04:04:21 -0700 (PDT)
Date:   Wed, 22 Jul 2020 08:04:11 -0300
From:   Melissa Wen <melissa.srw@gmail.com>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com, twoerner@gmail.com
Subject: [PATCH] drm/vkms: add missing drm_crtc_vblank_put to the get/put
 pair on flush
Message-ID: <20200722110411.ebkv6knvc6mzw5uf@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a missing drm_crtc_vblank_put op to the pair
drm_crtc_vblank_get/put (inc/decrement counter to guarantee vblanks).

It clears the execution of the following kms_cursor_crc subtests:
1. pipe-A-cursor-[size,alpha-opaque, NxN-(on-screen, off-screen, sliding,
   random, fast-moving])] - successful when running individually.
2. pipe-A-cursor-dpms passes again
3. pipe-A-cursor-suspend also passes

The issue was initially tracked in the sequential execution of IGT
kms_cursor_crc subtest: when running the test sequence or one of its
subtests twice, the odd execs complete and the pairs get stuck in an
endless wait. In the IGT code, calling a wait_for_vblank before the start
of CRC capture prevented the busy-wait. But the problem persisted in the
pipe-A-cursor-dpms and -suspend subtests.

Checking the history, the pipe-A-cursor-dpms subtest was successful when,
in vkms_atomic_commit_tail, instead of using the flip_done op, it used
wait_for_vblanks. Another way to prevent blocking was wait_one_vblank when
enabling crtc. However, in both cases, pipe-A-cursor-suspend persisted
blocking in the 2nd start of CRC capture, which may indicate that
something got stuck in the step of CRC setup. Indeed, wait_one_vblank in
the crc setup was able to sync things and free all kms_cursor_crc
subtests.

Tracing and comparing a clean run with a blocked one:
- in a clean one, vkms_crtc_atomic_flush enables vblanks;
- when blocked, only in next op, vkms_crtc_atomic_enable, the vblanks
started. Moreover, a series of vkms_vblank_simulate flow out until
disabling vblanks.
Also watching the steps of vkms_crtc_atomic_flush, when the very first
drm_crtc_vblank_get returned an error, the subtest crashed. On the other
hand, when vblank_get succeeded, the subtest completed. Finally, checking
the flush steps: it increases counter to hold a vblank reference (get),
but there isn't a op to decreased it and release vblanks (put).

Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_crtc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index ac85e17428f8..a99d6b4a92dd 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -246,6 +246,7 @@ static void vkms_crtc_atomic_flush(struct drm_crtc *crtc,
 
 		spin_unlock(&crtc->dev->event_lock);
 
+		drm_crtc_vblank_put(crtc);
 		crtc->state->event = NULL;
 	}
 
-- 
2.27.0

