Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AB8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E8492065C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597682544;
	bh=5QAZABmxmAr8UBXRYsJfzTUAG8IuMU8x+DTk2b2D7dY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N7dVRUgpdcPtw/IRnUGOjQMrWGa1m7jemEi4DMHbcc/1lNFUzZk394cjRTSbEwT8/
	 tyzzukMf52OBNM036ddm7wcvZIG2a/edf9p/FhYxg6nivb1BTscXt/x83NM7NkBguJ
	 zg8gS7isYn2zcUXOajMTZuelXrcFdsqPpHZcDK6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388930AbgHQQmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 12:42:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730846AbgHQP6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:58:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E17BA2072E;
        Mon, 17 Aug 2020 15:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679923;
        bh=5QAZABmxmAr8UBXRYsJfzTUAG8IuMU8x+DTk2b2D7dY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hfale9jQOtArKi/+tuTuri0kBNvtcr35KT9aRgtZOAheDrKZ528FGdl+s30IL7Ny5
         xd0TcfZw+qeDNUDcHzQVWBnd2nfnrhiCE4hkH5A5/uPShqHV9ImlrTbYyCbghrbPAQ
         xZxFtFCa2EhhwUrwdSugviO2duzCEHyU03Y2G4RM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Scott Branden <scott.branden@broadcom.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 5.7 380/393] firmware_loader: EFI firmware loader must handle pre-allocated buffer
Date:   Mon, 17 Aug 2020 17:17:10 +0200
Message-Id: <20200817143838.041441532@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

commit 4fb60b158afd3ac9e0fe9975aa476213f5cc0a4d upstream.

The EFI platform firmware fallback would clobber any pre-allocated
buffers. Instead, correctly refuse to reallocate when too small (as
already done in the sysfs fallback), or perform allocation normally
when needed.

Fixes: e4c2c0ff00ec ("firmware: Add new platform fallback mechanism and firmware_request_platform()")
Cc: stable@vger.kernel.org
Acked-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20200724213640.389191-4-keescook@chromium.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/firmware_loader/fallback_platform.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/base/firmware_loader/fallback_platform.c
+++ b/drivers/base/firmware_loader/fallback_platform.c
@@ -25,7 +25,10 @@ int firmware_fallback_platform(struct fw
 	if (rc)
 		return rc; /* rc == -ENOENT when the fw was not found */
 
-	fw_priv->data = vmalloc(size);
+	if (fw_priv->data && size > fw_priv->allocated_size)
+		return -ENOMEM;
+	if (!fw_priv->data)
+		fw_priv->data = vmalloc(size);
 	if (!fw_priv->data)
 		return -ENOMEM;
 


