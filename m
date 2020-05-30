Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0DCC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 06:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39D37206C3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 06:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590821947;
	bh=ILWZZh+okXiMKOu1SpkJQl4EysGMmt+0/+95PC1gmvc=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=BOu2qSJQKFGUb33JtDLbxL0JIAM3wfbJ8oyrKFMakZg8zWj0aq3x4co0BvRL8071T
	 PQb1SvonT7YRx+R3hdyvNyaKsQgrsbOV1YUubpt5F5K1RMA0c7lDKDFcUioFt6+u8G
	 vk/soeOh9sYyM/RMab+yktBr84IGnlegvgABgbBM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbgE3G6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 02:58:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:44920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728404AbgE3G4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 02:56:06 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB1BC21835;
        Sat, 30 May 2020 06:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590821763;
        bh=ILWZZh+okXiMKOu1SpkJQl4EysGMmt+0/+95PC1gmvc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yJ1Qvi/cYiTrwvIzGwxyZsdEbNVxj/TDmZ3yvTVuA7amaawziUab2kMAL0HkGgwvA
         JHkVI1nzW27crkbKKSbHdMpTVUioYTzxpP4PhYMNMyTxW+VrPM3jxijQcM6/Su1rsk
         AQYhPTYAw4xkP8YIXWnlKQsnykJmuwzTBi+p5MJo=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jevPV-001hq3-Ia; Sat, 30 May 2020 08:56:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH v2 25/41] media: atomisp: Avoid overflow in compute_blending
Date:   Sat, 30 May 2020 08:55:42 +0200
Message-Id: <22b531f57658727abacb28f534d6fc9d44eee4cf.1590821410.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1590821410.git.mchehab+huawei@kernel.org>
References: <cover.1590821410.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

Clang warns:

drivers/staging/media/atomisp/pci/isp/kernels/xnr/xnr_3.0/ia_css_xnr3.host.c:129:35:
warning: implicit conversion from 'unsigned long' to 'int32_t' (aka
'int') changes value from 18446744073709543424 to -8192
[-Wconstant-conversion]
        return MAX(MIN(isp_strength, 0), -XNR_BLENDING_SCALE_FACTOR);
        ~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~

XNR_BLENDING_SCALE_FACTOR is BIT(13), or 8192, which will easily fit
into a signed 32-bit integer. However, it is an unsigned long, which
means that negating it is the same as subtracting that value from
ULONG_MAX + 1, which causes it to be larger than a signed 32-bit
integer so it gets implicitly converted.

We can avoid this by using the variable isp_scale, which holds the value
of XNR_BLENDING_SCALE_FACTOR already, where the implicit conversion from
unsigned long to s32 already happened. If that were to ever overflow,
clang would warn: https://godbolt.org/z/EeSxLG

Link: https://github.com/ClangBuiltLinux/linux/issues/1036

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../atomisp/pci/isp/kernels/xnr/xnr_3.0/ia_css_xnr3.host.c      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/pci/isp/kernels/xnr/xnr_3.0/ia_css_xnr3.host.c b/drivers/staging/media/atomisp/pci/isp/kernels/xnr/xnr_3.0/ia_css_xnr3.host.c
index a9db6366d20b..629f07faf20a 100644
--- a/drivers/staging/media/atomisp/pci/isp/kernels/xnr/xnr_3.0/ia_css_xnr3.host.c
+++ b/drivers/staging/media/atomisp/pci/isp/kernels/xnr/xnr_3.0/ia_css_xnr3.host.c
@@ -126,7 +126,7 @@ compute_blending(int strength)
 	 * exactly as s0.11 fixed point, but -1.0 can.
 	 */
 	isp_strength = -(((strength * isp_scale) + offset) / host_scale);
-	return MAX(MIN(isp_strength, 0), -XNR_BLENDING_SCALE_FACTOR);
+	return MAX(MIN(isp_strength, 0), -isp_scale);
 }
 
 void
-- 
2.26.2

