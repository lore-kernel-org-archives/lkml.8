Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955E4C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BBFB24957
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588877388;
	bh=fkbkeAahLwkX2lnMf9WgnPl9OcYwVeE2Nk51rboRP08=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=xb2agTvZfc7AYHuFtniiAw0sRbX8dtIfr9CsoWDfPIZpejmaGev/w/XePIXdqQLRR
	 HRq02IYVFsvBmWK/Z6e9sZePyi7kXpN8+m/pcGw/cIkDYFHxXJyq8xIHfYVupE4xsY
	 wnRdY2AoCcEL5h5Knu3Lk+jAkT51TI2EiGQ8ZPvE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgEGSts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:49:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:51202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728238AbgEGStr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:49:47 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D10124957;
        Thu,  7 May 2020 18:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588877386;
        bh=fkbkeAahLwkX2lnMf9WgnPl9OcYwVeE2Nk51rboRP08=;
        h=Date:From:To:Cc:Subject:From;
        b=EcjQ9F+cajSdMzNf13o4290jHrc3hiXxrsOXujxafyGrYsOfH3G7YVWazRngdr0yM
         WUIUBnq8npVPl5gRq59mjmvVXvitiQlc2fbzlRoifRFS86xmm6H2SqVIaXBhoQOgh6
         1+Jq8BeUsgsGnSZbCysaPEzcu18w7Mc9Nod0H2TQ=
Date:   Thu, 7 May 2020 13:54:13 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] treewide: Replace zero-length array with flexible-array
Message-ID: <20200507185413.GA14583@embeddedor>
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
 samples/mei/mei-amt-version.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/mei/mei-amt-version.c b/samples/mei/mei-amt-version.c
index 32234481ad7d..ad3e56042f96 100644
--- a/samples/mei/mei-amt-version.c
+++ b/samples/mei/mei-amt-version.c
@@ -267,7 +267,7 @@ struct amt_host_if_msg_header {
 struct amt_host_if_resp_header {
 	struct amt_host_if_msg_header header;
 	uint32_t status;
-	unsigned char data[0];
+	unsigned char data[];
 } __attribute__((packed));
 
 const uuid_le MEI_IAMTHIF = UUID_LE(0x12f80028, 0xb4b7, 0x4b2d,  \

