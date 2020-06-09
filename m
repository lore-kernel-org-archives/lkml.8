Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E090C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F03262074B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591725138;
	bh=6YPxQIpnHA4tJL9vOwIld7dOcuszsw2Lm6F7R0UTo0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Bg5VgBtrm3YB9O4jWFqI6ojQa2RU3mFWLpUB4EocH/NLom9aYlTnH5sU6iz2cta5X
	 wDWI1gH9XiCVjGF9rvxCl+WBC10s/u3+7gsS+W5YKHYpWLiF8eDat972quB18FSX1D
	 agqLXV1ergPDhES0VrRm1CT1KgJ0JpDHyEFCqpiM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731668AbgFIRwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:52:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:39880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732789AbgFIRvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:51:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E7A4207C3;
        Tue,  9 Jun 2020 17:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591725073;
        bh=6YPxQIpnHA4tJL9vOwIld7dOcuszsw2Lm6F7R0UTo0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jGX2DcSGemlCopwGc/VfTR+0IMqKdun+zYXky0nvZPZtETAFvHil+/s950Ov9AjUV
         ta0b6FnQLSIj+MluINlmpLi9+TN9FVeKAZqwI9R3DdK3Bnj7sXR7hbbjGbPhwMpjhy
         dClGlK/pphMfPizo/VBnjJqLNEIqNMIIkdV6eNR0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Bin Liu <b-liu@ti.com>
Subject: [PATCH 4.19 13/25] usb: musb: Fix runtime PM imbalance on error
Date:   Tue,  9 Jun 2020 19:45:03 +0200
Message-Id: <20200609174050.120581172@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609174048.576094775@linuxfoundation.org>
References: <20200609174048.576094775@linuxfoundation.org>
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
@@ -168,6 +168,11 @@ static ssize_t musb_test_mode_write(stru
 	u8			test;
 	char			buf[24];
 
+	memset(buf, 0x00, sizeof(buf));
+
+	if (copy_from_user(buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
+		return -EFAULT;
+
 	pm_runtime_get_sync(musb->controller);
 	test = musb_readb(musb->mregs, MUSB_TESTMODE);
 	if (test) {
@@ -176,11 +181,6 @@ static ssize_t musb_test_mode_write(stru
 		goto ret;
 	}
 
-	memset(buf, 0x00, sizeof(buf));
-
-	if (copy_from_user(buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
-		return -EFAULT;
-
 	if (strstarts(buf, "force host full-speed"))
 		test = MUSB_TEST_FORCE_HOST | MUSB_TEST_FORCE_FS;
 


