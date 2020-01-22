Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B803CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC1F24673
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579685741;
	bh=o5ENOhAOLvVXmvZAAxOD8ynA2Hhx+mzchRgQvihpNNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HiZO5wokxV+toWrHG1onEZNU8tRUTfXnoNlI9g1CYYtoZrGiEp1QTSx1533bxgLil
	 qmrkxQmReEYCFJomh64SMKGvhJsUfSMB8C7jnL0FXBWF59iww58oJlnvmkuYn4+gZZ
	 n8RYeyUrOQUvRPOpTxAsaLPBO73wpK/fTM+R3u7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731448AbgAVJfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:35:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:50780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730073AbgAVJfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:35:36 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8B052071E;
        Wed, 22 Jan 2020 09:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685736;
        bh=o5ENOhAOLvVXmvZAAxOD8ynA2Hhx+mzchRgQvihpNNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CgGZkcLiFlMssMIhDRhV0mx/iTIUhQ91wI+d0+8ZsyGgU2tJ9CjxQRuQZwVFdTreT
         YL+mLGDp++VHmNMZD9YOGN2OeWaXYDPtzMckpXjytu3DhU/Yj41vRtC2Nf0ZZYq8hG
         wwIOxVRWczncJYClVVOSui5gSojyB7vDWnsUqQz0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 4.9 51/97] dt-bindings: reset: meson8b: fix duplicate reset IDs
Date:   Wed, 22 Jan 2020 10:28:55 +0100
Message-Id: <20200122092804.728189898@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092755.678349497@linuxfoundation.org>
References: <20200122092755.678349497@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

commit 4881873f4cc1460f63d85fa81363d56be328ccdc upstream.

According to the public S805 datasheet the RESET2 register uses the
following bits for the PIC_DC, PSC and NAND reset lines:
- PIC_DC is at bit 3 (meaning: RESET_VD_RMEM + 3)
- PSC is at bit 4 (meaning: RESET_VD_RMEM + 4)
- NAND is at bit 5 (meaning: RESET_VD_RMEM + 4)

Update the reset IDs of these three reset lines so they don't conflict
with PIC_DC and map to the actual hardware reset lines.

Fixes: 79795e20a184eb ("dt-bindings: reset: Add bindings for the Meson SoC Reset Controller")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/dt-bindings/reset/amlogic,meson8b-reset.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/include/dt-bindings/reset/amlogic,meson8b-reset.h
+++ b/include/dt-bindings/reset/amlogic,meson8b-reset.h
@@ -95,9 +95,9 @@
 #define RESET_VD_RMEM			64
 #define RESET_AUDIN			65
 #define RESET_DBLK			66
-#define RESET_PIC_DC			66
-#define RESET_PSC			66
-#define RESET_NAND			66
+#define RESET_PIC_DC			67
+#define RESET_PSC			68
+#define RESET_NAND			69
 #define RESET_GE2D			70
 #define RESET_PARSER_REG		71
 #define RESET_PARSER_FETCH		72


