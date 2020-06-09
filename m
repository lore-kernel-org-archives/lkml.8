Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0279C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7506E2067B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591726839;
	bh=X3vyRBVH4/GkTFt4U+nAcaxH2bkam9sS8gFS67sK6EU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Wg/WXRxwbleSu+W+DQWfi4yOFybFLZcAFl8nXg2fJIkANV+K9FB7IKDzRtM0+0yfm
	 EPsPOuWBrhs7dAP3fV9hbsHMdI6TkPYIHFfM0eaBPwpcUUzqKP0favPQJWVUEfA92o
	 ozR+IUQhiUuyZyw0vVO+X6naYK60HJjAy9jN0ffc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732599AbgFISUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:20:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:34054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730870AbgFIRs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:48:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52725207ED;
        Tue,  9 Jun 2020 17:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591724936;
        bh=X3vyRBVH4/GkTFt4U+nAcaxH2bkam9sS8gFS67sK6EU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tfVn5C5DIslctcTwcxp7NUnsQ1YWNwKergUqSaIU2AdZ++i5g3AQKIb0gHdVgQ2VS
         8hbr1UvYBl7+FWQS4aCUzezdzofmAkmSUSd4Tr6TbsxSHlKZngh5bQ0C655GdmM5Fv
         GbW4DcE7EOvheWR2NKcC2jhZq5g7PfuXYB27Q3xM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Bin Liu <b-liu@ti.com>
Subject: [PATCH 4.9 31/42] usb: musb: Fix runtime PM imbalance on error
Date:   Tue,  9 Jun 2020 19:44:37 +0200
Message-Id: <20200609174018.888846237@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609174015.379493548@linuxfoundation.org>
References: <20200609174015.379493548@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dinghao Liu <dinghao.liu@zju.edu.cn>

commit e4befc121df03dc8ed2ac1031c98f9538e244bae upstream.

When copy_from_user() returns an error code, there
is a runtime PM usage counter imbalance.

Fix this by moving copy_from_user() to the beginning
of this function.

Fixes: 7b6c1b4c0e1e ("usb: musb: fix runtime PM in debugfs")

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc: stable@vger.kernel.org
Signed-off-by: Bin Liu <b-liu@ti.com>
Link: https://lore.kernel.org/r/20200525025049.3400-7-b-liu@ti.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/musb/musb_debugfs.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/usb/musb/musb_debugfs.c
+++ b/drivers/usb/musb/musb_debugfs.c
@@ -200,6 +200,11 @@ static ssize_t musb_test_mode_write(stru
 	u8			test;
 	char			buf[18];
 
+	memset(buf, 0x00, sizeof(buf));
+
+	if (copy_from_user(buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
+		return -EFAULT;
+
 	pm_runtime_get_sync(musb->controller);
 	test = musb_readb(musb->mregs, MUSB_TESTMODE);
 	if (test) {
@@ -208,11 +213,6 @@ static ssize_t musb_test_mode_write(stru
 		goto ret;
 	}
 
-	memset(buf, 0x00, sizeof(buf));
-
-	if (copy_from_user(buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
-		return -EFAULT;
-
 	if (strstarts(buf, "force host"))
 		test = MUSB_TEST_FORCE_HOST;
 


