Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0EAC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A9C72084D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587552408;
	bh=iXMXhubN516VSHJjbodtOZrbU9W45/hHHrxQFuVpNxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TAnPUr376tMj8psJvTyHDKgKGciwBnmL9cOipeIBfw/1uGSThgX1FPfHvWtyOTq1S
	 K7Ras2mSWj9mKfliDqgB4kV9+baW3rvrswCoXedDCHui4Qy0YXC0KclUvst29dbUGY
	 G39Ja4LhgfCVf6VGbhUsz2Ru5BQrhY4GyapOiX0E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731981AbgDVKqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:46:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:52496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729768AbgDVKQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:16:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F5072070B;
        Wed, 22 Apr 2020 10:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550600;
        bh=iXMXhubN516VSHJjbodtOZrbU9W45/hHHrxQFuVpNxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0nTYABTjFWLt8Wibcx0RpXLQ7uY/XUfAAM0ciWyu4UPu9Q/oVp/yetkgXwTFw1Shk
         /XmYD75eBlZLiZ26MtEkqqzOnV4Sxf7z9if12CHc8M3Zaks3o8djE7PSW/Y/4l66x+
         sWXom9b1Aj5x/xWc6vr5+NSh2fIa/qH/+BqOSZk8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Erhard F." <erhard_f@mailbox.org>,
        Frank Rowand <frank.rowand@sony.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 5.4 018/118] of: overlay: kmemleak in dup_and_fixup_symbol_prop()
Date:   Wed, 22 Apr 2020 11:56:19 +0200
Message-Id: <20200422095034.550915891@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095031.522502705@linuxfoundation.org>
References: <20200422095031.522502705@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

commit 478ff649b1c8eb2409b1a54fb75eb46f7c29f140 upstream.

kmemleak reports several memory leaks from devicetree unittest.
This is the fix for problem 4 of 5.

target_path was not freed in the non-error path.

Fixes: e0a58f3e08d4 ("of: overlay: remove a dependency on device node full_name")
Reported-by: Erhard F. <erhard_f@mailbox.org>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/of/overlay.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -261,6 +261,8 @@ static struct property *dup_and_fixup_sy
 
 	of_property_set_flag(new_prop, OF_DYNAMIC);
 
+	kfree(target_path);
+
 	return new_prop;
 
 err_free_new_prop:


