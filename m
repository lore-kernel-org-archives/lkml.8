Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C5AC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 04:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D7F920658
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 04:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZqCycDwB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgC3EzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 00:55:13 -0400
Received: from m12-13.163.com ([220.181.12.13]:60198 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgC3EzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 00:55:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=yQHVo
        TC1AlKhOx5/dm2DqUi8M09WhVzXclK6/Qj4wyM=; b=ZqCycDwBSA7r4vtPmArIl
        P0AkvWcmVg8InEf2Atih/Wd/aWfs5e9yFKgq6gW0baDQr3LjiDv7ErK6fSpgwHTI
        AL+4XvFAwa0+Xsc4twM1aK5N9g8ebIuXmjVDbZzIlMe0aDNgFw5vPkle4Ik4yUif
        gcEMLl1tjd/1cCfglBym5I=
Received: from localhost.localdomain (unknown [125.82.11.174])
        by smtp9 (Coremail) with SMTP id DcCowAAHDQ2ae4FeVfa8Bg--.11805S4;
        Mon, 30 Mar 2020 12:54:52 +0800 (CST)
From:   Hu Haowen <xianfengting221@163.com>
To:     chris@zankel.net, jcmvbkbc@gmail.com
Cc:     linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org,
        Hu Haowen <xianfengting221@163.com>
Subject: [PATCH] arch/xtensa: correct an ungrammatical word
Date:   Mon, 30 Mar 2020 12:54:36 +0800
Message-Id: <20200330045436.12645-1-xianfengting221@163.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowAAHDQ2ae4FeVfa8Bg--.11805S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw4fGFW3KF4xArW7KrW8Xrb_yoWxZwb_Ar
        nrJ3W8u3Wrta9Fgrn8Ww4rXr4Yqws5WF1ruw4vy3Wavw1aqw13Gan7Jr4qv3yfua1xur10
        9FW8Zry5XF92kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjjQDUUUUUU==
X-Originating-IP: [125.82.11.174]
X-CM-SenderInfo: h0ld0wxhqj3xtqjsjii6rwjhhfrp/1tbiMhX2AFWBoES6WgAAsB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The word "Dont" is not grammatical. Maybe it means "Don't".

Signed-off-by: Hu Haowen <xianfengting221@163.com>
---
 arch/xtensa/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index de229424b659..3a9f1e80394a 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -122,7 +122,7 @@ config XTENSA_VARIANT_CUSTOM_NAME
 	help
 	  Provide the name of a custom Xtensa processor variant.
 	  This CORENAME selects arch/xtensa/variant/CORENAME.
-	  Dont forget you have to select MMU if you have one.
+	  Don't forget you have to select MMU if you have one.
 
 config XTENSA_VARIANT_NAME
 	string
-- 
2.20.1


