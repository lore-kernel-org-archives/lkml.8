Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A2BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F36A4207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388501AbgE0Njm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 09:39:42 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:54817 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387682AbgE0Njl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 09:39:41 -0400
Received: from localhost.localdomain ([149.172.98.151]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MlsWZ-1jDMy53Blj-00j3fQ; Wed, 27 May 2020 15:39:26 +0200
From:   Arnd Bergmann <arnd@arndb.de>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org, Jens Wiklander <jens.wiklander@linaro.org>,
        =?UTF-8?q?Vesa=20J=C3=A4=C3=A4skel=C3=A4inen?= 
        <vesa.jaaskelainen@vaisala.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        Gary R Hook <gary.hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tee: fix crypto select
Date:   Wed, 27 May 2020 15:39:16 +0200
Message-Id: <20200527133924.724819-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:P+KwTzBlyszTVG0EQVcxHYoNDDlR4ilvVgGJ8/tHgSBjq+KUIxk
 umhaGxlmmS5bsKk00Kwz/9SJNvdEN8zRjSDUwZ2aajPKqGo8xAkOLEAEyUvZwZuEOCJDMKB
 eoFmq2tbkVdKswWZ8yuSbeMxVfcg1ShQNhK7s54QUd8cQU7wlKJ3t/W8e+I2DJ5t8uex9/g
 AI7jafPdOimry8cHrF0Rw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h0wYUygjUYk=:cYmYE7qDUtHD/uUeKqsj0V
 Dj9POsWkIWO1+pp7LH9oYcwyuei3rfrUjpaj8Z6DW0aycdDXKsimy76ZJ2C+vsmbPKD3rNajJ
 EQlszaBxxVlHupu1tSiWWkeS8E5tkfEeLrZLt+N9/fe1VP3ewEocRdv7ocRFVC7DPb8HqDqri
 8BtKReRmxyoy4miQlxlb4RYRCgUspm9zLzHMDVzQeVZ/jvrw4ZPpnx5K6mVHlVl8CNHQNDgnf
 2+KyrtwOBKqG9ebiEDYV6k5xjjSJyocy0PpbACKsUBlKzozG/pgsx1U2dnOAqoKXO2f4Vkh3Q
 z7UFRhVLHQqegaVdG+B/6PG4xI9PjnkM87DHwgLJDloF9ICJEZwDE/+DE6kOwGlvhSuKf/oLP
 tCgAsMQKRj9f6VrrUqMacXG0E26y3loAqKj9j4TR5tnzvdbEOPLOZj4kcNm50eaCAjp5xFLAJ
 CWgqlYawYeZpF+8jdtYFs7rwo94Dgs9Ucub35oR1Y7yxkrIPNDDUgnQbeG0y5orLlrAKxJ+Uc
 izWxMKT+fpfN1zing8AjDoDkoHRENbhFziv4lqF0Dv9lOovg8bMEcHqfuRRjhBlNZwdzydX5S
 3jHDd9Qnya42xvLRGW93OqI5K3YoAYyBnLfV+sfDY8i79FsTLf6X4Lt75iaRlWoEHAFv/LIRx
 TggBXjlQuirAoRAc7pJ8mCg9djHtLw0TKvAnIdOGr1TbWTdpdphJG6I724clM4/BchHj1H+/P
 /Bt5u9x4xBQLR4VeoNl5vrZYdAqK8gv3zQNnnXulJtdk7j8zXRFgfdgHaMTwQ8yRJaOyOdBNf
 XufKNzcGopHz8Xp2g9CZt9+7tJGdG2repskAIpM//NyOqJwGF4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When selecting a crypto cipher, we also need to select the
subsystem itself:

WARNING: unmet direct dependencies detected for CRYPTO_SHA1
  Depends on [m]: CRYPTO [=m]
  Selected by [y]:
  - TEE [=y] && (HAVE_ARM_SMCCC [=n] || COMPILE_TEST [=y] || CPU_SUP_AMD [=y])
  Selected by [m]:
  - CRYPTO_DEV_QAT [=m] && CRYPTO [=m] && CRYPTO_HW [=y]
  - CRYPTO_DEV_MEDIATEK [=m] && CRYPTO [=m] && CRYPTO_HW [=y] && (ARM && ARCH_MEDIATEK || COMPILE_TEST [=y])
  - CRYPTO_DEV_SAFEXCEL [=m] && CRYPTO [=m] && CRYPTO_HW [=y] && (OF [=y] || PCI [=y] || COMPILE_TEST [=y]) && HAS_IOMEM [=y]
  - CRYPTO_DEV_CCREE [=m] && CRYPTO [=m] && CRYPTO_HW [=y] && OF [=y] && HAS_DMA [=y]
  - CRYPTO_DEV_SP_CCP [=y] && CRYPTO [=m] && CRYPTO_HW [=y] && CRYPTO_DEV_CCP [=y] && CRYPTO_DEV_CCP_DD [=m] && DMADEVICES [=y]

Fixes: e33bcbab16d1 ("tee: add support for session's client UUID generation")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
The regression was introduced in the soc tree, I'd pick this patch
up directly into that unless someone sees a problem
---
 drivers/tee/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tee/Kconfig b/drivers/tee/Kconfig
index 806eb87d4da0..e99d840c2511 100644
--- a/drivers/tee/Kconfig
+++ b/drivers/tee/Kconfig
@@ -3,6 +3,7 @@
 config TEE
 	tristate "Trusted Execution Environment support"
 	depends on HAVE_ARM_SMCCC || COMPILE_TEST || CPU_SUP_AMD
+	select CRYPTO
 	select CRYPTO_SHA1
 	select DMA_SHARED_BUFFER
 	select GENERIC_ALLOCATOR
-- 
2.26.2

