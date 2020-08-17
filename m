Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190C3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F339B20738
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597688143;
	bh=/1ramI7N/PC/FCx1+3BMK/mKLPfXJVkRCE13JhUik0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XHcbf6Lu1tS4k8dNdiIg+UgRtD4NggFosR0BidtG2Q5ynG7zgdmK+Ns7tkLDenLRS
	 kV+tAGzt6GOdi5rrVVd20nWx0ly+DMWIyT5X/fKRmtbj73fpHmw/feQbcOfCxvKNuD
	 N+LTlcQcPyUXkzeH+74kHol2PsB0Df+geMAsw+yM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390679AbgHQSPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:15:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:53970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730528AbgHQQGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:06:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A63820866;
        Mon, 17 Aug 2020 16:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680363;
        bh=/1ramI7N/PC/FCx1+3BMK/mKLPfXJVkRCE13JhUik0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ca9LiBUQ92g453SXnJ916Qsk4tnS/tKC7Bu3AI5txOmqWMF3W4tl7OEHUVdw5NjW4
         IiqV5+IqeoonqkomWdlhDaoRqzoLnoYVzd5+LpqCz/stVKIFPkJBk6m+hUIHbHc4A3
         pVKa016qWEweSsEf2IfjajaezySmue2vhfwLvJpA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kars Mulder <kerneldev@karsmulder.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 156/270] usb: core: fix quirks_param_set() writing to a const pointer
Date:   Mon, 17 Aug 2020 17:15:57 +0200
Message-Id: <20200817143803.596772999@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143755.807583758@linuxfoundation.org>
References: <20200817143755.807583758@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kars Mulder <kerneldev@karsmulder.nl>

[ Upstream commit b1b6bed3b5036509b449b5965285d5057ba42527 ]

The function quirks_param_set() takes as argument a const char* pointer
to the new value of the usbcore.quirks parameter. It then casts this
pointer to a non-const char* pointer and passes it to the strsep()
function, which overwrites the value.

Fix this by creating a copy of the value using kstrdup() and letting
that copy be written to by strsep().

Fixes: 027bd6cafd9a ("usb: core: Add "quirks" parameter for usbcore")
Signed-off-by: Kars Mulder <kerneldev@karsmulder.nl>

Link: https://lore.kernel.org/r/5ee2-5f048a00-21-618c5c00@230659773
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/core/quirks.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index e0b77674869ce..c96c50faccf72 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -25,17 +25,23 @@ static unsigned int quirk_count;
 
 static char quirks_param[128];
 
-static int quirks_param_set(const char *val, const struct kernel_param *kp)
+static int quirks_param_set(const char *value, const struct kernel_param *kp)
 {
-	char *p, *field;
+	char *val, *p, *field;
 	u16 vid, pid;
 	u32 flags;
 	size_t i;
 	int err;
 
+	val = kstrdup(value, GFP_KERNEL);
+	if (!val)
+		return -ENOMEM;
+
 	err = param_set_copystring(val, kp);
-	if (err)
+	if (err) {
+		kfree(val);
 		return err;
+	}
 
 	mutex_lock(&quirk_mutex);
 
@@ -60,10 +66,11 @@ static int quirks_param_set(const char *val, const struct kernel_param *kp)
 	if (!quirk_list) {
 		quirk_count = 0;
 		mutex_unlock(&quirk_mutex);
+		kfree(val);
 		return -ENOMEM;
 	}
 
-	for (i = 0, p = (char *)val; p && *p;) {
+	for (i = 0, p = val; p && *p;) {
 		/* Each entry consists of VID:PID:flags */
 		field = strsep(&p, ":");
 		if (!field)
@@ -144,6 +151,7 @@ static int quirks_param_set(const char *val, const struct kernel_param *kp)
 
 unlock:
 	mutex_unlock(&quirk_mutex);
+	kfree(val);
 
 	return 0;
 }
-- 
2.25.1



