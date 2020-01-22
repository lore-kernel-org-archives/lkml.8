Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2CBC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93632468D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579686539;
	bh=o5ENOhAOLvVXmvZAAxOD8ynA2Hhx+mzchRgQvihpNNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MMwjkS0d2O7xGRAJmIXyHOejtxI8l/5GwUHhRNL0lCWuwxiNeDib9/TAM248Aenn/
	 MpVcLe1TPY+sT5PfpJO/WVXWhPo65mwAhABx4Ry7rIvD+AdQKh9+GXi78wYlry2SCg
	 YXtJbJMQ1luFL57ptd85nAN8PIMQSKNTwutGWuO0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387430AbgAVJs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:48:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:59676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387470AbgAVJkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:40:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D82602467B;
        Wed, 22 Jan 2020 09:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579686041;
        bh=o5ENOhAOLvVXmvZAAxOD8ynA2Hhx+mzchRgQvihpNNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M22pXMQc6bElc/ClEJ2LAcebJwdHyBsaFXhE36vOIuGbUJI5xvGE/8UUG0CrMh6gT
         ap4MwhWRK3No33SdKLh/ums02NmO9a6AqCUk6fz1FZY8AEDLcbxk77kHNCOo3yj0yh
         XsTW8/TIufoM+tVY5c6cdSOILXAqmNZVdjkYdOek=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 4.19 003/103] dt-bindings: reset: meson8b: fix duplicate reset IDs
Date:   Wed, 22 Jan 2020 10:28:19 +0100
Message-Id: <20200122092804.144652552@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092803.587683021@linuxfoundation.org>
References: <20200122092803.587683021@linuxfoundation.org>
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


