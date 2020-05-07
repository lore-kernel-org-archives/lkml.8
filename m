Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E01C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C07AB24957
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588877344;
	bh=9FfT5ytYuVZhMpl5DmSdFr17qoYPHAktygqL1MmAtH4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=wZ4tD7m4GRXwFF31KQxF4nNeFJWtveZLCIDazeekPPI2/t6HkU47RRVQ77/7h5Dt4
	 55i9Zs6owTu5rzNiP9TtKg11hW0JZkyeGyyHkafsTkOlfZ1uygqQIfeLueFsPuIbOO
	 6nGfZeNwjPWQRNwvZlNedX9i77r3NnpkFCkJviq0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbgEGStE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:49:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728018AbgEGStD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:49:03 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43CC124955;
        Thu,  7 May 2020 18:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588877342;
        bh=9FfT5ytYuVZhMpl5DmSdFr17qoYPHAktygqL1MmAtH4=;
        h=Date:From:To:Cc:Subject:From;
        b=g9Axh4DeD69j75cW+0/OJiqkixbSS1yIGuftScR6tclyt8KYgScdUTPi3sssCN6Si
         OnFwHCWNx6jwnHpgXs585yBwRRlnAS/bMgY8xmtCvrmRQQvfQOzz3oho020afb3CXD
         +LXcsXZFFLf06bVY/eWUP/6TJXmgweZQddN3jXQc=
Date:   Thu, 7 May 2020 13:53:29 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: mux: Replace zero-length array with flexible-array
Message-ID: <20200507185329.GA14436@embeddedor>
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
 include/linux/i2c-mux.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/i2c-mux.h b/include/linux/i2c-mux.h
index c5a977320f82..98ef73b7c8fd 100644
--- a/include/linux/i2c-mux.h
+++ b/include/linux/i2c-mux.h
@@ -29,7 +29,7 @@ struct i2c_mux_core {
 
 	int num_adapters;
 	int max_adapters;
-	struct i2c_adapter *adapter[0];
+	struct i2c_adapter *adapter[];
 };
 
 struct i2c_mux_core *i2c_mux_alloc(struct i2c_adapter *parent,

