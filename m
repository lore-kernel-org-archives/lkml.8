Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1EEC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3528621BE5
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588879231;
	bh=3VqhG5M9IiE8DSTOrbitM36BDnGXR2Iy8OLFUl4M59Q=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=v45Ut87BBVilfhBCegGQ9R5EdcMSt9NpIy2bjZIKp9SyLbAw7+tdCyhcnqQGnusgd
	 4b0+cyGF6VHC1EiNFXN+VEza8LwyYmv1wkVDRbLr4qHaSFhCN+3GSCmrX+YG2b07i8
	 b82SEpODH7sGeBaCBCwA/WOdMCjGtZJ101q9NE8s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgEGTUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 15:20:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:42138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbgEGTUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:20:30 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 733A3208E4;
        Thu,  7 May 2020 19:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588879229;
        bh=3VqhG5M9IiE8DSTOrbitM36BDnGXR2Iy8OLFUl4M59Q=;
        h=Date:From:To:Cc:Subject:From;
        b=xD71iI2IjdTHLJYeGoxqKBldpBQWeW/WJpA5U9keYgnlXf/QsA2Jms9ppHXu2v0Ar
         xsI/teVQTCoRj67T9UHhrqT5WOpVWcbMeGQi6yJsWU1DY3/ezfZ5j+d6Sr3dAe+AFV
         SMHiOmHfCK/V3qXlozjdQNIvI6jByOKJG+ARXYNs=
Date:   Thu, 7 May 2020 14:24:56 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Sam Creasey <sammy@sammy.net>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] ethernet: i825xx: sun3_82586: Replace zero-length array with
 flexible-array
Message-ID: <20200507192456.GA16458@embeddedor>
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
 drivers/net/ethernet/i825xx/sun3_82586.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/i825xx/sun3_82586.h b/drivers/net/ethernet/i825xx/sun3_82586.h
index 79aef681ac85..451cb3d26cb5 100644
--- a/drivers/net/ethernet/i825xx/sun3_82586.h
+++ b/drivers/net/ethernet/i825xx/sun3_82586.h
@@ -250,7 +250,7 @@ struct mcsetup_cmd_struct
   unsigned short cmd_cmd;
   unsigned short cmd_link;
   unsigned short mc_cnt;		/* number of bytes in the MC-List */
-  unsigned char  mc_list[0][6];  	/* pointer to 6 bytes entries */
+  unsigned char  mc_list[][6];  	/* pointer to 6 bytes entries */
 };
 
 /*

