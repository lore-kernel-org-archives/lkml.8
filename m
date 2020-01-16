Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59250C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28EEF246DC
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579196269;
	bh=zPjllkjADDMjcToQuZOmKmG2EBKJqnMdfjf7vbvjdaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vToGHs4hoZ1Ow/vcYaDKeXwFq2yQl2EeIRJdjM+8n2XaaD0vYskft6hTCA7G1BtcC
	 8nsKp+lq9P9XXrfdF78eSyCynUSHf4AGDzEQuF+MrhFEPuXu+k1yQov9zpsPsMtDlZ
	 fXsshK4VvB7QDVTYjuVNt6QP5VC12NEpwqLvjGzo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393208AbgAPRhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:37:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:52728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405362AbgAPRh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:37:27 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7208246C0;
        Thu, 16 Jan 2020 17:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196247;
        bh=zPjllkjADDMjcToQuZOmKmG2EBKJqnMdfjf7vbvjdaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jl9pK7qYPexoCAQHUofV4KWzNkJyg9MgYMAbLseb8bYzrPMrmu2ZvzQpKLEtC+gSh
         vu5m5NrKeEUc9IKW4lWXh29bYkKcqM8fNRo+DBV019xEE0Q1O7snjvCcuQW/YQGDqq
         U8vskVu4fI36x+qcU5eyR6jbGhwKwkXcRiW6OmQo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 075/251] cdc-wdm: pass return value of recover_from_urb_loss
Date:   Thu, 16 Jan 2020 12:33:44 -0500
Message-Id: <20200116173641.22137-35-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116173641.22137-1-sashal@kernel.org>
References: <20200116173641.22137-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 0742a338f5b3446a26de551ad8273fb41b2787f2 ]

'rv' is the correct return value, pass it upstream instead of 0

Fixes: 17d80d562fd7 ("USB: autosuspend for cdc-wdm")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/class/cdc-wdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
index 217a479165e0..09337a973335 100644
--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -1098,7 +1098,7 @@ static int wdm_post_reset(struct usb_interface *intf)
 	rv = recover_from_urb_loss(desc);
 	mutex_unlock(&desc->wlock);
 	mutex_unlock(&desc->rlock);
-	return 0;
+	return rv;
 }
 
 static struct usb_driver wdm_driver = {
-- 
2.20.1

