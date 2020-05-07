Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA7BC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3B1E208D6
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588879236;
	bh=uXi39PQvaKDfT68j1+BxFLuUBBa53fIwGeidQwFDQog=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=KDyFnuBC+M4MsZeQO5dOLOb9IcE5mFmyFuseW1d8gmtJioCvwfHjoDoofdN2afgeP
	 MY0+L7S1bfHxRrtV28hFPOByYSDc8CuLAMo2gcCMmmXSM6Erz2caTYIgHaIGwZDWqL
	 ve1lNcA6dP+13UIq94wqNqcfDU3XTO9FGKlT+cL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgEGTUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 15:20:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728391AbgEGTUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:20:35 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B785F208D6;
        Thu,  7 May 2020 19:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588879235;
        bh=uXi39PQvaKDfT68j1+BxFLuUBBa53fIwGeidQwFDQog=;
        h=Date:From:To:Cc:Subject:From;
        b=GnfrXSO3O3Uth1ANWH7AgHHNxrQE6cvAFWkKtM6gDk0xlsOGOGzMAE1kp+iDksEMn
         +3l/CRAN2t0sGhoKkYSGCCS7kQrWA/6i9fsgmlNFEdvLaMTnF8XqK0fXXA7wQAmtS9
         ihdBaO3F0X7VkPiVE4WRC9MJUaS/8hWtf6dJJQQI=
Date:   Thu, 7 May 2020 14:25:01 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] stm class: Replace zero-length array with flexible-array
Message-ID: <20200507192501.GA16491@embeddedor>
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
 drivers/hwtracing/stm/policy.c |    2 +-
 drivers/hwtracing/stm/stm.h    |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/stm/policy.c b/drivers/hwtracing/stm/policy.c
index 4f932a419752..603b4a9969d3 100644
--- a/drivers/hwtracing/stm/policy.c
+++ b/drivers/hwtracing/stm/policy.c
@@ -34,7 +34,7 @@ struct stp_policy_node {
 	unsigned int		first_channel;
 	unsigned int		last_channel;
 	/* this is the one that's exposed to the attributes */
-	unsigned char		priv[0];
+	unsigned char		priv[];
 };
 
 void *stp_policy_node_priv(struct stp_policy_node *pn)
diff --git a/drivers/hwtracing/stm/stm.h b/drivers/hwtracing/stm/stm.h
index 3569439d53bb..a9be49fc7a6b 100644
--- a/drivers/hwtracing/stm/stm.h
+++ b/drivers/hwtracing/stm/stm.h
@@ -23,7 +23,7 @@ void *stp_policy_node_priv(struct stp_policy_node *pn);
 
 struct stp_master {
 	unsigned int	nr_free;
-	unsigned long	chan_map[0];
+	unsigned long	chan_map[];
 };
 
 struct stm_device {
@@ -42,7 +42,7 @@ struct stm_device {
 	const struct config_item_type		*pdrv_node_type;
 	/* master allocation */
 	spinlock_t		mc_lock;
-	struct stp_master	*masters[0];
+	struct stp_master	*masters[];
 };
 
 #define to_stm_device(_d)				\

