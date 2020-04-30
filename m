Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C58C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 20:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F4E12076D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 20:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kocurkovo.cz header.i=@kocurkovo.cz header.b="sl7XFsxO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgD3UTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 16:19:33 -0400
Received: from mail.kocurkovo.cz ([185.8.236.170]:50388 "EHLO
        mail.kocurkovo.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbgD3UTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 16:19:32 -0400
Received: by mail.kocurkovo.cz (Postfix, from userid 1000)
        id 8112314A6; Thu, 30 Apr 2020 22:10:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.kocurkovo.cz 8112314A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kocurkovo.cz;
        s=mail; t=1588277414;
        bh=DMrCxO5LfF+67B5Swz0IlQISgC769TejVCtIcdOO7Fc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sl7XFsxOSvFR5NUcHyTyS9JTovjTO3bsL2RbMfCf+fohv+FqMviOKFgYBWKRqt3P+
         bMjIJeF+Pyp0y5j6ebKLu+5QF+U+G0lLjd6AQEMmvtPQk4zCbq//Y16qqRHJzCBfub
         f2nTF59W7pmKa57uZBQPQrPFplndQz1ZWxwtuPbQ=
From:   Matej Dujava <mdujava@kocurkovo.cz>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Matej Dujava <mdujava@kocurkovo.cz>
Subject: [PATCH 3/3] staging: sm750fb: print error message with actual value
Date:   Thu, 30 Apr 2020 22:09:26 +0200
Message-Id: <1588277366-19354-4-git-send-email-mdujava@kocurkovo.cz>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588277366-19354-1-git-send-email-mdujava@kocurkovo.cz>
References: <1588277366-19354-1-git-send-email-mdujava@kocurkovo.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch will update error message, so it is same as error message in
another function.

Signed-off-by: Matej Dujava <mdujava@kocurkovo.cz>
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index c3ce7e653c7f..a1a82e59dfee 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -390,7 +390,7 @@ static int lynxfb_ops_set_par(struct fb_info *info)
 	var->accel_flags = 0;/*FB_ACCELF_TEXT;*/
 
 	if (ret) {
-		pr_err("pixel bpp format not satisfied\n.");
+		pr_err("bpp %d not supported\n", var->bits_per_pixel);
 		return ret;
 	}
 	ret = hw_sm750_crtc_setMode(crtc, var, fix);
-- 
2.26.2

