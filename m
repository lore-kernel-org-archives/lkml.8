Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0CAC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D34DC218AC
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588878040;
	bh=vrENF+GO20eVEagD1CaCNbMV3TQAdn3o+B0P5GilDE4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=JOirHyk3M1ZtVFJmUUuBLEbhtiELE5Lbt7a9HadlwXOnig5M1kwFRYhQlUFsOPX2Z
	 QGwoad9mtLb8lRQgwAErl1UbYFmXf+YRVGKSyvdipgARYIdualOFL9p0ze2uoMKV37
	 dqDBSfmuQCb1PKdqnu3EZCA68uuSQY+ozmKI1OtM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgEGTAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 15:00:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:60628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727837AbgEGTAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:00:39 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C197A21835;
        Thu,  7 May 2020 19:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588878039;
        bh=vrENF+GO20eVEagD1CaCNbMV3TQAdn3o+B0P5GilDE4=;
        h=Date:From:To:Cc:Subject:From;
        b=N6N7iFNjE706CS7j+ejMYHj5Ah0GA2rBA8+4XN8QPJika/wlYWXt7uIel8i1hW6py
         bJU45QXuLKNEDYIMVAcM5Mu82nieM+D2BJe4nFFrW4hWfGj3nvtVz1lgR7j1/tEij5
         51NTjUd0H6IEywVIOtvD2TH1pxXfNuCBkjWTVmKc=
Date:   Thu, 7 May 2020 14:05:05 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Robert Richter <rric@kernel.org>
Cc:     oprofile-list@lists.sf.net, linux-kernel@vger.kernel.org
Subject: [PATCH] oprofile: Replace zero-length array with flexible-array
Message-ID: <20200507190505.GA15577@embeddedor>
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
 drivers/oprofile/cpu_buffer.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/oprofile/cpu_buffer.h b/drivers/oprofile/cpu_buffer.h
index e1d097e250ae..31478c0cff87 100644
--- a/drivers/oprofile/cpu_buffer.h
+++ b/drivers/oprofile/cpu_buffer.h
@@ -33,7 +33,7 @@ void flush_cpu_work(void);
 struct op_sample {
 	unsigned long eip;
 	unsigned long event;
-	unsigned long data[0];
+	unsigned long data[];
 };
 
 struct op_entry;

