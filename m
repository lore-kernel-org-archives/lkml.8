Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56ADBC3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E81421739
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583428871;
	bh=Rcpuoua5mmJzEl3RbXML86RqG0/4QTit1QasTIw5ZQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e/4j+jAgX9/PamzYsklhcXQOrV4wp9rugNQNoTXdMZuc18I9L2FeEWVvtOaZgifia
	 xo/127ssbEj4aHe4gFu86dBFK6EJPu46uxHysUZo35EU6lzep0kh4c/frS8WHkr/h8
	 mTLyM9Utlt9uoT4aJ2VDu95aoNB16Z0uJwae+dJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbgCEROk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 12:14:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:40628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727678AbgCERO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 12:14:28 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D91621556;
        Thu,  5 Mar 2020 17:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583428468;
        bh=Rcpuoua5mmJzEl3RbXML86RqG0/4QTit1QasTIw5ZQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ixU/DRWwlFaqTM7b5YVjZ7usRmPwcZ0fXE+UX1g+dhz452KkvNcQq6RN6TLuWGsGm
         n1DoXqAzwRSyt7PgKfHmgDEXSNQG/7HScdSjDmo8kYqdxL+AhVv0WPOCGYIUHojlAH
         HIoWRnKgE2elcR7qztkC3daIDWqibn94NlTm1PdY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 06/58] HID: alps: Fix an error handling path in 'alps_input_configured()'
Date:   Thu,  5 Mar 2020 12:13:27 -0500
Message-Id: <20200305171420.29595-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305171420.29595-1-sashal@kernel.org>
References: <20200305171420.29595-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 8d2e77b39b8fecb794e19cd006a12f90b14dd077 ]

They are issues:
   - if 'input_allocate_device()' fails and return NULL, there is no need
     to free anything and 'input_free_device()' call is a no-op. It can
     be axed.
   - 'ret' is known to be 0 at this point, so we must set it to a
     meaningful value before returning

Fixes: 2562756dde55 ("HID: add Alps I2C HID Touchpad-Stick support")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-alps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
index ae79a7c667372..fa704153cb00d 100644
--- a/drivers/hid/hid-alps.c
+++ b/drivers/hid/hid-alps.c
@@ -730,7 +730,7 @@ static int alps_input_configured(struct hid_device *hdev, struct hid_input *hi)
 	if (data->has_sp) {
 		input2 = input_allocate_device();
 		if (!input2) {
-			input_free_device(input2);
+			ret = -ENOMEM;
 			goto exit;
 		}
 
-- 
2.20.1

