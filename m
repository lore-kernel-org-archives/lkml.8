Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BA1C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46A55214D8
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586607197;
	bh=AOAvaLVkDHeMRUUOp5dsa0b0RO3eEiCYm6DzGZdjcBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YuKYR61JQxiKOV/7bP984fgRd7w6L5tCbsq/RcjGL5J4rzvgcsV7QFxN+vWv6LGQV
	 igSPKDbKXTXSmcxCF8w1dKSuQcsXYoXXM7b36ts/bSHv6eVwTdaWo/lSPz3J6IBqog
	 B3g3BtFmRChF5i3pHEiqCyJH5GXGESnLSbI0XCMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbgDKMNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:13:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:46052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727664AbgDKMNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:13:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BCB02137B;
        Sat, 11 Apr 2020 12:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586607192;
        bh=AOAvaLVkDHeMRUUOp5dsa0b0RO3eEiCYm6DzGZdjcBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BuKPA4KYbZzrZQVFmrnQ7CB02HU3oU9Rd868wT4eW2ik3n2++0vtuvTBERhqPfRyL
         dEw9/iqIpSE0gi8DmIGZOFNylK+SERaOp7mGaVm8hetjDkcSIiS2a1et8IXuPXmfrX
         FX2VT5PCACm2MsxE62XGa8WLRf4g6B0k+5exX9co=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eugene Syromiatnikov <esyr@redhat.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH 4.14 12/38] coresight: do not use the BIT() macro in the UAPI header
Date:   Sat, 11 Apr 2020 14:08:56 +0200
Message-Id: <20200411115439.195299970@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200411115437.795556138@linuxfoundation.org>
References: <20200411115437.795556138@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugene Syromiatnikov <esyr@redhat.com>

commit 9b6eaaf3db5e5888df7bca7fed7752a90f7fd871 upstream.

The BIT() macro definition is not available for the UAPI headers
(moreover, it can be defined differently in the user space); replace
its usage with the _BITUL() macro that is defined in <linux/const.h>.

Fixes: 237483aa5cf4 ("coresight: stm: adding driver for CoreSight STM component")
Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
Cc: stable <stable@vger.kernel.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Link: https://lore.kernel.org/r/20200324042213.GA10452@asgard.redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/uapi/linux/coresight-stm.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/include/uapi/linux/coresight-stm.h
+++ b/include/uapi/linux/coresight-stm.h
@@ -2,8 +2,10 @@
 #ifndef __UAPI_CORESIGHT_STM_H_
 #define __UAPI_CORESIGHT_STM_H_
 
-#define STM_FLAG_TIMESTAMPED   BIT(3)
-#define STM_FLAG_GUARANTEED    BIT(7)
+#include <linux/const.h>
+
+#define STM_FLAG_TIMESTAMPED   _BITUL(3)
+#define STM_FLAG_GUARANTEED    _BITUL(7)
 
 /*
  * The CoreSight STM supports guaranteed and invariant timing


