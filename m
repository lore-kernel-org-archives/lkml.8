Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D03C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 14:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE5C02083B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 14:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgEHOkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 10:40:46 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:57927 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbgEHOkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 10:40:45 -0400
Received: from localhost.localdomain ([149.172.19.189]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MXp1Q-1jcT0s3K16-00Y70j; Fri, 08 May 2020 16:40:23 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Changbin Du <changbin.du@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] HMM: test: fix CONFIG_DEVICE_PRIVATE dependencies
Date:   Fri,  8 May 2020 16:40:08 +0200
Message-Id: <20200508144017.3501418-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:oEjOcKIyUKknp3ml6pCR7GOzJlBrlenpFz/gnnhel3lRHA1e6hl
 DS2ASRlD9j2N1iHIgIV3asc2AeDB6GzjcLfCCqiWUAsOQGn4YuDInwq4yzAeh4m99A6+hb8
 FZfz26uHWWWQS7p8MAyqtMNyxzsEXOIECntwGk8eACceGfVr2eLNt4ElvcNlPzWqdxbP+Yd
 9NkaaAbgBMRTGiuBJ6ZYQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:21X1C9y4tcM=:aDIGpK/Rrrc4jg1qAbf3ws
 l/fmznTHhXzMCLTLidJ9yTYgm3WEXKNzdMQGA1rnNB/9NqxFfqP/Xv6hTDeGJ/VDUKMD8p38h
 b/e9NjmgYuXQ9WLtDv7JGIBsskQYBg3u9Hp5K5aCu1mS24Ly2MZ7mzosL27uGRn/njo4P4b+M
 GxAhzvTKeVp6KdbVvZbXGu3sRJ3+6TabGFaf422XOE/rxa/EvKLGvRQMHJee/yZ0uWKpIC85T
 cOTgiAMnrq8z44O1ORrfMVefYjvWc+ZvX1zJMUTBZfiZOP0M/Bi6iNm2KdC7Sof9jAoXH2f7W
 vrjSP5qiWxSeQ0CEPwzPRuz2UXjGj2OgOPHogqiLdBowO4z3UeXPlb0i7MQtbDNWMRQC9gF7l
 zJhSo9chC57l7UEMsNyG7WF1JZWvdcACQwk9eHNis0CPW7/EzG2zN9nDrgI62YqYPz6l3j/up
 nPscjodRSYN+g/vti4H7i1l9MJZxE/gHw124lLFxNn1aP/kKFWDk0uneoGYiRyCc9PEwe0IHW
 RqCCxzOoXq4/gR+/lTPNMYSUlT8gMP66edquKyPO5bfVbDpTwnK0lL/7tckiED14yJYXtKY3N
 XWDRCvlMpEWy1Wr07GJ6LC4uv1akdR88oUU/pex8ad7rK0oL0qZjjdHuTjfUF6+IBXvSbt2bN
 GPu9mLnl/nlGgEcH8I4280tg/a2ixcsckoPmPenXYib1zRLuhdmieoKZdWACZEvFcBFnS8eOf
 F/HUijyjD1XcKnifLVgOdq7jGA/QtinS0GdKTUDKS9zagf8CoZaK7swBMsHCZiXtKz89rJLy0
 SE4Yms+h3Mu9fgbGIrt3DdrhBRcpE8LAbRoNLz/EOtvXsqZLU0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One cannot select DEVICE_PRIVATE when its dependencies are disabled:

WARNING: unmet direct dependencies detected for DEVICE_PRIVATE
  Depends on [n]: ZONE_DEVICE [=n]
  Selected by [m]:
  - TEST_HMM [=m] && RUNTIME_TESTING_MENU [=y] && TRANSPARENT_HUGEPAGE [=y]
lib/test_hmm.c:480:8: error: implicit declaration of function 'memremap_pages' [-Werror,-Wimplicit-function-declaration]
        ptr = memremap_pages(&devmem->pagemap, numa_node_id());
              ^
lib/test_hmm.c:480:8: note: did you mean 'memcmp_pages'?
include/linux/mm.h:3082:12: note: 'memcmp_pages' declared here
extern int memcmp_pages(struct page *page1, struct page *page2);
           ^
lib/test_hmm.c:480:6: error: incompatible integer to pointer conversion assigning to 'void *' from 'int' [-Werror,-Wint-conversion]
        ptr = memremap_pages(&devmem->pagemap, numa_node_id());
            ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/test_hmm.c:1089:4: error: implicit declaration of function 'memunmap_pages' [-Werror,-Wimplicit-function-declaration]
                        memunmap_pages(&devmem->pagemap);

Add a dependency from CONFIG_TEST_HMM to ZONE_DEVICE, to disallow
those broken configurations.

Fixes: 5d5e54be8a1e ("mm/hmm/test: add selftest driver for HMM")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/Kconfig.debug | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d9885fa37cc0..63667d62c9d8 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2262,6 +2262,7 @@ config TEST_MEMINIT
 config TEST_HMM
 	tristate "Test HMM (Heterogeneous Memory Management)"
 	depends on TRANSPARENT_HUGEPAGE
+	depends on ZONE_DEVICE
 	select DEVICE_PRIVATE
 	select HMM_MIRROR
 	select MMU_NOTIFIER
-- 
2.26.0

