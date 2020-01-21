Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCABC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 11:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C38624125
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 11:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbgAULq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 06:46:28 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:42287 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgAULq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 06:46:27 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N5mSj-1jhyoV2BSN-017CgH; Tue, 21 Jan 2020 12:46:00 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>, Rob Herring <robh@kernel.org>,
        Emil Velikov <emil.velikov@collabora.com>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/etnaviv: only reject timeouts with tv_nsec >= 2 seconds
Date:   Tue, 21 Jan 2020 12:45:25 +0100
Message-Id: <20200121114553.2667556-1-arnd@arndb.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:mC7FeQHazeOL/EsiloGVwenBqO1CqSzKh9a3azedjzvSyEdynvt
 PTIDkCtpkmSAi0hqrYtN76EzktImZwsEkh0+c9a1+oN67MRE439lpwzjVi5IyhqBMsix/Vx
 ifIKxKovG+T653zcUc8vdD0nVKWHd8AxwwkoaF51DpPrCMvQ6d624FEzGnKgvuIAkIAFp4Y
 KI3camDDhBDgIB75lVIAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9P78OmeT3W0=:SH2hT2Gyde3yA/AfdHEewi
 9UYWvun/XZNKgNXHoEQkKw8tmTTgY1IFjtViM9tiCn20dQzXqDeKTUnw4/puATqhanXuGAjml
 4mqXuyhHPbPPmXmfKN7n14u1uY+0OHeWBp1ZAaUkkxdRYLeOjJfq57z2VhNnP813Dzhvoie0A
 ix6fxh9pb9aEyR9Z541+Vr9l5s+a/gX6TS2+0VuZrx4MhpEgsSYpkqFpXOCFN2kljTVjrYSA0
 SQSC24h5OGcq2HD2Y7GDBWzWkfWpABo5qm66hilTrfGxm89HZ3EHc01W3pe91YZ7U3hMSR3OW
 D62+2Itr5NXjtNhvjidNeBd2UcqLfu7VoymS0X895yV92hwNnZQOqVhOdawxYAcihXzeZOzov
 1UKwsZv9IFebv9faPCPdHG2CRkOsFbhx+kZK8ZOwddoaHS3/KePFQZE3i9675NdwnrUzvmq9N
 y0brONYTtiRHLfC079hEng50khqQG9Q3+9YicMrlQQwMTw2Tt2mncuQbXaAk1rPQjmm1enOLQ
 C70OKrGiQNCaR8YsPOTa48OJhh2syTB1wgi1WGrgScEyZpTmTTWCL2Sh9rkfUmPPEVbNJT26G
 XxlELPJs4QaCLaT26iGicdw0SKgPb2TEkO8cpAI51ghu0+XpVXgcUJW+A4J6smoNcq3GeX/J6
 WCCrlkbTCr0lY2B8MrgypKacuQjDqXPif5uwJmd2grONww6wMfrzoTFAqdyJxjVEOnPbNbrmD
 lFlPnGjmwnS/3xsCLTZrrR9u3EyM7Y1DVXMwe9LwSFzapRaJayFC9kqXk9KzLNQJhbD1SpdsD
 q4TN7NSZfSOQZoCHf32AOxAfg/6l5nStTyKH3Txx+cF3PkFqo7A8ZCeF5LJeJ094CiUhNKfc9
 oyoLcIVRJgqFsOVsDiDg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Guido Günther reported, get_abs_timeout() in the etnaviv user space
sometimes passes timeouts with nanosecond values larger than 1000000000,
which gets rejected after my first patch.

To avoid breaking this, while also not allowing completely arbitrary
values, set the limit to 1999999999 and use set_normalized_timespec64()
to get the correct format before comparing it.

This also addresses the off-by-1 glitch reported by Ben Hutchings.

Fixes: 172a216ff334 ("drm/etnaviv: reject timeouts with tv_nsec >= NSEC_PER_SEC")
Cc: Guido Günther <agx@sigxcpu.org>
Link: https://patchwork.kernel.org/patch/11291089/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 10 +++++++---
 drivers/gpu/drm/etnaviv/etnaviv_drv.h |  6 ++----
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 3eb0f9223bea..d94740c123d3 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -292,7 +292,11 @@ static int etnaviv_ioctl_gem_cpu_prep(struct drm_device *dev, void *data,
 	if (args->op & ~(ETNA_PREP_READ | ETNA_PREP_WRITE | ETNA_PREP_NOSYNC))
 		return -EINVAL;
 
-	if (args->timeout.tv_nsec > NSEC_PER_SEC)
+	/*
+	 * existing user space passes non-normalized timespecs, but never
+	 * more than 2 seconds worth of nanoseconds
+	 */
+	if (args->timeout.tv_nsec >= (2 * NSEC_PER_SEC))
 		return -EINVAL;
 
 	obj = drm_gem_object_lookup(file, args->handle);
@@ -358,7 +362,7 @@ static int etnaviv_ioctl_wait_fence(struct drm_device *dev, void *data,
 	if (args->flags & ~(ETNA_WAIT_NONBLOCK))
 		return -EINVAL;
 
-	if (args->timeout.tv_nsec > NSEC_PER_SEC)
+	if (args->timeout.tv_nsec >= (2 * NSEC_PER_SEC))
 		return -EINVAL;
 
 	if (args->pipe >= ETNA_MAX_PIPES)
@@ -412,7 +416,7 @@ static int etnaviv_ioctl_gem_wait(struct drm_device *dev, void *data,
 	if (args->flags & ~(ETNA_WAIT_NONBLOCK))
 		return -EINVAL;
 
-	if (args->timeout.tv_nsec > NSEC_PER_SEC)
+	if (args->timeout.tv_nsec >= (2 * NSEC_PER_SEC))
 		return -EINVAL;
 
 	if (args->pipe >= ETNA_MAX_PIPES)
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.h b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
index efc656efeb0f..3e47050af706 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
@@ -109,12 +109,10 @@ static inline size_t size_vstruct(size_t nelem, size_t elem_size, size_t base)
 static inline unsigned long etnaviv_timeout_to_jiffies(
 	const struct drm_etnaviv_timespec *timeout)
 {
-	struct timespec64 ts, to = {
-		.tv_sec = timeout->tv_sec,
-		.tv_nsec = timeout->tv_nsec,
-	};
+	struct timespec64 ts, to;
 
 	ktime_get_ts64(&ts);
+	set_normalized_timespec64(&to, timeout->tv_sec, timeout->tv_nsec);
 
 	/* timeouts before "now" have already expired */
 	if (timespec64_compare(&to, &ts) <= 0)
-- 
2.25.0

