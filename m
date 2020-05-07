Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A3BC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C27F824955
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588877300;
	bh=C6TOslW0RPAVRj59vDbD1f7i1AMF+aeN9mPq2i49xY4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=zdpTRyz2cB449lXnZ7UVA8FiCuUkvlZZnvRm+KCwyzyZf/JDY0t/H52j1LHodD3qh
	 aH+IrO7F0E9lr8OUYQmAUPt25dfK1Pm+Bqapx8F2VgTcr1E6NDnTz9E+yxsvvFb1t4
	 YUzeJxOV4OKPqrCU/fAcx+em4RTf1hCljkTSwwtw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbgEGSsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:48:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728204AbgEGSsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:48:19 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9965124953;
        Thu,  7 May 2020 18:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588877299;
        bh=C6TOslW0RPAVRj59vDbD1f7i1AMF+aeN9mPq2i49xY4=;
        h=Date:From:To:Cc:Subject:From;
        b=Av6UYff8btecZx38Z7olbUqOwncd1TxdjTpvyo6mbOlW2ERUNIagx2GUM2EoS3l/Q
         xgwkXNwSQ9gG/MkxpODzzimCjvPV46xbtX6v+0hpeZkwiG6Pe0SpLQ1MxWbQBXZaWx
         iUvZIm8IwH+X2v51U5+XkvU67kuOB8t5IHNmHXs0=
Date:   Thu, 7 May 2020 13:52:45 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Clemens Ladisch <clemens@ladisch.de>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: fireworks: Replace zero-length array with
 flexible-array
Message-ID: <20200507185245.GA14270@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 sound/firewire/fireworks/fireworks.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/fireworks/fireworks.h b/sound/firewire/fireworks/fireworks.h
index dda797209a27..654e28a6669f 100644
--- a/sound/firewire/fireworks/fireworks.h
+++ b/sound/firewire/fireworks/fireworks.h
@@ -177,7 +177,7 @@ struct snd_efw_phys_meters {
 	u32 in_meters;
 	u32 reserved4;
 	u32 reserved5;
-	u32 values[0];
+	u32 values[];
 } __packed;
 enum snd_efw_clock_source {
 	SND_EFW_CLOCK_SOURCE_INTERNAL	= 0,

