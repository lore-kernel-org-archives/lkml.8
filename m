Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DA7C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0287D21D40
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599670636;
	bh=hlDPMvHxCpSsrfha9G6lVN3vMoyc02reshHmPW66AD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x9bra2dKs/h/9k/7wmrmMHKcXXf4a3TuLv7a+IVQsR7d+zzWqcHte/lu0z+B9pG8l
	 HFfePbOwQUce80ttfGmebho2UKhA7itkst+sjNaNxWoaUS2r4WSISew6fFct8MucQ3
	 vCsSORFP76RrYxJgrn17kZvBcSDd2BDIUkAd2meA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbgIIQ5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:57:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730685AbgIIPvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:51:19 -0400
Received: from mail.kernel.org (ip5f5ad5d6.dynamic.kabel-deutschland.de [95.90.213.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 461AA221E9;
        Wed,  9 Sep 2020 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599660665;
        bh=hlDPMvHxCpSsrfha9G6lVN3vMoyc02reshHmPW66AD0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=perkfRSHX6NGuUk83MFT0079niyG6giqxGVBXFReqciTLMY+aOlSWDSpNcC70N4I2
         yUoqKNpkibwU4miMvIJPADuOdVWyGSHcuiYJQRivA+3+H3hcxXmCq3OWkpzBOa+Q4p
         t36Gc7FRUgxYHdkuUXJN3hQUr8UFsyFBUhc0sfe0=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kG0oR-00DUX3-CO; Wed, 09 Sep 2020 16:11:03 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/30] scripts: device_attr_show.cocci: update location of sysfs doc
Date:   Wed,  9 Sep 2020 16:10:43 +0200
Message-Id: <048ed24b09aefa0051d76396d6250e35e6ba035c.1599660067.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599660067.git.mchehab+huawei@kernel.org>
References: <cover.1599660067.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sysfs.txt was converted and renamed to sysfs.rst.

Update device_attr_show.cocci script accordingly.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/coccinelle/api/device_attr_show.cocci | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccinelle/api/device_attr_show.cocci b/scripts/coccinelle/api/device_attr_show.cocci
index d8ec4bb8ac41..a28dc061653a 100644
--- a/scripts/coccinelle/api/device_attr_show.cocci
+++ b/scripts/coccinelle/api/device_attr_show.cocci
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 ///
-/// From Documentation/filesystems/sysfs.txt:
+/// From Documentation/filesystems/sysfs.rst:
 ///  show() must not use snprintf() when formatting the value to be
 ///  returned to user space. If you can guarantee that an overflow
 ///  will never happen you can use sprintf() otherwise you must use
-- 
2.26.2

