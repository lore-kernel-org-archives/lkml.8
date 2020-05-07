Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F1FC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB913208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588879259;
	bh=hzZ3BRJHxK/0iJNH5rKEuCwWUFrZiZMlsFx+KFOhD6E=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=f4512U/P5Rw6II52gb44ZVywh01liejI1k6/WnyFEsBUC1k3A/xy02yJhV8HwFsB6
	 DhE7krjAPZpSoe5xOxIUPBTYt3YeO9RoXQqRLTaB3l75YDkLiYKCL1rhlywlOC2UJZ
	 Z/X2q+EhYWjazcyqw6zXnsCINaq+Zr50Kaw7J5D0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbgEGTU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 15:20:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:42516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727837AbgEGTU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:20:58 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 970BF208D6;
        Thu,  7 May 2020 19:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588879258;
        bh=hzZ3BRJHxK/0iJNH5rKEuCwWUFrZiZMlsFx+KFOhD6E=;
        h=Date:From:To:Cc:Subject:From;
        b=Tq/MIkKsUFJuC5zOBIHBid/OytqD/3C8lK0sI37YnFdE9Amxy9nluQqghi/muFfKZ
         BF4iKukLDB9U57ZGGH6UfZuoAFFZ5Hi4i1N6ORzbWoRO4BAO3+eQIZ2qZDT4SvJG7F
         U+f3cF7Vh/2r/QiCpMT3QrufbXDQO5SvogLjygv0=
Date:   Thu, 7 May 2020 14:25:24 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] thunderbolt: Replace zero-length array with flexible-array
Message-ID: <20200507192524.GA16580@embeddedor>
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
 include/linux/thunderbolt.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/thunderbolt.h b/include/linux/thunderbolt.h
index ece782ef5466..ff397c0d5c07 100644
--- a/include/linux/thunderbolt.h
+++ b/include/linux/thunderbolt.h
@@ -80,7 +80,7 @@ struct tb {
 	int index;
 	enum tb_security_level security_level;
 	size_t nboot_acl;
-	unsigned long privdata[0];
+	unsigned long privdata[];
 };
 
 extern struct bus_type tb_bus_type;

