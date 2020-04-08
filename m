Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4605C2BA1B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 19:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A2BD2072F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 19:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbgDHTPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 15:15:13 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:57817 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbgDHTPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 15:15:13 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MG9Xu-1jW9e42yUO-00GXX9; Wed, 08 Apr 2020 21:15:00 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jcrouse@codeaurora.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Rob Clark <robdclark@chromium.org>,
        "Kristian H. Kristensen" <hoegsberg@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm: fix link error without CONFIG_DEBUG_FS
Date:   Wed,  8 Apr 2020 21:14:22 +0200
Message-Id: <20200408191458.1260397-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fdpx1d/DLJfitrFpYrv8Gkkt6VAi33wDZasxO8tqJ48cXnNukcc
 VB/q8aFUWkBATecQB02IKtYojv/7l+Y0/mI+xOkGkohuj0ZY4xA6z2cp4m13/z+BJ0uyHvn
 yA6d6TySZK/ah969Kwpn8hB3N5sX/O/4aiSFnMFZXs2FeFCV0pXCA3Gg2HWS8es86yMdTJp
 UwUjR8Rc/Y7boiWmcahiA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kF1greHftFI=:ivJ7OWNComZDWHcSPqHuVF
 fQMfSIdFDMDjxV7GJQtasTwesVIjnbxOV3ownNUKiWq7W4MmZ4/XEbw1+54eOK8dO2yRHdFAO
 NEVksE9tiSX25TanxKVRdD6CudBu/Y4jb5750M3LUoD2vwOvlf16CjXqNdWh2APT8ZuibJWvE
 o2tiuVNIucvkYERGk4fSWF6wsu7u1O6Po2lCq30E1NjRMTE5Dwa63rtXtiik5SX/Ukx9wqGHe
 gST/LpfRaMbauz6fxk4xCxEW/If7kUB50d1Ls3zpWQXZTPQckX2Jgk8zN0X9243OLFs7Gwaje
 GrRasgfxmZW9uqthJzj6odDkV/EWXn8e01lHb6iHK2+Rqm5xcBGZnGXpLf1lqjXOjcURmPIjt
 7jxvVts3EpHJ3CmN7su87024TaZeiU/63E8KScvBXle7nRZW/gubk+dyYhx4L3D+lr/IXNqS5
 ZUylcVDrWpAiW58UFyVbUl1q4o3BArcu1ZeKrgFNMAMg1BAyz63jlrXCUJOTOS/g3Mw+ebBMB
 QKPemHcn1TsdD5CXVQC+paAf2IfcdxBfzAgr7PDkF1qkeyFr4lESb3zWerIJhuX98S2V/IKOm
 2pjVCNR+I9/mnFscvygahOdh3eFe2wPgL2vKAV7vY+HlKEkr3f9H3Pep+SOCXVcyM7vzvoRyh
 1+PRFyl4gOalwGSgcG7klIUbrVX4krfAT9sfWE+3e4KJLoRuGA4wzROscPdwN9Y7Lm8UfJkic
 33UsM8NfMjkjuZc9EMwc8xbAvdckusmkA6IKvS/oUimisy+sB0pAxBbYwuh121fspv3WeZ3qX
 KmQQTuYd2KN8PuaOJPPaDdfSswvNBaI3+baHmXL7eWV9VhnvUY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I ran into a randconfig link error with debugfs disabled:

arm-linux-gnueabi-ld:
drivers/gpu/drm/msm/msm_gpu.o: in function `should_dump': msm_gpu.c:(.text+0x1cc): undefined reference to `rd_full'

Change the helper to only look at this variable if debugfs is present.

Fixes: e515af8d4a6f ("drm/msm: devcoredump should dump MSM_SUBMIT_BO_DUMP buffers")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/msm/msm_gem.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index 30584eaf8cc8..eb4aeaf291ea 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -167,7 +167,10 @@ static inline bool
 should_dump(struct msm_gem_submit *submit, int idx)
 {
 	extern bool rd_full;
-	return rd_full || (submit->bos[idx].flags & MSM_SUBMIT_BO_DUMP);
+	if (IS_ENABLED(CONFIG_DEBUG_FS) && rd_full)
+		return true;
+
+	return submit->bos[idx].flags & MSM_SUBMIT_BO_DUMP;
 }
 
 #endif /* __MSM_GEM_H__ */
-- 
2.26.0

