Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1683DC55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD0E42076E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587552985;
	bh=uxZn+6iQBZhne3sVwParQxdimdS2QwyNL9wAwNIljlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QLLgFiMFFc1gnUjsl/deqKhhFoctu9HKXoESnHAy1QcMimRzkQWgn4/ElKWhYnz+v
	 KJlVPIT7wLYUHCgK0fGUzNyzCRQZeqtPX716RTh/j9ENBB0Q6+xootCABsW3tXhuXf
	 49zPwLuW2GyAmeVHVgSEC/O7KnNRPwBEBWdyhSdw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgDVKGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:06:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:58508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728363AbgDVKGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:06:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FA9A2076C;
        Wed, 22 Apr 2020 10:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587549991;
        bh=uxZn+6iQBZhne3sVwParQxdimdS2QwyNL9wAwNIljlA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=reERQEeYrRyZ59Nc78CMF5CVs4V1GxVGo7KTd6B+jtg6oZQtgk2QkQzcxd9oIb8fY
         aZ7jTAZsBkrvb/+1cn/RCcGHXh/0CtXj7NYWyxj6GiHRmXEkgRi5QKnj2hwiOK/xFv
         O1/2byf5Legni/FGIn9ufpbvfpmJzxuUWtPI5riw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 4.9 089/125] video: fbdev: sis: Remove unnecessary parentheses and commented code
Date:   Wed, 22 Apr 2020 11:56:46 +0200
Message-Id: <20200422095047.371366550@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095032.909124119@linuxfoundation.org>
References: <20200422095032.909124119@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

commit 864eb1afc60cb43e7df879b97f8ca0d719bbb735 upstream.

Clang warns when multiple pairs of parentheses are used for a single
conditional statement.

drivers/video/fbdev/sis/init301.c:851:42: warning: equality comparison
with extraneous parentheses [-Wparentheses-equality]
      } else if((SiS_Pr->SiS_IF_DEF_LVDS == 1) /* ||
                 ~~~~~~~~~~~~~~~~~~~~~~~~^~~~
drivers/video/fbdev/sis/init301.c:851:42: note: remove extraneous
parentheses around the comparison to silence this warning
      } else if((SiS_Pr->SiS_IF_DEF_LVDS == 1) /* ||
                ~                        ^   ~
drivers/video/fbdev/sis/init301.c:851:42: note: use '=' to turn this
equality comparison into an assignment
      } else if((SiS_Pr->SiS_IF_DEF_LVDS == 1) /* ||
                                         ^~
                                         =
1 warning generated.

Remove the parentheses and while we're at it, clean up the commented
code, which has been here since the beginning of git history.

Link: https://github.com/ClangBuiltLinux/linux/issues/118
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Cc: Thomas Winischhofer <thomas@winischhofer.net>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/video/fbdev/sis/init301.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/video/fbdev/sis/init301.c
+++ b/drivers/video/fbdev/sis/init301.c
@@ -522,9 +522,7 @@ SiS_PanelDelay(struct SiS_Private *SiS_P
 	    SiS_DDC2Delay(SiS_Pr, 0x4000);
 	 }
 
-      } else if((SiS_Pr->SiS_IF_DEF_LVDS == 1) /* ||
-	 (SiS_Pr->SiS_CustomT == CUT_COMPAQ1280) ||
-	 (SiS_Pr->SiS_CustomT == CUT_CLEVO1400) */ ) {			/* 315 series, LVDS; Special */
+      } else if (SiS_Pr->SiS_IF_DEF_LVDS == 1) {			/* 315 series, LVDS; Special */
 
 	 if(SiS_Pr->SiS_IF_DEF_CH70xx == 0) {
 	    PanelID = SiS_GetReg(SiS_Pr->SiS_P3d4,0x36);


