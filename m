Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C2EC2BB54
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A31F62074F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586255231;
	bh=7d/wJqUuz5hIfd5ZLbF0o2zPbMj1oDOeQJTFbf3ygB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z7Qg98U6dh0U/ismEZmGPwOtKlcmVQmU5LnmkJTeUoNmnhosqAvXZ6Qnqr1PTrZUp
	 FdVEz3jqkqBdI15+RRkRcQ03lOVjKB0eX2cMJO4SudGkY9vOLyw9VzdCryLccQWzzq
	 OaLqJ6accGeI2sHPXBiOmjM5bztVPWGrQnp2PRL0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbgDGK1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 06:27:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:39432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729279AbgDGK1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 06:27:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CF772078A;
        Tue,  7 Apr 2020 10:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586255224;
        bh=7d/wJqUuz5hIfd5ZLbF0o2zPbMj1oDOeQJTFbf3ygB8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vbGfCIqEdCD9oLndXrXQGpjWMO1fh626n1j86oBsTDsG3IXbHK3qJ7PiG2ySvY8JJ
         GN7G4hnirqOW324nWv71ZEE7rVwR7/aRsiuPOGwRY0HIc10WjL1X4pxMtFxIvONtNJ
         yrw+vvzTYn1nkxLm5mUxj/0RoT+Nh8OtrrSCSs8I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Dmitry V. Levin" <ldv@altlinux.org>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.6 26/29] Revert "ALSA: uapi: Drop asound.h inclusion from asoc.h"
Date:   Tue,  7 Apr 2020 12:22:23 +0200
Message-Id: <20200407101455.292977095@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200407101452.046058399@linuxfoundation.org>
References: <20200407101452.046058399@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit b6f69c795547f59ddf1db17cddbd2b9a15c656ed upstream.

This reverts commit 645c08f17f477915f6d900b767e789852f150054
which was reported to break the build a program using this header.

The original issue was addressed in the alsa-lib side recently, so we
can make the header more self-contained again.

Reported-by: Dmitry V. Levin <ldv@altlinux.org>
Fixes: 645c08f17f47 ("ALSA: uapi: Drop asound.h inclusion from asoc.h")
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200331090023.8112-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/uapi/sound/asoc.h |    1 +
 1 file changed, 1 insertion(+)

--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -17,6 +17,7 @@
 #define __LINUX_UAPI_SND_ASOC_H
 
 #include <linux/types.h>
+#include <sound/asound.h>
 
 /*
  * Maximum number of channels topology kcontrol can represent.


