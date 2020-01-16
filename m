Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B277C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5412424653
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579194168;
	bh=tH7fwmpQiZPw0MyDgLkGZKtY/tukBcVLLZDmKus01K4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KE+yifptjuvxhsePPtVaUKjgBzFVRVkssVcXQjj/1I5gJS30YEzfMu3KfrM3zllQu
	 JPqtSLWj54cyrT/8rsCmKBvAxl7OpZTeFn6kD0ZXnbEUDPT72tEc9UXhe91yIY4egY
	 uhx8eyfMKk1O667zMV2qY2+usdB40uEkghf9mLhs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388479AbgAPRCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:02:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:55804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388435AbgAPRCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:02:39 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 909612467E;
        Thu, 16 Jan 2020 17:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194159;
        bh=tH7fwmpQiZPw0MyDgLkGZKtY/tukBcVLLZDmKus01K4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AXBk1q/z2vlL4yCOsGemOEGoKAAo2JNay6AmXM6AI7gbIC+SFmUTidpUoKGLSuKT6
         /DvdBYeLknZWIQ/QFpD0yaWlWT+svREbbg+0ttRF73OMTstURNkG8389ZOhZbR5TG9
         1W08gLwGBo7kMbTRYZboJ8glkOlzXpAPSdg4lqU8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alexandre.bounine@idt.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 241/671] drivers/rapidio/rio_cm.c: fix potential oops in riocm_ch_listen()
Date:   Thu, 16 Jan 2020 11:52:30 -0500
Message-Id: <20200116165940.10720-124-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116165940.10720-1-sashal@kernel.org>
References: <20200116165940.10720-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 5ac188b12e7cbdd92dee60877d1fac913fc1d074 ]

If riocm_get_channel() fails, then we should just return -EINVAL.
Calling riocm_put_channel() will trigger a NULL dereference and
generally we should call put() if the get() didn't succeed.

Link: http://lkml.kernel.org/r/20190110130230.GB27017@kadam
Fixes: b6e8d4aa1110 ("rapidio: add RapidIO channelized messaging driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Matt Porter <mporter@kernel.crashing.org>
Cc: Alexandre Bounine <alexandre.bounine@idt.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rapidio/rio_cm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/rapidio/rio_cm.c b/drivers/rapidio/rio_cm.c
index ef989a15aefc..b29fc258eeba 100644
--- a/drivers/rapidio/rio_cm.c
+++ b/drivers/rapidio/rio_cm.c
@@ -1215,7 +1215,9 @@ static int riocm_ch_listen(u16 ch_id)
 	riocm_debug(CHOP, "(ch_%d)", ch_id);
 
 	ch = riocm_get_channel(ch_id);
-	if (!ch || !riocm_cmp_exch(ch, RIO_CM_CHAN_BOUND, RIO_CM_LISTEN))
+	if (!ch)
+		return -EINVAL;
+	if (!riocm_cmp_exch(ch, RIO_CM_CHAN_BOUND, RIO_CM_LISTEN))
 		ret = -EINVAL;
 	riocm_put_channel(ch);
 	return ret;
-- 
2.20.1

