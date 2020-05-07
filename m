Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E1AC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD70121835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588879031;
	bh=chhTLOyl25ctDlbPRads+DWFmUp4LKfmtYEwFIBFJ1U=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=E5NTHanQwoLJwMKudcKFcP9LyM//oiZvUx3c4EGVMC/RFeAxQQRde1MwoZpBDL9wX
	 pks5JOkTBgs6mU/cjCf5IjXSG7ZgoNJSk6aH5HvOk8PhMGusHO2u1BwFHVieTAKIGI
	 k6VZV66P7OJi9H0ga2qJvxrPJALBL7paaJpuqJdY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbgEGTRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 15:17:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:40108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgEGTRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:17:10 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65544208D6;
        Thu,  7 May 2020 19:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588879029;
        bh=chhTLOyl25ctDlbPRads+DWFmUp4LKfmtYEwFIBFJ1U=;
        h=Date:From:To:Cc:Subject:From;
        b=UV/QKZUXlWSXUPZsVCZFXRmrm0IUCq6foTPP3YJF+prjloWCpi49Df+kywteniVx3
         riO5tDTA+vxzaRfZldzO4ZygD7+xMgAeUfmacuzO3sUji7WAQIIiN9KcmQGAzqByNw
         uGggw0H1i5KZDxSigZUdzjCZ50XqOjg6lQ9FoieE=
Date:   Thu, 7 May 2020 14:21:36 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kamil Debski <kamil@wypas.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] phy-samsung-usb2: Replace zero-length array with
 flexible-array
Message-ID: <20200507192136.GA16139@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/phy/samsung/phy-samsung-usb2.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/samsung/phy-samsung-usb2.h b/drivers/phy/samsung/phy-samsung-usb2.h
index 2c1a7d71142b..77fb23bc218f 100644
--- a/drivers/phy/samsung/phy-samsung-usb2.h
+++ b/drivers/phy/samsung/phy-samsung-usb2.h
@@ -43,7 +43,7 @@ struct samsung_usb2_phy_driver {
 	struct regmap *reg_pmu;
 	struct regmap *reg_sys;
 	spinlock_t lock;
-	struct samsung_usb2_phy_instance instances[0];
+	struct samsung_usb2_phy_instance instances[];
 };
 
 struct samsung_usb2_common_phy {

