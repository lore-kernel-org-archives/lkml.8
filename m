Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245F4C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 13:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 042B5207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 13:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgA1NHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:07:31 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:39919 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgA1NHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 08:07:30 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MnWx3-1jOJIF2sWT-00jah4; Tue, 28 Jan 2020 14:07:14 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Lucas Stach <l.stach@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>, Rob Herring <robh@kernel.org>,
        Emil Velikov <emil.velikov@collabora.com>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "drm/etnaviv: reject timeouts with tv_nsec >= NSEC_PER_SEC"
Date:   Tue, 28 Jan 2020 14:06:13 +0100
Message-Id: <20200128130710.4154835-1-arnd@arndb.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jR2l1s+z5kbbpiXAPBoXFcIwZf1d5sfaUoAveWe7BXOdoM8VEhw
 MgtLRbEvnZniSJSRMdkKtieu1Wa6lGggNCLlnV0B10jUud1mKAT2sWe+un4QvDtf5O/YXnH
 ZaEARxTnOTBVv034KYNb033JOFXCxahqjlumSvV8INXhz+AWKX2L/FTQZJ3S2GqlJhR8T0z
 2SjvhbmJ66CsQEqxGKdxA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Gq/3jwAUlUk=:AkxXnmXnBxr4cx1PP6b973
 oECszSyCfZmYjFBZJoggzjJoUCLupIKeZSPfvp3g1cIlqkJ6AecfG35as/vxqLhYd5RTDj8pW
 z7qEp6rZNPfgcnteY5Koqf0zkh3hDXGuSywOz7BHNXsCyTLp+deCsM6MBUb9KE3vbE8w+wq+B
 nByeZe2bw/O2mtsPitLFsyaqUBn7duQKwFdacxTiZw1e+T9jZoBo8/XkVwVYsMEv0vfCXq8et
 54SHmxnWwprOoim8Y9HZiQH4XZV7fPDSE1wvZzkcsQv7ZqVVtj6doUCZh1JtCTvxe8JWeHrN/
 l0zc+nI3cIrPzuAi9eunD/bQDo4JMC4ZJZ06PllSuz7GsukujqCZ+8KLsisSvJT27yPJ2Fmm7
 dhdyM4sP/IwHr5Jd8AyFb3Hb/3tv1wsjndnUCCdB71E2aT/MgOrWTa2JfXz/x1X6GCMQoCN1G
 unZI+lEmQmVLfCip46hzCS6Z2EXChR/+p08d5CVQnl6AYBfd3SaegDjuqXsZDu+ygdNUEinEb
 u6FR5gwEkRshKdkKYqDJCVXV0JM1hGKPxiId5H9CTRPYQWr6d27WbUtC/N1oIMOKKp04GOaLN
 HmHw9lWM4h3K5PjgA0OUgpA/avrMED8JuzkeX+Fpa6uFqpaHk9eY8wTUwRlXDuLZe3v0KVIfG
 Gri+3+0y2pMnHdaU+00hEw2O8i5FKEWp7Al0Og1E7AH0r/pL1H5LTBmJAULbaETlCIILGnTTm
 mzMrK7tqEzN17l0yIIP2ZfcZFejU+E9E9zFfFzUep01XCMqbHUJFUmkOwhalysFNkG4LzfdFD
 mxpLhu4wKFPy+NB0mzqhfLLZIqvQMXSivUv+4jrqitLSyxgqjs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 172a216ff334ad869b0d74188a70763e4167fd9e.

Guido Günther reported issues with this patch that broke existing
user space. Let's revert it for now and fix it properly later on.

Link: https://patchwork.kernel.org/patch/11291089/
https://lore.kernel.org/lkml/20200121114553.2667556-1-arnd@arndb.de/
Cc: Guido Günther <agx@sigxcpu.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I've added this to my branch for inclusion in v5.6 to avoid the
regression.

 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 3eb0f9223bea..ac26c084f30d 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -292,9 +292,6 @@ static int etnaviv_ioctl_gem_cpu_prep(struct drm_device *dev, void *data,
 	if (args->op & ~(ETNA_PREP_READ | ETNA_PREP_WRITE | ETNA_PREP_NOSYNC))
 		return -EINVAL;
 
-	if (args->timeout.tv_nsec > NSEC_PER_SEC)
-		return -EINVAL;
-
 	obj = drm_gem_object_lookup(file, args->handle);
 	if (!obj)
 		return -ENOENT;
@@ -358,9 +355,6 @@ static int etnaviv_ioctl_wait_fence(struct drm_device *dev, void *data,
 	if (args->flags & ~(ETNA_WAIT_NONBLOCK))
 		return -EINVAL;
 
-	if (args->timeout.tv_nsec > NSEC_PER_SEC)
-		return -EINVAL;
-
 	if (args->pipe >= ETNA_MAX_PIPES)
 		return -EINVAL;
 
@@ -412,9 +406,6 @@ static int etnaviv_ioctl_gem_wait(struct drm_device *dev, void *data,
 	if (args->flags & ~(ETNA_WAIT_NONBLOCK))
 		return -EINVAL;
 
-	if (args->timeout.tv_nsec > NSEC_PER_SEC)
-		return -EINVAL;
-
 	if (args->pipe >= ETNA_MAX_PIPES)
 		return -EINVAL;
 
-- 
2.25.0

