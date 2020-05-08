Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A08DC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 22:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7946E214D8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 22:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgEHWDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 18:03:09 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:42367 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbgEHWDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 18:03:08 -0400
Received: from localhost.localdomain ([149.172.19.189]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MCsgS-1jOPdr2RNo-008sQA; Sat, 09 May 2020 00:02:03 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ira Weiny <ira.weiny@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Andy Lutomirski <luto@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Chris Zankel <chris@zankel.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Helge Deller <deller@gmx.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Huang Rui <ray.huang@amd.com>, Ingo Molnar <mingo@redhat.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: vmwgfx: include linux/highmem.h
Date:   Sat,  9 May 2020 00:01:31 +0200
Message-Id: <20200508220150.649044-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TAKq1R05pzqZudtB3/eJjJKa8Xbr2qqNSVjJes2lRdzfJo28ior
 jpG2oBKBCIM9I0meRg4Do/dfII5ARO/ZpAAObB5iNU3iCCuxDZGC9ur9gy/e8/N5KH40xtl
 zubxBxUZ2TAxp6I2EEFhblKzvIbDSX2HvY1w7/WTEtxBhmU5S1+U1tGYNScR9bWvVvA9Lwt
 SUVJX3OpN5y1qagavtf6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pQ7ZCJSaxLY=:CvneInVbDCF7wVcYheL91B
 bulOWg0njJ2uR9LvROcwWe/vwyNzxp5K6WfdXMFHBwEkfhTNw0bVcxvD8IrSFpD0KC8TviK3o
 2mf/G8Dp7vGxGjScYm3LYde4pML/2dOUn9jiACrP7euRObZ2ijeOmEhl7jDEy27owpQao6o2f
 /SO03TB54PKwjk02/NXDsKOt4s7Vlel69d5geccRqk/dbPKsFx8eNeNQ70KZvuXUCYo+4gVNq
 AyrJYxx33AFDDBvjdTHUp8WSM6BvmQY8xW8tmCKPFZ/OY3h4XDKYApKCqQcok9vc/Qo/vaGhs
 Cy4G1g/dwFG7OyX+Lzq0K7xNNA1ZNy7YHIwqeqk0Kux4fHCq1lYpEGJqCsjRZ8zv5LJpjF4S2
 7p3LKoai6c/b8gZZJsch7W0e69UvHCI8bPdzFlRuGC7rm0ykWB4NZuqLTBuIC/HlzC9Z+kAId
 aBhvtAWagKCUIX31Q2v8+S47zcy1i2Z7zC+nzpqp3TUXriMCajRt6Kg+rQkJdIQhxFj4HX+jd
 rcSxAvUskYewdmUfBkJAQ2hiaX28j3DARTaEFxcJRbZdL2FCMy19Ug0uF0zjogz2OxmG2Uqkr
 4diBlDY9L7RHRrP3Hfb1MvdUSmkkFobkFN3S/ePNCydC65ZSo35zuFVrC7nvJguXY4+X0LBBM
 0Kr81poPPMNRnAsqTGRyZTs6vUqrzVL99DXoxms9mSGpDdIlNAzAvd3gqYwC/y7Ucy7HAA+YU
 3LyKV0Rosfc327PpqLHUs9jXHfSB+As31A6g12Nkokh9AIYp17vU1b8xjoLwZtQf1wF1C7YSD
 0MBAFq4u699ZjeZp0+NmUAQBJjY3JBFW0XlU185Wm7IMJzeY7w=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to call kmap_atomic() etc, we need to include linux/highmem.h:

drivers/gpu/drm/vmwgfx/vmwgfx_blit.c: In function 'vmw_bo_cpu_blit_line':
drivers/gpu/drm/vmwgfx/vmwgfx_blit.c:377:4: error: implicit declaration of function 'kunmap_atomic'; did you mean 'in_atomic'? [-Werror=implicit-function-declaration]
  377 |    kunmap_atomic(d->src_addr);
      |    ^~~~~~~~~~~~~
      |    in_atomic
drivers/gpu/drm/vmwgfx/vmwgfx_blit.c:391:5: error: implicit declaration of function 'kmap_atomic_prot' [-Werror=implicit-function-declaration]
  391 |     kmap_atomic_prot(d->dst_pages[dst_page],
      |     ^~~~~~~~~~~~~~~~
drivers/gpu/drm/vmwgfx/vmwgfx_blit.c:390:16: warning: assignment to 'u8 *' {aka 'unsigned char *'} from 'int' makes pointer from integer without a cast [-Wint-conversion]
  390 |    d->dst_addr =
      |                ^
drivers/gpu/drm/vmwgfx/vmwgfx_blit.c:403:16: warning: assignment to 'u8 *' {aka 'unsigned char *'} from 'int' makes pointer from integer without a cast [-Wint-conversion]
  403 |    d->src_addr =
      |                ^

Fixes: 46385a895322 ("drm: remove drm specific kmap_atomic code")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_blit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c b/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
index 94d456a1d1a9..1629427d5734 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
@@ -27,6 +27,7 @@
  **************************************************************************/
 
 #include "vmwgfx_drv.h"
+#include <linux/highmem.h>
 
 /*
  * Template that implements find_first_diff() for a generic
-- 
2.26.0

