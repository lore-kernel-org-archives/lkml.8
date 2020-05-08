Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3CCC47255
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BD1C21473
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588971819;
	bh=pfu8cwd9Mnmh9wwYakprq15dAD5AtNJSX5L+uHwmI58=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=TrA2mFHiL2TaPpYl+0o4TTd0sLyyNkYJPvnyrNOO0w8oTEahOwGJlBFe9cgN5EUQd
	 PiYvey2QFOzNfynmC1OyBhn+qVNTgA9pqDMKj0Xa3m5dpuFMqvtBmcRW3mH3Zjusdz
	 zHNZ4RaTY7hDPS+s6t86jirXueOgquvidqusYfUc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgEHVDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 17:03:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:33558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726883AbgEHVDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 17:03:38 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97F52206B8;
        Fri,  8 May 2020 21:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588971818;
        bh=pfu8cwd9Mnmh9wwYakprq15dAD5AtNJSX5L+uHwmI58=;
        h=Date:From:To:Cc:Subject:From;
        b=00MwkRBPLeUh1u1MuDYSlhMpmye5mAA2D+5XxoMuGjwsOYMv0k9SU/+kCbpCzlb7W
         /YAIUcMX7Nq1U1qhY/3i5AmHdMBpfO/CpMSWlGfstCMkR2zr6t4v2rynzUH8hNdT0X
         J4X/QgAiRGCLaQwfSd0qBnwTsu/OTwXh0lngm8lE=
Date:   Fri, 8 May 2020 16:08:05 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] firmware: qcom_scm-legacy: Replace zero-length array with
 flexible-array
Message-ID: <20200508210805.GA24170@embeddedor>
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

Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/firmware/qcom_scm-legacy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/qcom_scm-legacy.c b/drivers/firmware/qcom_scm-legacy.c
index 8532e7c78ef7..eba6b60bfb61 100644
--- a/drivers/firmware/qcom_scm-legacy.c
+++ b/drivers/firmware/qcom_scm-legacy.c
@@ -56,7 +56,7 @@ struct scm_legacy_command {
 	__le32 buf_offset;
 	__le32 resp_hdr_offset;
 	__le32 id;
-	__le32 buf[0];
+	__le32 buf[];
 };
 
 /**
-- 
2.26.2

