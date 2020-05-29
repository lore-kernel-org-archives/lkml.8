Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F89C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 20:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E4A92074D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 20:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgE2UPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 16:15:52 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:40089 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbgE2UPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 16:15:51 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MAOa3-1jpzoR1Oqx-00BsNh; Fri, 29 May 2020 22:15:36 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Nirmoy Das <nirmoy.das@amd.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, kbuild test robot <lkp@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/selftests/mm: reduce per-function stack usage
Date:   Fri, 29 May 2020 22:15:26 +0200
Message-Id: <20200529201534.474853-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ho4Mq3U3EtYfgJFR+q7973027xSV2eRELOhe3ml5gCU4m/2NxjG
 UwhT06TUOtlUo0TML7Hgbve1EF9Pa25ivKXm39twJdLIYZMu9WdiZbOP/XQqo1CGtibwBdv
 s9wd3LzL6M9uv0/1NLtMw4W/rqPCpYbNfpenFzkGW3EJndjzP76/7MZK43q6dVvNUHo880c
 A5HmS83cgLYOALPtHFf1w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9vksc22pmvo=:P9XjhkE+Q3JWW5vZh3siuU
 ezOC3IX4ktHT9kZRx/6s6Hppi7WQWsH9w7QOkliZdzUXhXxic7ZRmNIU2qeiJikarCw2bI8H5
 vbKkVQchoJYirSJznL7jWKW9ZARqAEVdBHAr6MDpqku6u838ZyNp52zB7a2IJyePtkDd4CDvE
 LPHUY24SE6z1OFHQl4OXhXbXAFESWWQl88ZnfhjloIeDG6E39ii/64/VmmmRnf02N6kCqmxd3
 RP/7H+wwG5aN2/7YI1Z7dfOKjVIO3FBkv/SoCajVFRvOJGG8yP1tKIfuOIDgdPvjSIGjSlvG3
 3ob2my9I3PU0g22tAjMVAagjAGbt1QPUIDP9Hz8LBeaObegCW15UO1LUIP2jbzw10FGhzN9DA
 ILPtP+o27BwKaRk32/FuD/D7ed+w3HqbXEGy2wOXEcClLKSe1CURWgobJfKzl94mIyMkV4k04
 VbUNIGx07Ngg8/An3jz5Q54tijiAPToUuhRQkMMXOLATm7+hvsQs3ZHvfObEb5PpaerqFVjGY
 nVgRkkfRTWvOlwqbBd49Rri6vSTfbFdmjYh/4LQUwon7Y2e79V4rA3oWaEmpH7TkZoN7tlEEM
 bMCPfLF42BinIC28wN0x+6ieUqz+uWur2CfhFw5l/EIwEf/vmGJeBdMABEiNobKhq/R/JT+o+
 5UYBClvnphTH2sql5sPfKnrNdMli+7Z/Thp1a1a0CfeeHWS8R8mn10MfyoNk4pJcxJIKtHECk
 vCupWg2BVpwyfTCys96xRpGqM/DR7h4/9FaOTAWOvnVKHtKnKcYk7PKOsJ1GYOeF7xfBHko+n
 1lVLY/kBbRPg/7sGq+/5BqyXn4Q4R2btongqsymuZ52S7+8L3s=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The check_reserve_boundaries() function has a large array on the stack,
over 500 bytes. It gets inlined into __igt_reserve, which has multiple
other large structures as well but stayed just under the stack size
warning limit of 1024 bytes until one more member got added to struct
drm_mm_node, causing a warning:

drivers/gpu/drm/selftests/test-drm_mm.c:371:12: error:
stack frame size of 1032 bytes in function '__igt_reserve' [-Werror,-Wframe-larger-than=]

As far as I can tell, this is not nice but will not be called from
a context that is already low for the kernel stack, so just annotate
the inner function as noinline_for_stack to ensure that each function
by itself stays under the warning limit.

Fixes: 0cdea4455acd ("drm/mm: optimize rb_hole_addr rbtree search")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/selftests/test-drm_mm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/selftests/test-drm_mm.c b/drivers/gpu/drm/selftests/test-drm_mm.c
index 9aabe82dcd3a..30108c330db8 100644
--- a/drivers/gpu/drm/selftests/test-drm_mm.c
+++ b/drivers/gpu/drm/selftests/test-drm_mm.c
@@ -323,9 +323,8 @@ static bool expect_reserve_fail(struct drm_mm *mm, struct drm_mm_node *node)
 	return false;
 }
 
-static bool check_reserve_boundaries(struct drm_mm *mm,
-				     unsigned int count,
-				     u64 size)
+static noinline_for_stack bool
+check_reserve_boundaries(struct drm_mm *mm, unsigned int count, u64 size)
 {
 	const struct boundary {
 		u64 start, size;
-- 
2.26.2

