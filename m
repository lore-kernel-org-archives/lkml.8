Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F800C33CA4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 15:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA1AC2080D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 15:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgAJPSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 10:18:40 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:53071 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbgAJPSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 10:18:40 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N4hex-1jrPza1LRH-011kch; Fri, 10 Jan 2020 16:18:09 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] i915: ggtt: include asm/smp.h
Date:   Fri, 10 Jan 2020 16:17:54 +0100
Message-Id: <20200110151807.2863347-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TdcCHNFfPiGJRLCq5binja0aFvhBJCOv8HRjm9+CE0MRaD/kmMC
 PxXlULSPhYzQYQk03k8vMnd9nBMyr/MQ5Ld3cz5W0g5CjnEA7pi41yBIkZ1AkBpPFsw99F3
 Q/9+SvoAR7bFeo2nssLIBt3H4TiAfDbX7gITxGA5/KZkL+UovBR7u8q60XPNB+DBz1aKUp/
 63h81eSnqzapgQkIIIeTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yO1slOsO/lk=:87iYLgBH6h0Q6+CY11Wgsh
 lXJDfAj9Z+L1mAm8zO//lZUSEfS885uQ3rtWp/fa3y4eAKLjJ31p58KgveFCmH8z3Cf5AOrL5
 LRkBRSeoIOVKfocu7It03ZHE3z5PaBq4NLbzbLDo6uTtmllJFMzkICYoYMRY+nJUjvNtLM7mh
 +pfK6RIWclprMq/CnxcXTt3bU9SvSh0ALmi+UdPt/VdS8cF5JLqABH8bVhSe33BJxYfCDJwGG
 yenDzMlBwAMw9D0VS1O4LND5LDtXfph2MqIgHXyjgsH6ShpDJZcFivCVbSXGP01Vbowq1aKI7
 YYRi5TXSnMewvbB07STL5AubGrVvM0boRbQ/meCeF5WG5t9HnR/Iax4h5Zpt7VlueEQ3upzxh
 j3KtF/IpmJ/e7BFU21fx025On/9lhDZVHKcCqtijoWAInG0juY/xoogs+Rvw/YzD6vAyoEggi
 p0CKQ3orLrhp7mwExGFhb/I+NVmtlq2xxttVdaO2dUqcHHaoOLoC41vm4pgJ3YkZtUbh8c/YZ
 ETS5wmA4144bEDx0tjWVf0Uqphv2f0kuj1l+8K+OYm4fLRVlT/XbO7GwCNh28FnkZursKWk0r
 5TvGSZKIPGUtgbLDKRCKAEPdJtBH1RERjYz6Fo/TJR9k/sFks9tZ7wT0dz3XEDb4J3CmmhHRg
 rXyQ9hBYChP04LW4prCaCox9WLCkyELnJWF7MYfoePDn+wcEyO7nPi3TNprvPJEmYyMBgU9wY
 CnfTFMxERtodVZJiJ+QNopuj6uBjoYrkpqM4D8EDtNIaHLmKhnDwB+VyJtcM+FLjSuifDiBvS
 TS7ed0v0h8yiOLRGlK/7vitAzB3iC9bPilS2XRke3o15Ba9KBIljFk0v/xo2+R23iheHnWzvq
 5/yeWvvJoKi8sTYAgWLw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Splitting up the i915_gem_gtt caused a build failure in some configurations:

drivers/gpu/drm/i915/gt/intel_ggtt.c: In function 'ggtt_restore_mappings':
drivers/gpu/drm/i915/gt/intel_ggtt.c:1239:3: error: implicit declaration of function 'wbinvd_on_all_cpus'; did you mean 'wrmsr_on_cpus'? [-Werror=implicit-function-declaration]
   wbinvd_on_all_cpus();
   ^~~~~~~~~~~~~~~~~~
   wrmsr_on_cpus

Add the missing header file.

Fixes: 2c86e55d2ab5 ("drm/i915/gtt: split up i915_gem_gtt")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I ran into this bug a few days ago on linux-next. Please just ignore
if it's already fixed in the meantime.
---
 drivers/gpu/drm/i915/gt/intel_ggtt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/gt/intel_ggtt.c b/drivers/gpu/drm/i915/gt/intel_ggtt.c
index 1a2b5dcde960..9ef8ed85a738 100644
--- a/drivers/gpu/drm/i915/gt/intel_ggtt.c
+++ b/drivers/gpu/drm/i915/gt/intel_ggtt.c
@@ -6,6 +6,7 @@
 #include <linux/stop_machine.h>
 
 #include <asm/set_memory.h>
+#include <asm/smp.h>
 
 #include "intel_gt.h"
 #include "i915_drv.h"
-- 
2.20.0

